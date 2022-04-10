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
cat index-filetypes.txt | awk -F ': ' '{ print $1 }' | sort | uniq -c | sort -rn > index-filetype-stats.txt

#! Keyword grep search
echo '==== Keyword search ===='
touch keywords.txt
egrep -rf keywords.txt . > keywords-content.txt
egrep -f keywords.txt index.txt > keywords-filenames.txt