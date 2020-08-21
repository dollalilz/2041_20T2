#!/bin/dash

# testing all numerical and string comparisons 
var1=10
var2=20
var3=Hi
var4=10 


# 20 > 10 test condition 
if test $var2 -gt $var1
then
    echo "$var2 is greater than $var1"
fi
# 10 < 20  
if test $var1 -lt $var2
then
    echo "$var1 is smaller than $var2"
fi

# 10 == 10  
if test $var1 -eq $var4
then
    echo "values are same "
fi

if test $var1 -ne $var2
then
    echo "values are not equal  "
fi

# 10 =< 10 
if test $var1 -le $var4
then
    echo "$var1 is le $var4"
fi

# 20 >= 10 
if test $var2 -ge $var1
then
    echo "var1 is smaller than $var2"
fi


# string tests
if test -n $var3
then
    echo "$var3 exists"
else
    echo "$var3 doesnt exist"
fi

if test -z $var1
then
    echo "$var1 exists"
else
    echo "$var1 doesnt exist"
fi
