#!/bin/sh

IFS=$'\n'

for filename in *.htm* 
do
    new=`echo $filename|sed -r "s/.htm(l)?$//"`
    if test -f "$new.html"
    then
        #echo "$new.html exists" 
        if test -f "$new.htm"
        then
        echo "$new.html exists"
        exit 1 
        fi
    else
        mv "$filename" "$new.html"
    fi
done