#!/bin/dash

# source: https://www.tutorialspoint.com/unix/if-elif-statement.htm

a=10
b=20

if test $a -eq $b 
then
   echo "a is equal to b"
elif test $a -gt $b
then
   echo "a is greater than b"
elif test $a -lt $b 
then
   echo "a is less than b"
else
   echo "None of the condition met"
fi