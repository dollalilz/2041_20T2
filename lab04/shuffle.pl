#!/usr/bin/perl -w

#perl ignores the fractional part of a number if you use it 
@file = <STDIN>; 
$len = scalar(@file);

@output = (); 

for( my $x = 0; $x < $len; $x++){
    $rand = int(rand($len)); 
    if($rand ~~ @output){
        $x = $x -1; 
        next; 
    }
    push @output, $rand;
    print "$output[$x]\n"; 
}

# foreach $line($file){
#     $rand = rand(scalar(@input)); 
#     push @new, $rand; 

#close <STDIN>; 

# print "$_\n" for @new;


