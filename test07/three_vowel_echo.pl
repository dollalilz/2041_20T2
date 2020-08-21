#!/usr/bin/perl -w

@array =  grep(/.*[aeiouAEIOU][aeiouAEIOU][aeiouAEIOU].*/,@ARGV); 

$string = join(" ", @array);
print ("$string\n");