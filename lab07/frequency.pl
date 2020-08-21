#!/usr/bin/perl -w 
$find = $ARGV[0];

foreach $file (glob "lyrics/*.txt") {
    $word_counter = 0;
    $total = 0;
    chomp $file;
    open F, "<", $file or die "Can't open $file\n";
    while ($line = <F>){
        chomp $line;
        @words = grep(/./, split(/[^a-zA-Z]/, $line));
        foreach $match (@words){
            if($match =~/^$find$/i){
                $word_counter ++; 
            }
        $total++; 
        }
    }

    $file =~s/.txt//;
    $file =~s/lyrics\///;
    $file =~tr/_/ /;

    $artist{"name"}= $file;
    $artist{"word"}= $word_counter; 
    $artist{"total"}= $total; 
    close F;

    printf "%4d/%6d = %.9f %s\n", $artist{"word"}, $artist{"total"}, $artist{"word"} / $artist{"total"}, $artist{"name"};
}