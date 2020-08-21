#!/bin/sh

for a in $@
do
    echo -n "$a "
    curl -I /dev/null $a 2>&1| egrep -i server: |cut -d ":" -f2| cut -c 2-

done