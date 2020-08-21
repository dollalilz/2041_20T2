#!/usr/bin/perl -w 
foreach $file (glob "lyrics/*.txt") {
    $file =~s/.txt//;
    $file =~s/lyrics\///;
    $file =~tr/_/ /;
    print "$file\n";
}