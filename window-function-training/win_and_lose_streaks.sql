WITH augmented_matches AS (
    SELECT match_details.*, m.completion_date, p.name as playlist
    FROM match_details
             JOIN matches m on match_details.match_id = m.match_id
             JOIN playlists p on m.playlist_id = p.playlist_id
),
     lagged_games AS (
         SELECT player_gamertag,
                did_win,
                playlist,
                completion_date,
                match_id,
                LAG(did_win, 1) OVER
                    (PARTITION BY player_gamertag, playlist
                    ORDER BY completion_date) AS did_win_game_before
         FROM augmented_matches
     ),
     streak_groups AS (
         SELECT player_gamertag,
                did_win,
                playlist,
                completion_date,
                match_id,
                CASE
                    WHEN did_win <> did_win_game_before
                        THEN 1
                    ELSE 0 END as new_streak
         FROM lagged_games
     ),
     grouped AS (
         SELECT *,
                SUM(new_streak)
                OVER
                    (PARTITION BY player_gamertag, playlist
                    ORDER BY completion_date) AS streak_group
         FROM streak_groups
     ),
     lengths AS (
         SELECT player_gamertag,
                playlist,
                completion_date,
                did_win,
                match_id,
                row_number() over (
                    PARTITION BY player_gamertag, playlist, streak_group ORDER BY completion_date, did_win) as streak_length
         FROM grouped
     ),
     augmented_streaks AS (
         SELECT player_gamertag,
                playlist,
                CASE WHEN did_win = 0 THEN 'losing' ELSE 'winning' END                        AS streak_type,
                streak_length,
                completion_date AS last_match_date,
                LAG(completion_date, CAST(streak_length AS INT)) over (
                    PARTITION BY player_gamertag, playlist ORDER BY completion_date, did_win) as first_match_date,
                LAG(match_id, CAST(streak_length AS INT)) over (
                    PARTITION BY player_gamertag, playlist ORDER BY completion_date, did_win) as first_match_of_streak
         FROM lengths
         ORDER BY streak_length DESC
     )

SELECT player_gamertag,
       playlist,
       first_match_of_streak,
       streak_type,
       MIN(first_match_date) AS start_date_of_streak,
       MIN(last_match_date) AS end_date_of_streak,
       MAX(streak_length) AS longest_streak
FROm augmented_streaks
GROUP BY player_gamertag,playlist, first_match_of_streak, streak_type
ORDER BY MAX(streak_length) DESC


