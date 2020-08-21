## Week 1
### Operating system 
An operating system is a piece of software that manages the hardware of a computer and provides an interface to the programs that run on the computer.

Operating systems on phones in your tut room might include Linux (Android), IOS (iPhone), Windows.

CSE's lab computers and servers run Linux.

Give five reasons why this attempt to search a file for HTML paragraph and break tags may fail.
`$grep <p>|<br> /tmp/index.html`

Answer:
The characters '<', '>' and '|' are part of the shell's syntax (meta characters) and the shell will interpret them rather than passing them to grep. This can be avoided with singleor double-quotes or backslash, e.g:

    egrep '<p>|<br>' /tmp/index.html
    egrep "<p>|<br>" /tmp/index.html
    egrep \<p>\|<br\> /tmp/index.html

For historical reasons 'grep' doesn't implement alternation ('|'). You need to use 'egrep' or ('grep -E') instead to get the full power of regular expressions.

The supplied regular expression won't match the HTML tags if they are in upper case (A-Z), e.g: <P>. The match can be case insensitive by changing the regular expression or using grep's -i flag

    egrep  '<[pP]>|<[bB][rR]>' /tmp/index.html
    egrep -i '<p>|<br>' /tmp/index.html

The supplied regular expression also won't match HTML tags containing spaces, e.g: <p >. This can be remedied by changing the regular expression

    egrep -i '< *(p|br) *>' /tmp/index.html

The HTML tag may contain attributes, e.g: <p class="lead_para">. Again can be remedied by changing the regular expression or using egrep's -w flag.

    egrep -i '<(p|br)[^>]*>' /tmp/index.html

This will still match <pre>. This can be avoided using a more complex regex:

    egrep -i '<(p|br)( [^>]*)*>' /tmp/index.html

The HTML tag might contain a newline. This is more difficult to handle with an essentially line-based tool like egrep.

egrep  -v . : prints all the empty lines in its input
same as egrep '^$' 

()? - optional match 

## Week 2 
```
$ my_first_shell_script.sh
my_first_shell_script.sh: command not found
```
-   **Problem:**  you might not have the current directory in your  `$PATH`.
    
    **Solution:**  either add  `.`  to the end of your  `$PATH`  (via  `PATH=$PATH:.`),  _or_  type the command name as  `./my_first_shell_script.sh`
    
-   **Problem:**  the  `my_first_shell_script.sh`  file may not be executable.
    
    **Solution:**  either make the file executable, by running (e.g.,)  `chmod +x my_first_shell_script.sh`,  _or_  execute it via the command  `sh my_first_shell_script.sh`  (also fixes the first problem)
    
-   **Problem:**  you might have gotten the  `#!/bin/sh`  line wrong.
    
    **Solution:**  check the first line of the script, to make sure there are no spurious spaces or spelling mistakes, and then check that the shell is called  `/bin/sh`  on your system
    
-   **Problem:**  the  `my_first_shell_script.sh`  file has been transferred from a Windows-based computer in binary mode, and there is a carriage-return character, which is often rendered as  `^M`  (or  `'\r'`  in C) after  `/bin/sh`.
    
    **Solution:**  Run the command  `dos2unix my_first_shell_script.sh`, which will remove the pesky  `^M`s.
    

Note that some of these problems might result in a message like:  `my_first_shell_script.sh: Permission denied`, depending on which shell you're using.


The bash-specific syntax ((..)) is used for arithmetic
This increases the readability but reduces the portability

The following shell script emulates the  [cat(1)](https://manpages.debian.org/jump?q=cat.1)  command using the built-in shell commands  [read(1)](https://manpages.debian.org/jump?q=read.1)  and  [echo(1)](https://manpages.debian.org/jump?q=echo.1):

```bash
#!/bin/sh
while read line
do
    echo "$line"
done
```

1.  What are the differences between the above script and the real  [cat(1)](https://manpages.debian.org/jump?q=cat.1)  command?
    
2.  modify the script so that it can concatenate multiple files from the command line, like the real  [cat(1)](https://manpages.debian.org/jump?q=cat.1)
    

(Hint: the shell's control structures — for example,  `if`,  `while`,  `for`  — are commands in their own right, and can form a component of a pipeline.)

#### Answer:

1.  Some differences:
    
    -   the script doesn't concatenate files named on the command line, just standard input
        
    -   it doesn't implement all of the  [cat(1)](https://manpages.debian.org/jump?q=cat.1)  options
        
    -   the appearance of lines may be altered: space at start of line is removed, and runs of multiple spaces will be compressed to a single space.
        
2.  A shell script to concatenate multiple files specified on command line:
```bash   
   #!/bin/sh
   for f in "$@"
   do
       if [ ! -r "$f" ]
       then
           echo "No such file: $f"
       else
           while read line
           do
               echo "$line"
           done < $f
       fi
   done
 ```
####  Cases: pass fail etc
- test doesn't support pattern matching in shell
```bash
#!/bin/sh
while read stid mark extras
do
    case "$mark" in
    [0-9] | [0-4][0-9])    echo $stid FL ;;
    5[0-9] | 6[0-4])       echo $stid PS ;;
    6[5-9] | 7[0-4])       echo $stid CR ;;
    7[5-9] | 8[0-4])       echo $stid DN ;;
    8[5-9] | 9[0-9] | 100) echo $stid HD ;;
    *)                     echo "$stid ?? ($mark)" ;;
    esac
done
```

If the input file used comma as a separator, the easiest thing would be to run the input through  [tr(1)](https://manpages.debian.org/jump?q=tr.1)  to convert the commas to spaces, and pipe the output into the  `grades`  program:

tr ',' ' ' <data | grades

Alternatively, you could alter the  input field separator  for the shell, by setting  `IFS=,`.

output: date(1)
`Friday 5 August  17:37:01 AEST 2016`

20. difference between the two outputs
```
wc -l *.tex
echo `wc -l *.tex`
```
first: 
```
 20 a.tex
 30 b.tex
 50 total
 ```
 second: same but backquotes = single string which is taken by the shell and passed as arguments to the echo command. In process of capturing the output, it is trimmed of trailing newlines. Becomes a sequence of words. 
 `20 a.tex 30 b.tex 50 total`

## Week 3 
A shell script is executed by a separate shell so changes to its working directory affect only it. Similarly changes to variables in it, affect only it.

You can indicate that the commands in a file are to be run by a shell rather than executed as a separate program like this.. 
```
./start_lab03.sh
pwd
/home/z1234567/labs/03
echo $ex1 $ex2 $ex3 $ex4
jpg2png email_image date_image tag_music
```
`sed's/COMP2041/COMP2042/g;s/COMP9044/COMP9042/g' $file >$temporary_file &&  mv $temporary_file $file`

sed -i is not universally supported 
test and = -a : and 

The shell does not replace tilde (~) with the user's home directory inside double-quotes, and does not handle spaces in filenames correctly  


## Week 5 
### What does **git init** do?

How does this differ from  **shrug-init**

**git init**  creates an empty repository as does  **shrug-init**

**git init**  uses the sub-directory  **.git**  (by default)

**shrug-init**  uses the sub-directory  **.shrug**  inside  **.git**

**git init**  creates many files and subdirectories

**shrug-init**  only  _needs_  to create  **.shrug**  but  _can_  create other things inside  **.shrug**

### What do **git add  _file_** and **shrug-add  _file_** do?

Adds a copy of  **_file_**  to the repository's  **index**.


### What is the index in **shrug** (and **git**), and where does it get stored?

Files get added to the repositoy via the index so its somethimes called a staging area.

It must be stored in the  **.shrug**  directory. exactly how you store it is up to you.

You might create a directory  **.shrug/index/**  and store the files there.

### What is a commit in **shrug** (and **git**), and where does it get stored?
A commit preserves the state of all files in the index.

It must be stored in  **.shrug**. exactly how you store it is up to you.

You might create a directory  **.shrug/_commit-number/_**  and store the files there.

### What is a merge conflict - and how do they get handled in git and shrug?

A merge conflict occurs when we attempt to merge branches and conflicting changes to the same part of a file have occured in both branches.

**shrug**  just stops with an error.

**git**  shows you the conflicting changes and lets you resolve the conflict.

 ## Week 7
 word_frequency.pl 
 ```perl
 1.  #!/usr/bin/perl -w
    
    while ($line = <>) {
        $line =~ tr/A-Z/a-z/;
        foreach $word ($line =~ /[a-z]+/g) {
            $count{$word}++;
        }
    }
    @words = keys %count;
    @sorted_words = sort {$count{$a} <=> $count{$b}} @words;
    foreach $word (@sorted_words) {
        printf "%d %s\n", $count{$word}, $word;
    }
 ```
## Week  8
    $webpage = `wget -q -O- '$url'`;
    
```perl
#!/usr/bin/perl -w
# written by andrewt@cse.unsw.edu.au as a COMP2041 example
# fetch specified web page and count the HTML tags in them

# The regex code below doesn't handle a number of cases.  It is often
# better to use a library to properly parse HTML before processing it.
# But beware illegal HTML is common & often causes problems for parsers.

use LWP::Simple;

$sort_by_frequency = 0;
foreach $arg (@ARGV) {
    if ($arg eq "-f") {
        $sort_by_frequency = 1;
    } else {
        push @urls, $arg;
    }
}
foreach $url (@urls) {
    $webpage = get $url;
    $webpage =~ tr/A-Z/a-z/;
    $webpage =~ s/<!--.*?-->//g; # remove comments
    @tags = $webpage =~ /<\s*(\w+)/g;
    foreach $tag (@tags) {
        $tag_count{$tag}++;
    }
}
if ($sort_by_frequency) {
    @sorted_tags = sort {$tag_count{$a} <=> $tag_count{$b} || $a cmp $b} keys %tag_count;
} else {
    @sorted_tags = sort keys %tag_count;
}
print "$_ $tag_count{$_}\n" foreach @sorted_tags;
## Week  9
Suppose typing ls -l yields:
```
-rw-r--r--    1 cs2041   cs2041         99 Sep 14 10:14 a
-rw-r--r--    1 cs2041   cs2041         26 Oct 20 18:16 b
-rw-r--r--    1 cs2041   cs2041         13 Sep 14 10:14 Makefile
```
and typing  more Makefile  yields:

a: b  
cp b a

What happens if  make  is typed?

What happens if  make  is typed a second time?

#### Answer:

`cp b a`

Nothing.

The following is an attempt by an inexperienced developer to produce a Makefile for a small project consisting of a main program (main.c), one module (module.c and module.h) plus a file of common definitions (defs.h). Both C files #include the two header files. The final product is called "myapp".
```
$CC=gcc-4.4
myapp:  main.o module.o defs.h
$CC -c -o $< main.o module.o

main.o:  module.h module.c defs.h
$CC -c main.o

module.o:  module.h defs.h
$CC -c main.o

main.c:  defs.h
```
There are 6+ errors in the Makefile. Identify them and rewrite the Makefile so it correctly reflects the dependencies and rules for building myapp.

#### Answer:

-   Incorrect variable syntax - the syntax is wrong for the assignment to the variable CC and in all of its uses.
-   Incorrect rule syntax - the build (compile) commands should be indented with a tab.
-   Rule 1: the final application only depends on the object files. It may indirectly depend on headers, but only through the object files.
-   Rule 1 command: the flag  -c  is used only for compiling, not for linking.
-   Rule 1 command: the implicit variable for the target is  $@, not  $<.
-   Rule 2: main.o depends on the header files and its own C file, not on any other C file (you don't have to recompile main.c if module.c changes).
-   Rule 3: module.o depends on module.c too.
-   Rule 4 doesn't make sense: main.c is a source file that doesn't depend on anything. Remove the rule.

The revised Makefile is
```
CC=gcc-4.4

myapp: main.o module.o
    $(CC) -o $@ main.o module.o

main.o: main.c module.h defs.h
    $(CC) -c main.c

module.o: module.c module.h defs.h
    $(CC) -c module.c
```
#### Hash example 
given the road distances between a number of towns (on standard input) calculates the shortest journey between two towns specified as arguments. Here is an example of how your program should behave.
```perl 
#!/usr/bin/perl -w
# find shortest path between two towns

die "Usage: $0 <start> <finish>\n" if @ARGV != 2;
$start = $ARGV[0];
$finish = $ARGV[1];

while (<STDIN>) {
    /(\S+)\s+(\S+)\s+(\d+)/ || next;
    $distance{$1}{$2} = $3;
    $distance{$2}{$1} = $3;
}

$shortest_journey{$start} = 0;
$route{$start} = "";
@unprocessed_towns = keys %distance;
$current_town = $start;
while ($current_town && $current_town ne $finish) {
    @unprocessed_towns = grep {$_ ne $current_town} @unprocessed_towns;

    foreach  $town (@unprocessed_towns) {
        if (defined $distance{$current_town}{$town}) {
            my $d = $shortest_journey{$current_town} + $distance{$current_town}{$town};
            if (!defined $shortest_journey{$town} || $shortest_journey{$town} > $d) {
                $shortest_journey{$town} = $d;
                $route{$town} = "$route{$current_town} $current_town";
            }
        }
    }

    my $min_distance = 1e99;   # must be larger than any possible distance
    $current_town = "";
    foreach $town (@unprocessed_towns) {
        if (defined $shortest_journey{$town} && $shortest_journey{$town} < $min_distance) {
            $min_distance = $shortest_journey{$town};
            $current_town = $town;
        }
    }
}

if (!defined $shortest_journey{$finish}) {
    print "No route from $start to $finish.\n";
} else {
    print "Shortest route is length = $shortest_journey{$finish}:$route{$finish} $finish.\n";
}
```

## Week 10 
These commands both copy a directory tree to a CSE server.
```
$scp -r directory1/ z1234567@login.cse.unsw.edu.au:directory2/
$rsync -a directory1/ z1234567@login.cse.unsw.edu.au:directory2/
```
What underlies them?

How do they differ?

Why are these differences important?

#### Answer:

Both command use  `ssh`  to connect to the remote machine.

`rsync`  will be more efficient if  `directory2`  already exists with similar contents. It will copy only files which are different and if only part of a file has changed it can copy only the changed bytes. This is is much more efficient when we are repeatedly making copies, e.g. for backups, particularly over a slow connection

`rsync -a`  also copies metadata such as file permissions and modification data which may be very important.

`scp -rp`  would copy metadata.

Question: Write a  _shell script_  called  `check`  that looks for duplicated student ids in a file of marks for a particular subject. The file consists of lines in the following format:
    
    2233445 David Smith 80
    2155443 Peter Smith 73
    2244668 Anne Smith 98
    2198765 Linda Smith 65
    
    The output should be a list of student ids that occur 2+ times, separated by newlines. (i.e. any student id that occurs more than once should be displayed on a line by itself on the standard output).
    
    Sample solution
    
    #!/bin/sh
    
    cut -d' ' -f1 < Marks | sort | uniq -c | egrep -v '^ *1 ' | sed -e 's/^.* //'
    
    **Explanation:**
    
    1.  `cut -d' ' -f1 < Marks`  ... extracts the student ID from each line
        
    2.  `sort | uniq -c`  ... sorts and counts the occurrences of each ID
        
    3.  IDs that occur once will be on a line that begins with spaces followed by  `1`  followed by a TAB
        
    4.  `grep -v '^ *1 '`  removes such lines, leaving only IDs that occur multiple times
        
    5.  `sed -e 's/^.* //'`  gets rid of the counts that  `uniq -c`  placed at the start of each line
