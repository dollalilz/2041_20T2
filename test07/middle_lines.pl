#!/usr/bin/perl -w

open F, $ARGV[0] or die;

my @file;
while ($line = <F>) {
	chomp $line;
	push @file, $line;
}

$len = scalar @file;

if ($len == 0) {
} 
else {
    $mid = $#file /2; 
	print $file[$mid],"\n";
	print ($file[$mid+1],"\n") if ($len%2 eq 0);
}