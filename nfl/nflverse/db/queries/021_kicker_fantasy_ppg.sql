SELECT
    name,
    kicker_team,
    SUM(games_played) AS games_played,
    SUM(fantasy_points) AS total_points,
    ROUND(AVG(fantasy_points), 2) AS avg_kicker_fantasy_points
FROM nflverse.kicker_fantasy_matchup_weekly
WHERE season = :kicker_season
  AND week BETWEEN :kicker_start_week AND :kicker_end_week
GROUP BY
    name,
    kicker_team
ORDER BY
    avg_kicker_fantasy_points DESC;

/* old query that showed matchup
SELECT
    name,
    kicker_team,
    defense,
    season,
    week,
    fantasy_points
FROM nflverse.kicker_fantasy_matchup_weekly
WHERE season = 2025
  AND week = 1
ORDER BY fantasy_points DESC;
*/
