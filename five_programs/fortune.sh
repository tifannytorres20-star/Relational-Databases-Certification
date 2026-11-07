#!/bin/bash
# Fortunaaaaaaaaaaaaaaaa

echo -e "\n~~ Fortune ~~\n"

RESPONSES=("Yes" "No" "Maybe" "Outlook good" "Outlook not so good" "Reply hazy, try again")

GET_FORTUNE() {
  echo "Ask a yes or no question:"
  read QUESTION
}

GET_FORTUNE

until [[ $QUESTION =~ \?$ ]]
do
  echo "Please try again. Make sure it ends with a question mark:"
  read QUESTION
done

N=$(( RANDOM % 6 ))

echo -e "\n${RESPONSES[$N]}\n"
