# Sports Data
## What's in here
I'm working on maintaining an nfl database... I was planning on doing multiple sports along with the nfl (mma/mlb/tennis)... but I'm realzing it's going to take way longer than I'd like to add other sports. I want to work on other things, so the nfl is likely all this will be.

I do have some data for the UFC dating back to UFC 1, up to some time in 2025 where I stopped running my scrapy spider... Maybe I'll work on automating that down the road

## My goal
I don't like watching the NFL anymore, but I still have a lot of fun playing fantasy... I like being a box score watcher and not knowing ball. What I'm trying to do is let Vegas make my decisions for me through player props and gamelines. So I'm using nflverse and player prop/odds data to create queries to replace the 5+ sites I would cross reference to make fantasy decisions... So the main goal of this project is to reduce fantasy decision making to about 15 minutes a day at the most...

## nflverse and draftkings db
The `analysis_setup` file is used to help with the command line when running queries in psql.

Both directories contain a `db` directory that have files to setup the table schema and `views` and `queries` that replace the work of visiting 5 different sites
