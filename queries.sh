#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

echo "$($PSQL "SELECT SUM(winner_goals) FROM games;")"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games;")"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games;")"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games;")"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games;")"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2;")"
echo "$($PSQL "SELECT name FROM teams t JOIN games g ON t.team_id = g.winner_id WHERE g.year = 2018 AND g.round = 'Final';")"
echo "$($PSQL "SELECT name FROM teams t JOIN games g ON t.team_id IN (g.winner_id, g.opponent_id) WHERE g.year = 2014 AND g.round = 'Eighth-Final' GROUP BY name ORDER BY name;")"
echo "$($PSQL "SELECT name FROM teams t JOIN games g ON t.team_id = g.winner_id GROUP BY name ORDER BY name;")"
echo "$($PSQL "SELECT g.year, t.name FROM games g JOIN teams t ON t.team_id = g.winner_id WHERE g.round='Final' ORDER BY g.year;")"
echo "$($PSQL "SELECT COUNT(*) FROM teams WHERE name LIKE 'Co%';")"
