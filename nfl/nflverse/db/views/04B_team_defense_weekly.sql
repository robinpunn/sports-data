CREATE OR REPLACE VIEW nflverse.defense_weekly AS
SELECT
    da.defense,
    da.opponent,
    da.season,
    da.week,
    da.season_type,

    -- What the defense allowed
    da.passing_yards,
    da.rushing_yards,
    da.total_yards_allowed,
    da.points_allowed,

    da.passing_tds,
    da.rushing_tds,
    da.passing_2pt_conversions,
    da.rushing_2pt_conversions,

    da.fg_attempts,
    da.fg_made,
    da.pat_attempts,
    da.pat_made,
    da.special_teams_tds,

    -- What the defense did
    COALESCE(td.def_fumbles_forced, 0) AS fumbles_forced,
    COALESCE(td.def_sacks, 0) AS sacks,
    COALESCE(td.def_qb_hits, 0) AS qb_hits,
    COALESCE(td.def_interceptions, 0) AS interceptions,
    COALESCE(td.def_pass_defended, 0) AS passes_defended,
    COALESCE(td.def_tds, 0) AS defensive_tds,
    COALESCE(td.def_fumbles, 0) AS fumbles,
    COALESCE(td.def_safeties, 0) AS safeties

FROM nflverse.defense_allowed_weekly da

JOIN nflverse.team_defense td
    ON td.team = da.defense
    AND td.season = da.season
    AND td.week = da.week
    AND td.season_type = da.season_type;
