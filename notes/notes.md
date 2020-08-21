## Unix Processes 
- A Unix process executes in this environment

**Filter** = a program that transforms a data stream

#### Unix Filter Commands:

 - read text from their standard input or specified files 
- perform useful transformations on the text stream
- write the transformed text to their standard output 

```
cat MyProg.c
# reads text of the program in the file MyProg.c
# writes the (untransformed) text to standard output (i.e. the screen) 

cat <MyProg.c
# shell (command interpreter) connects the file MyProg.c to standard input of cat
# cat reads its standard input 
# writes the (untransformed) text to standard output ( i.e. the screen) 
```
##### Command Interpreters
Aim: allow users to execute commands provided on a computer system 
Comes in 2 flavours:
1. Graphical (e.g. Windows/ Mac desktop): east for naive users to start using system 
2. Command-line (e.g. Unix Shell) : programmable, powerful tool for experts 
#### Filters 

- Shell I/O: used to specify filter source and destination 
- Alternate: filters allows multiple sources to be specified
- pipeline to combine filters 
- similar style of problem solve to function composition 

Unix filters conventions for command line arguments: 

 - input can be specified  by a list of file names 
 - no files are mentioned, reads from standard input 
 - filename "-" corresponds to standard input 

Difference between `$@` and `$*`: 
- $*: want to preserve the argument string thats passed
- $@: argument spaces are broken up
```
# read from the file data1 
filter data1 
# or 
filter < data1 

# read from the files data1 data2 data3 
filter data1 data2 data3 

# read from data1, then stdin, then data2 
filter data1 - data2
```

Filters normally perform multiple variations on a task.  Selection of the variation via command-line options:

 - options are introduced by a - ("minus" or "dash") 
 - options have a "short" form, - followed by a single letter (e.g. `-v`) 
 - options have a "long" form, – followed by a word (e.g. `–verbose`) 
 - short form options can usually be combined (e.g. `-av` vs `-a -v`) 
 - help (or `-?`) often gives a list of all command-line options

#### Filters: Option

Find what filters are available: `man -k keyword` The solution to all your problems: **RTFM**

#### Delimited Input 
- works w/ text data formatted as fields (like columns)
- option for specifying the delimiter/ field separator 
- make assumptions about the default column separator 
- e.g. : or | etc.

#### `egrep`: Globally search w/ Regular Expression and Print
 - `grep` 
	 - uses a limited form of POSIX regular expressions (no + ? | or parentheses) 
 - `egrep/grep -E (extended grep)` 
	 - implements full regex syntax
 -  `fgrep or grep -F `
	 - finds any of several (maybe even thousands of) fixed strings using an optimised algorithm. 
 - `grep -P `
	 - Perl-like extended regular expressions


#### `paste`
The paste command displays several text files "in parallel" on output. If the inputs are files a, b, c 
- the first line of output is composed of the first lines of a, b, c
- the second line of output is composed of the second lines of a, b, c 

Lines from each file are separated by a tab character or specified delimiter(s). 
If files are different lengths, output has all lines from longest file, with empty strings for missing lines.
Interleaves lines instead with -s (serial) option.

#### `sort`: sort lines
Copies input to output- rearranging particular order of lines
By default, sorting based on first characters in the line;
Other features: 

 - understands that text data sometimes occurs in delimited fields. (so, can also sort fields (columns) other than the first (which is the default)) 
 - can distinguish numbers and sort appropriately 
 - can ignore punctuation or case differences 
 - can sort files "in place" as well as behaving like a filter 
 - capable of sorting very large files
 
#### `sed`: stream editor 
The sed command provides the power of interactive-style editing in “filter-mode”. 
Invocation: 
`sed -e ’EditCommands’ DataFile `
`sed -f EditCommandFile DataFile`
How sed works: 
- read each line of input 
- check if it matches any patterns or line-ranges 
- apply related editing commands to the line 
- write the transformed line to output

The editing commands are very powerful and subsume the actions of many of the filters looked at so far. In addition, sed can: 
- partition lines based on patterns rather than columns 
- extract ranges of lines based on patterns or line numbers 

### `find`: search for files
The find commands allows you to search for files based on specified properties (a filter for the file system) 
- searches an entire directory tree, testing each file for the required property. 
- takes some action for all "matching" files (usually just print the file name) 

Invocation: 
	`find StartDirectory Tests Actions `
where
-  the Tests examine file properties like name, type, modification date 
- the Actions can be simply to print the name or execute an arbitrary command on the matched file


###`xargs` and `rm`
Potential issues with rm: 
- breaks if the filenames has whitespace but its not allowed  to have whitespace --> xargs echo. 
	- which read lines of output and passes it onto echo 
	- uses: lets you pivot where you stream of data is coming from 
	- xargs knows you can't have too many arguments and wil stop at some point 
	- assume at default that the program can be run many times 

rm *: limit to  the size that you can pass
#### Regular Expressions
A *regular expression* (regex) defines a set of strings. 
A *regular expression* usually thought of as a pattern 
Specifies a possibly infinite set of strings. 
Regular expressions libraries = available for most languages. In the Unix environment: 
- a lot of data is available in plain text format 
- many tools make use of regular expressions for searching 
- effective use of regular expressions makes you more productive 

A POSIX standard for regular expressions defines the "pattern language" used by many Unix tools.

## Shell
#### Command Interpreters 
A command interpreter is a program that executes other programs. 
Aim: allow users to execute the commands provided on a computer system. 
Command interpreters come in two flavours: 
- graphical (e.g. Windows or Mac desktop) 
	- advantage: easy for naive users to start using system 
- command-line (e.g. Unix shell) 
	- advantage: programmable, powerful tool for expert users On Unix/Linux, bash has become defacto standard shell.
#### What Shells Do
The "transformations" applied to input lines include: 
- variable expansion ... e.g. `$1 ${x-20} `
- file name expansion ... e.g.` *.c enr.07s?`

To "execute that command" the shell needs to: 
- find file containing named program (PATH) 
- start new process for execution of program

#### Command Search PATH 
Ways of execution: 
```console
$ sh bling # file need not be executable 
$ ./bling # file must be executable 
$ bling # file must be executable and . in PATH
```
Shell searches for programs to run using the colon-separated list of directories in the variable PATH. Beware: only append the current directory to end of your path
```console
$ PATH=.:$PATH 
$ cat >hi << eof
#!/bin/sh
echo hello
eof
$ chmod 755 cat
$ cat /home/cs2041/public_html/index.html
hello
```
Note ./cat is being run rather /bin/cat Much hard to discover if it happens with another shell script which runs cat. Safer still: don’t put . in your PATH.

#### Unix Processes 
<a href="https://ibb.co/kXm4yCp"><img src="https://i.ibb.co/XtY74R9/ss3.png" alt="ss3" border="0"></a>

#### Shell as Interpreter
The shell can be viewed as a programming language interpreter. As with all interpreters, the shell has: 
- a state (collection of variables and their values) 
- control (current location, execution flow) 
Different to most interpreters, the shell: 
- modifies the program code before finally executing it 
- has an infinitely extendable set of basic operations

Basic operations in shell scripts are a sequence of words. CommandName Arg1 Arg2 Arg3 ... 
A word defined to be any sequence of: 
- non-whitespace characters (e.g. x, y1, aVeryLongWord)
-  characters enclosed in double-quotes (e.g. "abc", "a b c") 
-  characters enclosed in single-quotes (e.g. ’abc’, ’a b c’) 
More on shell variables: 
- no need to declare shell variables; simply use them 
- are local to the current execution of the shell. 
- all variables have type string 
- initial value of variable = empty string 
- note that x=1 is equivalent to x="1"

-rw-r--r--: file owner/ group owner / all other users 

`$vi hi.txt`
- first have to indicate that this is not machine code by declaring the #! 
- then it will expect the name of the interpreter 
- instead of passing to CPU, it will follow the path of the declared program 
- /bin: short for binary (but they're really shell scripts) 

Shell Script: 
- don't have c or python equivalent
- $ has 2 meanings 
	- expect to see variable name following and replaces word with the contents of the variables 
	- expand the following text - get the value of that word as a variable
		- parentheses- executes a subshell of the listed words and expands to its outputs

Shell variables: 
$$: every executing linux program has a unique number and that $ contains that unique number 
#### Quoting 
Single-quote useful to pass meta-characters in args
e.g. `grep ’S.*[0-9]+$’ < myfile`
Double-quotes: 
 - construct strings using the values of shell variables 
	 - e.g. `"x=$x, y=$y"` like Java’s `("x=" + x + ", y=" + y) `
 - prevent empty variables from "vanishing" 
	 - e.g. test `"$x" = "abc"` vs.  `test $x = "abc"` in case $x is empty 
 - for values obtained from the command line or a user 
	 - e.g. `test -f "$1"` vs. `test -f $1` in case $1 contains a path with spaces e.g. folder /Program Files

#### Back-quotes 
Captures output of commands as shell values
1. performs variable-substitution (as for double-quotes) 
2. executes the resulting command and arguments 
3. captures the standard output from the command 
4. converts it to a single string 
5. uses this string as the value of the expression

#### Connecting Commands 
The shell provides I/O redirection to allow us to change where processes read from and write to.
<a href="https://ibb.co/YpGVnzH"><img src="https://i.ibb.co/cDdsfG4/ss4.png" alt="ss4" border="0"></a>

#### Exit Status and Control 
Exit Status
```
zero: command success -> true 
non-zero: error -> false 
AND list: execute if all succeeds (0 exit status)
OR list: sequential success 
```
Testing - same exit status if succeeds/fails
 
 Can't get true or false as exit status because it returns int exit status
 Doesn't work: 
 ```bash
even(){
	if (($1 % 2 == 0))
	then 
		return "even"
	else 
		return "odd"
	fi
}
 ```
 Workaround: 
```bash
evenness(){
	if test $(expr $1 % 2 == 0) -eq 0
	then
		echo "even"
	else 
		echo "odd" 
	fi 
}
```
Grouping
- commands can be groups w/ (..) (executed in new sub-shell) or {..} (executed in current shell)
- exit status of the last command

#### Opening a file in pipe mode 
```bash
open my $f, "-|", "date"; $ #runs the program and reads from it 
	# -|: run a program and give me stream of bytes from its STDOUT 
	# 'date' is passed through to the shell 
	# alternative "|-": outgoing stream of bytes to STDIN but deadlock if u wanna do both programs

$date = <$f>;
print "Date is $date"; 

```
####  Running 2 Shell Files in One
. my_config.sh  == #include “my_config.h”
- read and source this script 
- if want the value of a variable -add to their environment
```bash
#my_config file
name=lily
.my_config.sh
echo Hello $name
export name # variables arent passed onto sh thats run
c.sh
```
## Perl - Practical Extraction and Report Language 

- Larry Wall (late 80's) - replacement for awk
- influenced: PHP, Python, Ruby
- easy to write concise, powerful , obscure programs
- currently using Perl 5

Language Design Principles 
- easy/ concise to express common idioms 
- provide many different ways to express the same thing 
- use defaults where every possible 
- exploit powerful concise syntax & accept ambiguity/obscurity in some cases 
- create a large language that users will learn subsets of 

#### Syntax Conventions
Any unadorned identifiers are either 
- names of built in (or other) functions (e.g. chomp, split) 
- control-structures (e.g. if, for, foreach) 
- literal strings (like the shell!)
`$x = abc;` same as `$x ="abc";`

scalars - single atomic values (number/string) 
arrays - list of values, indexed by string 
hashes - group of values, indexed by string 
- no  argument specified: $_ is assumed 
	- easier to write brief programs 

$_:
- acts as the default location to assignment result values (e.g. STDIN) 
- acts as default argument to many operations (e.g. print)

#### Logical Operators
<a href="https://ibb.co/PtZs8LB"><img src="https://i.ibb.co/CW5pFcx/ss5.png" alt="ss5" border="0"></a>
<a href="https://ibb.co/pj0fTp9"><img src="https://i.ibb.co/Kx02gH3/ss6.png" alt="ss6" border="0"></a>

#### Anonymous File Handle 
If you supply a uninitialized variable Perl will store an anonymous file handle in it:
```perl
open my $output, ’>’, ’answer’ or die "Can’t open ..."; 
print $output "42\n";
close $output; 

open my $input, ’<’, ’answer’ or die "Can’t open ...";
$answer = <$input>; 
close $input; 
print "$answer\n"; # prints 42
```
Use this approach for larger programs to avoid collision between file handle names.

```perl
	open my $f, '<', $filename or die $0: cant open $!;
	open my $g '>', $temp_filename or die $0: cant open 
```
- open and truncates the file 1..0 length and file length  0 when you read <$f>
- solution: do an itermediate swap (as shown above)
	- Hermione -> Jashank -> Harry 
	- different filenames for in and out 

```perl
foreach $filename (@ARGV){
	$temp_filename = "filename.new"; 
	open my $f, '<', $filename or die $0: cant open $!;
	open my $g '>', $temp_filename or die $0: cant open $!;
	while ($line = <$f>){
		$line =~s/Harry/Jashank/g; 
		$line =~s/Hermione/Harry/g; 
		$line =~s/Jashank/Hermione/g; 
		print $g $line;
	}
	close $f; 
	close $g; 
	rename $tmp_filename, $filename or die; 
}
```
####  Close 
Handles can be explitly closed with close(HandleName) 
- All handles closed on exit. 
- Handle also closed if open done with same name good for lazy coders. 
- Data on output streams may be not written (buffered) until close - hence close ASAP.

#### Function Calls
All Perl function calls ... 
 - are call by value (like C) (except scalars aliased to @_) 
	 - @_ : array of the arguments 
 - are expressions (although often ignore return value)
```perl
&func(arg{1}, arg{2}, ... arg{n}) 
func(arg{1}, arg{2}, ... arg{n}) 
func arg{1}, arg{2}, ... arg{n}
```
Example: 
```perl 
sub print_odd{
	my ($selector, @list) =@_; 
	foreach (@list){
		print "$_\n" if &$selector;
	}
}
@numbers = (1..10); 
print_odd sub{$_ > 5} , @numbers;
```
&: sigil to run this perl - indicator that this is an executable

side effect in the {}: can have print statements
`grep {$_ % 2 == 1 && print "$_\n"} @numbers;`
#### Control Structure
<a href="https://imgbb.com/"><img src="https://i.ibb.co/XYpZh1J/ss7.png" alt="ss7" border="0"></a>

#### Terminating
Normal termination, call: exit 0 
The die function is used for abnormal termination: 
- accepts a list of arguments 
- concatenates them all into a single string 
- appends file name and line number
- prints this string 
-then terminates the Perl interpreter
```perl
if (! -r "myFile") { die "Can’t read myFile: $!\n"; } 
# or 
die "Can’t read myFile: $!\n" if ! -r "myFile"; 
# or 
-r "myFile" or die "Can’t read myFile: $!\n"
```

#### Perl and External Commands 
Ways to interact w/ external commands / programs: 
```perl
‘ cmd‘; 			#capture entire output of cmd as single string 
system "cmd" 		#execute cmd and capture its exit status 
only open F,"cmd|" 	#collect cmd output by reading from a stream
```
#### File Test Operators
```Perl
-r, -w, -x	readable, writable, executable 
-e, -z, -s	exists, zero size , non-zero size 
-f, -d, -l	plain file, directory, symlink

Usage: for cheking I/O operations 
	-r "dataFile" && open my $data, ’<’, "dataFile";
```

#### `Split`
- better than cut; takes a regex vs. a character
- normal character - no meaning on the regex 

#### Prototyping 
A function expects 2 references to arrays -> changes how a function gets called 
- can call the function by writing 2 arrays 
```perl
sub product(\@\@); 
sub product{
	my ($aref, $bref) = @_; 
	#do something 
}
@p = product @a,@b; 
```


## Perl Arrays 
```perl
@array
$array[index] #element in array @ index
$# #index  of last element 
$# + 1 #number of elements in array 
```
Examples
```perl
@a = ("abc", 123, ’x’); # scalar context ... gives list length $n = @a; # $n == 3 

# string context ... gives space-separated elems 
$s = "@a"; # $s eq "abc 123 x" 

# scalar context ... gives list length 
$t = @a.""; # $t eq "3" 

# list context ... gives joined elems 
print @a; # displays "abc123x"
```

Arrays don't need to be declared: they grow and shrink as needed 
" Missing" elements are interpolated e.g.
`$abc[0] = "abc"; $abc[2] = "xyz";`
	$abc[1] returns "";

#### Hashes
Hash is a set of (key, value) pairs 
- undefined returns as ""
Usage: `$hashName{keyString}`

Each method produces keys/values in same order. It's illegal to change hash within loop 


## Modules ( i got hella lazy)
use keyword --> module name prefixed with ::

#### Pragmas 
- way of controlling some aspects of the interpreter's behaviour (introduced by the *use* keyword) 
	- e.g. use `English`- `$NF=$.` and `$ARG = $_`
	-  use integer;  - truncates all arithmetic operations to int, effective to end of the enclosing block 
	- use strict 'vars'; - all variables use my
