#!/usr/bin/perl -w
if (@ARGV == 2){
    if ($ARGV[0] =~ /^[0-9]+/ && $ARGV[0] >= 0){
        foreach $a(0..$ARGV[0]-1){
        print $ARGV[1],"\n";
        }
    }   
    else{
        print "$0: argument 1 must be a non-negative integer\n";
    }
}
else{
    print "Usage: $0 <number of lines> <string>\n";
}