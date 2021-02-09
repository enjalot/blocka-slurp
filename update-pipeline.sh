# here is the log of a d3 blocks metadata update run
# this log assumes that:
#
#  1) we have already updated before, and only need to check since the last update date
#     (which in our case was ~20180120.  we'll get everything since 2018-01-19T00:00:00Z 
#      to be safe) 
#  2) we are not worried about validating that users have at least one
#
# note: 
#   each command shows a sample of what the terminal output 
#   should look like if command runs successfully


BLOCKBUILDER_SEARCH_INDEX_HOME="/Users/m/workspace/blockbuilder-search-index"
UPDATE_AFTER_TIMESTAMP="2018-08-24T00:00:00Z"

cd $BLOCKBUILDER_SEARCH_INDEX_HOME

coffee combine-users.coffee
# 205 users from blocks links in SO
# 468 users from blocks links in knight course
# 4524 users added from bb
# 199 added from manual list of users
# 37 users added from blocksplorer
# 5433 users total

#
# optionally get all blocks for new users 
# for all time
#
# TODO implement bash if else to check if 
# the file data/new.json exists
# if yes, run this command. if no, do nothing
#  
coffee gist-meta.coffee data/new.json '' 'new-users'
# no change, did not run this one this time

#
# fetch the metadata for all new gists
# for all known users from the github API
#
coffee gist-meta.coffee data/latest-20180824-to-20180825.json $UPDATE_AFTER_TIMESTAMP
# done with zzhang115, found 0 gists
# rate limit remaining 418
# done with zzolo, found 0 gists
# done. number of new gists: 57
# combining 57 with 37321 existing blocks
# writing 37346 blocks to data/gist-meta.json
# writing 57 to data/latest-20180824-to-20180825.json
# Elasticsearch DEBUG: 2018-08-27T05:29:31Z
#   starting request { method: 'POST',
#     path: '/bbindexer/scripts',
#     body:
#      { script: 'meta',
#        numBlocks: 57,
#        filename: 'data/latest-20180824-to-20180825.json',
#        since: '2018-08-24T00:00:00Z',
#        ranAt: 2018-08-27T05:29:31.657Z },
#     query: {} }
#
#
# Elasticsearch TRACE: 2018-08-27T05:29:31Z
#   -> POST http://localhost:9200/bbindexer/scripts
#   {
#     "script": "meta",
#     "numBlocks": 57,
#     "filename": "data/latest-20180824-to-20180825.json",
#     "since": "2018-08-24T00:00:00Z",
#     "ranAt": "2018-08-27T05:29:31.657Z"
#   }
#   <- 201
#   {
#     "_index": "bbindexer",
#     "_type": "scripts",
#     "_id": "F6bbeWUBizCTN0xZyZ1N",
#     "_version": 1,
#     "result": "created",
#     "_shards": {
#       "total": 2,
#       "successful": 1,
#       "failed": 0
#     },
#     "_seq_no": 1,
#     "_primary_term": 1
#   }
#
# Elasticsearch DEBUG: 2018-08-27T05:29:31Z
#   Request complete
#
# indexed
#
#
# let's clone the gists we just found
#
coffee gist-cloner.coffee data/latest-20180824-to-20180825.json
# Cloning into '7fba0feaccd30a12fffcfaa42b79a2e7'...
# 7fba0feaccd30a12fffcfaa42b79a2e7 tomshanley 0 Cloning into '7fba0feaccd30a12fffcfaa42b79a2e7'...
#
# done writing files
# Elasticsearch DEBUG: 2018-08-27T05:49:30Z
#   starting request { method: 'POST',
#     path: '/bbindexer/scripts',
#     body:
#      { script: 'content',
#        timeouts: [],
#        filename: 'data/latest-20180824-to-20180825.json',
#        ranAt: 2018-08-27T05:49:30.801Z },
#     query: {} }
#
#
# Elasticsearch TRACE: 2018-08-27T05:49:30Z
#   -> POST http://localhost:9200/bbindexer/scripts
#   {
#     "script": "content",
#     "timeouts": [],
#     "filename": "data/latest-20180824-to-20180825.json",
#     "ranAt": "2018-08-27T05:49:30.801Z"
#   }
#   <- 201
#   {
#     "_index": "bbindexer",
#     "_type": "scripts",
#     "_id": "GKbueWUBizCTN0xZFZ1A",
#     "_version": 1,
#     "result": "created",
#     "_shards": {
#       "total": 2,
#       "successful": 1,
#       "failed": 0
#     },
#     "_seq_no": 1,
#     "_primary_term": 1
#   }
#
# Elasticsearch DEBUG: 2018-08-27T05:49:30Z
#   Request complete
#
# indexed

# coffee parse.coffee

# try new command from branch
# https://github.com/micahstubbs/blockbuilder-search-index/tree/micah/55/exp/parse-modules 
#
# node parse
#
# gist 757ad6ea093000bf1900d6c0e2a9b126 romsson
# gist 7fba0feaccd30a12fffcfaa42b79a2e7 tomshanley
# done
# skipped 0 missing files
# wrote d3 API functions                         to data/parsed/apis.json
# wrote colors                                   to data/parsed/colors.json
# wrote 37346 block metadata entries             to data/parsed/blocks.json
# wrote 37346 minified block metadata entries    to data/parsed/blocks-min.json
# wrote 10446 single-block d3 API function lists to data/parsed/blocks-api.json
# wrote 11523 colors entries                     to data/parsed/blocks-colors.json
# wrote 11523 minified colors entries            to data/parsed/blocks-colors-min.json
# wrote 0 file metadata entries                  to data/parsed/files-blocks.json
# wrote 3844 script tags                         to data/parsed/script-tags.jsons

cd data/parsed
pwd
# /Users/m/workspace/blockbuilder-search-index/data/parsed

#
# tada, we have some fresh blocks metadata files
#
ls -lAFh
# total 286816
# -rw-r--r--@ 1 m  staff   6.0K Mar 16 18:10 .DS_Store
# -rw-r--r--  1 m  staff     2B Aug 21 06:29 apis.json
# -rw-r--r--  1 m  staff   3.2M Aug 21 06:29 blocks-api.json
# -rw-r--r--  1 m  staff   2.2M Aug 21 06:29 blocks-colors-min.json
# -rw-r--r--  1 m  staff   4.2M Aug 21 06:29 blocks-colors.json
# -rw-r--r--  1 m  staff   5.9M Aug 21 06:29 blocks-min.json
# -rw-r--r--  1 m  staff    76M Aug 21 06:29 blocks.json
# -rw-r--r--  1 m  staff     2B Aug 21 06:29 colors.json
# -rw-r--r--  1 m  staff    45M Aug 21 06:29 files-blocks.json
# -rw-r--r--  1 m  staff    10B Aug 21 06:29 libs.csv
# -rw-r--r--  1 m  staff    13B Aug 21 06:29 modules.csv
# -rw-r--r--  1 m  staff   3.6M Aug 14  2017 readme-blocks-graph.json

#
# now let's call another shell script to generate the 
# blocks graph metadata
#
cd $BLOCKBUILDER_SEARCH_INDEX_HOME
sh update-pipeline-blocks-graph.sh
