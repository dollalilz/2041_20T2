#!/usr/bin/perl -w 

open $in ,"<", $ARGV[1] or die "$0: cant be opened";

@lines = <$in>;

