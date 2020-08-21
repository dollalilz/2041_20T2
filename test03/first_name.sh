#!/bin/sh
egrep COMP[29]041 enrollments.txt | cut -d "|" -f3| cut -d "," -f2|sed "s/^ //"| cut -d " " -f1|sort|uniq -c|sort -k1,1nr -k2,2|cut -c9-|sed -n 1p
