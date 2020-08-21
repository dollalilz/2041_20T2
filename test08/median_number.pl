#!/usr/bin/perl -w


# sort and get the middle
@sorted = sort {$a <=> $b } @ARGV;

$mid = $#sorted/2; 
print $sorted[$mid],"\n";
