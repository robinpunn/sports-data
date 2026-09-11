CREATE TABLE nflverse.teams (
    team_id TEXT NOT NULL,        
    abbr TEXT PRIMARY KEY,
    name TEXT NOT NULL,               
    nickname TEXT NOT NULL,
    conference TEXT NOT NULL,
    division TEXT NOT NULL
);

