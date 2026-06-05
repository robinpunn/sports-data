import nflreadpy as nfl
import polars as pl
from utils.db import run_ingestion

WEEKLY_CONFLICT = "player_id, season, week, season_type"

weekly = nfl.load_player_stats(seasons=2025)
weekly = weekly.filter(
    (pl.col("week") ==1) &
    (pl.col("player_id").is_not_null())
)
weekly = weekly.rename({
    "player_display_name":"name"
})

passing = weekly.filter(
    (pl.col('attempts') > 0) 
).select([
    "player_id",
    "name",
    "season",
    "week",
    "season_type",
    "completions",
    "attempts",
    "passing_yards",
    "passing_tds",
    "passing_interceptions",
    "sacks_suffered",
    "sack_fumbles",
    "sack_fumbles_lost",
    "passing_air_yards",
    "passing_yards_after_catch",
    "passing_first_downs",
    "passing_epa",
    "passing_cpoe",
    "passing_2pt_conversions",
    "pacr"
]).rename({
    "passing_yards": "yards",
    "passing_tds": "tds",
    "passing_interceptions": "ints",
    "sacks_suffered": "sacks",
    "passing_air_yards": "air_yards",
    "passing_yards_after_catch": "yac",
    "passing_first_downs": "first_down",
    "passing_epa": "epa",
    "passing_cpoe": "cpoe",
    "passing_2pt_conversions": "two_pt_conv"
})

rushing = weekly.filter(
    pl.col("carries") > 0
).select([
    "player_id",
    "name",
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
]).rename({
    "rushing_yards": "yards",
    "rushing_tds": "tds",
    "rushing_fumbles": "fumbles",
    "rushing_fumbles_lost": "fumbles_lost",
    "rushing_first_downs": "first_down",
    "rushing_epa": "epa",
    "rushing_2pt_conversions": "two_pt_conv"
})

receiving = weekly.filter(
    pl.col("targets") > 0
).select([
    "player_id",
    "name",
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
]).rename({
    "receiving_yards": "yards",
    "receiving_tds": "tds",
    "receiving_fumbles": "fumbles",
    "receiving_fumbles_lost": "fumbles_lost",
    "receiving_air_yards": "air_yards",
    "receiving_yards_after_catch": "yac",
    "receiving_first_downs": "first_down",
    "receiving_epa": "epa",
    "receiving_2pt_conversions": "two_pt_conv",
    "target_share": "tar_share",
    "air_yards_share": "a_y_share",
})

kicking = weekly.filter(
    (pl.col("fg_att") > 0) |
    (pl.col("pat_att") > 0)
).select([
    "player_id",
    "name",
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
    "gwfg_distance",
]).rename({
    "fg_made": "made",
    "fg_att": "att",
    "fg_missed": "missed",
    "fg_blocked": "blocked",
    "fg_pct": "pct",
    "fg_made_0_19": "made_0_19",
    "fg_made_20_29": "made_20_29",
    "fg_made_30_39": "made_30_39",
    "fg_made_40_49": "made_40_49",
    "fg_made_50_59": "made_50_59",
    "fg_made_60_": "made_60_",
    "fg_missed_0_19": "missed_0_19",
    "fg_missed_20_29": "missed_20_29",
    "fg_missed_30_39": "missed_30_39",
    "fg_missed_40_49": "missed_40_49",
    "fg_missed_50_59": "missed_50_59",
    "fg_missed_60_": "missed_60_",
    "fg_made_list": "made_list",
    "fg_missed_list": "missed_list",
    "fg_blocked_list": "blocked_list",
    "fg_made_distance": "made_distance",
    "fg_missed_distance": "missed_distance",
    "fg_blocked_distance": "blocked_distance",
})

def parse_fg_list(value):
    if value is None or value == "":
        return None
    separator = ";" if ";" in value else ","
    return [int(x) for x in value.split(separator)]

kicking = kicking.with_columns([
    pl.col("made_list").map_elements(parse_fg_list, return_dtype=pl.List(pl.Int32)),
    pl.col("missed_list").map_elements(parse_fg_list, return_dtype=pl.List(pl.Int32)),
    pl.col("blocked_list").map_elements(parse_fg_list, return_dtype=pl.List(pl.Int32)),
])

special_teams = weekly.filter(
    (pl.col("punt_returns") > 0) |
    (pl.col("kickoff_returns") > 0) |
    (pl.col("special_teams_tds") > 0)
).select([
    "player_id",
    "name",
    "season",
    "week",
    "season_type",
    "punt_returns",
    "punt_return_yards",
    "kickoff_returns",
    "kickoff_return_yards",
    "special_teams_tds",
]).rename({
    "special_teams_tds": "tds",
})

defense = weekly.filter(
    (pl.col("def_tackles_solo") > 0) |
    (pl.col("def_tackle_assists") > 0) |
    (pl.col("def_sacks") > 0) |
    (pl.col("def_interceptions") > 0) |
    (pl.col("def_pass_defended") > 0) |
    (pl.col("def_fumbles_forced") > 0) |
    (pl.col("def_tds") > 0) |
    (pl.col("def_safeties") > 0)
).select([
    "player_id",
    "name",
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
]).rename({
    "def_tackles_solo": "tackles_solo",
    "def_tackles_with_assist": "tackles_with_assist",
    "def_tackle_assists": "tackle_assists",
    "def_tackles_for_loss": "tackles_for_loss",
    "def_tackles_for_loss_yards": "tackles_for_loss_yards",
    "def_fumbles_forced": "fumbles_forced",
    "def_sacks": "sacks",
    "def_sack_yards": "sack_yards",
    "def_qb_hits": "qb_hits",
    "def_interceptions": "interceptions",
    "def_interception_yards": "interception_yards",
    "def_pass_defended": "pass_defended",
    "def_tds": "tds",
    "def_fumbles": "fumbles",
    "def_safeties": "safeties",
})

misc = weekly.filter(
    (pl.col("misc_yards") > 0) |
    (pl.col("fumble_recovery_own") > 0) |
    (pl.col("fumble_recovery_opp") > 0) |
    (pl.col("fumble_recovery_tds") > 0) |
    (pl.col("penalties") > 0)
).select([
    "player_id",
    "name",
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
    "penalty_yards",
]).rename({
    "misc_yards": "yards",
})

run_ingestion([
    ("player_passing", passing, WEEKLY_CONFLICT),
    ("player_rushing", rushing, WEEKLY_CONFLICT),
    ("player_receiving", receiving, WEEKLY_CONFLICT),
    ("player_kicking", kicking, WEEKLY_CONFLICT),
    ("player_special_teams", special_teams, WEEKLY_CONFLICT),
    ("player_defense", defense, WEEKLY_CONFLICT),
    ("player_misc", misc, WEEKLY_CONFLICT),
])
