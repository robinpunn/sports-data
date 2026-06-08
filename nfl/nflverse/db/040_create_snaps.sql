CREATE TABLE IF NOT EXISTS nflverse.snaps (
    game_id TEXT NOT NULL REFERENCES nflverse.games(game_id),
    pfr_game_id TEXT,
    season INTEGER,
    week INTEGER,
    game_type TEXT,
    player TEXT,
    position TEXT,
    team TEXT,
    pfr_player_id TEXT,
    offense_snaps INTEGER,
    offense_pct FLOAT,
    defense_snaps INTEGER,
    defense_pct FLOAT,
    st_snaps INTEGER,
    st_pct FLOAT,
    PRIMARY KEY (game_id, pfr_player_id) 
);
