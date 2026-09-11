CREATE OR REPLACE VIEW nflverse.player_receiving_weekly AS
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

    r.receptions,
    r.targets,
    r.yards AS receiving_yards,
    r.tds AS receiving_tds,
    r.fumbles,
    r.fumbles_lost,
    r.air_yards,
    r.yac,
    r.first_down AS receiving_first_downs,
    r.epa AS receiving_epa,
    r.two_pt_conv AS receiving_two_pt_conv,
    r.racr,
    r.tar_share,
    r.a_y_share,
    r.wopr,

    ng.avg_cushion,
    ng.avg_separation,
    ng.percent_share_of_intended_air_yards,
    ng.catch_percentage,
    ng.avg_yac,
    ng.avg_expected_yac,
    ng.avg_yac_above_expectation

FROM nflverse.snaps s

JOIN nflverse.players p
    ON p.pfr_id = s.pfr_player_id

LEFT JOIN nflverse.player_receiving r
    ON r.player_id = p.player_id
   AND r.season = s.season
   AND r.week = s.week
   AND r.season_type = s.game_type

LEFT JOIN nflverse.player_nextgen_receiving ng
    ON ng.player_id = p.player_id
   AND ng.season = s.season
   AND ng.week = s.week
   AND ng.season_type = s.game_type

WHERE s.offense_snaps > 0;
