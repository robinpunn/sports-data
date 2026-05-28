import nflreadpy as nfl
import polars as pl

teams = nfl.load_teams()
teams_available = set(teams.columns)
#print("TEAM COLUMNS:", teams.columns)

team_fields = [
    "team_id",
    "team_name",
    "team_abbr",
    "team_nick",
    "team_conf",
    "team_division"
]

missing = [f for f in team_fields if f not in teams_available]
if missing:
    print(f"MISSING: {missing}")
#print(teams.head())
#print(teams.dtypes)
print(teams.null_count().sum())

players = nfl.load_players()
players_available = set(players.columns)

tables = {
    "players": [
        "gsis_id",
        "display_name",
        "common_first_name",
        "short_name",
        "football_name",
        "birth_date",
        "nfl_id",
        "pfr_id",
        "pff_id",
        "espn_id",
        "position",
        "height",
        "weight"
    ],
    "player_draft": [
        "gsis_id",
        "college_name",
        "college_conference",
        "draft_year",
        "draft_round",
        "draft_pick",
        "draft_team",
    ],
    "player_status": [
        "gsis_id",
        "rookie_season",
        "status",
        "years_of_experience",
        "pff_status",
    ]
}

for name, fields, in tables.items():
    print(f"\n== {name.upper()} ===")
    missing = [f for f in fields if f not in players_available]
    if missing:
        print(f"MISSING: {missing}")
        fields = [f for f in fields if f in players_available]
    subset = players[fields]
    #print(subset.columns)
    print(subset.head())
    #print(subset.null_count().sum())
