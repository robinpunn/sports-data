\set season 2025
\set start_week 1
\set end_week 17

SELECT
    player_id,
    full_name,
    position,
    SUM(games_played) AS games_played,
    SUM(fantasy_points) AS total_points,
    ROUND(
        SUM(fantasy_points) / SUM(games_played),
        2
    ) AS ppg
FROM nflverse.player_fantasy_weekly
WHERE season = :season
  AND week BETWEEN :start_week AND :end_week
  AND position IN ('QB', 'RB', 'WR', 'TE')
GROUP BY
    player_id,
    full_name,
    position
ORDER BY ppg DESC
LIMIT 100;
