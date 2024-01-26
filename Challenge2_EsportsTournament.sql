-- SQL Challenge 2 
--- Esports Tournament
--BY SANNIDHYA DAS
-- Creating tables and inserting data into them

CREATE TABLE Teams (
team_id INT PRIMARY KEY,
team_name VARCHAR(50) NOT NULL,
country VARCHAR(50),
captain_id INT
);
--------
INSERT INTO Teams (team_id, team_name, country, captain_id)
VALUES (1, 'Cloud9', 'USA', 1),
(2, 'Fnatic', 'Sweden', 2),
(3, 'SK Telecom T1', 'South Korea', 3),
(4, 'Team Liquid', 'USA', 4),
(5, 'G2 Esports', 'Spain', 5);
-----------------------
CREATE TABLE Players (
player_id INT PRIMARY KEY,
player_name VARCHAR(50) NOT NULL,
team_id INT,
role VARCHAR(50),
salary INT,
FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);
--------------------
INSERT INTO Players (player_id, player_name, team_id, role, salary)
VALUES (1, 'Shroud', 1, 'Rifler', 100000),
(2, 'JW', 2, 'AWP', 90000),
(3, 'Faker', 3, 'Mid laner', 120000),
(4, 'Stewie2k', 4, 'Rifler', 95000),
(5, 'Perkz', 5, 'Mid laner', 110000),
(6, 'Castle09', 1, 'AWP', 120000),
(7, 'Pike', 2, 'Mid Laner', 70000),
(8, 'Daron', 3, 'Rifler', 125000),
(9, 'Felix', 4, 'Mid Laner', 95000),
(10, 'Stadz', 5, 'Rifler', 98000),
(11, 'KL34', 1, 'Mid Laner', 83000),
(12, 'ForceZ', 2, 'Rifler', 130000),
(13, 'Joker', 3, 'AWP', 128000),
(14, 'Hari', 4, 'AWP', 90000),
(15, 'Wringer', 5, 'Mid laner', 105000);
--------------------
CREATE TABLE Matches (
match_id INT PRIMARY KEY,
team1_id INT,
team2_id INT,
match_date DATE,
winner_id INT,
score_team1 INT,
score_team2 INT,
FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
FOREIGN KEY (team2_id) REFERENCES Teams(team_id),
FOREIGN KEY (winner_id) REFERENCES Teams(team_id)
);
--------------------
INSERT INTO Matches (match_id, team1_id, team2_id, match_date, 
					 winner_id, score_team1, score_team2)
VALUES (1, 1, 2, '2022-01-01', 1, 16, 14),
(2, 3, 5, '2022-02-01', 3, 14, 9),
(3, 4, 1, '2022-03-01', 1, 17, 13),
(4, 2, 5, '2022-04-01', 5, 13, 12),
(5, 3, 4, '2022-05-01', 3, 16, 10),
(6, 1, 3, '2022-02-01', 3, 13, 17),
(7, 2, 4, '2022-03-01', 2, 12, 9),
(8, 5, 1, '2022-04-01', 1, 11, 15),
(9, 2, 3, '2022-05-01', 3, 9, 10),
(10, 4, 5, '2022-01-01', 4, 13, 10);

----------------------------------Questions and Answers-----------------------------------

-- Q1. What are the names of the players whose salary is greater than
-- 100,000?

SELECT * FROM players 
WHERE salary > 100000;

-- Q2. What is the team name of the player with player_id = 3?

SELECT player_id,player_name,players.team_id,teams.team_name
FROM players 
JOIN teams ON players.team_id=teams.team_id
WHERE player_id = '3';

--Q3. What is the total number of players in each team?

SELECT players.team_id,teams.team_name,
COUNT(player_name) AS Total_players
FROM players 
JOIN teams ON players.team_id=teams.team_id
GROUP BY players.team_id,
teams.team_name;

-- Q4. What is the team name and captain name of the team with 
-- team_id = 2?

SELECT teams.team_id,team_name,captain_id,
players.player_name
FROM teams
JOIN players ON players.team_id=teams.team_id
WHERE teams.captain_id=players.player_id
AND teams.team_id='2';

-- Q5. What are the player names and their roles in the team with 
-- team_id = 1?

SELECT player_name,team_id,role FROM players
WHERE team_id=1;

-- Q6. What are the team names and the number of matches they have won?

SELECT teams.team_id,team_name,Count(winner_id) AS total_wins
FROM teams 
JOIN matches ON teams.team_id=matches.winner_id
GROUP BY teams.team_id
ORDER BY 3 DESC;

-- Q7. What is the average salary of players in the teams with country 
-- 'USA'?

SELECT players.team_id,teams.team_name,country,
ROUND(AVG(salary),2) AS avg_salary 
FROM teams
JOIN players ON teams.team_id=players.team_id
WHERE country='USA' 
GROUP BY players.team_id,
teams.team_name,
country

-- Q8. Which team won the most matches?

SELECT teams.team_id,team_name,Count(winner_id) AS total_wins
FROM teams 
JOIN matches ON teams.team_id=matches.winner_id
GROUP BY teams.team_id
ORDER BY 3 DESC
LIMIT 1;

-- Q9. What are the team names and the number of players in each team 
-- whose salary is greater than 100,000?

SELECT team_name,COUNT(player_id)
FROM teams
JOIN players ON teams.team_id=players.team_id
WHERE salary > 100000
GROUP BY teams.team_name;

-- Q10. What is the date and the score of the match with match_id = 3?

SELECT match_id,match_date,winner_id,
team_name AS winning_team_name,
score_team1,score_team2
FROM matches 
JOIN teams ON matches.winner_id=teams.team_id
WHERE  match_id = '3'


-------------------------------THANK YOU---------------------------------------------





