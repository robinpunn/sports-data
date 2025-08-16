import os
import glob
import pandas as pd 
from dotenv import load_dotenv
import psycopg2
from psycopg2.extras import execute_values

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

csv_files = sorted(glob.glob(os.path.join(MMA_DATA, "*.csv")))

if not csv_files:
    print(f"No CSV files found in {MMA_DATA}")
    exit(1)

print(f"Found {len(csv_files)} CSV files to process")

for csv_file in csv_files:
    print(f"Loading: {csv_file}")

    try:
        df = pd.read_csv(csv_file)

        df = df.reindex(columns=[
            'date', 'event', 'weight_class', 'winner', 'winner_weight', 'winner_odds',
            'loser', 'loser_weight', 'loser_odds', 'method', 'rnd', 'time'
        ])

        df['source_file'] = os.path.basename(csv_file)
        df['match_number'] = df.groupby('event').cumcount(ascending=False) + 1

        records = df[['event', 'date', 'match_number', 'weight_class', 'winner', 'winner_weight',
                      'winner_odds', 'loser', 'loser_weight', 'loser_odds',
                      'method', 'rnd', 'time', 'source_file']].values.tolist()

        insert_query = """
        INSERT INTO stg_mma_fights (
            event_name, event_date, match_number, weight_class, winner, winner_weight, winner_odds,
            loser, loser_weight, loser_odds, method, round, time, source_file
        ) VALUES %s
        """

        execute_values(cur, insert_query, records)
        conn.commit()

    except pd.errors.EmptyDataError:
        print(f"  Warning: {csv_file} is empty, skipping")
        continue
    except pd.errors.ParserError as e:
        print(f"  Error parsing {csv_file}: {e}")
        continue
    except psycopg2.Error as e:
        print(f"  Database error with {csv_file}: {e}")
        conn.rollback()
        continue
    except Exception as e:
        print(f"  Unexpected error with {csv_file}: {e}")
        continue

cur.close()
conn.close()
print("complete")
