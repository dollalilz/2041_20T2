#!/usr/bin/perl -w 

$find = $ARGV[0]; 

open $in, "<", $ARGV[1] or die "$0: cannot be opened"; 

#loop through the thing
$i = 1; 
while ($line = <$in> ){
    if ($i == $find){
        print $line;
        last;
    }
    $i ++; 
}