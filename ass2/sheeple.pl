#!/usr/bin/perl -w
#global variables
$tab = 0; 
# check if string has arguments e.g. $1, $2 
sub check_args {
    my $str = shift; 
    #print ("\$str is $str"); 
    if ($str =~ m/\$(\d+)/){
        my $arg_num = $1; 
        $arg_num --;
        $str =~ s/(.*)\$(\d+)(.*)/$1\$ARGV\[$arg_num\]$3/;
    }
    # else do nothing to the string 
    return $str; 
}

# handle if elif and else 
sub handle_if {
    my $str = shift;
    my $eqn; 

    if ($str=~m/^elif test (.*)/){
        $eqn = handle_tests($1); 
        $str = "\} elsif ($eqn) \{"; 
    }
    elsif($str=~m/^if test (.*)/){
        $eqn = handle_tests($1);
        $str = "if ($eqn) \{";
    }
    # if theres no 'test'
    elsif($str=~m/^elif \[ (.*) \]/){
        $eqn = handle_tests($1);
        $str = "\} elsif ($eqn) \{"; 

    }
    elsif($str=~m/^if \[ (.*) \]/){
        $eqn = handle_tests($1);
        $str = "if ($eqn) \{";
    }
    return $str; 
}

# handles test equations / comparisons 
sub handle_tests {
    my $equation = shift; 
    # >> string comparison << 
    if ($equation=~ m/(.*) = (.*)/){
        $equation = "'$1' eq '$2'"; 
    }
        # string is not/is null 
    elsif ($equation =~ m/-n (.*)/){
        $equation = "$1 ne \'\'"; 
    }
        # string is null 
    elsif ($equation =~ m/-z (.*)/){
        $equation = "$1 eq \'\'"; 
    }
    # file operators 
    elsif ($equation =~ m/-r (.*)/){
        $equation = "-r \'$1\'"; 
    }
    elsif ($equation =~ m/-w (.*)/){
        $equation = "-w \'$1\'"; 
    }
    elsif ($equation =~ m/-x (.*)/){
        $equation = "-x \'$1\'"; 
    }
    elsif ($equation =~ m/-O (.*)/){
        $equation = "-o \'$1\'"; 
    }
    elsif ($equation =~ m/-e (.*)/){
        $equation = "-e \'$1\'"; 
    }
     elsif ($equation =~ m/-s (.*)/){
        $equation = "-s\'$1\'"; 
    }
    elsif ($equation =~ m/-f (.*)/){
        $equation = "-f \'$1\'"; 
    }
    elsif ($equation =~ m/-d (.*)/){
        $equation = "-d \'$1\'"; 
    }
    elsif ($equation =~ m/-L (.*)/){
        $equation = "-l \'$1\'"; 
    }
    elsif ($equation =~ m/-p (.*)/){
        $equation = "-p \'$1\'"; 
    }
    elsif ($equation =~ m/-S (.*)/){
        $equation = "-S \'$1\'"; 
    }
     elsif ($equation =~ m/-b (.*)/){
        $equation = "-b \'$1\'"; 
    }
     elsif ($equation =~ m/-c (.*)/){
        $equation = "-c \'$1\'"; 
    }
     elsif ($equation =~ m/-u (.*)/){
        $equation = "-u \'$1\'"; 
    }elsif ($equation =~ m/-g (.*)/){
        $equation = "-g \'$1\'"; 
    }elsif ($equation =~ m/-k (.*)/){
        $equation = "-k \'$1\'"; 
    }

    # >> numeric comparisons << 
    elsif ($equation =~ m/(.*) -eq (.*)/){
        $equation = "$1 == $2"; 
    }
    elsif ($equation =~ m/(.*) -ne (.*)/){
        $equation = "$1 != $2"; 
    }
    elsif ($equation =~ m/(.*) -gt (.*)/){
        $equation = "$1 > $2"; 
    }
    elsif ($equation =~ m/(.*) -lt (.*)/){
        $equation = "$1 < $2"; 
    }
    elsif ($equation =~ m/(.*) -ge (.*)/){
        $equation = "$1 >= $2"; 
    }
    elsif ($equation =~ m/(.*) -le (.*)/){
        $equation = "$1 <= $2"; 
    }   
    return $equation; 
}

# handle single quotes 
sub handle_quotes {
    my $temp; 
    my $ret_line = shift;
    #$ret_line =~ s/echo (.*)$/print "$1\\n";/;
    if ($ret_line =~ m/^echo (.*)$/){
        # backslash double quotes from the string 
        $temp = $1;
        #remove double or single quotes from the ends
        $temp =~s/^["']//; 
        $temp =~s/["']$//; 
        $temp =~s/"/\\"/g; 

        $ret_line = "print \"$temp\\n\";"; 
    }
    return $ret_line;
}

sub handle_for {
    # $line =~ s/^for (.*) in (.*)$/foreach \$$1 ()/;
    my $str = shift; 
    my $temp_glob=""; 
    if ($str =~ m/^for (.*) in (.*)$/){
        #print ("\$2 = $2\n"); 
        my $for = $1; 
        my $list_str = $2;
        
        # check if the string has a suffix e.g. .sh .c 
        if ($list_str =~ m/\.(.*)$/){
            $list_str = "glob(\"$list_str\")";
            $str = "foreach \$$for ($list_str) \{"; 
            return $str; 
        }
        elsif ($list_str =~m/^\*$/){
            $list_str = "glob(\"$list_str\")";
            $str = "foreach \$$for ($list_str) \{"; 
            return $str; 
        }
        # split the string to form a list 
        my @list = split (/ /,$list_str);
        my @new_list; 
        
        #iterate through to determine if string or int
        foreach (@list){
            $_ =~ s/\D+/'$_'/;  #if non-digits 

            # appended the changes to a new list 
            push (@new_list, $_); 
        }
        $pl_list = join (', ',@new_list); 
        $str = "foreach \$$for ($pl_list) \{"; 
    }
    return $str;
}

sub handle_assignment {
    my $str = shift;
    my $second_arg = shift; 
    # numerical assingment
    if ($second_arg =~ m/\d+|^\$/){
        $str =~ s/^(.*)=(.*)$/\$$1 = $2;/;
    }
    else{
        $str =~ s/^(.*)=(.*)$/\$$1 = '$2';/;
    }
    return $str;
}

sub handle_increment {
    my ($expr) = (@_);
    my @array = split(' ',$expr);
    $expr = "$array[0] = $array[0] + $array[2];";
    return $expr;
}

sub check_test {
    my $str = shift;
    my $incr = shift;
    
    $incr =~s/[()]//g; 
    $incr = handle_tests($incr); 
    $str =~ s/test (.*)/\($incr\) {/;
    return $str; 
}
# MAIN FUNCTION 
while ($line = <>){ #<>: read from stdin if theres no command line files
    chomp ($line); 
    $line =~ s/\t//g; # remove tabs from line 
    $line =~ s/^\s+//; # remove leading whitespace

   #print "the current line" . $line . "\n";
     # >>>>>>> SHEBANG LINE <<<<<<<<<<<<<<
    # this substitution from Andrew Taylor's lecture wk8 friday
    $line =~ s?^#!.*?#!/usr/bin/perl -w?;
    
    # skip processing if its a comment 
    if ($line =~m/^#.*/){
        print("$line\n"); 
        next;  
    }

    # Handling done / fi statement
    if ($line =~ m/^done$|^fi$/){
        $tab = 0;
        $line ="\}";
    };
    
    if ($line =~ m/^do|^then$/){
        $tab = 1;
        next; #dont want to print empty line 
    };

    $line =~ s/"\$\@"/\@ARGV/;

    # avoiding greedy matches related to = symbol 
    # trickle down the if conditions to avoid clash in matches
    # handle test 
    if ($line=~m/^elif test (.*)|^if test (.*)/){
        $line = handle_if($line);
    }
    # handle if/ elif (no test )
    elsif($line=~m/^if|^elif/){
        $line = handle_if($line);
    }
    elsif($line =~ m/(.*)=\`expr (.*)\`/){
        $line = handle_increment($2); 
    }
    elsif($line =~m/^(.*)=(.*)$/){
         $line = handle_assignment($line, $2); 
    }

       #print ("before while:" . $line . "\n"); 
    $line=~s/^while (.*)/while $1 \{/;
    #print ("after while:" . $line . "\n"); 
    $line=~s/\[/\(/;
    $line=~s/\]/\)/;

    if ($line =~m/test (.*) \{/){
        $line = check_test($line,$1);
    }
    elsif($line =~m/^while \( (.*) \)/){
        my $soln = handle_tests($1);
        $line ="while \( $soln \){";
    }

    $line=~s/^else/\} else \{/;

    $line = handle_quotes($line);

    $line = check_args($line);

    $line =~ s/^ls (.*)$/system "ls $1";/;

    if ($line =~ m/^ls (.*)$/ && $1){print ("system \"ls $1\";"); next;}
    elsif ($line =~m/^ls$/) {print ("system \"ls\";"); next;}

    $line =~ s/^pwd$/system "pwd";/; 
    $line =~ s/^id$/system "id";/; 
    $line =~ s/^date$/system "date";/; 
    
    $line =~ s/^cd (.*)$/chdir '$1';/;

    $line =~ s/^read (.*)/\$$1 = <STDIN>;\n\tchomp \$$1;/;
    
    # HANDLE FOR LOOP 
    $line = handle_for($line);

    $line =~ s/^exit (.*)/exit $1;/;
    
    # append tab to front of line
    if ($tab == 1){
            $line = "\t" . $line;
    }

    
    print ("$line\n");

}
