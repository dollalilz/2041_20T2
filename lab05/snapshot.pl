#!/usr/bin/perl -w

use File::Copy; 

my $dirname='.'; 
opendir my($dh), $dirname or die "Couldn't open dir '$dirname': $!";
my @files = readdir $dh;
closedir $dh;

my @string= split('./',$0);
$comp = $string[1];

for (@files){
    if (($_ !~/^\..*/) && ($_ ne $comp)){
        push @new, $_; 
    }
}

sub save_snapshot{
    my $i="0";
    $dir = ".snapshot.$i";

    while(-e "$dir"){
        $i++;
        $dir =".snapshot.$i";
    }

    mkdir $dir;
    print "Creating snapshot $i\n"; 

    for (@new){
        copy("$_", "$dir");
    }
}

sub copy_all{
    $openthis= $_[0];
    opendir my($dh), $openthis or die "Couldn't open dir '$openthis': $!";
    my @inside = grep !/^[.][.]?$/, readdir $dh;
    closedir $dh;

    chomp @inside; 
    foreach $i (@inside){
            #print($i);
            copy("$openthis/$i", "."); 
    }
}

if ($ARGV[0] eq "save"){
    save_snapshot();
}
elsif($ARGV[0] eq "load"){
    $backup=".snapshot.$ARGV[1]";
    if (-e "$backup"){
        save_snapshot();
        unlink @new; 
        print "Restoring snapshot $ARGV[1]\n";
        copy_all($backup); 
    }
}

#print "@new\n";
