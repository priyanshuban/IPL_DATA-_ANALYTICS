-- IPL Data Analytics Project
DROP TABLE IF EXISTS matches;
CREATE TABLE matches (
 id INTEGER PRIMARY KEY, season TEXT, city TEXT, date TEXT, match_type TEXT,
 player_of_match TEXT, venue TEXT, team1 TEXT, team2 TEXT, toss_winner TEXT,
 toss_decision TEXT, winner TEXT, result TEXT, result_margin REAL,
 target_runs REAL, target_overs REAL, super_over TEXT, method TEXT,
 umpire1 TEXT, umpire2 TEXT
);

DROP TABLE IF EXISTS deliveries;
CREATE TABLE deliveries (
 match_id INTEGER, inning INTEGER, batting_team TEXT, bowling_team TEXT,
 over INTEGER, ball REAL, batter TEXT, bowler TEXT, non_striker TEXT,
 batsman_runs INTEGER, extra_runs INTEGER, total_runs INTEGER, extras_type TEXT,
 is_wicket INTEGER, player_dismissed TEXT, dismissal_kind TEXT, fielder TEXT
);

-- KPI 1: Matches and seasons
SELECT COUNT(*) AS total_matches, COUNT(DISTINCT season) AS seasons FROM matches;

-- KPI 2: Wins by team
SELECT winner AS team, COUNT(*) AS wins
FROM matches WHERE winner IS NOT NULL
GROUP BY winner ORDER BY wins DESC;

-- KPI 3: Toss decision distribution
SELECT toss_decision, COUNT(*) AS matches
FROM matches GROUP BY toss_decision ORDER BY matches DESC;

-- KPI 4: Toss winner also wins match
SELECT ROUND(100.0 * SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) / COUNT(*), 2) AS toss_to_match_win_pct
FROM matches WHERE winner IS NOT NULL;

-- KPI 5: Top run scorers
SELECT batter, SUM(batsman_runs) AS runs
FROM deliveries GROUP BY batter ORDER BY runs DESC LIMIT 10;

-- KPI 6: Top wicket takers (common bowler-credited dismissals)
SELECT bowler, COUNT(*) AS wickets
FROM deliveries
WHERE is_wicket = 1
  AND dismissal_kind NOT IN ('run out','retired hurt','obstructing the field')
GROUP BY bowler ORDER BY wickets DESC LIMIT 10;

-- KPI 7: Season match count
SELECT season, COUNT(*) AS matches FROM matches GROUP BY season ORDER BY season;

-- KPI 8: Team season win percentage
WITH team_matches AS (
 SELECT season, team1 AS team FROM matches
 UNION ALL
 SELECT season, team2 AS team FROM matches
),
played AS (
 SELECT season, team, COUNT(*) AS matches_played FROM team_matches GROUP BY season, team
),
wins AS (
 SELECT season, winner AS team, COUNT(*) AS wins FROM matches
 WHERE winner IS NOT NULL GROUP BY season, winner
)
SELECT p.season, p.team, p.matches_played, COALESCE(w.wins,0) AS wins,
 ROUND(100.0*COALESCE(w.wins,0)/p.matches_played,2) AS win_pct
FROM played p LEFT JOIN wins w ON p.season=w.season AND p.team=w.team
ORDER BY p.season, win_pct DESC;

-- KPI 9: Run scoring by batting team
SELECT batting_team, SUM(total_runs) AS total_runs
FROM deliveries GROUP BY batting_team ORDER BY total_runs DESC;

-- KPI 10: Dismissal types
SELECT dismissal_kind, COUNT(*) AS dismissals
FROM deliveries WHERE is_wicket=1
GROUP BY dismissal_kind ORDER BY dismissals DESC;
