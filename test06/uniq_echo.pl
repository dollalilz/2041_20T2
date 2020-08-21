#!/usr/bin/perl -w

%repeat= ();
foreach $item (@ARGV) {
    push(@list, $item) unless $repeat{$item}++;
}

$out = join(" ", @list);
print("$out\n"); 