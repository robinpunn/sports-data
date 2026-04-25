# FF Rankings Data Dictionary 

Generated: 2026-04-25 15:04:28 UTC

## FF Rankings (ff_rankings)

| Field                   | Description                                                                                                                                                              | Type      |
|:------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------|
| fp_page                 | The relative url that the data was scraped from (add the prefix https://www.fantasypros.com/ to visit the page)                                                          | character |
| page_type               | Two word identifier separated by a dash identifying the type of fantasy ranking (best = bestball; dynasty; redraft) and what position it applies to                      | character |
| ecr_type                | A two letter identifier combining the ranking type (b = bestball; d = dynasty; r = redraft) and position type (o = overall; p = positional; sf = superflex; rk = rookie) | character |
| player                  | Player name                                                                                                                                                              | character |
| id                      | FantasyPros ID                                                                                                                                                           | character |
| pos                     | Position as tracked by FP                                                                                                                                                | character |
| team                    | NFL team the player plays for                                                                                                                                            | character |
| sportsdata_id           | ID - also known as sportradar_id (they are equivalent!)                                                                                                                  | character |
| player_filename         | base URL for this player on fantasypros.com                                                                                                                              | character |
| yahoo_id                | Yahoo ID                                                                                                                                                                 | character |
| cbs_id                  | CBS ID                                                                                                                                                                   | character |
| player_image_url        | An image of the player                                                                                                                                                   | character |
| player_square_image_url | An square image of the player                                                                                                                                            | character |
| mergename               | Player name after being cleaned by dp_cleannames - generally strips punctuation and suffixes as well as performing common name substitutions.                            | character |
| tm                      | Team ID as used on MyFantasyLeague.com                                                                                                                                   | character |
| scrape_date             | Date this dataframe was last updated                                                                                                                                     | Date      |
| ecr                     | Average (mean) expert ranking for this player                                                                                                                            | numeric   |
| sd                      | Standard deviation of expert rankings for this player                                                                                                                    | numeric   |
| best                    | The highest ranking given for this player by any one expert                                                                                                              | numeric   |
| worst                   | The lowest ranking given for this player by any one expert                                                                                                               | numeric   |
| player_owned_avg        | The average percentage this player is rostered across ESPN and Yahoo                                                                                                     | numeric   |
| player_owned_espn       | The percentage that this player is rostered in ESPN leagues                                                                                                              | numeric   |
| player_owned_yahoo      | The percentage that this player is rostered in Yahoo leagues                                                                                                             | numeric   |
| rank_delta              | Change in ranks over a recent period                                                                                                                                     | numeric   |
| bye                     | NFL bye week                                                                                                                                                             | numeric   |
