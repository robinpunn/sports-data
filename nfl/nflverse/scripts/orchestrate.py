import argparse

SEASON_UPDATES = {
    "games": "ingest_games.py", 
    "team_weekly": "ingest_team_weekly.py",
    "player_weekly": "ingest_player_weekly.py",
    "ngs": "ingest_ngs.py",
    "snaps": "ingest_snaps.py"
}

parser = argparse.ArgumentParser()

command_parser = parser.add_subparsers(dest="command", required=True)

update_parser = command_parser.add_parser("update")

update_type_parser = update_parser.add_subparsers(dest="update_type", required=True)

season_parser = update_type_parser.add_parser("season")
season_parser.add_argument("seasons", nargs="+", type=int)
season_parser.add_argument("--week", type=int)
season_parser.add_argument("--only", nargs="+")

reference_parser = update_type_parser.add_parser("reference")
reference_parser.add_argument("reference", choices=["players","teams"])

args = parser.parse_args()

if args.update_type == "season":
    print(args.seasons)
    print(args.week)
    print(args.only)
elif args.update_type == "reference":
    print(args.reference)
