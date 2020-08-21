#!/usr/bin/perl -w 
open $out, ">", $ARGV[2] or die "cannot open or find out"; 

$first = $ARGV[0];
$last = $ARGV[1];

for(my $i=$first; $i <= $last; $i++){
    print $out "$i\n";
}