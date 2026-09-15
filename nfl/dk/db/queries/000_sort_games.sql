SELECT
    event_id,
    season,
    week,
    game_type,
    home_team,
    away_team,
    game_id
FROM draftkings.events_with_nflverse_game
WHERE season = :dk_events_season
  AND week BETWEEN :dk_events_start_week AND :dk_events_end_week
ORDER BY
    week,
    game_id;
