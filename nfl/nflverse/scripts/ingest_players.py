import nflreadpy as nfl
from utils.db import run_ingestion

CONFLICT = "player_id"

players = nfl.load_players()

players = players.rename({
    "gsis_id": "player_id",
    "display_name": "full_name",
    "college_name": "college",
    "years_of_experience": "yoe",
})

players = players.filter(
    players["player_id"].is_not_null()
)

players = players.unique(subset=["player_id"])

players_core = players.select([
    "player_id",
    "full_name",
    "short_name",
    "birth_date",
    "nfl_id",
    "pfr_id",
    "pff_id",
    "espn_id",
    "position",
    "position_group",
    "height",
    "weight"
])

player_draft = players.select([
    "player_id",
    "college",
    "college_conference",
    "draft_year",
    "draft_round",
    "draft_pick",
    "draft_team",
])


player_status = players.select([
    "player_id",
    "rookie_season",
    "last_season",
    "status",
    "yoe",
    "pff_status",
])


run_ingestion([
    ("players", players_core, CONFLICT),
    ("player_draft", player_draft, CONFLICT),
    ("player_status", player_status, CONFLICT),
])
