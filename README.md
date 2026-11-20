# grundtvigsværker.dk

* git is installed
* java SDK 21 is installed

## Development Installation

* Clone this repository.
* Download play framework >= 1.11 from https://github.com/playframework/play1/releases (the zip file) and
  extract it to a directory. (The intellij project structure module settings might need to be adjusted (CTRL+SHIFT+ALT+S)).
* Download solr from https://archive.apache.org/dist/lucene/solr/4.10.4/ (the zip file) and extract it to a directory.

### Environment variables

- Copy `./conf/example_application.conf` to `./conf/application.conf`, open the file and delete the "PRODUCTION"
  section of the file and change/fill out values as needed. (Do not include in GIT).

### Solr configuration

- Copy `./solr/example/solr/collection1` to `./solr/example/solr/grundtvig`.
- Open `./solr/example/solr/grundtvig/core.properties` and change the value of the `name` property to `grundtvig`.
- Replace `./solr/example/solr/grundtvig/conf/schema.xml` with `./conf/schema.xml`. from the git repository.

## Development

- Start solr by navigating to the solr `example` directory e.g. `/app-bin/solr-4.10.4/example` and run
  `java -jar start.jar`.
    - Solr should be running on `localhost:8983` and the dashboard should be available on `localhost:8983/solr`.
- Start play by navigating to the play directory e.g. `/app-bin/play-1.11.0` and run `./play run PATH_TO_REPOSITORY`
  e.g.
  `./play run /git/grundtvigsvaerker.dk`.
    - Play should be running on `localhost:9000`.

## Reindexing Solr

If Solr needs to be reindexed do the following:

- Run `curl "http://localhost:8983/solr/grundtvig/update?commit=true" -H "Content-Type: text/xml" --data-binary '<delete><query>*:*</query></delete>'`
  locally on the machine with the Solr server running.
- Go to `https://xxx/admin/reindex` in a browser and wait one hour or so.

## Releases

Use git tag following semantic versioning for releases. Make sure to make an annotated release and
push the tag to the remote repository to be able to use the deployment script in
https://github.com/centre-for-humanities-computing/production-servers/tree/master/servers/grundtvigsv%C3%A6rker.dk.

Example:

- Tag: `v1.2.3`
- Comment: `Release v1.2.3`

Releasing a new version of the Grundtvig dataset (every 6 months) is considered to be a minor version bump (We change the version
number and the dataset in the HTML but do not add new features).

