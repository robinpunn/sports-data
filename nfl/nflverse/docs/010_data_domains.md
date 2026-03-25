# nflverse - Data Domains
How my nflverse sql database is is grouped

## Reference Tables
### teams
- id (based on nflverse dataset)
- name (city + team name)
- abbr (city abreviation)
- nickname (team name)
- conference (temporal data... for now)
- division (temporal data... for now)
### players
- player_id (gsid_id from nflverse dataset) 
- full_name  (Isaako Aaitui)
- short_name (I.Aatui)
- birth_date 

- nfl_id  
- pfr_id 
- pff_id 
- espn_id

- position 
- position_group 

- height 
- weight 

- college_name
- college_conference 

- draft_year 
- draft_round 
- draft_pick 
- draft_team 

- rookie_season 
- status (temporal data... for now)
- years_of_experience (temporal data... for now)
- pff_status (temporal data... for now)

## Games
### game
- gameid
- oldgameid

- home team
- away team

- season
- season type
- week
- divisional game
 
- home rest (need to calculate)
- away rest (need to calculate)
 
- home score q1
- home score q2
- home score q3
- home score q4
- home score ot
- away score q1
- away score q2
- away score q3
- away score q4
- away score ot

- away score
- home score
- overtime (if game half includes overtime or quarter > 4)
- result (Equals home_score - away_score and means the game outcome from the perspective of the home team)
- total
 
- home_wp
- away_wp
- spread line (closing spread, + means home favored, - means away favored)
- total line
 
- home coach
- away coach
 
- location (home or neutral)
- game date
- start time
- weather 
- stadium
- roof
- surface
- temp
- wind

## Weekly Player Stats
### snap_counts
- game_id 
- player_id 
- player_name
- team 
- offense_snaps 
- defense_snaps 
- st_snaps 
- total_snaps (sum of above)
- offense_pct 
- defense_pct 
- st_pct 

### passing_stats
### rushing_stats
### receiving_stats
### kicking_stats
### defense_stats
### special_teams_stats
## Weekly Team Stats
### team_offense_stats
### team_defense_stats
### team_kicking_stats
### team_special_teams_stats
