
WITH starter AS (
    SELECT player_gamertag,
           did_win,
           player_total_kills,
           player_total_deaths,
           md.match_id,
           m.completion_date,
           pl.name as playlist

    FROM match_details md
             JOIN matches m ON md.match_id = m.match_id
             JOIN playlists pl ON m.playlist_id = pl.playlist_id
),
     lagged AS (
         SELECT *,
                LAG(did_win, 1)
                OVER (PARTITION BY player_gamertag, playlist ORDER BY completion_date) AS did_win_game_before
         FROM starter
     ),
     streak_change AS (
         SELECT *,
                did_win,
                CASE WHEN did_win <> did_win_game_before THEN 1 ELSE 0 END as streak_changed
         FROm lagged
     ),
     streak_identified AS (

         SELECT *,
                SUM(streak_changed) OVER (PARTITION BY player_gamertag, playlist ORDER BY completion_date) AS streak_identifier

         FROM streak_change
     ),
     record_counts AS (

         SELECT *,
            ROW_NUMBER() OVER (PARTITION BY player_gamertag, playlist, streak_identifier ORDER BY completion_date) as streak_length
         FROM streak_identified
     ),
     ranked AS (
         SELECT *,
       RANK() OVER (PARTITION BY player_gamertag, playlist, streak_identifier ORDER BY streak_length DESC) AS rank
       FROM record_counts
     )

SELECT * FROM ranked WHERE rank = 1
ORDER BY streak_length DESC





