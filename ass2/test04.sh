#!/bin/dash

a=20
b=40
# multiple for loops nested in if statement 
# if 20 == 40 
if test $a -eq $b
then
    for i in 1 2 3
    do
        echo $i
    done
else
    # if 40 > 20 
    if test $b -gt $a
    then
        # test single list 
        for j in 3
        do
            echo $j
        done
    else
        for k in 4 5 6
        do
            echo $k
        done 
    fi
fi 

