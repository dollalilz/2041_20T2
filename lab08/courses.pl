#!/usr/bin/perl -w

use LWP::Simple;
use IO::String;

%seen =();
@uniq =(); 

my $web_page = IO::String->new(get("http://www.timetable.unsw.edu.au/current/${ARGV[0]}KENS.html"));
while (defined (my $line = <$web_page>)) {
    if($line =~ /$ARGV[0]/ && $line !~ /$ARGV[0].*$ARGV[0]/){
        my $description = $line; 
        @des = split /href=/, $description;

        my $hi = $des[1]; 
        $hi =~ s/<\/a><\/td>//g; 
        $hi =~ s/["]//g; 
        $hi =~ s/\.html//g; 
        my @full = split />/, $hi;
        $hi = join ' ', @full; 

        #unique cases 
        unless($seen{$hi}){
            $seen{$hi} = 1;
            push (@uniq, $hi); 
        }
    }
    else{
        next; 
    }
}
close $web_page;

foreach (sort @uniq){
    print $_; 
}