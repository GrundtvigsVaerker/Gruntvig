package controllers;

import play.Play;
import play.mvc.*;

import java.io.File;

public class PublicFiles extends Controller {

    private static final File BASE_DIR;
    static {
        String dataDirPath = Play.configuration.getProperty("data.dir");
        if (dataDirPath == null || dataDirPath.trim().isEmpty()) {
            throw new RuntimeException("The 'data.dir' is required in application.conf");
        }
        if (dataDirPath.endsWith("/") || dataDirPath.endsWith("\\")) {
            dataDirPath = dataDirPath.substring(0, dataDirPath.length() - 1);
        }
        BASE_DIR = new File(dataDirPath);
    }

    public static void getImgFile(String filePath) {
        getFile("img/" + filePath);
    }

    public static void getXmlFile(String filePath) {
        getFile("xml/" + filePath);
    }

    public static void getPdfFile(String filePath) {
        getFile("pdf/" + filePath);
    }

    private static void getFile(String filePath) {
        File file = new File(BASE_DIR, filePath);

        if (!file.exists() || !file.isFile() || !file.getAbsolutePath().startsWith(BASE_DIR.getAbsolutePath())) {
            notFound("The file does not exist");
        }

        if (Play.mode.isProd()) {
            String cacheControl = Play.configuration.getProperty("http.cacheControl", "3600");
            response.setHeader("Cache-Control", "max-age=" + cacheControl);
        } else {
            response.setHeader("Cache-Control", "no-cache");
        }

        renderBinary(file);
    }
}
