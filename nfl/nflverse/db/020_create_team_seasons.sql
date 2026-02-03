CREATE TABLE team_seasons (
    team_id TEXT REFERENCES teams(team_id),
    season INTEGER NOT NULL,
    conference TEXT NOT NULL,
    division TEXT NOT NULL,
    PRIMARY KEY (team_id, season)
);
