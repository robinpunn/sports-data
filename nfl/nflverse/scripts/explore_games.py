import nflreadpy as nfl
import polars as pl

games = nfl.load_schedules(2025)
games_available = set(games.columns)
print("GAME COLUMNS:", games.columns)

tables = {
    "game": [
        "game_id",
        "old_game_id",
        "season",
        "game_type",
        "week",
        "gameday",
        "weekday",
        "gametime",
        "away_team",
        "away_score",
        "home_team",
        "home_score",
        "result",
        "total",
        "overtime"
    ],
    "game_odds": [
        "game_id",
        "away_moneyline",
        "home_moneyline",
        "spread_line",
        "away_spread_odds",
        "home_spread_odds",
        "total_line",
        "under_odds",
        "over_odds",
    ],
    "game_context": [
        "game_id",
        "div_game",
        "away_coach",
        "home_coach",
        "referee",
        "away_rest",
        "home_rest"
    ],
    "game_conditions": [
        "game_id",
        "location",
        "roof",
        "surface",
        "temp",
        "wind",
        "stadium_id",
        "stadium"
    ]
}

for name, fields, in tables.items():
    print(f"\n== {name.upper()} ===")
    missing = [f for f in fields if f not in games_available]
    if missing:
        print(f"MISSING: {missing}")
        fields = [f for f in fields if f in games_available]
    subset = games[fields]
    #print(subset.columns)
    print(subset.head())
    #print(subset.null_count().sum())
