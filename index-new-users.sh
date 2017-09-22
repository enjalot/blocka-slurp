# get the ids of all gists created by known users 
# since a date we specify
# write out the gist ids we find to data/latest.json
coffee gist-meta.coffee data/new-user-gists.json '' new-users

# download files for all gists in latest.json
coffee gist-cloner.coffee data/new-user-gists.json

# generate a series of JSON files 
# that pull out interesting metadata 
# from the downloaded gists
coffee parse.coffee