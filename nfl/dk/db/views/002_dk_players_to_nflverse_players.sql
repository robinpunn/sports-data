CREATE OR REPLACE VIEW draftkings.selections_with_nflverse_player AS
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
    ON regexp_replace(lower(p.full_name), '[^a-z ]', '', 'g')
     = regexp_replace(lower(s.player), '[^a-z ]', '', 'g')
ORDER BY
    s.player;
