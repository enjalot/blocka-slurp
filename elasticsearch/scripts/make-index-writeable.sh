curl -X PUT "localhost:9200/blockbuilder/_settings" -H 'Content-Type: application/json' -d'
{
  "index.blocks.read_only_allow_delete": null
}
'
