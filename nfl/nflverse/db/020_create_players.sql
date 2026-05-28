CREATE TABLE nflverse.players (
    player_id TEXT PRIMARY KEY,
    full_name TEXT NOT NULL,
    short_name TEXT,
    birth_date DATE,
    nfl_id TEXT,
    pfr_id TEXT,
    pff_id TEXT,
    espn_id TEXT,
    position TEXT,
    position_group TEXT,
    height INTEGER,
    weight INTEGER
);

CREATE TABLE nflverse.player_draft (
    player_id TEXT PRIMARY KEY REFERENCES players(player_id),
    college_name TEXT,
    college_conference TEXT, 
    draft_year INTEGER,
    draft_round INTEGER,
    draft_pick INTEGER,
    draft_team TEXT
);

CREATE TABLE nflverse.player_status (
    player_id TEXT PRIMARY KEY REFERENCES players(player_id),
    rookie_season INTEGER,
    last_season INTEGER,
    status TEXT,
    years_of_experience INTEGER,
    pff_status TEXT
);    
