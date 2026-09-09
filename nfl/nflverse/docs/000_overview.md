# nflvers/db
running these queries assuming we're inside ~/Develop/python/sports-data/:
`psql nfl -f nfl/nflverse/db/020_create_players.sql`
### analysis_setup
found in the nfl directory, running this sets a bunch of variables in psql required for certain queries... this is the 'for now' method until i find a better workflow...

# nflverse/views
### player_fantasy_points
uses the snaps table and joins player, player passing, player rushing, player receiving, and player special teams tables creating the `player_fantasy_weekly` view
- tracks the amount of games played
- calculate fantasy points for each game based on 0.5 ppr scoring

### kicker_fantasy_points
uses the player_kicking table to create a view that calculates kicker fantasy points at 1 point per 10 yards

### player_fantasy_matchups
uses the `player_fantasy` view and joins the snaps, games, and players table to create the `player_fantasy_matchup_weekly` view which provides the game_id and other identifying information for games

### kicker_fantasy_matchups
uses the `kicker_fantasy_weekly` view and joins the snaps, games, and players table to create the `player_fantasy_matchup_weekly` view which provides the game_id and other identifying information for games

### defense_player_fantasy_allowed
create the `defense_fantasy_allowed_weekly` view from `fantasy_matchup_weekly` allowing for queries to see how many fantasy points a defense allows to the specified positions

### defense_kicker_fantasy_allowed
create the `kicker_fantasy_allowed_weekly` view from `kicker_fantasy_matchup_weekly` allowing for queries to see how many fantasy points a defense allows to kickers 

### team_defense_points_yards_fgs
this `defense_allowed_weekly` view uses games, team_offense, team_kicking, team_special_teams tables to reverse engineer defensive stats from the opponent's offense production 

### team_defense_weekly
the `defense_weekly` view uses the `defense_weekly_allowed` to combine the opponent's offensive production with the team's defensive stats...

# nflverse/queries
### 010_wr_stats_by_rookie_year
queries players and receiving tables... choose a rookie season, choose a year, and get the final stats for that year for all the players from that rookie season
- currently just for WR as i bought into the idea of the 3rd year jump
- but it can be used with other positions... it's just limited to receiving stats
```
\set rookie_season 2025
\set current_season_for_rookie_wr :season
\set rec_rookie_position 'WR'
```

### 020_sort_by_player_fantasy_points
queries the player_fantasy_weekly view, sorting players by most points per game given a fixed period
- choose the season
- choose a start week and end week
- choose multiple positions or just one:`\set positions '{QB,RB,WR,TE}'`
```
\set season_for_player_ppg :season
\set player_ppg_start_week 1
\set player_ppg_end_week 17
\set player_ppg_positions '{QB,RB,WR,TE}'
```

### 021_kicker_fantasy_ppg
queries the kicker_fantasy_matchup_weekly view to provide the average points per game for a kicker 
- choose the season
- choose a start week and end week
```
\set kicker_season :season
\set kicker_start_week 1
\set kicker_end_week 17
```

### 030_defense_player_fantasy_allowed_average
queries the `defense_fantasy_allowed_weekly` view to see how many points a defense gives up to a certain position in a week range
- set the season
- set the start week and end week
- set the position
```
\set def_player_ppg_season :season
\set def_player_ppg_start_week 1
\set def_player_ppg_end_week 17
\set def_player_ppg_position 'QB'
```

### 031_offense_kicking_fantasy_average
queries the `kicker_fantasy_weekly` view to determine the average points over a given period for all kickers from the team
- set season
- set start week and week
```
\set team_k_season :season
\set team_k_start_week 1
\set team_k_end_week 17
```

### 035_defense_player_and_kicker_fantasy_allowed
... this one needs to be refined... right now it just lists the teams alphabetically and lists how much the team gives up on average to each position given the time frame
```
\set d_player_kicker_ppg_season :season
\set d_player_kicker_ppg_start_week 1
\set d_player_kicker_ppg_end_week 10
\set d_player_kicker_ppg_positions '{QB,RB,WR,TE}'
```

### 040_team_passing_pain
queries `offense_weekly` view to sort based on sacks suffered, qb hits, or sack fumbles lost
```
\set team_pass_pain_season :season
\set team_pass_pain_start_week 1
\set team_pass_pain_end_week 17
\set team_pass_pain_order sacks_suffered
```

### 041_team_average_defense_weekly
queries the `defense_weekly` view to get the basic defense stats and qb hits which isn't found in the regular defense table
```
\set team_d_basic_season :season
\set team_d_basic_start_week 1
\set team_d_basic_end_week 4
\set team_d_basic_order_by 'pts_allowed'
```

### 042_team_average_defense_weekly
same as above but with more fields

### 050_find_k_for_week
queries `offense_weekly`, `defense_weekly`, `kicker_fantasy_weekly` views, and `games`, `game_odds` tables allowing to set a time frame for a season and select the same or another season and week to find best kicking matchups... orders based on:
- average fg attempts allowed
- the projected total for the game
- average kicker points allowed
- average fg attempts by team
```
\set find_k_reference_season :season
\set find_k_start_week 1
\set find_k_end_week 17
\set find_k_season_to_check 2026
\set find_k_week_to_check 1
```

