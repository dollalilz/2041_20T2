#!/bin/sh

for file in "$@"
do
    curr=`cat $file |egrep '^#include "[0-9a-zA-Z]*.h"$' |cut -d '"' -f2`
    for i in $curr
    do
        if test "$i" != ""
        then
            if test -f $i
            then
                continue
            else
                echo "$i included into $file does not exist"
            fi
        fi
    done
done

