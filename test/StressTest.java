import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class StressTest {

    private static final String TARGET_URL = "https://gv.au.dk/krono";
    private static final int REQUEST_COUNT = 100;
    private static final int CONCURRENCY = 10;

    public static void main(String[] args) throws Exception {
        HttpClient client = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .followRedirects(HttpClient.Redirect.NORMAL)
                .build();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(TARGET_URL))
                .timeout(Duration.ofSeconds(30))
                .GET()
                .build();

        try (var executor = Executors.newFixedThreadPool(CONCURRENCY)) {
            List<Future<Result>> futures = new ArrayList<>();

            long start = System.currentTimeMillis();

            for (int i = 0; i < REQUEST_COUNT; i++) {
                int requestNumber = i + 1;

                futures.add(executor.submit(() -> {
                    try {
                        HttpResponse<Void> response = client.send(
                                request,
                                HttpResponse.BodyHandlers.discarding()
                        );

                        int statusCode = response.statusCode();

                        if (statusCode >= 500) {
                            return new Result(
                                    requestNumber,
                                    statusCode,
                                    new RuntimeException("Server returned HTTP " + statusCode)
                            );
                        }

                        return new Result(
                                requestNumber,
                                statusCode,
                                null
                        );
                    } catch (Throwable t) {
                        return new Result(
                                requestNumber,
                                -1,
                                t
                        );
                    }
                }));
            }

            int successCount = 0;
            int failureCount = 0;

            for (Future<Result> future : futures) {
                Result result = future.get();

                if (result.error() == null) {
                    successCount++;
                    System.out.println(
                            "Request " + result.requestNumber()
                                    + " completed with status "
                                    + result.statusCode()
                    );
                } else {
                    failureCount++;

                    String httpStatus = result.statusCode() > 0
                            ? "HTTP " + result.statusCode()
                            : "no HTTP response";

                    String errorMessage = result.error().getMessage() != null
                            ? result.error().getMessage()
                            : result.error().getClass().getName();

                    System.err.println(
                            "Request " + result.requestNumber()
                                    + " failed with "
                                    + httpStatus
                                    + ": "
                                    + errorMessage
                    );
                }
            }

            long duration = System.currentTimeMillis() - start;

            System.out.println();
            System.out.println("Finished stress test");
            System.out.println("Requests: " + REQUEST_COUNT);
            System.out.println("Successful: " + successCount);
            System.out.println("Failed: " + failureCount);
            System.out.println("Duration: " + duration + " ms");

            if (failureCount > 0) {
                throw new AssertionError("Some requests failed: " + failureCount);
            }
        }
    }

    private record Result(
            int requestNumber,
            int statusCode,
            Throwable error
    ) {
    }
}