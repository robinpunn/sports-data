CREATE TABLE IF NOT EXISTS nflverse.player_nextgen_passing (
    player_id TEXT NOT NULL REFERENCES nflverse.players(player_id),
    name TEXT NOT NULL,
    position TEXT,
    team TEXT,
    season INTEGER,
    week INTEGER,
    season_type TEXT,
    avg_time_to_throw NUMERIC(8,4),
    avg_completed_air_yards NUMERIC(8,4),
    avg_intended_air_yards NUMERIC(8,4),
    avg_air_yards_differential NUMERIC(8,4),
    aggressiveness NUMERIC(8,4),
    max_completed_air_distance NUMERIC(8,4),
    avg_air_yards_to_sticks NUMERIC(8,4),
    passer_rating NUMERIC(8,4),
    completion_percentage NUMERIC(8,4), 
    expected_completion_percentage NUMERIC(8,4),
    completion_percentage_above_expectation NUMERIC(8,4),
    avg_air_distance NUMERIC(8,4),
    max_air_distance NUMERIC(8,4),
    PRIMARY KEY (player_id, season, week, season_type)
);

CREATE TABLE IF NOT EXISTS nflverse.player_nextgen_rushing (
    player_id TEXT NOT NULL REFERENCES nflverse.players(player_id),
    name TEXT NOT NULL,
    position TEXT,
    team TEXT,
    season INTEGER,
    week INTEGER,
    season_type TEXT,
    efficiency NUMERIC(8,4),
    eight_defenders NUMERIC(8,4),
    avg_time_to_los NUMERIC(8,4),
    expected_rush_yards NUMERIC(8,4),
    avg_rush_yards NUMERIC(8,4),
    rush_yards_over_expected_per_att NUMERIC(8,4),
    rush_pct_over_expected NUMERIC(8,4), 
    PRIMARY KEY (player_id, season, week, season_type)
);

CREATE TABLE IF NOT EXISTS nflverse.player_nextgen_receiving (
    player_id TEXT NOT NULL REFERENCES nflverse.players(player_id),
    name TEXT NOT NULL,
    position TEXT,
    team TEXT,
    season INTEGER,
    week INTEGER,
    season_type TEXT,
    avg_cushion NUMERIC(8,4),
    avg_separation NUMERIC(8,4),
    percent_share_of_intended_air_yards NUMERIC(8,4),
    catch_percentage NUMERIC(8,4),
    avg_yac NUMERIC(8,4),
    avg_expected_yac NUMERIC(8,4),
    avg_yac_above_expectation NUMERIC(8,4),
    PRIMARY KEY (player_id, season, week, season_type)
);
