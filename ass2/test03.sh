#!/bin/dash
# echo in test03.sh

# # exit with no integer condition 
# exit

# nested while loop 
i=0
j=0

# square brackets instead of test 
while [ $i -lt 5 ]
do
    while [ $j -lt 5 ]
    do 
        echo $i, $j 
        j=`expr $j + 1`
    done
    i=`expr $i + 1`
done