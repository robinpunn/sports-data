import argparse

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--season", nargs="+", type=int)
    parser.add_argument("--week", type=int)
    return parser.parse_args()
