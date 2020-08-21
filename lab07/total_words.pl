#!/usr/bin/perl -w 

# counts the total number of words found in its input (STDIN)
$word_counter = 0;


while ($line = <STDIN>){
    chomp $line;
    @words = grep(/./, split(/[^a-zA-Z]/, $line));
    $word_counter = scalar(@words)+ $word_counter;
    
}

print $word_counter, " words\n";