# https://coolestguidesontheplanet.com/how-to-compress-and-uncompress-files-and-folders-in-os-x-lion-10-7-using-terminal/
# compress blocks metadata without Mac metadata files

zip -r -X blocks-metadata-20161016.zip parsed
zip -r -X blocks-gists-clones-20161016.zip gists-clones
# to extract
unzip blocks-metadata-20161016.zip

# better compression
tar -zcvf blocks-metadata-20161016.tar.gz parsed
tar -zcvf blocks-gists-clones-20161016.tar.gz gists-clones

# to extract
tar -zxvf blocks-metadata-20161016.tar.gz

# even better compression
tar -jcvf blocks-metadata-20161016.tar.bz2 parsed
tar -jcvf blocks-gists-clones-20161016.tar.bz2 gists-clones

# to extract
tar -jxvf blocks-metadata-20161016.tar.bz2
