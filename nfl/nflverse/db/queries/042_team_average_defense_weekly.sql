SELECT
    defense,
    ROUND(AVG(points_allowed), 1) AS pts_allowed,
    ROUND(AVG(passing_yards), 1) AS pass_yds_allowed,
    ROUND(AVG(rushing_yards), 1) AS rush_yds_allowed,
    ROUND(AVG(total_yards_allowed), 1) AS total_yds_allowed,
    ROUND(AVG(fg_attempts), 1) AS fg_attempts_allowed,
    ROUND(AVG(fg_made), 1) AS fg_made_allowed,
    ROUND(AVG(sacks), 1) AS sacks,
    ROUND(AVG(interceptions), 1) AS interceptions,
    ROUND(AVG(fumbles_forced), 1) AS fumbles_forced,
    ROUND(AVG(qb_hits), 1) AS qb_hits,
    ROUND(AVG(passes_defended), 1) AS passes_defended,
    ROUND(AVG(defensive_tds), 1) AS defensive_tds,
    ROUND(AVG(safeties), 1) AS safeties
FROM nflverse.defense_weekly
WHERE season = :season
  AND week BETWEEN :start_week AND :end_week
GROUP BY defense
ORDER BY :team_d_order_by;
