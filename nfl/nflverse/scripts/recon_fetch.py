import requests
from bs4 import BeautifulSoup
import json
import pandas as pd

def fetch_dictionary_html(url: str) -> str:
    response = requests.get(url)
    response.raise_for_status()
    return response.text

def parse_pbp_dictionary(html: str) -> pd.DataFrame:
    soup = BeautifulSoup(html, 'html.parser')
    script = soup.find('script', {'type': 'application/json'})
    if not script or not script.string:
        raise ValueError("No <script> with content found")

    data = json.loads(script.string)

    table_data = data["x"]["data"]
    print(f"Raw table data: {len(table_data)} rows")

    df = pd.DataFrame(table_data).T
    df.columns = ['field', 'description', 'data_type']

    return df

def main():
    url = "https://nflreadr.nflverse.com/articles/dictionary_pbp.html"
    html = fetch_dictionary_html(url)

    print("\nHTML size:", len(html))
    
    df = parse_pbp_dictionary(html) 

    print(f"\n✅ PBP Dictionary: {df.shape}")
    print("Columns:", df.columns.tolist())
    print("\nFirst 3 rows:")
    print(df.head(3))
    
    print("\n Recon complete")

if __name__ == "__main__":
    main()
