-- 11018 = First TD
-- 11019 = Anytime TD
-- 11020 = 2+ TD

SELECT
    p.player,
    r.position,
    s.team,
    p.home_team,
    p.away_team,
    american_odds
FROM draftkings.latest_props p
JOIN draftkings.selections_with_event s
    ON s.selection_id = p.selection_id
LEFT JOIN draftkings.players_resolved r
    ON r.dk_player = p.player
WHERE p.subcategory_id = '12438'
  AND p.market_type_id = :'market_type_id'
  AND r.position = ANY(:'player_td_positions'::text[])
ORDER BY american_odds ASC;

/* full query without player resolved
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
*/
