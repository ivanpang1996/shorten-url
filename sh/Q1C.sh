#!/bin/bash -e

cat access.log|cut -d' ' -f1|uniq -c | awk '{printf("%s ",$1); system("geoiplookup " $2 )}' | awk '{print $5 " " $1}'| awk '{arr[$1]+=$2} END {for (i in arr) {print i,arr[i]}}'| sort -k2 -rn | head -n 1
