Reindex of solr:

If Solr and Postgres gets out of sync do the following to regenerate the index:

crl "http://localhost:8983/solr/gv/update?commit=true" -H "Content-Type: text/xml" --data-bin
ary '<delete><query>*:*</query></delete>'

go to https://xxx/admin/reindex in a browser and wait one hour or so
