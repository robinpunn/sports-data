-- 11018 = First TD
-- 11019 = Anytime TD
-- 11020 = 2+ TD

\set market_type_id 11019

SELECT
    player,
    event_id,
    home_team,
    away_team,
    market_name,
    american_odds
FROM draftkings.latest_props
WHERE subcategory_id = '12438'
  AND market_type_id = :'market_type_id'
ORDER BY american_odds ASC;
