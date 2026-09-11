CREATE OR REPLACE VIEW nflverse.player_rushing_weekly AS
SELECT
    s.game_id,
    s.season,
    s.week,
    s.game_type,
    s.team,
    s.pfr_player_id,
    p.player_id,
    p.full_name,
    p.position,
    s.offense_snaps,

    r.carries,
    r.yards AS rushing_yards,
    r.tds AS rushing_tds,
    r.fumbles,
    r.fumbles_lost,
    r.first_down AS rushing_first_downs,
    r.epa AS rushing_epa,
    r.two_pt_conv AS rushing_two_pt_conv,

    ng.efficiency,
    ng.eight_defenders,
    ng.avg_time_to_los,
    ng.expected_rush_yards,
    ng.avg_rush_yards,
    ng.rush_yards_over_expected_per_att,
    ng.rush_pct_over_expected

FROM nflverse.snaps s

JOIN nflverse.players p
    ON p.pfr_id = s.pfr_player_id

LEFT JOIN nflverse.player_rushing r
    ON r.player_id = p.player_id
   AND r.season = s.season
   AND r.week = s.week
   AND r.season_type = s.game_type

LEFT JOIN nflverse.player_nextgen_rushing ng
    ON ng.player_id = p.player_id
   AND ng.season = s.season
   AND ng.week = s.week
   AND ng.season_type = s.game_type

WHERE s.offense_snaps > 0;
