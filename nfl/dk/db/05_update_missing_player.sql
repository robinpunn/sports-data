UPDATE draftkings.player_map
SET nflverse_player_id = :'update_nflverse_player_id'
WHERE dk_player = :'update_dk_player';
