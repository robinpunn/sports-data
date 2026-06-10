import nflreadpy as nfl
import polars as pl

pl.Config.set_tbl_cols(-1)

passing_ngs = nfl.load_nextgen_stats(2025, stat_type="passing")
rushing_ngs = nfl.load_nextgen_stats(2025, stat_type="rushing")
receiving_ngs = nfl.load_nextgen_stats(2025, stat_type="receiving")
passing_available = set(passing_ngs.columns)
rushing_available = set(rushing_ngs.columns)
receiving_available = set(receiving_ngs.columns)

next_gen_domain = { 
    "passing": {
        "data": passing_ngs,
        "fields": [
            "player_gsis_id",
            "name",
            "player_position",
            "season_type",
            "season",
            "week",
            "avg_time_to_throw",
            "avg_completed_air_yards",
            "avg_intended_air_yards",
            "avg_air_yards_differential",
            "aggressiveness",
            "max_completed_air_distance",
            "avg_air_yards_to_sticks",
            "passer_rating",
            "avg_air_distance",
            "max_air_distance"
        ]
    },
    "rushing": {
        "data": rushing_ngs,
        "fields": [
            "player_gsis_id",
            "player_display_name",
            "player_position",
            "season_type",
            "season",
            "week",
            "efficiency",
            "percent_attempts_gte_eight_defenders",
            "avg_time_to_los",
            "expected_rush_yards",
            "rush_yards_over_expected",
            "avg_rush_yards",
            "rush_yards_over_expected_per_att",
            "rush_pct_over_expected"
        ]
    },
    "receiving": {
        "data": receiving_ngs,
        "fields": [
            "player_gsis_id",
            "player_display_name",
            "player_position",
            "team_abbr",
            "season_type",
            "season",
            "week", 
            "avg_cushion",
            "avg_separation",
            "avg_intended_air_yards",
            "percent_share_of_intended_air_yards",
            "catch_percentage",
            "avg_yac",
            "avg_expected_yac",
            "avg_yac_above_expectation"
        ]
    },
}

for name, config, in next_gen_domain.items():
    print(f"\n== {name.upper()} ===")
    df = config["data"]
    fields = config["fields"]
    available = set(df.columns)
    missing = [f for f in fields if f not in available]
    if missing:
        print(f"MISSING FIELDS: {missing}")
        fields = [f for f in fields if f in available]
    #print(subset.columns)
    print(df.select(fields).head())
    #print(subset.dtypes)
    #print(subset.null_count().sum())

#print(passing_ngs.columns)
#print(rushing_ngs.columns)
#print(receiving_ngs.columns)
