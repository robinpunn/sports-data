SELECT DISTINCT
    m.dk_player,
    e.team,
    m.nflverse_player_id
FROM draftkings.player_map m
JOIN draftkings.selections_with_event e
    ON e.player = m.dk_player
ORDER BY
    e.team,
    m.dk_player;
