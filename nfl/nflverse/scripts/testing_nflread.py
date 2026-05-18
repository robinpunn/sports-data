import nflreadpy as nfl

weekly = nfl.load_player_stats(seasons=[2025])

# print(weekly.shape)
# print(weekly.columns)
# print(weekly.dtypes)
# print(weekly.head())

print(
    weekly[[
        "player_id",
        "season",
        "week",
        "season_type",
        "team",
        "opponent_team",
    ]].head()
)
