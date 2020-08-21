#!/usr/bin/perl -w

# testing all numerical and string comparisons 
$var1 = 10;
$var2 = 20;
$var3 = 'Hi';
$var4 = 10 ;


# 20 > 10 test condition 
if ($var2 > $var1) {
	print "$var2 is greater than $var1\n";
}
# 10 < 20  
if ($var1 < $var2) {
	print "$var1 is smaller than $var2\n";
}

# 10 == 10  
if ($var1 == $var4) {
	print "values are same \n";
}

if ($var1 != $var2) {
	print "values are not equal  \n";
}

# 10 =< 10 
if ($var1 <= $var4) {
	print "$var1 is le $var4\n";
}

# 20 >= 10 
if ($var2 >= $var1) {
	print "var1 is smaller than $var2\n";
}


# string tests
if ($var3 ne '') {
	print "$var3 exists\n";
	} else {
	print "$var3 doesnt exist\n";
}

if ($var1 eq '') {
	print "$var1 exists\n";
	} else {
	print "$var1 doesnt exist\n";
}
