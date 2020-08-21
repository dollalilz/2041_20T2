#!/bin/bash

# check if both of them exist 
IFS=$'\n'

if test ! -d $1
then
    exit 1
fi

if test ! -d $2 
then
    exit 1
fi 

list=()
i=0
cd $1
for file in *
do
    if test -e ../$2/$file
    then
        diff $file ../$2/$file >/dev/null 
        if test $? -eq 0
        then
            list[i]=$file
            #echo "$file is identical"
            i=$((i+1))
        fi
    fi
done

sorted=($(sort <<<"${list[*]}"))
for x in ${list[*]}
do 
echo $x
done



