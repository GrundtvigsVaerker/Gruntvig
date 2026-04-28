Install Solr:

wget http://apache.vianett.no/lucene/solr/4.7.1/solr-4.7.1.tgz
tar xvzf solr-4.7.1.tgz
mv example gv
mv collection1 gv
Set core.properties to name=gv
flytt schema.xml inn i solr/gv/conf/schema.xml skjema
start med java -jar start.jar


Reindex of solr:

If Solr and Postgres gets out of sync do the following to regenerate the index:

crl "http://localhost:8983/solr/gv/update?commit=true" -H "Content-Type: text/xml" --data-bin
ary '<delete><query>*:*</query></delete>'

go to https://xxx/admin/reindex in a browser and wait one hour or so
