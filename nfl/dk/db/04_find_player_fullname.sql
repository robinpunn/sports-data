SELECT
    player_id,
    full_name,
    position
FROM nflverse.players
WHERE full_name ILIKE '%' || :'find_full_name' || '%';
