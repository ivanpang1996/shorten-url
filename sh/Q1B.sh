#!/bin/bash -e

awk -vDate=`date -d'2019-06-10 00:00:00' +[%d/%b/%Y:%H:%M:%S` -vDate2=`date -d'2019-06-19 23:59:59' +[%d/%b/%Y:%H:%M:%S` '$4 >= Date && $4 <= Date2 {print $0}' access.log | awk -F'"' '{print $6}' | awk -F"//" '{print $2}'| awk -F"/" '{if (length($1) != 0) print $1}'|sort |uniq -c|sort -rn | head -n 10

