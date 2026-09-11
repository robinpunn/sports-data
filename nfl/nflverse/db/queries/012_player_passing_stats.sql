SELECT
    full_name AS name,
    position AS pos,

    COUNT(*) AS games,

    SUM(COALESCE(completions, 0)) AS cmp,
    ROUND(AVG(COALESCE(completions, 0)), 2) AS cmp_game,

    SUM(COALESCE(attempts, 0)) AS att,
    ROUND(AVG(COALESCE(attempts, 0)), 2) AS att_game,

    SUM(COALESCE(passing_yards, 0)) AS yds,
    ROUND(AVG(COALESCE(passing_yards, 0)), 2) AS yds_game,

    ROUND(
        SUM(COALESCE(completions, 0))::numeric
        / NULLIF(SUM(COALESCE(attempts, 0)), 0) * 100,
        2
    ) AS cmp_pct,

    ROUND(
        SUM(COALESCE(passing_yards, 0))::numeric
        / NULLIF(SUM(COALESCE(attempts, 0)), 0),
        2
    ) AS yds_att,

    SUM(COALESCE(passing_tds, 0)) AS tds,
    ROUND(AVG(COALESCE(passing_tds, 0)), 2) AS tds_game,

    SUM(COALESCE(interceptions, 0)) AS ints,
    ROUND(AVG(COALESCE(interceptions, 0)), 2) AS ints_game

FROM nflverse.player_passing_weekly

WHERE season = :passing_stats_season
  AND week BETWEEN :passing_stats_start_week AND :passing_stats_end_week
  AND position = ANY(:'passing_stats_position'::text[])

GROUP BY
    name,
    pos

HAVING
    SUM(COALESCE(attempts, 0)) > 0

ORDER BY
    :passing_stats_sort DESC;
