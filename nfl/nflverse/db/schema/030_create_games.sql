CREATE TABLE IF NOT EXISTS nflverse.games (
    game_id TEXT NOT NULL PRIMARY KEY,
    pfr TEXT,
    pff TEXT,
    espn TEXT,
    season INTEGER,
    week INTEGER,
    game_type TEXT,
    gameday TEXT,
    weekday TEXT,
    gametime TEXT,
    away_team TEXT,
    away_score INTEGER,
    home_team TEXT,
    home_score INTEGER,
    result INTEGER,
    total INTEGER,
    overtime INTEGER
);

CREATE TABLE IF NOT EXISTS nflverse.game_odds (
    game_id TEXT NOT NULL PRIMARY KEY REFERENCES nflverse.games(game_id),
    away_moneyline INTEGER,
    home_moneyline INTEGER,
    spread_line INTEGER,
    away_spread_odds INTEGER,
    home_spread_odds INTEGER,
    total_line INTEGER,
    under_odds INTEGER,
    over_odds INTEGER
);

CREATE TABLE IF NOT EXISTS nflverse.game_context (
    game_id TEXT NOT NULL PRIMARY KEY REFERENCES nflverse.games(game_id),
    location TEXT,
    div_game INTEGER,
    away_coach TEXT,
    home_coach TEXT,
    referee TEXT,
    away_rest INTEGER,
    home_rest INTEGER, 
    stadium_id TEXT,
    stadium TEXT
);

CREATE TABLE IF NOT EXISTS nflverse.game_conditions (
    game_id TEXT NOT NULL PRIMARY KEY REFERENCES nflverse.games(game_id),
    roof TEXT,
    surface TEXT,
    temp INTEGER,
    wind INTEGER
);
