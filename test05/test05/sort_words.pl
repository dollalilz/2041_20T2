#!/usr/bin/perl -w

@lines = <STDIN>;

foreach my $line (@lines){
    chomp $line;
    @words = split /\s+/, $line;
    @words = sort @words;
    $printthis = join(' ',@words);
    print "$printthis\n";
}