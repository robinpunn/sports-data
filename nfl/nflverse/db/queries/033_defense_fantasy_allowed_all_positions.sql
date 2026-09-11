SELECT
    defense,
    ROUND(AVG(fantasy_points_allowed) FILTER (WHERE position = 'QB'), 2) AS qb,
    ROUND(AVG(fantasy_points_allowed) FILTER (WHERE position = 'RB'), 2) AS rb,
    ROUND(AVG(fantasy_points_allowed) FILTER (WHERE position = 'WR'), 2) AS wr,
    ROUND(AVG(fantasy_points_allowed) FILTER (WHERE position = 'TE'), 2) AS te,
    ROUND(AVG(fantasy_points_allowed) FILTER (WHERE position = 'K'), 2) AS k
FROM nflverse.defense_fantasy_allowed_w_k_weekly
WHERE season = :team_d_all_pos_ppg_season
  AND week BETWEEN :team_d_all_pos_start_week AND :team_d_all_pos_end_week

GROUP BY defense
ORDER BY :team_d_all_pos DESC;

