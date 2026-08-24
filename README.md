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

- Start solr by navigating to the solr `example` directory e.g. `/app-bin/solr-4.10.4/example` and run `java -jar start.jar`.
    - Solr should be running on `localhost:8983` and the dashboard should be available on `localhost:8983/solr`.
- Start play by nagigating to the play directory e.g. `/app-bin/play-1.11.0` and run `./play run PATH_TO_REPOSITORY` e.g.
  `./play run /git/grundtvigsvaerker.dk`.
    - Play should be running on `localhost:9000`.

## Reindexing Solr

If Solr needs to be reindexed do the following:

- Run `curl "http://localhost:8983/solr/grundtvig/update?commit=true" -H "Content-Type: text/xml" --data-binary '<delete><query>*:*</query></delete>'` locally
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
- Alle uploadede (bruger-filer) er flyttet uden for kode-repositoriet, så det er nemmere og sikrere at vedligeholde (kræver migration af data ved overgang)
- JPA mappings er ændret til at resolve til text kolonner i stedet for LOB, dette skal formentlig transformeres i databasen ved migrationen. Dette burde
  forøge performance og muliggør indekses på kolonnerne. -> Alle kolonner fra KB dump, var allerede TEXT
- Der er tilføjet indexes til JPA-mappings. Disse skal køres manuelt på database ved migration (efter LOB -> text transformation).
- Fixet bibelregister så den ikke laver dobbelt kolonne, uden indhold, i visning (ændret bibleXSLT.xsl)
- Droppet tabellen `assetshadow` fra databasen, den var tom og så aldrig ud til at have været i brug.

# TODO ON SERVER FILES:

Når vi får data fra KB, tag hele public mappens indhold og lav bash filter der finder alle billeder, pdfs etc. og kopier:

- alle billeder til DATA-DIR/img (jpeg, jpg,,, andre?)
- alle pdf til DATA-DIR/pdf
- public/tidslinje skal ind i DATA-DIR/xml/tidslinje
- alle xml til DATA-DIR/xml
- alle html til DATA-DIR/html
- lav sanity tjek om der er andre fil-formater (som ikke er de png og gif der hører til i public/images), hvis der er, så kopier til DATA-DIR/img
- Og så fra DATA-DIR/img slet alle dem der er i public/images i repository.
- OBS: erstat IKKE public/images med det overleverede public/ dir, public/* skal komme fra git-hub, alt brugergenereret skal ligge eksternt.
- Der er referencer til `href="public/images/` erstat disse med `href="img/`
- i html kolonnen for chapter of asset, find alle referencer til `href="img/xxx.pdf"` og erstat med `href="pdf/xxx.pdf"`
  TAG ET SNAPSHOT INDEN, GØR DET I NEDENSTÅENDE RÆKKEFØLGE...

> ``` 
>  UPDATE __TABLE_NAME__
>  SET __COLUMN_NAME__ = replace(
>    __COLUMN_NAME__,
>    'href="public/images/',
>    'href="img/'
>  )
>  WHERE __COLUMN_NAME__ LIKE '%href="public/images/%'
>  ;
> 
>  UPDATE __TABLE_NAME__
>  SET __COLUMN_NAME__ = regexp_replace(
>    __COLUMN_NAME__,
>    'href="img/([^"]+\.pdf)"',
>    'href="pdf/\1"',
>    'g'
>  )
>  WHERE __COLUMN_NAME__ ~ 'href="img/[^"]+\.pdf"';
>  ;
> ```

- Upload `regList.xml` og `bookInventory1805.xml` og `bookInventory1839.xml` igen, så de bliver parset korrekt...

# TODO ON SERVER POSTGRES:

Login to the db as grundtvig user:

```
psql -U grundtvig -d grundtvig -h localhost
```

## Change to TEXT

Find all Lob columns:

```
SELECT
    table_schema,
    table_name,
    column_name,
    data_type,
    udt_name
FROM information_schema.columns
WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
  AND udt_name = 'oid'
ORDER BY table_schema, table_name, ordinal_position;
```

for each table+column that is LOB do:

```
ALTER TABLE __table_name__
ALTER COLUMN __column_name__ TYPE text
USING convert_from(lo_get(xml), 'UTF8');
```

Exit the db and run:

```
vacuumlo -U grundtvig -h localhost grundtvig
```

to remove any Lob leftovers.

Log into the db again:

```
psql -U grundtvig -d grundtvig -h localhost
```

And test no Lob remains:

```
SELECT
    table_schema,
    table_name,
    column_name,
    udt_name
FROM information_schema.columns
WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
  AND udt_name = 'oid'
ORDER BY table_schema, table_name, ordinal_position;
```

Verify the converted column types:

```
SELECT
    table_name,
    column_name,
    data_type,
    udt_name
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;
```

## Add indexes

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
