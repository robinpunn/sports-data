import nflreadpy as nfl
import polars as pl

weekly = nfl.load_player_stats(seasons=[2025])

available = set(weekly.columns)
print(weekly.columns)

domains = {
    "passing": [
        "player_id",
        "player_display_name",
        "season",
        "week",
        "season_type",
        "completions",
        "attempts",
        "passing_yards",
        "passing_tds",
        "passing_interceptions",
        "sacks_suffered",
        "sack_yards_lost",
        "sack_fumbles",
        "sack_fumbles_lost",
        "passing_air_yards",
        "passing_yards_after_catch",
        "passing_first_downs",
        "passing_epa",
        "passing_cpoe",
        "passing_2pt_conversions",
        "pacr"
    ],
    "rushing": [
        "player_id",
        "player_display_name",
        "season",
        "week",
        "season_type",
        "carries",
        "rushing_yards",
        "rushing_tds",
        "rushing_fumbles",
        "rushing_fumbles_lost",
        "rushing_first_downs",
        "rushing_epa",
        "rushing_2pt_conversions" 
    ],
    "receiving": [
        "player_id",
        "player_display_name",
        "season",
        "week",
        "season_type",
        "receptions",
        "targets",
        "receiving_yards",
        "receiving_tds",
        "receiving_fumbles",
        "receiving_fumbles_lost",
        "receiving_air_yards",
        "receiving_yards_after_catch",
        "receiving_first_downs",
        "receiving_epa",
        "receiving_2pt_conversions",
        "racr",
        "target_share",
        "air_yards_share",
        "wopr"
    ],
    "kicking": [
        "player_id",
        "player_display_name",
        "season", 
        "week",
        "season_type",
        "fg_made",
        "fg_att",
        "fg_missed",
        "fg_blocked",
        "fg_long",
        "fg_pct",
        "fg_made_0_19",
        "fg_made_20_29",
        "fg_made_30_39",
        "fg_made_40_49",
        "fg_made_50_59",
        "fg_made_60_",
        "fg_missed_0_19",
        "fg_missed_20_29",
        "fg_missed_30_39",
        "fg_missed_40_49",
        "fg_missed_50_59",
        "fg_missed_60_",
        "fg_made_list",
        "fg_missed_list",
        "fg_blocked_list",
        "fg_made_distance",
        "fg_missed_distance",
        "fg_blocked_distance",
        "pat_made",
        "pat_att",
        "pat_missed",
        "pat_blocked",
        "pat_pct",
        "gwfg_made",
        "gwfg_att",
        "gwfg_missed",
        "gwfg_blocked",
        "gwfg_distance"
    ],
    "special_teams": [
        "player_id",
        "season",
        "week",
        "season_type",
        "punt_returns",
        "punt_return_yards",
        "kickoff_returns",
        "kickoff_return_yards",
        "special_teams_tds"
    ],
    "defense": [
        "player_id",
        "season",
        "week",
        "season_type",
        "def_tackles_solo",
        "def_tackles_with_assist",
        "def_tackle_assists",
        "def_tackles_for_loss",
        "def_tackles_for_loss_yards",
        "def_fumbles_forced",
        "def_sacks",
        "def_sack_yards",
        "def_qb_hits",
        "def_interceptions",
        "def_interception_yards",
        "def_pass_defended",
        "def_tds",
        "def_fumbles",
        "def_safeties",
    ],
    "misc": [
         "player_id",
         "season",
         "week",
         "season_type",
         "misc_yards",
         "fumble_recovery_own",
         "fumble_recovery_yards_own",
         "fumble_recovery_opp",
         "fumble_recovery_yards_opp",
         "fumble_recovery_tds",
         "penalties",
         "penalty_yards"
    ]
}

for name, fields, in domains.items():
    print(f"\n== {name.upper()} ===")
    missing = [f for f in fields if f not in available]
    if missing:
        print(f"MISSING FIELDS: {missing}")
        fields = [f for f in fields if f in available]
    subset = weekly[fields]
    print(subset.head())
    #print(subset.dtypes)
    #print(subset.null_count().sum())
    #print(weekly.filter(pl.col("player_id").is_null()))
