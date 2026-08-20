import nflreadpy as nfl
import polars as pl
from utils.db import run_ingestion
from utils.args import get_args

CONFLICT = "game_id"

args = get_args()
seasons = args.season 

games = nfl.load_schedules(seasons)

if args.week:
    games = games.filter(pl.col("week") == args.week)

games_core = games.select([
    "game_id",
    "pfr",
    "pff",
    "espn",
    "season",
    "week",
    "game_type",
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
])

game_odds = games.select([
    "game_id",
    "away_moneyline",
    "home_moneyline",
    "spread_line",
    "away_spread_odds",
    "home_spread_odds",
    "total_line",
    "under_odds",
    "over_odds"
])

game_context = games.select([
    "game_id",
    "location",
    "div_game",
    "away_coach",
    "home_coach",
    "referee",
    "away_rest",
    "home_rest",
    "stadium_id",
    "stadium"
])

game_conditions = games.select([
    "game_id",
    "roof",
    "surface",
    "temp",
    "wind"
])

run_ingestion([
    ("games", games_core, CONFLICT),
    ("game_odds", game_odds, CONFLICT),
    ("game_context", game_context, CONFLICT),
    ("game_conditions", game_conditions, CONFLICT)
])
