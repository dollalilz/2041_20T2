#!/bin/dash

#source: https://www.tutorialspoint.com/unix/while-loop.htm#:~:text=The%20while%20loop%20enables%20you,value%20of%20a%20variable%20repeatedly.
a=0
while [ $a -lt 10 ]
do
   echo $a
   a=`expr $a + 1`
done