INSERT INTO draftkings.player_map
    (dk_player, nflverse_player_id)
VALUES
    (:'insert_dk_player', :'insert_nflverse_player_id')
ON CONFLICT (dk_player)
DO UPDATE SET
    nflverse_player_id = EXCLUDED.nflverse_player_id;
