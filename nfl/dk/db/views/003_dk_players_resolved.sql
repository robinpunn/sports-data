CREATE OR REPLACE VIEW draftkings.players_resolved AS

SELECT
    d.dk_player,
    COALESCE(m.nflverse_player_id, a.player_id) AS player_id,
    p.full_name AS nflverse_player,
    p.position
FROM (
    SELECT DISTINCT player AS dk_player
    FROM draftkings.selections
    WHERE player IS NOT NULL
) d
LEFT JOIN draftkings.player_map m
    ON m.dk_player = d.dk_player
LEFT JOIN (
    SELECT DISTINCT ON (dk_player)
        dk_player,
        player_id
    FROM draftkings.selections_with_nflverse_player
    ORDER BY
        dk_player,
        CASE WHEN player_id LIKE '00-%' THEN 0 ELSE 1 END,
        player_id
) a
    ON a.dk_player = d.dk_player
   AND m.nflverse_player_id IS NULL
LEFT JOIN nflverse.players p
    ON p.player_id = COALESCE(m.nflverse_player_id, a.player_id)
ORDER BY
    d.dk_player;
