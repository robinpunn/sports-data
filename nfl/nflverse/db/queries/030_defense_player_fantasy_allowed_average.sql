SELECT
    defense,
    position,
    ROUND(AVG(fantasy_points_allowed), 2) AS avg_fantasy_points_allowed
FROM nflverse.defense_fantasy_allowed_weekly
WHERE season = :def_player_ppg_season
  AND week BETWEEN :def_player_ppg_start_week AND :def_player_ppg_end_week
  AND position = :'def_player_ppg_position'
GROUP BY
    defense,
    position
ORDER BY
    avg_fantasy_points_allowed DESC;
