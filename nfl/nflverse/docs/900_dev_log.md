## 2026-06-10
- found some type of "edge case" where 2025 week 1, nflverse doesn't seem to credit kaleb johnson with a fumble
- yahoo, nfl, espn all show that kaleb johnson has a fumble (not lost)
- using the pbp data, i see this is because the fumble happened during a kick off return
- so the aggregated weekly stats, don't have a field for special teams fumbles
- for now, im okay with this, but might consider making a special teams fumble field in a misc table...

## 2026-06-09
- added teams field to player stats tables
- just makes querying easier...

## 2026-06-08
- created snap count schema/ingestion script
- i shouldn't be using INTEGER for all numerical fields...
- using NUMERIC(5,4) for percentages and NUMERIC(8,4) for advanced stats
- changed db util script so it updates rather than 'do nothing'... 'do nothing' would ignore stat corrections

## 2026-06-07
- added utility script to add season/week arguments for ingestion scripts

## 2026-06-05
- created games schema and ingestion script

## 2026-06-04
- have a utility script that connects to the db and inserts as needed
- this is going to be used in all ingestion scripts, so makes sense to create a utility function

## 2026-06-01
- weekly player stats schema and ingestion script are complete

## 2026-05-29
- i have the schema ready for all the tables i need
- questioning whether i want to put the effor into to play by play tables
- but right now, i'm creating sql scripts for schema and ingestion scripts to populate tables
- have working ingestion scripts for teams and players... since these are reference tables, i don't have to worry about updating weekly...
but i will update them occasionally... just not as frequently as the stats tables

## 2026-05-26
- passing_redzone
    - gameid
    - season
    - week
    - season_type
    - posteam
    - play_type == pass
    - pass == 1 (might not need this)
    - yardline_100 <= 20
    - pass_player_id
    - pass_player_name
    - pass_attempt
    - completion
    - passing_yards
    - passing_tds
    - passing_interceptions
    - sack
    - fumble
    - fumble_lost
- passing_extra
    - gameid
    - season
    - week
    - season_type
    - posteam
    - play_type == pass
    - pass == 1 (might not need this)
    - qb_scrambles
    - qb_hit
    - sack
    - qb_spike
    - shotgun
    - no_huddle
- rushing_redzone
    - gameid
    - season
    - week
    - season_type
    - posteam
    - play_type == run
    - run == 1 (might not need this)
    - yardline_100 <= 20
    - rusher_player_id (this is how to track carries)
    - rusher_player_name
    - rushing_yards
    - rushing_tds
    - fumble
    - fumble_lost
- receiving_redzone
    - gameid
    - season
    - week
    - season_type
    - posteam
    - play_type == pass
    - yardline_100 <= 20
    - receiving_player_id (target)
    - receiving_player_name
    - complete_pass == 1 (reception)
    - receiving_yards
    - pass_touchdown
    - fumble
    - fumble_lost

## 2026-05-25
- figuring out how to determine a valid play using pbp
- relevant fields i may need to use
    - posteam (string of team with possession)
    - side_of_field (which team's side of the field)
    - yardline_100 (distance of yards from opponent's endzone)
    - sp (binary for scoring plays)
    - down (down for given play)
    - goal_to_go (goal to go situations)
    - yardstogo (numeric distance from 1st down or goal)
    - desc (detailed string description of play)
    - play (binary indicator if play was "normal" including penalties???)
    - play_deleted (binary for deleted plays???)
    - aborted_play (binary indicator if play was aborted???)
    - special_teams_play (binary for special teams play)
    - play_type (string indicating type of play)
        - pass (includes sacks)
        - run (includes scrambles)
        - punt 
        - field_goal
        - kick_off
        - extra_point
        - qb_kneel
        - qb_spike
        - no_play (timeouts and penalties)
        - missing (rows for indicating end of play???)
    - pass (binary indicator if play was a pass)
    - rush (binary indicator is play was a rush)
    - first_down (binary indicator if play ended in a first down)
    - yards_gained (excludes fumble recoveries and laterals)
    - shotgun (binary for formation)
    - no_huddle (binary for formation)
    - qb_dropback (binary includes pass attempt, sack, scramble)
    - qb_kneel (binary whether or not qb took knee)
    - pass_length (string for short or deep)
    - pass_location (string for left/middle/right)
    - air_yards (numeric for yards perpendicular to los where wr did or didn't catch the ball)
    - yards_after_catch (numeric for yards perpendicular to where ball is caught)
    - run_location (string for left/middle/right)
    - run_gap (string for end/guard/tackle)
    - two_point_conv_result (string: success, failure, saftey, return)
    - td_team (string for scoring team)
    - td_player_name (string for scoring player name)
    - td_player_id (id for scoring player)
    - first_down_rush (binary if rush converted first down)
    - first_down_pass (binary if pass converted first down)
    - first_down_penalty (binary if penalty converted first down)
    - third_down_converted (binary if 1st down was converted on 3rd)
    - third_down_failed (binary if posteam failed convering 3rd down)
    - fourth_down_converted (binary if 1st down converted on 4th down)
    - incomplete_pass (binary if pass was incomplete)
    - interception (binary if pass was intercepted)
    - fumble_forced (binary if fumble was forced)
    - fumble_not_forced (binary if fumble was not forced)
    - fumble_out_of_bounds (binary if fumble went out of bounds)
    - penalty (binary if penalty occured)
    - fumble_lost (binary for fumble lost)
    - qb_hit (binary for qb hit on play)
    - rush_attempt (binary if play was a run)
    - pass_attempt (binary if play was a pass, includes sacks)
    - sack (binary if play resulted in sack)
    - touchdown (binary if play resulted in TD)
    - pass_touchdown (binary if play resulted in pass TD)
    - rush_touchdown (binary if play resulted in rush TD)
    - return_td (binary if play resulted in return TD)
        - interception
        - fumble
        - kick_off
        - punt
        - blocked kicks
    - fumble (binary if fumble occured)
    - complete_pass (binary for completed passes)
    - pass_player_id (id of passer)
    - pass_player_name (name of passer)
    - lateral_reception (binary if lateral occured on a reception)
    - lateral_rush (binary if lateral occured on a rush)
    - lateral_recovery (binary if lateral occured on fumble recovery)
    - passing_yards (numeric yards for pass plays... includes laterals)
    - receiver_player_id (id for player targeted on pass)
    - receiver_player_name (string for targetted player)
    - receiving_yards (numeric yards gained, does NOT include laterals) 
    - rush_player_id (id for player that attempted run)
    - rush_player_name (string for player that attempted run)
    - rushing_yards (yards for rushing player, does NOT include laterals)
    - lateral_receiver_player_id (id for player that received LAST lateral on pass play)
    - lateral_receiver_player_name (string for player that received LAST lateral on pass play)
    - lateral_receiving_yards (numeric yards for pass plays with laterals for the LAST lateral receiver)
    - lateral_rush_player_id (id for player that received LAST lateral on a rush play)
    - lateral_rush_player_named (string for player that received LAST lateral on a rush play)


## 2026-05-15
- finalized schema
- next step is to test data ingestion from nflverse
- nflverse tables are already "clean", so the plan is to 1) create staging tables and 2) update database
- right now, creating scripts to test ingestion of data sets

## 2026-04-29
- creating smaller tables so i can move towards extracting from pbp in the future
- right now, the plan is to create initial tables with aggregated data sets
- in the future, i'll move towards updating tables with pbp data
- right now, pbp data is only going to be used for redzone stats while everything else can be populated with aggregated data sets

## 2026-03-30
- creating a script to exctract data dictionaries into a markdown file to make it easier to create my db schema
- [`data dictionaries`](https://nflreadr.nflverse.com/reference/#data-dictionaries)


## 2026-03-22
- recreate pbp database later if needed
- focus on creating weekly stats
- can use [`load_snap_counts`](https://nflreadr.nflverse.com/reference/load_snap_counts.html) for player snapcounts
- for everything else (weekly player and team stats) use [`load_pbp`](https://nflreadr.nflverse.com/reference/load_pbp.html)


## 2026-03-08
- create a raw pbp database...
    - use this to create your other tables

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
