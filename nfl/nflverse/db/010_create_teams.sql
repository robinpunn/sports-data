CREATE TABLE teams (
    team_id TEXT PRIMARY KEY,        
    abbr TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,               
    nickname TEXT NOT NULL            
);

