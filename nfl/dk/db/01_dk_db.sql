CREATE SCHEMA IF NOT EXISTS draftkings;

CREATE TABLE IF NOT EXISTS draftkings.events (
	event_id TEXT PRIMARY KEY,
	name TEXT NOT NULL,
	start_event_date TIMESTAMPTZ,
	home_team TEXT,
	away_team TEXT
);

CREATE TABLE IF NOT EXISTS draftkings.markets (
	market_id TEXT PRIMARY KEY,
	event_id TEXT NOT NULL REFERENCES draftkings.events(event_id),
	name TEXT NOT NULL,
	subcategory_id TEXT NOT NULL,
	market_type_id TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS draftkings.outcomes (
	outcome_id TEXT PRIMARY KEY,
	market_id TEXT NOT NULL REFERENCES draftkings.markets(market_id),
	participant_id TEXT,
	player TEXT,
	outcome_type TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS draftkings.snapshots (
	snapshot_id BIGSERIAL PRIMARY KEY,
	outcome_id TEXT NOT NULL REFERENCES draftkings.outcomes(outcome_id),
	scraped_at TIMESTAMPTZ NOT NULL,
	line NUMERIC(10,2),
	american_odds INTEGER,
	decimal_odds NUMERIC(10,4),
	fractional_odds TEXT,
	implied_probability NUMERIC(8,4)
);
