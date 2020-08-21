#!/bin/sh

#small less than 10 lines
#medium <100
#otherwise 100
small=""
med=""
large=""

for text_file in *
do
    word_count=`wc -l $text_file|cut -d " " -f1`
    # echo "$text_file has $word_count words"
    if [ $word_count -lt 10 ]
    then
        small+=" $text_file"
    elif [ $word_count -lt 100 ]
    then
        med+=" $text_file"
    else
        large+=" $text_file"
    fi
done

echo "Small files:$small"
echo "Medium-sized files:$med"
echo "Large files:$large"
