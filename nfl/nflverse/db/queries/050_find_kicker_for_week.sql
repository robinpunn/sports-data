WITH team_kicking_avg AS (
    SELECT
        offense,
        ROUND(AVG(fg_attempts), 1) AS avg_fg_attempts
    FROM nflverse.offense_weekly
    WHERE season = :find_k_historical_season
      AND week BETWEEN :find_k_start_week AND :find_k_end_week
    GROUP BY offense
),

defense_avg AS (
    SELECT
        defense,
        ROUND(AVG(fg_attempts), 1) AS avg_fg_attempts_allowed
    FROM nflverse.defense_weekly
    WHERE season = :find_k_historical_season
      AND week BETWEEN :find_k_start_week AND :find_k_end_week
    GROUP BY defense
),

kicker_points_allowed AS (
    SELECT
        defense,
        ROUND(AVG(kicker_fantasy_points), 1) AS avg_kicker_points_allowed
    FROM (
        SELECT
            CASE
                WHEN g.home_team = k.team THEN g.away_team
                WHEN g.away_team = k.team THEN g.home_team
            END AS defense,
            g.season,
            g.week,
            SUM(k.fantasy_points) AS kicker_fantasy_points
        FROM nflverse.kicker_fantasy_weekly k
        JOIN nflverse.games g
            ON g.season = k.season
            AND g.week = k.week
            AND (
                g.home_team = k.team
                OR g.away_team = k.team
            )
        WHERE k.season = :find_k_historical_season
          AND k.week BETWEEN :find_k_start_week AND :find_k_end_week
        GROUP BY
            CASE
                WHEN g.home_team = k.team THEN g.away_team
                WHEN g.away_team = k.team THEN g.home_team
            END,
            g.season,
            g.week
    ) kpa
    GROUP BY defense
),

upcoming_matchups AS (

    -- Road team
    SELECT
        g.game_id,
        g.away_team AS team,
        g.home_team AS opponent,
        go.total_line AS total,
        go.spread_line AS spread
    FROM nflverse.games g
    JOIN nflverse.game_odds go
        ON go.game_id = g.game_id
    WHERE g.season = :find_k_season_to_check
      AND g.week = :find_k_week_to_check

    UNION ALL

    -- Home team
    SELECT
        g.game_id,
        g.home_team AS team,
        g.away_team AS opponent,
        go.total_line AS total,
        -go.spread_line AS spread
    FROM nflverse.games g
    JOIN nflverse.game_odds go
        ON go.game_id = g.game_id
    WHERE g.season = :find_k_season_to_check
      AND g.week = :find_k_week_to_check
)

SELECT
    um.team,
    um.opponent,
    tka.avg_fg_attempts,
    da.avg_fg_attempts_allowed,
    kpa.avg_kicker_points_allowed,
    um.total,
    um.spread
FROM upcoming_matchups um
JOIN team_kicking_avg tka
    ON tka.offense = um.team
JOIN defense_avg da
    ON da.defense = um.opponent
JOIN kicker_points_allowed kpa
    ON kpa.defense = um.opponent
ORDER BY
    da.avg_fg_attempts_allowed DESC,
    um.total DESC,
    kpa.avg_kicker_points_allowed DESC,
    tka.avg_fg_attempts DESC;
