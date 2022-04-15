WITH augmented_matches AS (
    SELECT match_details.*, m.completion_date, p.name as playlist
    FROM match_details
             JOIN matches m on match_details.match_id = m.match_id
             JOIN playlists p on m.playlist_id = p.playlist_id
),
     moving_avgs AS (
         SELECT player_gamertag,
                playlist,
                AVG(did_win) OVER
                    (PARTITION BY player_gamertag, playlist
                    ORDER BY completion_date
                    ROWS BETWEEN 200 preceding AND CURRENT ROW
                    ) AS two_hundred_game_avg,
                AVG(did_win) OVER
                    (PARTITION BY player_gamertag, playlist
                    ORDER BY completion_date
                    ROWS BETWEEN 50 PRECEDING AND current row
                    ) AS fifty_game_avg
         FROM augmented_matches
     )

SELECT *,
       fifty_game_avg/CASE WHEN two_hundred_game_avg = 0 THEN NULL ELSE two_hundred_game_avg END
           AS win_ratio
FROM moving_avgs
