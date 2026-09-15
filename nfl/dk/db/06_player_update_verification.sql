SELECT
    m.dk_player,
    m.nflverse_player_id,
    p.full_name,
    p.position
FROM draftkings.player_map m
JOIN nflverse.players p
    ON p.player_id = m.nflverse_player_id
WHERE m.dk_player = :'dk_player';
