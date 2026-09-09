\set season 2025

-- wr rookie season
\set rookie_season 2025
\set current_season_for_rookie_wr :season
\set rec_rookie_position 'WR'

-- sort player by fantasy ppg
\set player_ppg_season :season
\set player_ppg_start_week 1
\set player_ppg_end_week 17
\set player_ppg_positions '{QB,RB,WR,TE}'

-- kicker fantasy ppg
\set kicker_season :season
\set kicker_start_week 1
\set kicker_end_week 17

-- defense ppg allowed per position
\set def_player_ppg_season :season
\set def_player_ppg_start_week 1
\set def_player_ppg_end_week 17
\set def_player_ppg_position 'QB'

-- average kicking points per team
\set team_k_season :season
\set team_k_start_week 1
\set team_k_end_week 17

-- defense position and kicker ppg
\set d_player_kicker_ppg_season :season
\set d_player_kicker_ppg_start_week 1
\set d_player_kicker_ppg_end_week 17
\set d_player_kicker_ppg_positions '{QB,RB,WR,TE}'

-- team passing pain
\set team_pass_pain_season :season
\set team_pass_pain_start_week 1
\set team_pass_pain_end_week 17
\set team_pass_pain_order sacks_suffered

-- team defense
\set team_d_basic_season :season
\set team_d_basic_start_week 1
\set team_d_basic_end_week 4
\set team_d_basic_order_by 'pts_allowed'

-- find kicker
\set find_k_historical_season :season
\set find_k_start_week 1
\set find_k_end_week 17
\set find_k_season_to_check 2026
\set find_k_week_to_check 1

-- dk props
\set subcategory_id 9514

-- dk tds
\set market_type_id 11019

