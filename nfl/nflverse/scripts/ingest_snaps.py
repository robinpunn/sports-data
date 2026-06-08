import nflreadpy as nfl
import polars as pl
from utils.db import run_ingestion
from utils.args import get_args

WEEKLY_CONFLICT = "game_id, pfr_player_id"

args = get_args()
seasons = args.season or [2025]

snaps = nfl.load_snap_counts(seasons)

if args.week:
    snaps = snaps.filter(pl.col("week") == args.week)

snaps = snaps.filter(
        pl.col("pfr_player_id").is_not_null()
).select([
    "game_id",
    "pfr_game_id",
    "season",
    "week",
    "game_type",
    "player",
    "position",
    "team",
    "pfr_player_id",
    "offense_snaps",
    "offense_pct",
    "defense_snaps",
    "defense_pct",
    "st_snaps",
    "st_pct"
])

run_ingestion([
    ("snaps", snaps, WEEKLY_CONFLICT)
])
#schedules = nfl.load_schedules(2025)

#snap_ids = set(snaps["game_id"].to_list())
#schedule_ids = set(schedules["game_id"].to_list())

#print(f"snap: {snap_ids}") 
#print(f"schedule: {schedule_ids}")
#print(snap_ids - schedule_ids)
