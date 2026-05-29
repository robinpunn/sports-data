import nflreadpy as nfl
import psycopg

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

conn = psycopg.connect(
    dbname="nfl",
    user="mayjasp",
)

cur = conn.cursor()

for row in teams.iter_rows(named=True):
    cur.execute(
        """
        INSERT INTO nflverse.teams (
            team_id,
            abbr,
            name,
            nickname,
            conference,
            division
        )
        VALUES (%s, %s, %s, %s, %s, %s)
        ON CONFLICT (team_id) DO NOTHING
        """,
        (
            row["team_id"],
            row["abbr"],
            row["name"],
            row["nickname"],
            row["conference"],
            row["division"],
        )
    )

try:
    conn.commit()
    print(f"Inserted {len(teams)} teams")
except Exception as e:
    conn.rollback()
    print(f"Error: {e}")
finally:
    cur.close()
    conn.close()
