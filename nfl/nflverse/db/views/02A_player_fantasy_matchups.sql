CREATE OR REPLACE VIEW nflverse.player_fantasy_matchup_weekly AS
SELECT
    pf.player_id,
    pf.full_name,
    pf.position,
    pf.game_id,
    pf.season,
    pf.week,
    pf.season_type,
    s.team AS player_team,
    CASE
        WHEN s.team = g.away_team THEN g.home_team
        WHEN s.team = g.home_team THEN g.away_team
    END AS defense,
    pf.fantasy_points
FROM nflverse.player_fantasy_weekly pf
JOIN nflverse.snaps s
    ON pf.game_id = s.game_id
JOIN nflverse.games g
    ON pf.game_id = g.game_id
JOIN nflverse.players p
    ON s.pfr_player_id = p.pfr_id
    AND pf.player_id = p.player_id;
