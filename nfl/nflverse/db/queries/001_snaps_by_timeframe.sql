SELECT
    player,
    position,
    team,

    COUNT(*) AS games,

    SUM(COALESCE(offense_snaps, 0)) AS snaps,
    ROUND(AVG(COALESCE(offense_snaps, 0)), 2) AS snaps_game,

    ROUND(AVG(offense_pct) * 100, 2) AS snap_pct

FROM nflverse.snaps

WHERE season = :snap_timeframe_season
  AND week BETWEEN :snap_timeframe_start_week AND :snap_timeframe_end_week
  AND position = ANY(:'snap_timeframe_position'::text[])

GROUP BY
    player,
    position,
    team

ORDER BY
    :snap_timeframe_sort DESC;
