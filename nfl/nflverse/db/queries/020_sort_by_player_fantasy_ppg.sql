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
WHERE season = :player_ppg_season
  AND week BETWEEN :player_ppg_start_week AND :player_ppg_end_week
  AND position = ANY(:'player_ppg_positions'::text[]) 
GROUP BY
    player_id,
    full_name,
    position
ORDER BY ppg DESC
LIMIT 100;
