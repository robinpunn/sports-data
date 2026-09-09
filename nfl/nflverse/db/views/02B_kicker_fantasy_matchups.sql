CREATE OR REPLACE VIEW nflverse.kicker_fantasy_matchup_weekly AS
SELECT
    k.player_id,
    k.name,
    k.team AS kicker_team,
    g.game_id,
    k.season,
    k.week,
    k.season_type,

    CASE
        WHEN k.team = g.away_team THEN g.home_team
        WHEN k.team = g.home_team THEN g.away_team
    END AS defense,

    k.fantasy_points,
    k.games_played

FROM nflverse.kicker_fantasy_weekly k

JOIN nflverse.games g
    ON k.season = g.season
    AND k.week = g.week
    AND k.season_type = g.game_type
    AND (
        k.team = g.away_team
        OR k.team = g.home_team
    );
