## Test Solutions 
### Week 3
first_name.sh
```bash 
#!/bin/sh

egrep 'COMP[29]041' "$1"|
cut -d\| -f3|
cut -d, -f2|
cut -d\  -f2|
sort|
uniq -c|
sort -nr|
head -1|
sed 's/.* //'
```
htm2html.sh
```bash
#!/bin/sh

for file in *.htm
do
    new_file_name="$file"l
    if test -e "$new_file_name"
    then
        echo "$new_file_name exists"
        exit 1
    else
        mv "$file" "$new_file_name"
    fi
done
exit 0
```
missing_include.sh 
```bash
#!/bin/sh

for c_file in "$@"
do
    for include_file in `egrep '^#include *"' "$c_file"|sed 's/" *$//;s/.*"//'`
    do
        if test ! -r "$include_file"
        then
            echo "$include_file included into $c_file does not exist"
        fi
    done
done
```
### Week 4
create_integers_file.sh
```bash
#!/bin/bash

start=$1
finish=$2
filename="$3"

i=$start
while ((i <= finish))
do
    echo $i
    i=$((i + 1))
done >$filename
```
create_integers_file.pl
```perl
#!/usr/bin/perl -w

# create a file containing numbers min..max 1 per line
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

die "Usage: $0 <min> <max> <file>\n" if @ARGV != 3;

$min = $ARGV[0];
$max = $ARGV[1];
$file = $ARGV[2];

open F, '>', $file or die "$0: ca not open file: $!\n";

foreach $i ($min..$max) {
    print F "$i\n";
}

close F;
```
```perl
ARGV == 3 and open F, '>', $ARGV[2] or die;
print F join("\n", ($ARGV[0]..$ARGV[1])), "\n";
```
nth_line.pl
```perl
!/usr/bin/perl -w

# print nth-line of a file
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

die "Usage $0: <n> <file>\n" if @ARGV != 2;

open F, "<", $ARGV[1] or die "$0: can not open $ARGV[1]: $!\n";
$line_number = 1;
while ($line = <F>) {
    if ($line_number == $ARGV[0]) {
        print $line;
        last;
    }
    $line_number++;
}
```
```perl
# more concise but less readable solution

$target_line_number = shift @ARGV or die "Usage $0: <n> <file>\n";
$. == $target_line_number and print while <>;
```
### Week 5 
sort_words.pl
```perl 
#!/usr/bin/perl -w

# sort words on each line of STDIN
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

while ($line = <STDIN>) {
    my @words = split /\s+/, $line;
    my @sorted_words = sort @words;
    print join(" ", @sorted_words), "\n";
}
```

```perl
print join(" ", sort split), "\n" while <STDIN>;
```

replace_digits.pl
```perl
#!/usr/bin/perl -w

# replaced digits in specified files with #s
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

foreach $file (@ARGV) {
    open my $f, '<', $file or die "Can not open $file: $!";
    @lines = <$f>;
    close $f;

    foreach $line (@lines) {
        $line =~ s/\d/#/g;
    }

    open my $g, '>', $file or die "Can not open $file: $!";
    print $g @lines;
    close $g;
}
```
```perl
#!/usr/bin/perl -pi
s/\d/#/g
```

identical_files.pl
```perl
#!/usr/bin/perl -w

# test if files all contain identical contents
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

die "Usage: $0 <files>\n" if !@ARGV;

sub read_file {
    my ($file) = @_;
    open my $f, '<', $file or die "$0: can not open file $file: $!\n";
    my @lines = <$f>;
    close $f;
    return join "", @lines;
}

$first_file_contents = read_file($ARGV[0]);

for $file (@ARGV[1..$#ARGV]) {
    if (read_file($file) ne $first_file_contents) {
        print "$file is not identical\n";
        exit 0;
    }
}
print "All files are identical\n";
```
```perl
#!/usr/bin/perl -w

# test if files all contain identical contents
# concise less-readable version  (note Perl close file when open next file)

foreach $file (@ARGV) {
    open F, '<', $file or die "$0: can not open file $file: $!\n";
    $contents = join "", <F>;
    if (!defined $first_file_contents) {
        $first_file_contents = $contents;
    } elsif ($first_file_contents ne $contents) {
        print "$file is not identical\n";
        exit 0;
    }
}
print "All files are identical\n";
```
### Week 6 
uniq_echo.pl 
```perl
#!/usr/bin/perl -w

# print command line arguments unless they are a repeat
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

foreach $argument (@ARGV) {
    next if $arguments_seen{$argument};
    print " " if %arguments_seen;
    print $argument;
    $arguments_seen{$argument} = 1;
}

print "\n";
```
```perl
#!/usr/bin/perl -w

# print command line arguments unless they are a repeat
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution
# more concise less readable version

my %seen; # avoid warning
print join(" ", grep(!$seen{$_}++, @ARGV)), "\n"
```
snap_n.pl
```perl
#!/usr/bin/perl -w

# Stop after a line oN STDIN is seen n times, n is supplied as a command line argument
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

die "Usage: $0 <n>" if @ARGV != 1;

my $snap_after_n_repeats = $ARGV[0];
my %line_repeats;

while ($line = <STDIN>) {
    $line_repeats{$line}++;

    if ($line_repeats{$line} >= $snap_after_n_repeats) {
        print "Snap: $line";
        last;
    }
}
```
sort_file_lines.pl
```perl
#!/usr/bin/perl -w

# print the lines of a files sorted on length, shortest to longest
# if lines are of equal length they sorted alphabetically
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

sub compare {
    my $a_length = length $a;
    my $b_length = length $b;
    if ($a_length == $b_length) {
        return $a cmp $b;
    } else {
        return $a_length <=> $b_length;
    }
}

die "Usage $0: <file>\n" if @ARGV != 1;
open my $f, "<", $ARGV[0] or die "$0: can not open $ARGV[0]: $!\n";
@lines = <$f>;
close $f;

@sorted_lines = sort compare @lines;

print @sorted_lines;

exit 0;
```

```perl
#!/usr/bin/perl -w

# print the lines of a files sorted on length, shortest to longest
# if lines are of equal length they sorted alphabetically
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution
# more concise but less readable solution

print sort {length $a <=> length $b || $a cmp $b} <>;
```
### Week 7
three_vowel_echo.pl 
```perl
#!/usr/bin/perl -w

# print command line arguments which contain 3 consecutive vowels
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

my $n_printed = 0;
foreach $argument (@ARGV) {
    if ($argument =~ /[aeiou][aeiou][aeiou]/i) {
        print " " if $n_printed++;
        print $argument;
    }
}
print "\n";
```
```perl
#!/usr/bin/perl -w

# print command line arguments which contain 3 consecutive vowels
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution
# more conise less readable version

print join(" ", grep(/[aeiou][aeiou][aeiou]/i, @ARGV)), "\n"
```
middle_lines.pl
```perl
#!/usr/bin/perl -w

# print middle lines of a file
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

open F, '<', $ARGV[0] or die;
my @lines = <F>;
close F;

if (!@lines) {
    # no lines
} elsif (@lines % 2 == 1) {
    # odd number of lines
    print $lines[$#lines/2];
} else {
    # even number of lines
    print $lines[$#lines/2];
    print $lines[$#lines/2 + 1];
}
```
```perl
#!/usr/bin/perl -w

# print middle lines of a file
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution
# more conise less readable version

my @lines = <>;
print @lines[(@lines-1)/2..((@lines-1)/2 + 1 - (@lines%2))] if @lines;
```
largest_numbered_line.pl 
```perl
#!/usr/bin/perl -w

# print line of a file containing largest number
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

while ($line = <STDIN>) {
    my @line_numbers = $line =~ /\-?(?:\d+\.?\d*|\.\d+)/g;
    if (@line_numbers) {
        my $largest_line_number = (sort {$b <=> $a} @line_numbers)[0];
        push @numbers, $largest_line_number;
        push @lines, $line;
    }
}

if (@numbers) {
    my $largest_number = (sort {$b <=> $a} @numbers)[0];
    foreach $i (0..$#numbers) {
        if ($numbers[$i] == $largest_number) {
            print $lines[$i];
        }
    }
}
```
```perl
#!/usr/bin/perl -w

# print line of a file containing largest number
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution
# more concise less readable version

push @numbers, /\-?(?:\d+\.?\d*|\.\d+)/g foreach @lines = <STDIN>;
exit if !@numbers;
$largest = (sort {$b <=> $a} @numbers)[0];
(sort {$b <=> $a} /\-?(?:\d+\.?\d*|\.\d+)/g)[0] == $largest && print foreach @lines;
```

### Week 8
median_number.pl
```perl
#!/usr/bin/perl -w

# print the median value of positive numbers supplied as arguments
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

die "$0: number of numbers supplied as arguments must be odd\n" if @ARGV % 2 != 1;

my @sorted_numbers = sort {$b <=> $a} @ARGV;
my $median_index = @sorted_numbers / 2;
my $median_number = $sorted_numbers[$median_index];
print "$median_number\n";
```
```perl
#!/usr/bin/perl -w

# print the median value of positive numbers supplied as arguments
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution
# one line version

print(((sort {$b <=> $a} @ARGV)[@ARGV/2]),"\n");
```
ls_identical.sh 
```bash
#!/bin/bash

# list identical files in the two directories given as arguments
# files starting with . are ignored
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

if test "$#" != 2
then
    echo "Usage: $0 <directory1> <directory2>" 1>&2
    exit 1
fi

directory1="$1"
directory2="$2"

for file in "$directory1"/*
do
    # compare file to coressponding file in directory2
    # any error message e.g. if file not present in directory2
    # is directed to /dev/null

    if diff "$file" "$directory2" >/dev/null 2>&1
    then
        basename "$file"
    fi
done
```
```bash
# list identical files in the two directories given as arguments
# files starting with . are ignored
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution
# terse less readable version

#test "$#" != 2 &&  echo "Usage: $0 <directory1> <directory2>" 1>&2 && exit 1
for file in "$1"/*
do
    diff "$file" "$2" >/dev/null 2>&1 && basename "$file"
done
```
ls_identical.pl
```perl
#!/usr/bin/perl -w

# list identical files in the two directories given as arguments
# files starting with . are ignored
# written by andrewt@unsw.edu.au as COMP[29]041 sample solution

sub main() {
    die "Usage: $0 <directory1> <directory2>\n" if @ARGV != 2;
    for $file1 (sort glob "$ARGV[0]/*") {
        my $basename = $file1;
        $basename =~ s/.*\///;
        my $file2 = "$ARGV[1]/$basename";
        if (identical_files($file1, $file2)) {
            print "$basename\n" if -r $file2;
        }
    }
}

sub identical_files {
    my ($file1, $file2) = @_;
    return 0 if !-r $file1 or !-r $file2;
    return read_file($file1) eq read_file($file2);
}

sub read_file {
    my ($file) = @_;
    open my $f, '<', $file or die "$0: can not open file $file: $!\n";
    my @lines = <$f>;
    close $f;
    return join "", @lines;
}

main()
```

### Week 9
distinct_lines.pl 
```perl
#!/usr/bin/perl -w

$n_distinct_lines_needed = shift @ARGV or die;

$n_lines = 0;
while ($line = <STDIN>) {
    $n_lines++;
    $line = lc $line;
    $line =~ s/\s//g;
    $lines_seen{$line}++;
    if (keys %lines_seen >= $n_distinct_lines_needed) {
        print "$n_distinct_lines_needed distinct lines seen after $n_lines lines read.\n";
        exit 0;
    }
}
print "End of input reached after $n_lines lines read - $n_distinct_lines_needed different lines not seen.\n";
```
```perl
#!/usr/bin/perl -w

while (<STDIN>) {
    s/\s//g;
    $lines_seen{lc $_}++;
    if (keys %lines_seen >= $ARGV[0]) {
        print "$ARGV[0] distinct lines seen after $. lines read.\n";
        exit 0;
    }
}

print "End of input reached after $. lines read - $ARGV[0] different lines not seen.\n";
```
eating.sh
```bash
#!/bin/sh

# Tally supermarket bills in a file
# andrewt@unsw.edu.au for a COMP[29]041 exercise
# Lines in file have this format
# {"name": "Peanut Butter", "price": "$6.93"},

egrep '"name"' "$1"|
cut -d\" -f4|
sort|
uniq
```
```bash
#!/bin/sh

# Tally supermarket bills in a file
# andrewt@unsw.edu.au for a COMP[29]041 exercise
# Lines in file have this format
# {"name": "Peanut Butter", "price": "$6.93"},

egrep '"name"' "$1"|
sed '
 s/.*"name": "//
 s/".*//
 '|
sort|
uniq
```
json_count.pl
```perl
#!/usr/bin/perl -w

# Count  observations of a whale species in a file
# andrewt@unsw.edu.au for a COMP[29]041 exercise

die "Usage: $0 <whale species> <file>\n" if @ARGV != 2;

$target_species = $ARGV[0];
$filename = $ARGV[1];

my $n_whales = 0;

open my $f, $filename or die "Can not open $filename\n";

while ($line = <$f>) {
    if ($line =~ /"how_many": (\d+)/i) {
        $how_many = $1;
    } elsif ($line =~ /"species": "(.*)"/i) {
        my $species = $1;
        if ($species eq $target_species) {
            $n_whales += $how_many;
        }
    }
}

close $f;

print "$n_whales\n";
```
```perl
#!/usr/bin/perl -w

#Count  observations of a whale species in  1 or more files
# andrewt@unsw.edu.au for a COMP[29]041 exercise
# terse less readable version

die "Usage: $0 <whale species> <files>\n" if @ARGV != 2;

$target_species = shift @ARGV;
while (<>) {
    $how_many = $1 if /"how_many": (\d+)/i;
    $n_whales += $how_many if /"species": "$target_species"/i;
}
print "$n_whales\n";
```

### Week 10
remove_repeats.pl
```perl
foreach $arg (@ARGV) {
    next if $seen{$arg};
    print "$arg ";
    $seen{$arg} = 1;
}
print "\n";
```
```perl
#!/usr/bin/perl
my %seen;
print join(" ",grep(!$seen{$_}++, @ARGV)), "\n";
```
text_round.pl
```perl
#!/usr/bin/perl -w

while ($line = <>) {
    while ($line =~ /(\d+\.\d+)/) {
        my $number = $1;
        $number =~ /^(\d+)/;
        my $rounded_number = $1;
        if ($number =~ /\.[5-9]/) {
            $rounded_number++;
        }
        $line =~ s/$number/$rounded_number/;
    }
    print $line;
}
```
```perl
#!/usr/bin/perl -wp
s/(\d+\.\d+)/int($&+0.5)/eg;
```
reference.pl
```perl
#!/usr/bin/perl -w
@a = <STDIN>;
foreach $i (0..$#a) {
    if ($a[$i] =~ /^#(\d+)/) {
        $a[$i] = $a[$1 - 1];
    }
}
print @a;
```
```perl
#!/usr/bin/perl -w
@a = <STDIN>;
/^#(\d+)/ and $_ = $a[$1 - 1] foreach @a;
print @a;
```
