SELECT
    team,
    ROUND(AVG(fantasy_points), 2) AS avg_kicker_fantasy_points
FROM nflverse.kicker_fantasy_weekly
WHERE season = :team_k_season
  AND week BETWEEN :team_k_start_week AND :team_k_end_week
GROUP BY
    team
ORDER BY
    avg_kicker_fantasy_points DESC;
