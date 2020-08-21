### 2041 Cheatsheet ###
Shoutout to [Luka Kerr](https://lukakerr.github.io/uni/2041-notes) for his notes. Basically an extensive version of what he had. 

## Unix

### `cat`
- copies its input to output unchanged (identity filter)
- when supplied with list of name, concats onto stdout 
```bash
Usage: cat [option][file] 
	- n		number output lines (starting from 1)
	- s 	file.txt 	squeeze consecutive blank lines into single blank line
	- v		display control-characters in visible form (e.g. ^C)

tac [option][file]	reverse order of lines 
```

### `wc` : word count
```bash
Usage: wc [option][file]
	-w		number of words	(non-white space)
	-c		number of characters
	-l		number of lines
	
Output
[how many lines]	[words non-whitespace character]	[number of bytes]
```

### `tr` : transliterate characters

Each input character from *sourceChars* mapped to corresponding character in *destChars*.

 - characters  not in *sourceChars* = copied unchanged to output 
 - if no corresponding character (i.e. *destChars* shorter than *sourceChars*), then the last char in *destChars* is used. 
 - can use shorthands e.g. `a-z`
 - newlines will be modified if mapping specs requires it 

```bash
# replace source characters by destination characters
	tr ’sourceChars’ ’destChars’ < dataFile

# map all characters not occurring in sourceChars (complement)
	tr -c 'srcChars' < file		

# squeeze adjacent repeated characters out (only copy the first)
	tr -s 'srcChars' < file	

# delete all characters in sourceChars (no destChars)
	tr -d 'srcChars' < file	
```

 Examples:
```bash
# map all upper-case letters to lower-case equivalents 
	tr ’A-Z’ ’a-z’ < text 

# simple encryption (a->b, b->c, ... z->a) 
	tr ’a-zA-Z’ ’b-zaB-ZA’ < text 

# remove all digits from input 
	tr -d ’0-9’ < text 

# break text file into individual words, one per line 
	tr -cs ’a-zA-Z0-9’ ’\n’ < text
```

### `grep/ egrep`
```bash
	-i		ignore cases
	-c		count number of lines
	-v		prints inverted matches
```
### `head/ tail` 
default: first/last 10 lines
```bash
	- n 	change number of lines to print
or
# get last 5 lines of file 
	tail -5 file
```
### `cut` : vertical slice
```bash
Usage: cut OPTION [file]
	-f1-5		prints first 5 fields 
	-c1,2,3		print first 3 characters
	-d'c'		c as field seaparator
* Lists can be n-n or comma-separated
```
- no way to refer to "last column" without counting the columns

### `paste` : combine files
Example: using `paste to rebuilt a file broken by cut`
```bash
# assume "data" is a file with 3 tab-separated columns 
	cut -f1 data > data1 
	cut -f2 data > data2 
	cut -f3 data > data3 

	paste data1 data2 data3 > newdata 
# "newdata" should look the same as "data"
```
### `sort`
```bash
Usage: sort [options][files]
	-r 		sort in descending order (reverse sort) 
	-n 		sort numerically rather than lexicographically 
	-d 		dictionary order: ignore non-letters and non-digits 
	-t’c’ 	use character c to separate columns (default: space) 
	-kn’ 	sort on column n

* '' optional - but useful to prevent shell misinterpreting meta-characters e.g. '|'
```

Examples:
```bash
# sort numbers in 3rd column in descending order 
sort -nr -k3 data 
# sort the password file based on user name 
sort -t: -k5 /etc/passwd
```

### `uniq`: remove or count duplicates
How it works: sees 2 lines to determine if they are the same, doesnt print the 2nd one. Sort first --> uniq --> sort 
```bash
-c 		also print number of times each line is duplicated 
-d 		only print (one copy of) duplicated lines 
-u 		only print lines that occur uniquely (once only)

# extract first field, sort, and tally 
cut -f1 data | sort | uniq -c
```

### `xargs`: run command  w/ arguments from stdin
```bash
-n max-args 	Use at most max-args arguments per command line. 
-P max-procs 	Run up to max-procs processes at a time 
-i replace-str 	Replace occurrences of replace-str with words read from stdin
-d delimeter

# remove home directories of users named Andrew: 
grep Andrew /etc/passwd | cut -d: -f6 | xargs rm -r

# replace -i example: 1 2 3 --> 1.txt 2.txt 3.txt
printf "1\n2\n3\n" | xargs -i touch {}.txt 
```
### `join`: database operator
Merges two files using values in a field in each files as a common key. Key field can be in a different position but the files must e ordered on that field. 
- pretty standard stdin and file
- reading from stdin, put a dash in front of it e.g.
`egrep 'COMP' enrollments|sort|join -program_codes`
Default key field: 1 
```bash
-1 k 	key field in first file is k 
-2 k 	key field in second file is k 
-a N 	print a line for each unpairable line in file N (1 or 2) 
-i 		ignore case 
-t c 	tab character is c
```
<a href="https://imgbb.com/"><img src="https://i.ibb.co/1RY3m7N/ss2.png" alt="ss2" border="0"></a>

### `sed`: stream editor
look at [this website for more examples](https://www.tldp.org/LDP/abs/html/x23170.html)
```bash
-n		no printing: editing still applied  
-e		run the expression 
	e.g. sed -e '/\d/DIGIT/g' file.txt - replacing all digits with DIGITS

s/regex/replace/	substitute first match w/ replace
s/regex/replace/g	substitute all matches w/ replace
p 		print the current line 
	# print first 5 lines
	sed -n '1,5p' file 
d		delete (don't print) the current line
q 		terminate execution of sed
	# print the first 10 lines 
	sed -e ’10q’ < file 
	sed -n -e ’1,10p’ < file
/xyz/p	only lines containing xyz
/xyz/d 	lines NOT containing 'xyz'

# appending to beginning of a filename
seq -w 1 100 | sed 's/^/hello/'
Output: hello1
		hello2 etc.
```
### `md5sum/ sha1sum`
Hashing: takes bytes in every file and turns into hashes 
```bash
hash=$(sed "$transform""$filename1"|sort|md5sum)
		echo $hash $filename1
```

### `seq`
```bash
	-w	pads with whitespace 
	-s 	"a" 10
		1a2a3a..
	-f "GFG%02g" 4
		GFG01
		GFG02..
	
```

### `find`
look at last page of lecture 1 
```bash
# find all html files under /home
find /home -name '*.html' -print

# execute command on found files
find  /home -name '*.html' -exec ls -l {} \;
```
## Regex 

|Symbol |      Meaning     | Example
|:----------|:-------------:|:-------------:|
| letter, digits, punctuation|  matches itself|
| `*` |    zero or more repetitions   | ab*c -> ac, abc , abbc
| `|` | union of to patterns | a\|the -> a, the 
| `(..)` | group | 
| `\` | escape next character | 
| `.` (dot) | matches any single character |a.c -> abc, aac,acc,aXc
| `[ABC]` | A or B or C |
| `[^ABC]` | inverted match: not (A or B or C) |
| `[a-z]` | characters from a-z |
| `^pattern` | start of the line  |
| `pattern$` | end of line  |
| `p*` | 0+ repetitions of *p* |
| `p+` | 1+ repetitions of *p* |[0-9]+: any sequence of numbers|
| `p?` | 0 or 1 occurence of *p* |
| `{3}` | exactly 3 |
| `{3,}` | 3 or more |
| `{3,5}` | 3-5 |

## Shell
```bash
#!/bin/sh
set -x  # used for shell debugging

# printing
echo "whatever"

# read a value into variable name 
echo -n "enter your name:"
read name

# iterate counter 
counter=$((counter+1))

$x$y	#appends the 2 values
echo ${j-10} #give value of j or 10 if no value
10
echo ${x:?No Value} #display "No Value" if $x not set 

# cli arguments
$0	 # name of executing program
$1   # first cli argument
$#   # number of cli arguments
$@ 	 # array of cli args 
$*	 # arguments separately 
$? 	 # exit status of previous command 
$$	 # process of current executing shell
		#if theres 2 instances, it gives 2 dif values 


for arg in "$@"   # iterate over cli arguments
do
  echo $arg
done

# redirections
>> outfile 		#append stdout to file outfile 
2>      		# redirect stderr
2>&1 > outfile# redirect stderr and stdout

command > /dev/null 2>&1

# variables
x=5
echo "x = $x"

# conditionals
Usage:
-a	  # logical AND
-o 		#logical OR

Numerical Comparisons
-eq , -ne, -gt, -ge, -lt, -le
<, <= , > , >= 

String Comparisons
=,!=
< 	#less than in ASCII order
>   # in ASCII order 
-z 	#string is null 
-n string not null

File Comparisons

# file diff check
diff $1 $2 > /dev/null/
comp=$? #exit status of previous command 
# Alternatively 
	if diff -iBw tmp1 tmp2 >/dev/null
	then
		echo "$filename1""$filename2" are the same 
	fi 
-i: --ignore-case
-B: blank lines 
-w: whitespace 
# Exit Values of diff: 
0		No differences were found
1 		Differences found
>1		Error occured 


# statements
if [[ 5 -gt 3 ]]   # if statement
then
  echo "do something"
elif [[ 5 -lt 3 ]] #else if 
then
  echo "do something"
fi

while true   # while loop
do
  echo "do something"
done

# checking the number of cla
case $# in   # case statement 
0) echo "do something" ;;
1) .. process the argument... 
*) echo "do something" ;;
esac

#classifying file via name
case "file" in 
*.c) echo "c file" ;;
*.h) echo "h file" ;;
?) default case;; 

# math
sum=0
sum=`expr $sum + 3`
```
## Perl
```perl
#!/usr/bin/perl -w

Other Shebang Options 
-i: inplace changes to file; gives line by line - processes when all done 
-p:	while(<>)
$scalar 
@array
%hash
&subroutine
# printing
print "whatever";

next 	# continue in perl 
last 	#break in perl
# cli arguments
@ARVG   # array of cli arguments

for my $arg (@ARGV) {   # iterate over cli arguments
  print "$arg\n";
}

# variables
$x = 5
print "x = $x\n";

# read from STDIN or input file
while ($line = <>) {
  print $line;
}
$line = <IN> #read next line from stream IN

# open, read and close a file
open F, '<', "file.txt" or die "$!";
for my $line (<F>) {
  print $line;
}
close F;

open RES, '>', results or die "Cant open data:$!"; # write tto file results 
open XTRA, '>>', stuff "Cant open data:$!"; # append to file stuff 
# regex
if ($var =~ m/expr/)         # if regex matches
if ($var !~ m/expr/)         # if regex doesn't match
if ($var =~ /(\d)-(a-z)/)   # regex groups - matches in () are stored in $1 to $9 
$var =~ tr/[a-z]/[A-Z]/     # convert to uppercase
$var =~ s/123/789/          # replace 123 with 789

#comparators
Numeric
==, !=, <, >, <=, >= 
String
eq, ne,  lt, gt, le, ge

<==>
$low =  8;$mid = 10;$hi  = 12;

print($low <=> $mid, "\n"); ⇒ -1: 
print($mid <=> $mid, "\n"); ⇒ 0
print($hi <=> $mid, "\n");	⇒ 1

The program produces the following output:
-1
0
1
cmp

. 		# concatenation string
+= 		#increment 
$y *=2 	#double value of y 
$a .= "abc" #append abc to $a
** 		# power of 
if...elsif...else 

$_	 #default input and pattern match 
@ARGV	#list (array) of cli arg
$0 #name of file 
$i #matching string for ith regex in pattern
$! # last error from system call e.g. open
$. #line number from input file stream
$/ #line seapartor, none if undefined 
$$ #process no. of executing Perl
%ENV #lookup table of environment variables 

#Array Slices
@list = (1, 3, 5, 7, 9); 
print "@list[0,2]\n"; # displays "1 5" 
print "@list[0..2]\n"; # displays "1 3 5" 

#Array Interpolation
@a =(2,3,4); 
@c = (1, @a, 9); ==> (1,2,3,4,9)

push @array, $element; #push to end of array
	#note: can't push empty strings (solution below)
	push @list, $string if $string ne ""

@b = sort(@a) returns sorted version of @a 
@b = reverse(@a) returns reversed version of @a 

shift(@a) # pop from the front (left) 
	e.g. handle_assignment($1, $2); 
	sub  handle_assignment {
		my  $str = shift;
		my  $second_arg = shift;
	} 
	
unshift(@a,x) #places at beginning of array 

split(/pattern/ or character,string) # returns list 

join(string, list) # returns string 

#splitting string to list of chars
split (//,'hello') 

eval $line #executes line if contains perl

(glob("*.c *.h"))

IFS=$'\n' #fixes issues with whitespace filenames 

```
#### Hashes 
```perl
# just keys 
foreach $key (sort keys %myHash) { 
	print "($key, $myHash{$key})\n"; }

# values without keys 
foreach $val (values %myHash) { 
	print "(?, $val)\n"; }

# both together 
while (($key,$val) = each %myHash) { 
	print "($key, $val)\n"; }

#Hash: unique elements in a list 
	%seen = ();
	foreach $item (@list) {
	    push(@uniq, $item) unless $seen{$item}++;
	}

#name count
$name_count{$first_name}++
#remove entry from associative array 
	# remove single pair 
	delete $days{"Mon"};

	#multiple Pairs 
	delete @days{ ("Sat","Sun") };

	#clear whole hash
	%days= (); 
```

POSIX regex
```perl
\d: digits i.e. [0-9]
\w: words [a-zA-Z_0-9]
\s: whitespace [\t\n\r\f]
Capital version = inverse of the lowercase counterparts e.g. \D = non-digits => [^0=9]

#new anchors to regex: 
\b: matches at word boundary
```

