#!/usr/bin/perl -w

open my $in, '<', $ARGV[0] or
	die "$0: open of $ARGV[0] failed: $!\n"; 
@lines = <$in>;
close $in; 

open my $out, '>', $ARGV[0] or 
	die "$0: open of $ARGV[0] failed: $!\n";

foreach my $line (@lines){
    $line =~ tr/[0-9]/#/;
    print $out $line;
}

close $out; 
