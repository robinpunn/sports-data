CREATE TABLE players (
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
    weight INTEGER,

    college_name TEXT,
    college_conference TEXT, 

    draft_year INTEGER,
    draft_round INTEGER,
    draft_pick INTEGER,
    draft_team TEXT
    rookie_season DATE,

    status TEXT,
    years_of_experience INTEGER,
    pff_status TEXT,
);    
