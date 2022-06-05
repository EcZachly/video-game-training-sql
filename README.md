# Serious SQL Video Game Training
This is the repo that has all the queries and data for my Serious SQL video game training series!

The portfolio project for these trainings is located at https://www.halogods.com

## Base Data Model (getting started)

1. Install Postgres locally (Homebrew is really nice for installing on Mac)
-  Mac
-- This [tutorial](https://daily-dev-tips.com/posts/installing-postgresql-on-a-mac-with-homebrew/) is what I used
- Window
-- This [tutorial](https://www.sqlshack.com/how-to-install-postgresql-on-windows/) is what I used
2. Use the data dump at the root of this directory and pg_restore to create a new database. 
```
pg_restore -U <yourusername> -d postgres --no-owner "halo-data.dump"
```
3. Set up DataGrip to point at your locally running Postgres instance
4. Have fun querying!

## Specific Trainings

### Self Join Training
- YouTube [link](https://www.youtube.com/watch?v=dbgK6cx--IY)
- Queries
1. [Self Join Teammate analysis query](self-join-training/self-join-analysis-query.sql)


### Window Functions Training
- YouTube [link](https://www.youtube.com/watch?v=ejeGJHeKn-o)
- Queries 
1. [Simple consecutive streaks](window-function-training/rank_filter_streaks.sql) (covered in YT video)
2. [Win and lose streaks](window-function-training/win_and_lose_streaks.sql) (extra credit example)
3. [Hot and Cold Bounded Window Functions](window-function-training/hot_and_cold_ratios.sql) (extra credit example)
