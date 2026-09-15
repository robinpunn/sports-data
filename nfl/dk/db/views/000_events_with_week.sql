CREATE OR REPLACE VIEW draftkings.events_with_nflverse_game AS
SELECT
    e.event_id,
    e.season,

    e.home_team,
    e.away_team,

    g.game_id,
    g.week,
    g.game_type,

    g.home_team AS nflverse_home_team,
    g.away_team AS nflverse_away_team

FROM draftkings.events e
JOIN nflverse.games g
    ON g.season = e.season
   AND (
        (g.home_team = e.home_team
         AND g.away_team = e.away_team)

        OR

        (e.home_team = 'LAR'
         AND g.home_team = 'LA'
         AND g.away_team = e.away_team)
       );
