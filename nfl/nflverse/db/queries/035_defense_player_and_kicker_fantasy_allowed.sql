SELECT
    defense,
    position,
    ROUND(AVG(fantasy_points_allowed), 2) AS avg_fantasy_points_allowed
FROM (
    SELECT
        defense,
        season,
        week,
        season_type,
        position,
        fantasy_points_allowed
    FROM nflverse.defense_fantasy_allowed_weekly
    WHERE season = :d_player_kicker_ppg_season
      AND week BETWEEN :d_player_kicker_ppg_start_week AND :d_player_kicker_ppg_end_week
      AND position = ANY(:'d_player_kicker_ppg_positions'::text[]) 

    UNION ALL

    SELECT
        defense,
        season,
        week,
        season_type,
        'K' AS position,
        fantasy_points_allowed
    FROM nflverse.kicker_fantasy_allowed_weekly
    WHERE season = :d_player_kicker_ppg_season
      AND week BETWEEN :d_player_kicker_ppg_start_week AND :d_player_kicker_ppg_end_week
) allowed
GROUP BY
    defense,
    position
ORDER BY
    defense,
    position;
