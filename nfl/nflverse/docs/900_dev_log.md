## 2026-02-14
- teams (from teams precompiled dataset)
- players (from players precompiled dataset)
- games (derive from pbp)
- passing_weekly (include season/game/redzone/penalty)
- rushing_weekly (include season/game/redzone/penalty)
- receiving_weekly (include season/game/redzone/penalty)
- kicking_weekly (include season/game/)
- defense_weekly (include season/game/redzone/penalty)
- special_teams_weekly (include season/game/redzone/penalty)
- any other table like seasons or stints can go in analysis db

## 2026-02-13
- finalized plan is to:
    - create a players and teams referene table using the provided data
    - use pbp data going back to 1999 to recreate my own stats tables for passing/rushing/receiving/kicking/defense/st
- player_seasons, team_seasons, stints isn't necessary in the raw nflverse db... might be considerations for analysis db

## 2026-02-12
- playbyplay data is the highest value information nflverse has to offer...
- i can easily recreate the precompiled data scraping other sites, but the playbyplay going back to 1999 is extremely valuable
- i need to create my own players/teams stats tables
- i can use the schedule/players/teams data sets as references 
- BUT, i can also derive all of that from playbyplay...
- edge cases i need to consider:
    - look at the play_type field to make sure it doesn't say no_play... if so, don't count the stats that might be displayed
    - i can also create "true stats" that would include plays erased by penalty
    - on plays were play_type is empty, this is usually a valid play with penalty yards enforced after

## 2026-02-11
- discovered the playbyplay dataset... this is what i should be targeting
- BUT, i can still use the precompiled data... just add new tables that are derived from playbyplay
- what i need to figure out:
    - schema from schedule data settled
    - schema for playbyplay and the logic to derive it 
    - how do i use nflreadr???
- plan
    - use precompiled data from nflverse to create a raw table 
    - use pbp data to create what's missing (redzone, separation?, route depth?)
    - feed this to an analysis db that will allow for easier queries, keeping most of the data the same
    - create tables for the trends you want to look for in the analysis db
    - your api ONLY queries the analysis db 

## 2026-02-10
- moving on to create tables, but im thinking about how to handles coaches...
    - do i add coach fields to team_seasons, or do i create coach/coach_season tables?
    - right now, i dont have a data source for coaches, so i'll figure this out when i get there
    - schema is flexible enough right now to make the decision later
- need to rename tables to: passing/rushing/receiving/kicking/special/defense
    - these tables shouldn't care about a player's position, that is determined by the player table
- adding a player_stints table to capture edge cases like midseason trades
- rethinking team_seasons and player_seasons because this feels like it belong in an analysis layer???
    - this db should update weekly snapshots of players/teams... i can use an analysis db to create a season picture...
- using the player/team csv i populate the analysis db, this will be fed by all other dbs
- using weekly csvs, i populate the nflverse db... this also gives me player ids and team
- discovered the schedule csv has a ton of information...

## 2026-02-09
- figuring out db schema 
- how do i create tables for various positions... 
- for example, do i need a table just for kicker stats? 
- what i've settled on for now:
    - teams: what entities exist that are considered nfl teams?
    - team_seasons: team context per season 
    - players: who is this player?
    - player_seasons: how did the player exist in a given season, makes analysis easier down the road
    - pos_stats_table: qb_stats, wr_stats(includes tes), rb_stats, k_stats, idp_stats
    - team_stats: team_offense, team_defense
- nflVerse also has advanced stats which i may consider... so i can turn them into tables in the future
    - qb_advanced, wr_advanced, rb_advanced
- each player/team stats table should have a year/week field... i can use this to populate player_seasons
