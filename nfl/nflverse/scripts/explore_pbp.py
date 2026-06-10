import nflreadpy as nfl
import polars as pl

pl.Config.set_tbl_cols(-1)

pbp = nfl.load_pbp(2025)
pbp = pbp.filter(pl.col("week") == 1)
#print("PBP COLUMNS:", len(pbp.columns))

pbp_pit = pbp.filter(
    (pl.col("home_team") == "PIT") |
    (pl.col("away_team") == "PIT")
)

fumbles = pbp_pit.filter(
    pl.col("desc").str.contains("FUMBLES", literal=True)
).select([
    "game_id",
    "play_id",
    "qtr",
    "passer_player_name",
    "rusher_player_name",
    "receiver_player_name"
])

#print(fumbles)

plays = pbp_pit.filter(
    pl.col("play_id").is_in([787.0, 1706.0, 2977.0])
)

print(plays.to_dict())

#team_fields = [
#    "team_id",
#    "team_name",
#    "team_abbr",
#    "team_nick",
#    "team_conf",
#    "team_division"
#]
#
#missing = [f for f in team_fields if f not in teams_available]
#if missing:
#    print(f"MISSING: {missing}")
##print(teams.head())
##print(teams.dtypes)
#print(teams.null_count().sum())
#
#players = nfl.load_players()
#players_available = set(players.columns)
#
#tables = {
#    "players": [
#        "gsis_id",
#        "display_name",
#        "common_first_name",
#        "short_name",
#        "football_name",
#        "birth_date",
#        "nfl_id",
#        "pfr_id",
#        "pff_id",
#        "espn_id",
#        "position",
#        "height",
#        "weight"
#    ],
#    "player_draft": [
#        "gsis_id",
#        "college_name",
#        "college_conference",
#        "draft_year",
#        "draft_round",
#        "draft_pick",
#        "draft_team",
#    ],
#    "player_status": [
#        "gsis_id",
#        "rookie_season",
#        "status",
#        "years_of_experience",
#        "pff_status",
#    ]
#}
#
#for name, fields, in tables.items():
#    print(f"\n== {name.upper()} ===")
#    missing = [f for f in fields if f not in players_available]
#    if missing:
#        print(f"MISSING: {missing}")
#        fields = [f for f in fields if f in players_available]
#    subset = players[fields]
#    #print(subset.columns)
#    print(subset.head())
#    #print(subset.null_count().sum())
