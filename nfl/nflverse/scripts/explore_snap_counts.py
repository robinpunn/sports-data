import nflreadpy as nfl
import polars as pl

snaps = nfl.load_snap_counts(2025)
snaps_available = set(snaps.columns)
print("SNAPS COLUMNS:", snaps.columns)

snap_fields = [
    "pfr_player_id",
    "season",
    "week",
    "game_type",
    "game_id",
    "pfr_game_id",
    "player",
    "position",
    "team",
    "opponent",
    "offense_snaps",
    "defense_snaps",
    "st_snaps",
    "offense_pct",
    "defense_pct",
    "st_pct"
]

missing = [f for f in snap_fields if f not in snaps_available]
if missing:
    print(f"MISSING: {missing}")
#print(teams.head())
#print(teams.dtypes)
print(snaps.null_count().sum())
