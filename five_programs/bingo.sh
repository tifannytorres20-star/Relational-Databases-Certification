#!/bin/bash
# Bingo 
echo -e "\n~~ Bingo ~~\n"

NUMBER=$(( RANDOM % 75 + 1 ))

TEXT="The next number, is, "

if [[ $NUMBER -le 15 ]]
then
  echo "$TEXT B: $NUMBER"
elif [[ $NUMBER -le 30 ]]
then
  echo "$TEXT I: $NUMBER"
elif [[ $NUMBER -le 45 ]]
then
  echo "$TEXT N: $NUMBER"
elif [[ $NUMBER -le 60 ]]
then
  echo "$TEXT G: $NUMBER"
else
  echo "$TEXT O: $NUMBER"
fi
