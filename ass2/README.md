## About ##
shell  --> perl translator 
- kinda like a compilor

Task -
write a lot of shell code to perl 
- keep using 
- compilors to translate languages
- has to perfect translation- but dont care about readability of the machine code
    - easier for us to keep maintaining : 95% (5% human)
sidenote: compilors leave some sort of translation. 
e.g. 

```$cat gcc.sh
#!/bin/dash
for c_file in *.c
do
    gcc -c $c_file
done
```
*.c : useful for when we accidently type something - fail to glob and pass it through
` $ grep a.*b file.txt `
- the shell will try to expand that: shell just passes through a.*b to grep
- semantics not really designed for


glob in perl: provides the same matching in the shell
- if no .c files; returns an empty list
- this is the natural translation that we want 
- changes the natural semantics but not the exact and only answer
- the most human readable code 
```./sheeple.pl gcc.sh
#!/usr/bin/perl -w
foreach $c_file (glob("*.c")) {
    system "gcc -c $c_file";
}
```

##### MOST IDEAL #####
```
#!/usr/bin/perl -w
if (glob("*.c") {
    foreach $c_file (glob("*.c")) {
       system "gcc -c $c_file";
    }
} else {
    system "gcc -c '*.c'";
}
```

### SUBSET ### 
- what special characters in the shell 
- their definition of POSIX standard - only the stuff on bin dash not !bash

#### 0: #### 
- linear
- =: variable assignment but can rule out arithmetic cos other characters are not there
    - but you dont have the $(()) - so its not fully 
#### 1: #### 
- adds more characters - can be overloaded in the shell 
- keywords+ built-ins 
- no nesting or loops
#### 2: #### 
#### 3: #### 
#### 4: #### 
#### 5: #### 

e.g. dont need to necessarily be an exact translation- not absolute
- checks for indentation for style mark
- can assume the for loop isnt on 1 line 