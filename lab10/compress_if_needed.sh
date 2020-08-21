#!/bin/sh

for a in $@
do
    cp $a temp
    xz -z $a
    original=`ls -l temp |cut -d " " -f5`
    compressed=`ls -l $a* |cut -d " " -f5`
    
    if test $original -le $compressed
    then
        echo "$a $original bytes, compresses to $compressed bytes, left uncompressed"
        cp temp $a
        rm temp
        rm "$a.xz"
    else
        echo "$a $original bytes, compresses to $compressed bytes, compressed"
        rm temp
    fi
done
