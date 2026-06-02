import nflreadpy as nfl
import psycopg

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

players_draft = players.select([
    "player_id",
    "college",
    "college_conference",
    "draft_year",
    "draft_round",
    "draft_pick",
    "draft_team",
])


players_status = players.select([
    "player_id",
    "rookie_season",
    "last_season",
    "status",
    "yoe",
    "pff_status",
])

conn = psycopg.connect(
    dbname="nfl",
    user="mayjasp",
)

cur = conn.cursor()

for row in players_core.iter_rows(named=True):
    cur.execute(
        """
        INSERT INTO nflverse.players (
            player_id,
            full_name,
            short_name,
            birth_date,
            nfl_id,
            pfr_id,
            pff_id,
            espn_id,
            position,
            position_group,
            height,
            weight
        )
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON CONFLICT (player_id) DO NOTHING
        """,
        (
            row["player_id"],
            row["full_name"],
            row["short_name"],
            row["birth_date"],
            row["nfl_id"],
            row["pfr_id"],
            row["pff_id"],
            row["espn_id"],
            row["position"],
            row["position_group"],
            row["height"],
            row["weight"]
        )
    )

for row in players_draft.iter_rows(named=True):
    cur.execute(
        """
        INSERT INTO nflverse.player_draft (
            player_id,
            college,
            college_conference,
            draft_year,
            draft_round,
            draft_pick,
            draft_team 
        )
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        ON CONFLICT (player_id) DO NOTHING
        """,
        (
            row["player_id"],
            row["college"],
            row["college_conference"],
            row["draft_year"],
            row["draft_round"],
            row["draft_pick"],
            row["draft_team"], 
        )
    )

for row in players_status.iter_rows(named=True):
    cur.execute(
        """
        INSERT INTO nflverse.player_status (
            player_id,
            rookie_season,
            last_season,
            status,
            yoe,
            pff_status
        )
        VALUES (%s, %s, %s, %s, %s, %s)
        ON CONFLICT (player_id) DO NOTHING
        """,
        (
            row["player_id"],
            row["rookie_season"],
            row["last_season"],
            row["status"],
            row["yoe"],
            row["pff_status"],
        )
    )

try:
    conn.commit()
    print(f"Processed {len(players)} player records")
except Exception as e:
    conn.rollback()
    print(f"Error: {e}")
finally:
    cur.close()
    conn.close()

