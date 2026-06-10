import nflreadpy as nfl
import polars as pl
from utils.db import run_ingestion
from utils.args import get_args

WEEKLY_CONFLICT = "player_id, season, week, season_type"

args = get_args()
seasons = args.season or [2025]

passing_ngs = nfl.load_nextgen_stats(seasons, stat_type="passing")
rushing_ngs = nfl.load_nextgen_stats(seasons, stat_type="rushing")
receiving_ngs = nfl.load_nextgen_stats(seasons, stat_type="receiving")

if args.week:
    passing_ngs = passing_ngs.filter(pl.col("week") == args.week)
    rushing_ngs = rushing_ngs.filter(pl.col("week") == args.week)
    receiving_ngs = receiving_ngs.filter(pl.col("week") == args.week)

passing_ngs = passing_ngs.rename({
    "player_gsis_id":"player_id",
    "player_display_name":"name",
    "player_position":"position",
    "team_abbr": "team"
}).select([
    "player_id",
    "name",
    "position",
    "team",
    "season",
    "week",
    "season_type",
    "avg_time_to_throw",
    "avg_completed_air_yards",
    "avg_intended_air_yards",
    "avg_air_yards_differential",
    "aggressiveness",
    "max_completed_air_distance",
    "avg_air_yards_to_sticks",
    "passer_rating",
    "completion_percentage",
    "expected_completion_percentage",
    "completion_percentage_above_expectation",
    "avg_air_distance",
    "max_air_distance"
])

rushing_ngs = rushing_ngs.rename({
    "player_gsis_id":"player_id",
    "player_display_name":"name",
    "player_position":"position",
    "team_abbr": "team",
    "percent_attempts_gte_eight_defenders": "eight_defenders",
}).select([
   "player_id",
   "name",
   "position",
   "team",
   "season",
   "week",
   "season_type",
   "efficiency",
   "eight_defenders",
   "avg_time_to_los",
   "expected_rush_yards",
   "avg_rush_yards",
   "rush_yards_over_expected_per_att",
   "rush_pct_over_expected"
])

receiving_ngs = receiving_ngs.rename({
    "player_gsis_id":"player_id",
    "player_display_name":"name",
    "player_position":"position",
    "team_abbr": "team",
}).select([
    "player_id",
    "name",
    "position",
    "team",
    "season",
    "week",
    "season_type",
    "avg_cushion",
    "avg_separation",
    "percent_share_of_intended_air_yards",
    "catch_percentage",
    "avg_yac",
    "avg_expected_yac",
    "avg_yac_above_expectation"
])

run_ingestion([
    ("player_nextgen_passing", passing_ngs, WEEKLY_CONFLICT),
    ("player_nextgen_rushing", rushing_ngs, WEEKLY_CONFLICT),
    ("player_nextgen_receiving", receiving_ngs, WEEKLY_CONFLICT),
])
