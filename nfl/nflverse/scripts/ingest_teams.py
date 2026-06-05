import nflreadpy as nfl
from utils.db import run_ingestion

CONFLICT = "team_id"

teams = nfl.load_teams()

teams = teams.rename({
    "team_name": "name",
    "team_abbr": "abbr",
    "team_nick": "nickname",
    "team_conf": "conference",
    "team_division": "division"
})

teams = teams.select([
    "team_id",
    "abbr",
    "name",
    "nickname",
    "conference",
    "division",
])

run_ingestion([
    ("teams", teams, CONFLICT),
])
