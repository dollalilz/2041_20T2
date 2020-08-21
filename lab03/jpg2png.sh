#!/bin/sh

IFS=$'\n'
for filename in *.jpg
do
    new_name=`echo $filename |sed 's/jpg/png/'`

    if test -f "$new_name"
    then
        echo "$new_name already exists"
        exit 1
    else
        convert $filename $new_name
        rm "$filename"
    fi
done