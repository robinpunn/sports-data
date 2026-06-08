import psycopg

def get_connection():
    return psycopg.connect(
        dbname="nfl",
        user="mayjasp"
    )


def insert_rows(cur, table, df, conflict_cols):
    cols = df.columns
    
    placeholders = ", ".join(["%s"] * len(cols)) 
    col_names = ", ".join(cols)
   
    conflict_list = [c.strip() for c in conflict_cols.split(",")]

    update_cols = [c for c in cols if c not in conflict_list]

    update_assignments = ", ".join([f"{c} = EXCLUDED.{c}" for c in update_cols])

    query = f"""
        INSERT INTO nflverse.{table} ({col_names})
        VALUES ({placeholders})
        ON CONFLICT ({conflict_cols}) 
        DO UPDATE SET {update_assignments}
    """
    for row in df.iter_rows(named=True):
        cur.execute(query, tuple(row.values()))
    print(f"Inserted {len(df)} rows into {table}")


def run_ingestion(tables):
    conn = get_connection()
    cur = conn.cursor()

    try:
        for table, df, conflict_cols in tables:
            insert_rows(cur, table, df, conflict_cols)
        conn.commit()
    except Exception as e:
        conn.rollback()
        print(f"Error: {e}")
        raise
    finally:
        cur.close()
        conn.close()
