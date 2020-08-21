#!/bin/dash

curr_file=`echo $0| cut -c 3-`

i=0
curr=".snapshot.$i"
while :
do
    if test -d $curr
    then
        i=`expr $i + 1`
        # echo $i
        curr=".snapshot.$i"
    else 
        echo "Creating snapshot $i"
        mkdir $curr
        break; 
    fi
done

for i in *
do
    if cmp -s "$i" "$curr_file"
    then 
        continue 
    else
        # echo $i 
        cp "$i" "$curr"
    fi
    
done