SELECT
    offense,
    SUM(pass_attempts) AS pass_attempts, 
    SUM(sacks_suffered) AS sacks_suffered,
    SUM(qb_hits_allowed) AS qb_hits_allowed,
    SUM(sack_fumbles_lost) AS sack_fumbles_lost
 
FROM nflverse.offense_weekly

WHERE season = :team_pass_pain_season
  AND week BETWEEN :team_pass_pain_start_week AND :team_pass_pain_end_week

GROUP BY offense

ORDER BY :team_pass_pain_order DESC;

/*
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

ORDER BY :pass_etc_order_by DESC;
*/
