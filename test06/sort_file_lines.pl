#!/usr/bin/perl -w

while (<>){
    push @print, $_; 
}
@yes = sort @print; 
print sort {length $a <=> length $b}@yes;
