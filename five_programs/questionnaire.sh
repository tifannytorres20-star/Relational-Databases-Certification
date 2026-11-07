#!/bin/bash
QUESTION1="Whats your name?"
echo $QUESTION1

read NAME
echo Hello $NAME

QUESTION2="Where are you from?"
echo $QUESTION2

read LOCATION
echo Hello $NAME from $LOCATION

echo "~~ Questionnaire ~~"

echo -e "\n~~ Questionnaire ~~\n"

QUESTION3="What is your favorite coding website?"
echo $QUESTION3

read WEBSITE
echo -e "\nThat's awesome, $NAME from $LOCATION! Check out $WEBSITE for more coding practice.\n"
