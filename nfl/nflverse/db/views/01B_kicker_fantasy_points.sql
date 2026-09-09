CREATE OR REPLACE VIEW nflverse.kicker_fantasy_weekly AS
SELECT
    player_id,
    name,
    team,
    season,
    week,
    season_type,

    COALESCE(made_list, ARRAY[]::integer[]) AS made_list,

    COALESCE(made, 0) AS field_goals_made,

    COALESCE(
        (
            SELECT SUM(distance)
            FROM unnest(COALESCE(made_list, ARRAY[]::integer[])) AS distance
        ),
        0
    ) AS field_goal_yards,

    COALESCE(pat_made, 0) AS extra_points_made,

    ROUND(
        (
            COALESCE(
                (
                    SELECT SUM(distance)
                    FROM unnest(COALESCE(made_list, ARRAY[]::integer[])) AS distance
                ),
                0
            ) / 10.0
            + COALESCE(pat_made, 0)
        ),
        2
    ) AS fantasy_points,

    1 AS games_played

FROM nflverse.player_kicking;
