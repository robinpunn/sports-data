CREATE OR REPLACE VIEW draftkings.latest_props AS 
SELECT DISTINCT on (s.selection_id)
	e.season,
	e.event_id,
	e.home_team,
	e.away_team,
	m.market_id,
	m.subcategory_id,
	m.market_type_id,
	m.name AS market_name,
	s.selection_id,
	s.player,
	s.venue_role,
	s.side,
	sn.scraped_at,
	sn.line,
	sn.american_odds,
	sn.decimal_odds,
	sn.fractional_odds,
	sn.implied_probability
FROM draftkings.events e
JOIN draftkings.markets m ON e.event_id = m.event_id
JOIN draftkings.selections s ON m.market_id = s.market_id
JOIN draftkings.snapshots sn ON s.selection_id = sn.selection_id
ORDER BY s.selection_id, sn.scraped_at DESC;
