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
    
    $num =log(($word_counter + 1)/ $total); 
    $artist{"total"}= $total; 
    $artist{"calc"} = $num; 
    
    close F;

    printf "log((%d+1)/%6d) = %8.4f %s\n", $artist{"word"}, $artist{"total"}, $artist{"calc"}, $artist{"name"};

}