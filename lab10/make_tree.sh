#!/bin/sh
pwd=`pwd`
list=`find $1 | egrep Makefile | sed s?/Makefile??`

commands=`echo "${@:2}"`
for a in $list
do 
    echo "Running make in $a"
    cd $a
    make $commands
    cd $pwd
done 