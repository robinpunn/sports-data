SELECT
    player,
    position,
    team,
    offense_snaps AS snaps,
    ROUND(offense_pct * 100, 2) AS snap_pct

FROM nflverse.snaps

WHERE season = :snap_stats_season
  AND week = :snap_stats_week
  AND position = ANY(:'snap_stats_position'::text[])

ORDER BY
    snap_pct DESC;
