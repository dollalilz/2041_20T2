#!/usr/bin/perl -w 

# counts the total number of words found in its input (STDIN)
$word_counter = 0;

$find = $ARGV[0]; 


while ($line = <STDIN>){
    chomp $line;
    @words = grep(/./, split(/[^a-zA-Z]/, $line));
    foreach $match (@words){
        if($match =~/^$find$/i){
            $word_counter ++; 
        }
    }
    
}

print "$find occurred $word_counter times \n"