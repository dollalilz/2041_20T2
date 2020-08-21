#!/usr/bin/perl -w
 no warnings 'uninitialized'; 

$N = 10; 
$D = 10; 

foreach $arg (@ARGV) {
    if ($arg eq "--version") {
        print "$0: version 0.1\n";
        exit 0;
    }
    elsif($arg=~ /^-[0-9]+$/){
        $N = $arg;
        $N =~ s/\-//;
    }
    else {
        push @files, $arg;
    }
}

$len = scalar(@files); 

foreach $file (@files) {
    open F, '<', $file or die "$0: Can't open $file: $!\n";
    
    if ($len > 1 ){
        print ("==> $file <==\n"); 
    }
    # read the file; put in array
    chomp(my @content = <F>);

    my $len_content = scalar(@content); 
    #print"len_content: $len_content"; 
    if ($len_content < $N){
        print "$_\n" for @content[0..$len_content-1];
        print "$content[$len_content]";
    }
    else{
        my $index_start = $len_content - $N; 
       # print "index start: $index_start\n";
        print "$_\n" for @content[$index_start..$len_content-1];
        print "$content[$len_content]";
    }
    close F;
}

# if there are no files, read from command line
@arg_files = <STDIN>; 
$len_arg = scalar(@arg_files); 

chomp(@arg_files); 

if ($len_arg < $D){
        print "$_\n" for @arg_files[0..$len_arg-1];
        print "$arg_files[$len_arg]";
}
else{
    my $index_start = $len_arg - $N; 
    print "$_\n" for @arg_files[$index_start..$len_arg-1];
    print "$arg_files[$len_arg]";
}

