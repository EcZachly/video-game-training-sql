# Serious SQL Video Game Training
This is the repo that has all the queries and data for my Serious SQL video game training series!

## Base Data Model (getting started)

1. Install Postgres locally (Homebrew is really nice for installing on Mac)
This [tutorial](https://daily-dev-tips.com/posts/installing-postgresql-on-a-mac-with-homebrew/) is what I used
2. Use the data dump and pg_restore to create a new database. 
```
pg_restore -U <yourusername> -d postgres --no-owner "halo5-dump.sql"
```
3. Set up DataGrip to point at your locally running Postgres instance
4. Have fun querying!

## Specific Trainings

### Self Join Training
- YouTube [link](https://www.youtube.com/watch?v=dbgK6cx--IY)
- Queries can be found in self-join-training folder


### Window Functions Training
- Coming Soon!
