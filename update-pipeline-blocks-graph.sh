#
# now let's generate an updated readme-blocks-graph.json
#

#
# first we copy over the blocks metadata from blockbuilder-search-index
#
BLOCKBUILDER_SEARCH_INDEX_HOME="/Users/m/workspace/blockbuilder-search-index"
README_VIS_HOME="/Users/m/workspace/readme-vis"
cd $README_VIS_HOME
cp -r $BLOCKBUILDER_SEARCH_INDEX_HOME/data/parsed/ $README_VIS_HOME/data/gist-metadata/input/

cd $README_VIS_HOME/data/scripts

node 01-gists-with-readme.js
# 28576 README.md files in the d3 gists corpus
#

node 01b-gists-users.js
# wrote 37321 gist ID, github username key, value pairs
# see the results at ../gist-metadata/output/gist-id-to-username.json
#

node 02-gists-with-readme-with-blocks-link.js
# 0 gists with unknown users
# 7001 gists with missing files or folders
# 28576 README.md files in the d3 gists corpus
# of those README.md files
# 10876 contain links to bl.ocks.org
#

node 03a-generate-graph.js
# 7945 nodes
# 25884 links
# in the D3 README graph
#
