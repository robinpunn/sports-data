# draftkings
## purpose
i can't dont see any good sources for historical odds
if it is available, it probably isn't free
going to do my best to track odds movements for the nfl starting with 2026
this might be a way to find patterns, but mainly just a tool to set my fantasy roster without having to do the research

## what am i tracking?
- td props
- player stats
- odds for both
- tracking the above by saving snapshots off the odds over time...
- using my nflverse db, i should be able to determine something like josh allen's opening odds and closing odds

# draftkings/db
the main files here are to handle names that don't match from draftkings to nflverse...
### dk_db
this file just creates the initial db
### missing_player_map
after running the dk spider, this table should contain all the mismatches
### insert_missing_players
after running the spider, i run this script to populate the player_map with players that don't match based on name from the dk players to nflverse player table
### view_player_map
a quick way to view all the players that don't resolve in the `selections_with_nflverse_player` table
### find_player_fullname
use this to find the missing player in question in the nflverse players table
### update_missing_player
use this to update the missing player with the proper nflverse id
### add_player_to_map
if joining players from selections to nflverse grabs the wrong player id, this is how to overwrite (josh allen C instead of QB was a mistake i discovered) 
