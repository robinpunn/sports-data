CREATE OR REPLACE VIEW nflverse.defense_fantasy_allowed_weekly AS
SELECT
    defense,
    season,
    week,
    season_type,
    position,
    SUM(fantasy_points) AS fantasy_points_allowed
FROM nflverse.player_fantasy_matchup_weekly
GROUP BY
    defense,
    season,
    week,
    season_type,
    position;
