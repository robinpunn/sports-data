SELECT
    full_name,
    position,

    COUNT(*) AS games,

    SUM(COALESCE(carries, 0)) AS car,
    ROUND(AVG(COALESCE(carries, 0)), 2) AS car_game,

    SUM(COALESCE(rushing_yards, 0)) AS rushing_yds,
    ROUND(AVG(COALESCE(rushing_yards, 0)), 2) AS rushing_yds_game,

    ROUND(
    	SUM(COALESCE(rushing_yards, 0))::numeric
    	/ NULLIF(SUM(COALESCE(carries, 0)), 0),
    	2
    ) AS yds_carry,

    SUM(COALESCE(rushing_tds, 0)) AS tds,
    ROUND(AVG(COALESCE(rushing_tds, 0)), 2) AS tds_game

FROM nflverse.player_rushing_weekly

WHERE season = :rushing_stats_season
  AND week BETWEEN :rushing_stats_start_week AND :rushing_stats_end_week
  AND position = ANY(:'rushing_stats_position'::text[]) 

GROUP BY
    full_name,
    position

HAVING
    SUM(COALESCE(carries, 0)) > 0

ORDER BY
    :rushing_stats_sort DESC;
