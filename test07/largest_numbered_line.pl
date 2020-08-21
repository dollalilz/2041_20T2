#!/usr/bin/perl -w


my $curr; 
my $max; 
while ($line = <STDIN>) {
    chomp $line;
    my @out = $line=~ /[-+]?[0-9]*\.?[0-9]+/g;
    for $hi (@out){
        if (!$curr || $hi > $curr){
            $curr = $hi; 
            $max = "$line\n"; 
        }
        elsif ($curr eq $max){ 
            $max =  $max . "$line\n";
        }
    }
}

print $max if $max; 

