#!/bin/bash
# Do not change this line; FCC tests expect PSQL to exist and be used.
if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Reset tables each run
$PSQL "TRUNCATE TABLE games, teams RESTART IDENTITY;" > /dev/null

# Load CSV (skip header)
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    # Insert teams (idempotent)
    $PSQL "INSERT INTO teams(name) VALUES('$WINNER') ON CONFLICT (name) DO NOTHING;" > /dev/null
    $PSQL "INSERT INTO teams(name) VALUES('$OPPONENT') ON CONFLICT (name) DO NOTHING;" > /dev/null

    # Get IDs
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")

    # Insert game row
    $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
           VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);" > /dev/null
  fi
done
