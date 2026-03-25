import requests

def fetch_dictionary_html(url: str) -> str:
    response = requests.get(url)
    response.raise_for_status()
    return response.text

def main():
    url = "https://nflreadr.nflverse.com/articles/dictionary_pbp.html"
    html = fetch_dictionary_html(url)

    print("\nFirst 300 chars of HTML:")
    print(html[:300])

    print("\n Step A complete")

if __name__ == "__main__":
    main()
