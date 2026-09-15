SELECT
    s.player AS dk_player,
    p.player_id,
    p.full_name AS nflverse_player,
    p.position
FROM (
    SELECT DISTINCT player
    FROM draftkings.selections
    WHERE player IS NOT NULL
) s
LEFT JOIN nflverse.players p
    ON p.full_name = s.player
ORDER BY
    s.player;
