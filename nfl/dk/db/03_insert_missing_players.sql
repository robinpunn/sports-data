INSERT INTO draftkings.player_map (dk_player)
SELECT dk_player
FROM draftkings.selections_with_nflverse_player
WHERE player_id IS NULL
  AND dk_player NOT LIKE '%D/ST'
  AND dk_player <> 'No Touchdown Scorer'
ON CONFLICT (dk_player) DO NOTHING;
