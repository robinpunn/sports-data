import os
from dotenv import load_dotenv
import psycopg2
from dateutil import parser

load_dotenv()
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")
MMA_DATA = os.getenv("MMA_DATA")

try:
    conn = psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )
    cur = conn.cursor()
    print("connected to postgresql")
except psycopg2.Error as e:
    print(f"Error connecting to PostgreSQL: {e}")
    exit(1)

cur.execute("""
    SELECT DISTINCT event_name, event_date
    FROM stg_mma_fights
    WHERE event_name is NOT NULL AND event_date IS NOT NULL
""")
events = cur.fetchall()

for event_name, raw_event_date in events:
    try:
        normalized_date = parser.parse(raw_event_date).strftime('%Y-%m-%d')
    except Exception as e:
        print(f"Could not parse event date '{raw_event_date}' for '{event_name}': {e}")
        continue

    cur.execute("""
        SELECT event_id FROM events
        WHERE event_name = %s AND event_date = %s
    """, (event_name, normalized_date))
    result = cur.fetchone()

    if result:
        event_id = result[0]
    else:
        cur.execute("""
            INSERT INTO events(event_name, event_date, org_id, event_status)
            VALUES (%s, %s, %s, %s)
            RETURNING event_id
        """, (event_name, normalized_date, 1, 'completed'))
        event_id = cur.fetchone()
        conn.commit()

    cur.execute("""
        SELECT mapping_id FROM event_source_mapping
        WHERE event_id = %s AND source = %s
    """, (event_id, 'sherdog'))
    if not cur.fetchone():
        cur.execute("""
            INSERT INTO event_source_mapping (event_id, source, source_event_id)
            VALUES (%s, %s, %s)
        """, (event_id, 'sherdog', event_name))
        conn.commit()

cur.close()
conn.close()
print("Event ETL complete.")
