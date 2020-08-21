#!/usr/bin/perl -w

$dir1=$ARGV[0];
$dir2=$ARGV[1];


opendir(d1, "$dir1") or die;

@files1 = grep{$_ ne '.' and $_ ne '..'}readdir(d1);

opendir(d2, "$dir2") or die;
@files2 = grep{$_ ne '.' and $_ ne '..'}readdir(d2);

use File::Compare;

for $f1(sort @files1){
    for $f2(sort @files2){
        if("$f1" eq "$f2"){
            if(compare($dir1."/".$f1, $dir2."/".$f2) == 0){
                print "$f1\n";
            }
        }
    }
}

closedir(d1);
closedir(d2);
