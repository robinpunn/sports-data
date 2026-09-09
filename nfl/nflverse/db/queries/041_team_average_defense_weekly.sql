SELECT
    defense,
    ROUND(AVG(points_allowed), 1) AS pts_allowed,
    ROUND(AVG(passing_yards), 1) AS p_yds_allowed,
    ROUND(AVG(rushing_yards), 1) AS r_yds_allowed,
    ROUND(AVG(total_yards_allowed), 1) AS t_yds_allowed,
    ROUND(AVG(sacks), 1) AS sacks,
    ROUND(AVG(interceptions), 1) AS ints,
    ROUND(AVG(fumbles_forced), 1) AS f_f,
    ROUND(AVG(qb_hits), 1) AS qb_hits,
    ROUND(AVG(defensive_tds), 1) AS tds,
    ROUND(AVG(safeties), 1) AS safe
FROM nflverse.defense_weekly
WHERE season = :team_d_basic_season
  AND week BETWEEN :team_d_basic_start_week AND :team_d_basic_end_week
GROUP BY defense
ORDER BY :team_d_basic_order_by DESC;
