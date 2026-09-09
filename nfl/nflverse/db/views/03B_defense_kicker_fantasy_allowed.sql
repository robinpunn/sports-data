CREATE OR REPLACE VIEW nflverse.kicker_fantasy_allowed_weekly AS
SELECT
    defense,
    season,
    week,
    season_type,
    SUM(fantasy_points) AS fantasy_points_allowed
FROM nflverse.kicker_fantasy_matchup_weekly
GROUP BY
    defense,
    season,
    week,
    season_type;
