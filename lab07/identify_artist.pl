#!/usr/bin/perl -w 
my %compWords;
my %count; #word frequency in a file 
foreach my $arg(@ARGV){
    if($arg eq "-d"){
        print "hi"; 
        last;  
    }
    else{
        open F, $arg or die;
        while ($line = <F>){
            chomp $line; 
            @words = grep(/./, split(/[^a-zA-Z]/, $line));
            foreach $word (@words){
                $count{$word}++; 
            }
        }
    }
    print "FILE : $arg\n"; 
    foreach my $str (sort keys %count){
        printf "%s : %d\n ", $str, $count{$str}; 
    }
}
