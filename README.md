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
section of the file and change values as needed. (Do not include in GIT).

### Solr configuration
- Copy `./solr/example/solr/collection1` to `./solr/example/solr/gv`.
- Open `./solr/example/solr/gv/core.properties` and change the value of the `name` property to `gv`.
- Replace `./solr/example/solr/gv/conf/schema.xml` with `./conf/schema.xml`. from the git repository.

## Development
- Start solr by navigating to the solr `example` directory e.g. `/app-bin/solr-4.10.4/example` and run `java -jar start.jar`.
  - Solr should be running on `localhost:8983` and the dashboard should be available on `localhost:8983/solr`.
- Start play by nagigating to the play directory e.g. `/app-bin/play-1.11.0` and run `./play run PATH_TO_REPOSITORY` e.g. `play run /git/grundtvigsværker.dk`.
  - Play should be running on `localhost:9000`.

## Reindexing Solr
If Solr needs to be reindexed do the following:
- Run `curl "http://localhost:8983/solr/gv/update?commit=true" -H "Content-Type: text/xml" --data-binary '<delete><query>*:*</query></delete>'` locally on the
- machine with the Solr server running.
- Go to `https://xxx/admin/reindex` in a browser and wait one hour or so.


# TODO ON SERVER FILES:
Når vi får data tag hele public mappens indhold og lav bash filter der finder alle billeder og kopier til DATA-DIR/img alle pdf til DATA-DIR/pdf 
og alle xml til DATA-DIR/xml. Og så fra DATA-DIR/img slet alle dem der er i public/images i repository.

# TODO ON SERVER POSTGRES:

```postgresql
BEGIN;

CREATE INDEX IF NOT EXISTS idx_asset_filename_type
ON asset (filename, type);

CREATE INDEX IF NOT EXISTS idx_asset_rootname_type_variant
ON asset (rootname, type, variant);

CREATE INDEX IF NOT EXISTS idx_chapter_asset_num
ON chapter (asset_id, num);

CREATE INDEX IF NOT EXISTS idx_textreference_textid
ON textreference (textid);

CREATE INDEX IF NOT EXISTS idx_textreference_type
ON textreference (type);

COMMIT;
```
