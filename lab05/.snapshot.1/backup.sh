#!/bin/sh
i=0
curr=".$1.$i"

while test -f $curr
    do
        ((i=i+1))
        curr=".$1.$i"
    done 

cp "$1" "$curr"
echo "Backup of '$1' saved as '.$1.$i'"


