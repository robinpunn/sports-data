CREATE TABLE draftkings.player_map (
    dk_player text PRIMARY KEY,
    nflverse_player_id text
        REFERENCES nflverse.players(player_id)
);
