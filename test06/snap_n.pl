#!/usr/bin/perl -w
$match = $ARGV[0];

while ($line = <STDIN>) {
    chomp $line;
    if (exists($hash{$line})) {
        if ($hash{$line} == $match) {
            print "Snap: $line\n";
            last;
        }
        else {
            $hash{$line}++;
            if ($hash{$line} == $match) {
            print "Snap: $line\n";
            last;  
        }
        }
    }
    else {
        $hash{$line} = 1;
    }
}