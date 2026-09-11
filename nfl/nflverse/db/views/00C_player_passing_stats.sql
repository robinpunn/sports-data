CREATE OR REPLACE VIEW nflverse.player_passing_weekly AS
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

    pa.completions,
    pa.attempts,
    pa.yards AS passing_yards,
    pa.tds AS passing_tds,
    pa.ints AS interceptions,
    pa.sacks,
    pa.sack_yards_lost,
    pa.sack_fumbles,
    pa.sack_fumbles_lost,
    pa.air_yards,
    pa.yac,
    pa.first_down AS passing_first_downs,
    pa.epa AS passing_epa,
    pa.cpoe,
    pa.two_pt_conv,
    pa.pacr,

    ng.avg_time_to_throw,
    ng.avg_completed_air_yards,
    ng.avg_intended_air_yards,
    ng.avg_air_yards_differential,
    ng.aggressiveness,
    ng.max_completed_air_distance,
    ng.avg_air_yards_to_sticks,
    ng.passer_rating,
    ng.completion_percentage,
    ng.expected_completion_percentage,
    ng.completion_percentage_above_expectation,
    ng.avg_air_distance,
    ng.max_air_distance

FROM nflverse.snaps s

JOIN nflverse.players p
    ON p.pfr_id = s.pfr_player_id

LEFT JOIN nflverse.player_passing pa
    ON pa.player_id = p.player_id
   AND pa.season = s.season
   AND pa.week = s.week
   AND pa.season_type = s.game_type

LEFT JOIN nflverse.player_nextgen_passing ng
    ON ng.player_id = p.player_id
   AND ng.season = s.season
   AND ng.week = s.week
   AND ng.season_type = s.game_type

WHERE s.offense_snaps > 0;
