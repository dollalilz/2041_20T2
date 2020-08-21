#!/bin/dash
curl --location --silent http://www.timetable.unsw.edu.au/current/$1KENS.html| egrep "$1" | egrep -v "$1.*$1"| sed -e 's/\.html//' -e 's/[<>]//g' -e 's/\/a\/td//g' -e 's/"/ /g'|cut -d "=" -f3|cut -c 2-| sort| uniq 


