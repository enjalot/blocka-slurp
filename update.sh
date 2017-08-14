# get the ids of all gists created by known users 
# since a date we specify
# write out the gist ids we find to data/latest.json
coffee gist-meta.coffee data/latest.json 2016-10-01T00:00:00Z

# download files for all gists in latest.json
coffee gist-cloner.coffee data/latest.json

# generate a series of JSON files 
# that pull out interesting metadata 
# from the downloaded gists
coffee parse.coffee