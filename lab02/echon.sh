#!/bin/sh
if test $# = 2
then
    num=$1
else
    echo "Usage: $0 <number of lines> <string>" 1>&2
    exit 1
fi

if ! [[ "$num" =~ ^-?[0-9]+$ ]] #if not an integer 
then
    echo "$0: argument 1 must be a non-negative integer"
    exit 1
fi

if [ "$num" -gt "0" ]
then
    n='1'
    while test $n -le $num
    do
        echo $2
        n=$((n+1))
    done
elif [ "$num" -lt 0 ]
then
    echo "$0: argument 1 must be a non-negative integer"
    exit 1
fi
