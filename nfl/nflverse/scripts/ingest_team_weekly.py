import nflreadpy as nfl
import polars as pl
from utils.db import run_ingestion
from utils.args import get_args
from utils.fg_list import parse_fg_list

WEEKLY_CONFLICT = "team, season, week, season_type"

args = get_args()
seasons = args.season

weekly = nfl.load_team_stats(seasons)

if args.week:
    weekly = weekly.filter(pl.col("week") == args.week)

offense_weekly = weekly.select([
    "team",
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
    "passing_2pt_conversions",
    "carries",
    "rushing_yards",
    "rushing_tds",
    "rushing_fumbles",
    "rushing_fumbles_lost",
    "rushing_first_downs",
    "rushing_epa",
    "rushing_2pt_conversions",
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
    "receiving_2pt_conversions"
])

defense_weekly = weekly.select([
    "team",
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
    "def_safeties"
])

kicking_weekly = weekly.select([
    "team",
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

kicking_weekly = kicking_weekly.with_columns([
    pl.col("made_list").map_elements(parse_fg_list, return_dtype=pl.List(pl.Int32)),
    pl.col("missed_list").map_elements(parse_fg_list, return_dtype=pl.List(pl.Int32)),
    pl.col("blocked_list").map_elements(parse_fg_list, return_dtype=pl.List(pl.Int32)),
    ])

special_teams_weekly = weekly.select([
    "team",
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

misc_weekly = weekly.select([
    "team",
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
    ("team_offense", offense_weekly, WEEKLY_CONFLICT),
    ("team_defense", defense_weekly, WEEKLY_CONFLICT),
    ("team_kicking", kicking_weekly, WEEKLY_CONFLICT),
    ("team_special_teams", special_teams_weekly, WEEKLY_CONFLICT),
    ("team_misc", misc_weekly, WEEKLY_CONFLICT),
])
