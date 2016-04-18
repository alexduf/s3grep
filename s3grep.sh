#!/bin/bash

s3Path="$1"
expression="$2"

workDir="$HOME/s3grepworkdir"
rm -rf "$workDir"
mkdir "$workDir"

echo -e "Fetching the file list for $s3Path... \c"
aws s3 ls "$s3Path/" | cut -c32- > "$workDir/$0.files"
echo "Done!"


total=0
while read file
do
	echo -e "\nProcessing $file"
	aws s3 cp "$s3Path/$file" "$workDir/$file"
	if [ "$?" -ne 0 ] ; then
		exit 1
	fi
	count=$(grep "$expression" "$workDir/$file" | tee -a "$workDir/$0.results" | wc -l)
	rm "$workDir/$file"
	total=$(($count + $total))
	echo "$count matching line(s) were fond in $file"
	echo "$total matching line(s) in total"
	if [ "$count" -ne "0" ] ; then
		echo "$workDir/$file" >> "$workDir/$0.matching"
	fi
done < "$workDir/$0.files"
