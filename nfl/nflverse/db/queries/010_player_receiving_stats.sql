SELECT
    full_name,
    position,

    COUNT(*) AS games,

    SUM(COALESCE(targets, 0)) AS targets,
    ROUND(AVG(COALESCE(targets, 0)), 2) AS tar_per_game,

    SUM(COALESCE(receptions, 0)) AS recs,
    ROUND(AVG(COALESCE(receptions, 0)), 2) AS recs_per_game,

    SUM(COALESCE(receiving_yards, 0)) AS rec_yds,
    ROUND(AVG(COALESCE(receiving_yards, 0)), 2) AS rec_yds_per_game,

    SUM(COALESCE(receiving_tds, 0)) AS tds,
    ROUND(AVG(COALESCE(receiving_tds, 0)), 2) AS tds_per_game

FROM nflverse.player_receiving_weekly

WHERE season = :receiving_stats_season
  AND week BETWEEN :receiving_stats_start_week AND :receiving_stats_end_week

GROUP BY
    full_name,
    position

HAVING
    SUM(COALESCE(targets, 0)) > 0

ORDER BY
    :receiving_stats_sort DESC;
