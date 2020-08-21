#!/usr/bin/perl -w

if (@ARGV == 0){
    print "Usage: $0 <files>\n";
    exit; 
}

foreach $file (@ARGV) {
    open F, '<', $file or die "$0: Can't open $file: $!\n";
    chomp(@my_content =<F>); 
    if (@ident == 0){
        push @ident,  $file; 
        chomp(@first = @my_content); 
    }
    else{
        $my_first = join (" ", @first); 
        $content = join (" ", @my_content); 
        if ($my_first eq $content){
            push @ident,  $file; 
        }
        else{
            push @not, $file; 
        }
    }
    close F;
}
if (@not == 0){
    print "All files are identical\n"; 
}
else{
    print "$not[0] is not identical\n"; 
}