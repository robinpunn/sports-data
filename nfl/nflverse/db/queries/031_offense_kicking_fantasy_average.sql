SELECT
    team,
    ROUND(AVG(fantasy_points), 2) AS avg_kicker_fantasy_points
FROM nflverse.kicker_fantasy_weekly
WHERE season = :season
  AND week BETWEEN :start_week AND :end_week
GROUP BY
    team
ORDER BY
    avg_kicker_fantasy_points DESC;
