CREATE OR REPLACE VIEW nflverse.player_fantasy_weekly AS
SELECT
    p.player_id,
    p.full_name,
    p.position,
    s.game_id,
    s.season,
    s.week,
    s.game_type AS season_type,

    1 AS games_played,

    COALESCE(pp.yards, 0) AS passing_yards,
    COALESCE(pp.tds, 0) AS passing_tds,
    COALESCE(pp.ints, 0) AS passing_interceptions,

    COALESCE(pru.yards, 0) AS rushing_yards,
    COALESCE(pru.tds, 0) AS rushing_tds,

    COALESCE(pre.receptions, 0) AS receptions,
    COALESCE(pre.yards, 0) AS receiving_yards,
    COALESCE(pre.tds, 0) AS receiving_tds,

    COALESCE(st.tds, 0) AS return_tds,

    (
        COALESCE(pp.two_pt_conv, 0)
        + COALESCE(pru.two_pt_conv, 0)
        + COALESCE(pre.two_pt_conv, 0)
    ) AS two_point_conversions,

    (
        COALESCE(pp.sack_fumbles_lost, 0)
        + COALESCE(pru.fumbles_lost, 0)
        + COALESCE(pre.fumbles_lost, 0)
    ) AS fumbles_lost,

    ROUND(
        (
            COALESCE(pp.yards, 0) / 25.0
            + COALESCE(pp.tds, 0) * 4
            - COALESCE(pp.ints, 0)
            + COALESCE(pru.yards, 0) / 10.0
            + COALESCE(pru.tds, 0) * 6
            + COALESCE(pre.receptions, 0) * 0.5
            + COALESCE(pre.yards, 0) / 10.0
            + COALESCE(pre.tds, 0) * 6
            + COALESCE(st.tds, 0) * 6
            + (
                COALESCE(pp.two_pt_conv, 0)
                + COALESCE(pru.two_pt_conv, 0)
                + COALESCE(pre.two_pt_conv, 0)
            ) * 2
            - (
                COALESCE(pp.sack_fumbles_lost, 0)
                + COALESCE(pru.fumbles_lost, 0)
                + COALESCE(pre.fumbles_lost, 0)
            ) * 2
        ),
        2
    ) AS fantasy_points

FROM nflverse.snaps s

JOIN nflverse.players p
    ON s.pfr_player_id = p.pfr_id

LEFT JOIN nflverse.player_passing pp
    ON p.player_id = pp.player_id
    AND pp.season = s.season
    AND pp.week = s.week
    AND pp.season_type = s.game_type

LEFT JOIN nflverse.player_rushing pru
    ON p.player_id = pru.player_id
    AND pru.season = s.season
    AND pru.week = s.week
    AND pru.season_type = s.game_type

LEFT JOIN nflverse.player_receiving pre
    ON p.player_id = pre.player_id
    AND pre.season = s.season
    AND pre.week = s.week
    AND pre.season_type = s.game_type

LEFT JOIN nflverse.player_special_teams st
    ON p.player_id = st.player_id
    AND st.season = s.season
    AND st.week = s.week
    AND st.season_type = s.game_type

WHERE s.offense_snaps > 0
   OR s.st_snaps > 0;
