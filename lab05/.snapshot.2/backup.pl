#!/usr/bin/perl -w

$i="0";
$file = ".$ARGV[0].$i";

while(-e "$file"){
    $i++;
    $file =".$ARGV[0].$i";
}

use File::Copy; 
copy("$ARGV[0]", "$file");
print "Backup of '$ARGV[0]' saved as '$file'\n";
