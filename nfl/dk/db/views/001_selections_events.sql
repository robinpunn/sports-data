CREATE OR REPLACE VIEW draftkings.selections_with_event AS
SELECT
    s.selection_id,
    s.player,
    s.venue_role,
    s.side,

    m.market_id,
    m.name AS market_name,
    m.subcategory_id,
    m.market_type_id,

    e.event_id,
    e.season,
    e.week,
    e.game_type,
    e.game_id,
    e.home_team,
    e.away_team,

    CASE
        WHEN s.venue_role = 'HomePlayer' THEN e.home_team
        WHEN s.venue_role = 'AwayPlayer' THEN e.away_team
    END AS team

FROM draftkings.selections s
JOIN draftkings.markets m
    ON m.market_id = s.market_id
JOIN draftkings.events_with_nflverse_game e
    ON e.event_id = m.event_id;
