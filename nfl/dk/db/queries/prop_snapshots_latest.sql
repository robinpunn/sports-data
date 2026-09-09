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
    player,
    home_team,
    away_team,
    line,
    american_odds
FROM draftkings.latest_props
WHERE subcategory_id = :'subcategory_id'
  AND side = 'Over'
ORDER BY line DESC, american_odds ASC;

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
