#! Index
echo '==== Index ===='
find . > index.txt

#! Index by file type
echo '==== Index by file type ===='
cat index.txt | sed 's/^/file /' | bash | awk -F ': ' '{ print $2 ": " $1 }' | sort > index-filetypes.txt

#! Index by file size
echo '==== Index by file size ===='
cat index.txt | xargs stat -f "%z %N" | sort -rn > index-filesize.txt

#! File type stats
echo '==== File type stats ===='
cat index-filetypes.txt | awk -F ': ' '{ print $1 }' | sort | uniq -c | sort -rn | egrep -v 'cannot open' > index-filetype-stats.txt

#! Keyword grep search
echo '==== Keyword search ===='
touch keywords.txt
egrep -rf keywords.txt . | sort > keywords-content.txt
egrep -f keywords.txt index.txt | sort > keywords-filenames.txt
egrep '[0-9]{13}' . | sort > keywords-timestamps-13.txt
egrep '[0-9]{10}' . | sort > keywords-timestamps-10.txt
wc -l keywords-*.txt | sort -rn > keywords-stats.txt

# Hashing
cat index.txt | sed 's/^/md5 -r /' | bash > hashes-md5.txt
cat index.txt | sed 's/^/shasum -a 1 /' | bash > hashes-sha1.txt
cat index.txt | sed 's/^/shasum -a 256 /' | bash > hashes-sha256.txt
