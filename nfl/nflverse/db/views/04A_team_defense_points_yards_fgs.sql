CREATE OR REPLACE VIEW nflverse.defense_allowed_weekly AS

SELECT
    g.home_team AS defense,
    g.away_team AS opponent,
    g.season,
    g.week,
    g.game_type AS season_type,

    ao.passing_yards,
    ao.rushing_yards,
    ao.passing_tds,
    ao.rushing_tds,
    ao.passing_2pt_conversions,
    ao.rushing_2pt_conversions,

    ak.att AS fg_attempts,
    ak.made AS fg_made,
    ak.pat_att AS pat_attempts,
    ak.pat_made,

    ast.tds AS special_teams_tds,

    (
        COALESCE(ao.passing_yards, 0) +
        COALESCE(ao.rushing_yards, 0)
    ) AS total_yards_allowed,

    (
        COALESCE(ao.passing_tds, 0) * 6 +
        COALESCE(ao.rushing_tds, 0) * 6 +
        COALESCE(ao.passing_2pt_conversions, 0) * 2 +
        COALESCE(ao.rushing_2pt_conversions, 0) * 2 +
        COALESCE(ak.made, 0) * 3 +
        COALESCE(ak.pat_made, 0) +
        COALESCE(ast.tds, 0) * 6
    ) AS points_allowed

FROM nflverse.games g

JOIN nflverse.team_offense ao
    ON ao.team = g.away_team
    AND ao.season = g.season
    AND ao.week = g.week
    AND ao.season_type = g.game_type

JOIN nflverse.team_kicking ak
    ON ak.team = g.away_team
    AND ak.season = g.season
    AND ak.week = g.week
    AND ak.season_type = g.game_type

JOIN nflverse.team_special_teams ast
    ON ast.team = g.away_team
    AND ast.season = g.season
    AND ast.week = g.week
    AND ast.season_type = g.game_type

UNION ALL

SELECT
    g.away_team AS defense,
    g.home_team AS opponent,
    g.season,
    g.week,
    g.game_type AS season_type,

    ho.passing_yards,
    ho.rushing_yards,
    ho.passing_tds,
    ho.rushing_tds,
    ho.passing_2pt_conversions,
    ho.rushing_2pt_conversions,

    hk.att AS fg_attempts,
    hk.made AS fg_made,
    hk.pat_att AS pat_attempts,
    hk.pat_made,

    hst.tds AS special_teams_tds,

    (
        COALESCE(ho.passing_yards, 0) +
        COALESCE(ho.rushing_yards, 0)
    ) AS total_yards_allowed,

    (
        COALESCE(ho.passing_tds, 0) * 6 +
        COALESCE(ho.rushing_tds, 0) * 6 +
        COALESCE(ho.passing_2pt_conversions, 0) * 2 +
        COALESCE(ho.rushing_2pt_conversions, 0) * 2 +
        COALESCE(hk.made, 0) * 3 +
        COALESCE(hk.pat_made, 0) +
        COALESCE(hst.tds, 0) * 6
    ) AS points_allowed

FROM nflverse.games g

JOIN nflverse.team_offense ho
    ON ho.team = g.home_team
    AND ho.season = g.season
    AND ho.week = g.week
    AND ho.season_type = g.game_type

JOIN nflverse.team_kicking hk
    ON hk.team = g.home_team
    AND hk.season = g.season
    AND hk.week = g.week
    AND hk.season_type = g.game_type

JOIN nflverse.team_special_teams hst
    ON hst.team = g.home_team
    AND hst.season = g.season
    AND hst.week = g.week
    AND hst.season_type = g.game_type;
