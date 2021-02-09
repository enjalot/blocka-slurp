curl -X PUT "localhost:9200/blockbuilder" -H 'Content-Type: application/json' -d' 
{
  "mappings": {
    "blocks": {
      "properties": {
        "userId": { "type": "text" },
        "description": { "type": "text" },
        "created_at": { "type": "date" },
        "updated_at": { "type": "date" },
        "api": { "type": "keyword" },
        "d3version": { "type": "keyword" },
        "d3modules": { "type": "keyword" },
        "colors": { "type": "text" },
        "tags": { "type": "keyword" },
        "filesTypes": { "type": "keyword" },
        "readme": { "type": "text" },
        "code": { "type": "text" },
        "filenames": { "type": "keyword" },
        "thumb": { "type": "text" },
        "preview": { "type": "text" }
      }
    }
  }
}
'
