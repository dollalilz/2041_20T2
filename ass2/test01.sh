#!/bin/dash

# globbing 2 types of files 

# SETUP: 
# touch a.c a.h b.c b.h
# assumed: test in current directory 

for a in *.[ch]
do
    echo $a
done 

# test ?? parsing 
for a in test??.sh
do
    echo $a
done 

# no .; just all files 
for a in *
do
    echo $a 
done

# REMOVE TEST FILES:
# rm a.c a.h b.c b.h


