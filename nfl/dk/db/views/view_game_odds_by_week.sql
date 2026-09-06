-- sort games
SELECT
    game_id,
    away_moneyline,
    home_moneyline,
    spread_line,
    away_spread_odds,
    home_spread_odds,
    total_line,
    under_odds,
    over_odds
FROM nflverse.game_odds
WHERE game_id LIKE '2026_%'
  AND split_part(game_id, '_', 2)::int BETWEEN 1 AND 17
ORDER BY game_id;

-- sort games based on total and highest spread
SELECT
    game_id,
    away_moneyline,
    home_moneyline,
    spread_line,
    away_spread_odds,
    home_spread_odds,
    total_line,
    under_odds,
    over_odds
FROM nflverse.game_odds
WHERE game_id LIKE '2026_%'
  AND split_part(game_id, '_', 2)::int BETWEEN 1 AND 17
ORDER BY
    split_part(game_id, '_', 2)::int ASC,
    total_line DESC,
    ABS(spread_line) DESC;
