CREATE SCHEMA IF NOT EXISTS draftkings;

CREATE TABLE IF NOT EXISTS draftkings.events (
	event_id TEXT PRIMARY KEY,
	season INTEGER, 
	home_team TEXT,
	away_team TEXT
);

CREATE TABLE IF NOT EXISTS draftkings.markets (
	market_id TEXT PRIMARY KEY,
	event_id TEXT NOT NULL REFERENCES draftkings.events(event_id),
	subcategory_id TEXT NOT NULL,
	market_type_id TEXT NOT NULL,
	name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS draftkings.selections (	
	selection_id TEXT PRIMARY KEY,
	market_id TEXT NOT NULL REFERENCES draftkings.markets(market_id),
	player TEXT,
	venue_role TEXT,
	side TEXT
);

CREATE TABLE IF NOT EXISTS draftkings.snapshots (
	snapshot_id BIGSERIAL PRIMARY KEY,
	selection_id TEXT NOT NULL REFERENCES draftkings.selections(selection_id),
	scraped_at TIMESTAMPTZ NOT NULL,
	line NUMERIC(10,2),
	american_odds INTEGER,
	decimal_odds NUMERIC(10,4),
	fractional_odds TEXT,
	implied_probability NUMERIC(8,4)
);
