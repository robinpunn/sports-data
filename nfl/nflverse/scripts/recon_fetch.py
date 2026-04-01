import requests
from bs4 import BeautifulSoup
import json
import pandas as pd
from pathlib import Path

script_dir = Path(__file__).resolve().parent
project_root = script_dir.parent

def fetch_dictionary_html(url: str) -> str:
    response = requests.get(url)
    response.raise_for_status()
    return response.text

def parse_dictionary(html: str) -> pd.DataFrame:
    soup = BeautifulSoup(html, 'html.parser')
    script = soup.find('script', {'type': 'application/json'})
    if not script or not script.string:
        raise ValueError("No <script> with content found")

    data = json.loads(script.string)
    table_data = data["x"]["data"]
    df = pd.DataFrame(table_data).T
    df.columns = ['Field', 'Descriptions', 'Type']

    return df

def render_dataset_markdown(dataset_id: str, label: str, df: pd.DataFrame) -> str:
    header = f"## {label} ({dataset_id})\n\n"
    body = df.to_markdown(index=False)
    return f"{header}\n{body}\n"

def main():
    datasets = [
        {
            "id": "pbp",
            "label": "Play by Play",
            "url": "https://nflreadr.nflverse.com/articles/dictionary_pbp.html",
        }
    ]
    
    output = "# nlfverse Data Dictionaries \n\n"
    output += f"Generated: {pd.Timestamp.now().strftime('%Y-%m-%d %H:%M:%S')} UTC\n\n"

    for ds in datasets:
        print(f"Fetching {ds['label']}...")
        html = fetch_dictionary_html(ds["url"])
        df = parse_dictionary(html)

        section = render_dataset_markdown(ds["id"], ds["label"], df)

        output += section + "\n"

        print(f"{ds['label']}: {df.shape[0]} fields extracted")

    output_path = project_root/ "docs" / "nflverse_data_dictionary.md" 
    output_path.parent.mkdir(exist_ok=True)
    output_path.write_text(output)

    print("\n Data dictionaries complete")

if __name__ == "__main__":
    main()
