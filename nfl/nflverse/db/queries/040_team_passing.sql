SELECT
    offense,
    SUM(pass_attempts) AS pass_attempts,
    SUM(completions) AS completions,
    SUM(passing_yards) AS passing_yards,

    SUM(sacks_suffered) AS sacks_suffered,
    SUM(qb_hits_allowed) AS qb_hits_allowed,
    SUM(sack_fumbles_lost) AS sack_fumbles_lost,

    ROUND(
        SUM(passing_yards)::numeric / NULLIF(SUM(pass_attempts), 0),
        1
    ) AS yards_per_attempt,

    ROUND(
        SUM(passing_yards)::numeric / NULLIF(SUM(completions), 0),
        1
    ) AS yards_per_completion

FROM nflverse.offense_weekly

WHERE season = :season
  AND week BETWEEN :start_week AND :end_week
  AND season_type = 'REG'

GROUP BY offense

ORDER BY :order_by DESC;
