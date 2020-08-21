#!/usr/bin/perl -w

sub generate_before(){
	use POSIX qw(strftime);
	my $now_string = strftime "%a %b %e %H:%M:%S AEST %Y", localtime;
	print ("# Makefile generated at " . $now_string  . "\n");
	print ("\n");
	print ("CC = gcc\n");
	print ("CFLAGS = -Wall -g\n");
	print ("\n");

}
sub generate_main_files(){
	#%seen = ();
	@files = sort(glob("*.c"));
	for $file(@files){
		open (F, '<', $file) or die "cant open $file";
		$temp_file = substr($file, 0, -2);
		while (<F>){
			if ($_ =~/^\s*(int|void)\s*main\s*\(/){
				print ($temp_file . ":\t");
			}
		}
		close F;
		$temp_file = $temp_file . ".o";
		push (@uniq, $temp_file); 
	}
	$ret = join(" ",@uniq);
	print ($ret . "\n");
	print ("\t\$(CC) \$(CFLAGS) -o \$@ " . $ret . "\n");
	print ("\n");


	# look through the c files and print the ones t
	#f

	chomp @uniq; 
	for $i(sort @uniq){
		chomp $i;
		# raw file with no suffixth
		my @filelist;
		my $temp_str = substr($i, 0, -2);
		#print ($temp_str . "\n");
		# open the .c versions
		if (-e $temp_str . ".c"){
			open (F, '<', $temp_str . ".c") or die "cant open $temp_str";
			while (<F>){
				# extract the
				if ($_ =~/^#include ".*"$/){
					#print($_);
					my @line  =split / /, $_;
					$cut_word = $line[1];
					$cut_word =~ s/"//g;
					#print ("include file: " . $cut_word);
					push(@filelist, $cut_word);
				}
			}
			close F;
			print ("$i:\t");
			for $f(@filelist){
				chomp $f;
				print ("$f ");
			}
			print ($temp_str . ".c\n");
			#print ($i . ":  " . join(" ",@filelist) . $temp_str . ".c" . "\n");
		}
		else {
			next;
		}

	}
}



generate_before;
generate_main_files;