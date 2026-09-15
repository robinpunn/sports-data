SELECT DISTINCT
    p.dk_player,
    e.team
FROM draftkings.selections_with_nflverse_player p
JOIN draftkings.selections_with_event e
    ON e.player = p.dk_player
WHERE p.player_id IS NULL
ORDER BY
    e.team,
    p.dk_player;

/*
SELECT
    dk_player
FROM draftkings.selections_with_nflverse_player
WHERE player_id IS NULL
ORDER BY dk_player;
*/
