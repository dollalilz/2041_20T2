#!/bin/dash

# the test cases are all in the demo files. please refer to them 
# ./demo00.sh > output_sh
# ./sheeple.pl demo00.sh > translated.pl
# ./translated.pl > output_pl
for a in demo??.sh
do  
    if test $a=demo02.sh
    then
        continue
    fi
    ./$a > output_sh
    ./sheeple.pl $a > translated.pl
    ./translated.pl> output_pl
    
    diff output_pl output_sh > /dev/null 
    if test $? -eq 0
    then 
        echo "$a passed"
    else
        diff -c output_pl output_sh
        echo "$a failed"
    fi
done

for a in test??.sh
do
    ./$a > output_sh
    ./sheeple.pl $a > translated.pl
    ./translated.pl> output_pl
    
    diff output_pl output_sh > /dev/null 
    if test $? -eq 0
    then 
        echo "$a passed"
    else
        diff -c output_pl output_sh
        echo "$a failed"
    fi
done

rm output_pl
rm output_sh
rm translated.pl