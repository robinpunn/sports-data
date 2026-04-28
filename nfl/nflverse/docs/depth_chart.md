# Depth Chart Data Dictionary 

Generated: 2026-04-28 12:15:43 UTC

## Depth Chart (depth_chart)

| Field       | Description                                                                                                                                                          | Type      |
|:------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------|
| dt          | The timestamp (ISO8601-formatted text) indicating when the data record was loaded. Can be used to assign the data set to a specific point in time during the season. | character |
| team        | Team that depth chart belongs to                                                                                                                                     | character |
| player_name | Full name of player                                                                                                                                                  | character |
| espn_id     | ESPN Player ID                                                                                                                                                       | character |
| gsis_id     | Game Stats and Info Service ID: the primary ID for play-by-play data                                                                                                 | character |
| pos_grp_id  | Player position group identifier                                                                                                                                     | character |
| pos_grp     | Player position group: formation of offense, defense, or special teams                                                                                               | character |
| pos_id      | Player position identifier                                                                                                                                           | character |
| pos_name    | Player position name                                                                                                                                                 | character |
| pos_abb     | Player position abbreviation                                                                                                                                         | character |
| pos_slot    | A number assigned to each position in a formation                                                                                                                    | numeric   |
| pos_rank    | Player’s rank on depth chart grouped by pos_slot                                                                                                                     | numeric   |
