# NFL
The NFL project brings together 4 different sources to create a single analysis db
- NFLverse: creates a convenient place to get a look at all the important basic stats
- Advanced stats: allows us to look at more advanced stats like yards per route or explosive %
- Player props: allows us to create player rankings based on vegas props
- Gamelines/spreads/totals: gives us a look at the games as whole providing a bit more context

# PSQL
I'm mainly using psql in the command line to run queries... this is very annoying when running many queries, but I'll have to look into better options down the road... for now, im trying to use variables where I can

I can do something like:
```
psql -v season=2025 -v start_week=1 -v end_week=10 -f 050_average_fantasy_points_allowed.sql
```
But working within psql and setting variables like this is my main workflow:
```
\set season 2025
\set start_week 1
\set end_week 10
```

