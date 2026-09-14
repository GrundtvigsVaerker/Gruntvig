# grundtvigsværker.dk

* git is installed
* java SDK 21 is installed

## Development Installation

* Clone this repository.
* Download play framework >= 1.11 from https://github.com/playframework/play1/releases (the zip file) and
  extract it to a directory. (The intellij project structure module settings might need to be adjusted
  (CTRL+SHIFT+ALT+S)).
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
- Start play by nagigating to the play directory e.g. `/app-bin/play-1.11.0` and run `./play run PATH_TO_REPOSITORY`
  e.g.
  `./play run /git/grundtvigsvaerker.dk`.
    - Play should be running on `localhost:9000`.

## Reindexing Solr

If Solr needs to be reindexed do the following:

- Run
  `curl "http://localhost:8983/solr/grundtvig/update?commit=true" -H "Content-Type: text/xml" --data-binary '<delete><query>*:*</query></delete>'`
  locally
  on the
- machine with the Solr server running.
- Go to `https://xxx/admin/reindex` in a browser and wait one hour or so.

## Releases

Use git tag following semantic versioning for releases. Make sure to make an annotated release and
push the tag to the remote repository to be able to use the deployment script in
https://github.com/centre-for-humanities-computing/production-servers/tree/master/servers/grundtvigsv%C3%A6rker.dk.

Example:

- Tag: `v1.2.3`
- Comment: `Release v1.2.3`

# ÆNDRINGER

- Opgradering til Play 1.11 og JDK 21
- `/uploadXml/uploadForm` er flytter til `/admin/uploadXml/uploadForm`
- Alle automatiske stier er disablet, så hvis der er en sti der mangler skal den enables i `routes` filen
- Alle uploadede (bruger-filer) er flyttet uden for kode-repositoriet, så det er nemmere og sikrere at vedligeholde
  (kræver migration af data ved overgang)
- JPA mappings er ændret til at resolve til text kolonner i stedet for LOB, dette skal formentlig transformeres i
  databasen ved migrationen. Dette burde
  forøge performance og muliggør indekses på kolonnerne. -> Alle kolonner fra KB dump, var allerede TEXT
- Der er tilføjet indexes til JPA-mappings. Disse skal køres manuelt på database ved migration (efter LOB -> text
  transformation).
- Fixet bibelregister så den ikke laver dobbelt kolonne, uden indhold, i visning (ændret bibleXSLT.xsl)
- Droppet tabellen `assetshadow` fra databasen, den var tom og så aldrig ud til at have været i brug.

# TODO ON SERVER FILES:

----
Grundtvig værker...

- [V] tag snapshop
- [V] lav søg og erstat af stier til images, se noter
- [V] lav release tag. v0.1 og commit
- [V] lav deploy på serveren (se noter)
- [V] start server, se noter, har scripts til det
- [V] tjek at den virker
- [V] reindex lucene, der er endpoint til det...
- se noter om filer der skal uploades igen.

[V] Test at søgninger virker...

[V] Test performance...


Tqg snapshot INDEN vi giver mulighed for at Kim etc. kan teste upload, og rul tilbage til snapshot efter de har testet...
----

