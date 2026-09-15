\set season 2025
-- nflverse
-- snaps by position for a week
\set snap_stats_season :season
\set snap_stats_week 1
\set snap_stats_position '{QB,RB,WR,TE}'

-- snaps by timeframe
\set snap_timeframe_season :season
\set snap_timeframe_start_week 1
\set snap_timeframe_end_week 17
\set snap_timeframe_position '{QB,RB,WR,TE}'
\set snap_timeframe_sort snaps_game

-- player receiving stats
\set receiving_stats_season :season
\set receiving_stats_start_week 1
\set receiving_stats_end_week 17
\set receiving_stats_sort tar_per_game
\set receiving_stats_position '{QB,RB,WR,TE}'

-- player rushing stats
\set rushing_stats_season :season
\set rushing_stats_start_week 1
\set rushing_stats_end_week 17
\set rushing_stats_sort car
\set rushing_stats_position '{QB,RB,WR,TE}'

-- player passing stats
\set passing_stats_season :season
\set passing_stats_start_week 1
\set passing_stats_end_week 17
\set passing_stats_sort yds
\set passing_stats_position '{QB,RB,WR,TE}'

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

-- defense ppg all positions
\set team_d_all_pos_ppg_season 2025
\set team_d_all_pos_start_week 1
\set team_d_all_pos_end_week 17
\set team_d_all_pos qb

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

-- find kicker for week
\set find_k_reference_season :season
\set find_k_start_week 1
\set find_k_end_week 17
\set find_k_season_to_check 2026
\set find_k_week_to_check 1

--action network
-- action network implied scores
\set act_book_id 68
\set act_season :season
\set act_imp_week 1

-- draftkings
-- find player full name
\set find_full_name NULL

-- add player to map
\set update_dk_player NULL
\set update_nflverse_player_id NULL

-- update missing player
\set insert_nflverse_player_id NULL
\set insert_dk_player NULL

-- dk props
\set subcategory_id 9514
\set player_prop_positions '{QB,RB,WR,TE}'

-- dk tds
\set market_type_id 11019
\set player_td_positions '{QB,RB,WR,TE}'

-- sort games by week
\set dk_events_season :season
\set dk_events_start_week 1
\set dk_events_end_week 1

