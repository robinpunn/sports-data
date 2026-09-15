-- 9514  = Rushing Yards
-- 9518  = Rush Attempts
-- 9523  = Rush + Rec Yards
-- 14114 = Receiving Yards
-- 14115 = Receptions
-- 9524  = Passing Yards
-- 9525  = Passing TDs
-- 9517  = Passing Attempts
-- 15937 = Passing INTs

SELECT
    p.player,
    r.position,
    s.team,
    p.home_team,
    p.away_team,
    p.market_name,
    p.line,
    p.american_odds
FROM draftkings.latest_props p
JOIN draftkings.selections_with_event s
    ON s.selection_id = p.selection_id
LEFT JOIN draftkings.players_resolved r
    ON r.dk_player = p.player
WHERE p.subcategory_id = :'subcategory_id'
  AND p.side = 'Over'
  AND r.position = ANY(:'player_prop_positions'::text[])
ORDER BY
    p.line DESC,
    p.american_odds ASC;

/* tmi, but saving for reference
SELECT
    p.player,
    r.player_id,
    r.nflverse_player,
    r.position,
    s.team,
    p.home_team,
    p.away_team,
    p.market_name,
    p.line,
    p.american_odds
FROM draftkings.latest_props p
JOIN draftkings.selections_with_event s
    ON s.selection_id = p.selection_id
LEFT JOIN draftkings.players_resolved r
    ON r.dk_player = p.player
WHERE p.subcategory_id = :'subcategory_id'
  AND p.side = 'Over'
ORDER BY
    p.line DESC,
    p.american_odds ASC;
*/

/*
this version didn't use the players resolved view
SELECT
    p.player,
    s.team,
    p.home_team,
    p.away_team,
    p.line,
    p.american_odds
FROM draftkings.latest_props p
JOIN draftkings.selections_with_event s
    ON s.selection_id = p.selection_id
WHERE p.subcategory_id = :'subcategory_id'
  AND p.side = 'Over'
ORDER BY
    p.line DESC,
    p.american_odds ASC;
*/

/*
SELECT
    player,
    home_team,
    away_team,
    line,
    american_odds
FROM draftkings.latest_props
WHERE subcategory_id = :'subcategory_id'
  AND side = 'Over'
ORDER BY line DESC, american_odds ASC;
*/

/* full query
SELECT
    player,
    home_team,
    away_team,
    market_name,
    line,
    american_odds
FROM draftkings.latest_props
WHERE subcategory_id = :'subcategory_id'
  AND side = 'Over'
ORDER BY line DESC, american_odds ASC;
*/
