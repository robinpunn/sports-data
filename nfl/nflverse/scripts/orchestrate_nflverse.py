import argparse
import subprocess
import sys
from pathlib import Path

SEASON_UPDATES = {
    "games": "ingest_games.py", 
    "team_weekly": "ingest_team_weekly.py",
    "player_weekly": "ingest_player_weekly.py",
    "ngs": "ingest_ngs.py",
    "snaps": "ingest_snaps.py"
}

REFERENCE_UPDATES = {
    "players": "ingest_players.py",
    "teams": "ingest_teams.py",
}

script_dir = Path(__file__).parent

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
    if args.only: 
        for update in args.only:
            if update not in SEASON_UPDATES:
                parser.error(f"unknown season update: {update}")
        updates = args.only
    else:
        updates = list(SEASON_UPDATES)
 
    for update in updates:
        script = script_dir / SEASON_UPDATES[update]
        
        command = [
            sys.executable,
            str(script),
            "--season",
            *map(str, args.seasons),
        ]

        if args.week:
            command.extend(["--week", str(args.week)])

        subprocess.run(command, check=True)

elif args.update_type == "reference":
    script = script_dir / REFERENCE_UPDATES[args.reference]

    subprocess.run([sys.executable, str(script)], check=True)
