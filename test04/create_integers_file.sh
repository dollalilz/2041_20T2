#!/bin/sh

# print all between $1 and $2 to the file$3
for i in $(seq $1 $2)
do
    echo $i >> $3
done