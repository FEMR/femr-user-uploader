#!/bin/bash

INPUT=accounts.csv
OLDIFS=$IFS
IFS=","
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read last first email profession agency r1 r2

do

./execute_users.rb -e "$email" -p "Password1" -f "$first" -l "$last" -n "'$profession $agency'" -r "$r1,$r2" -c "cookies.txt" -i "http://fe.mr"

#  echo "$last,$first,$email,$note,$r1,$r2"

done < $INPUT

IFS=$OLDIFS
