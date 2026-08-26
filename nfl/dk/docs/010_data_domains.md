# draftkings data domains

## events
- event_id
- league_id
- sport_id
- name (should be something like TEAM A @ TEAM B)
- start_event_date
- status (whether or not game is started/over)
- home_team
- away_team

## markets
- market_id (id linking prop bets to events???)
- event_id
- name (actual name of the prop bet)
- subcategory_id (id for specific prop bet in relation to this event???)
- market_type_id (universal id for this prop bet???)

## outcomes
- id (id linking player to prop bet)
- market_id
- player (derived from label or participants.name)
- outcome_type (prop being bet on)
- participant_id 

## snapshots
- outcome_id
- scraped_at (timestamp to keep track of odds changes)
- american_odds
- decimal_odds
- fractional_odds
- implied_probability
