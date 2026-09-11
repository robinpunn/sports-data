CREATE OR REPLACE VIEW nflverse.offense_weekly AS

SELECT
    g.away_team AS offense,
    g.home_team AS opponent,
    g.season,
    g.week,
    g.game_type AS season_type,

    ao.attempts AS pass_attempts,
    ao.completions AS completions,
    ao.targets AS targets,
    ao.passing_yards,

    ao.carries,
    ao.rushing_yards,

    ao.sacks_suffered,
    td.def_qb_hits AS qb_hits_allowed,

    ak.att AS fg_attempts,
    ak.made AS fg_made,

    ao.passing_interceptions AS interceptions_thrown,

    COALESCE(ao.sack_fumbles_lost, 0) AS sack_fumbles_lost,
    COALESCE(ao.rushing_fumbles_lost, 0) AS rushing_fumbles_lost,
    COALESCE(ao.receiving_fumbles_lost, 0) AS receiving_fumbles_lost,

    COALESCE(ao.sack_fumbles_lost, 0)
        + COALESCE(ao.rushing_fumbles_lost, 0)
        + COALESCE(ao.receiving_fumbles_lost, 0) AS fumbles_lost

FROM nflverse.games g

JOIN nflverse.team_offense ao
    ON ao.team = g.away_team
    AND ao.season = g.season
    AND ao.week = g.week
    AND ao.season_type = g.game_type

JOIN nflverse.team_defense td
    ON td.team = g.home_team
    AND td.season = g.season
    AND td.week = g.week
    AND td.season_type = g.game_type

JOIN nflverse.team_kicking ak
    ON ak.team = g.away_team
    AND ak.season = g.season
    AND ak.week = g.week
    AND ak.season_type = g.game_type

UNION ALL

SELECT
    g.home_team AS offense,
    g.away_team AS opponent,
    g.season,
    g.week,
    g.game_type AS season_type,

    ho.attempts AS pass_attempts,
    ho.completions AS completions,
    ho.targets AS targets,
    ho.passing_yards,

    ho.carries,
    ho.rushing_yards,

    ho.sacks_suffered,
    td.def_qb_hits AS qb_hits_allowed,

    hk.att AS fg_attempts,
    hk.made AS fg_made,

    ho.passing_interceptions AS interceptions_thrown,

    COALESCE(ho.sack_fumbles_lost, 0) AS sack_fumbles_lost,
    COALESCE(ho.rushing_fumbles_lost, 0) AS rushing_fumbles_lost,
    COALESCE(ho.receiving_fumbles_lost, 0) AS receiving_fumbles_lost,

    COALESCE(ho.sack_fumbles_lost, 0)
        + COALESCE(ho.rushing_fumbles_lost, 0)
        + COALESCE(ho.receiving_fumbles_lost, 0) AS fumbles_lost

FROM nflverse.games g

JOIN nflverse.team_offense ho
    ON ho.team = g.home_team
    AND ho.season = g.season
    AND ho.week = g.week
    AND ho.season_type = g.game_type

JOIN nflverse.team_defense td
    ON td.team = g.away_team
    AND td.season = g.season
    AND td.week = g.week
    AND td.season_type = g.game_type

JOIN nflverse.team_kicking hk
    ON hk.team = g.home_team
    AND hk.season = g.season
    AND hk.week = g.week
    AND hk.season_type = g.game_type;
