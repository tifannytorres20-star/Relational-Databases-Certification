#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Generar número secreto aleatorio entre 1 y 1000
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

echo "Enter your username:"
read USERNAME

# Buscar usuario en la base de datos
USER_INFO=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

if [[ -z $USER_INFO ]]
then
  # Si el usuario no existe, crearlo
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  USER_ID=$USER_INFO
  # Obtener estadísticas de juegos anteriores
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID")
  BEST_GAME=$($PSQL "SELECT MIN(guesses) FROM games WHERE user_id=$USER_ID")
  
  if [[ -z $BEST_GAME ]]
  then
    BEST_GAME=0
  fi

  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# Iniciar juego de adivinanza
echo "Guess the secret number between 1 and 1000:"
READ_GUESS=()
GUESS_COUNT=0

while [[ $USER_GUESS -ne $SECRET_NUMBER ]]
do
  read USER_GUESS
  
  # Validar si es un entero
  if ! [[ $USER_GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    continue
  fi

  ((GUESS_COUNT++))

  if [[ $USER_GUESS -gt $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  elif [[ $USER_GUESS -lt $SECRET_NUMBER ]]
  then
    echo "It's higher than that, guess again:"
  else
    echo "You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
  fi
done

# Guardar partida en la base de datos
$PSQL "INSERT INTO games(user_id, guesses) VALUES($USER_ID, $GUESS_COUNT)" > /dev/null