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
    offense_pct NUMERIC(5,4),
    defense_snaps INTEGER,
    defense_pct NUMERIC(5,4),
    st_snaps INTEGER,
    st_pct NUMERIC(5,4),
    PRIMARY KEY (game_id, pfr_player_id) 
);
