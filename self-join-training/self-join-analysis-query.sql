WITH augment_matches AS (
    SELECT md.match_id,
           player_gamertag,
           p.name AS playlist,
           player_total_deaths,
           player_total_kills,
           did_win,
           team_id
    FROM match_details md
             JOIN matches m ON md.match_id = m.match_id
             JOIN playlists p ON m.playlist_id = p.playlist_id
),
     combined_matches AS (
         SELECT am.player_gamertag      as shooting_player,
       am2.player_gamertag     as helping_player,
       am.player_total_kills   as shooting_player_total_kills,
       am.player_total_deaths  as shooting_player_total_deaths,
       am2.player_total_kills  as helping_player_total_kills,
       am2.player_total_deaths as helping_player_total_deaths,
       am.did_win,
       COALESCE(am.playlist, 'unknown') AS playlist,
       am.match_id
FROM augment_matches am
         JOIN augment_matches am2
              ON am.match_id = am2.match_id
                  AND am.team_id = am2.team_id
                  AND am.player_gamertag <> am2.player_gamertag
     ),
     agged_matches AS (
         SELECT
    shooting_player,
       COALESCE(helping_player, '(overall)') AS helping_player,
       COALESCE(playlist, '(overall)') as playlist,
       CAST(SUM(shooting_player_total_kills) AS REAL)
           /CASE WHEN SUM(shooting_player_total_deaths) = 0 THEN 1 ELSE SUM(shooting_player_total_deaths) END as shooting_player_kdr,
       CAST(SUM(helping_player_total_kills) AS REAL)
           /CASE WHEN SUM(helping_player_total_deaths) = 0 THEN 1 ELSE SUM(helping_player_total_deaths)
        END as helping_player_kdr,
       AVG(did_win) AS win_percentage,
       COUNT(DISTINCT match_id) AS number_of_matches
FROM combined_matches
GROUP BY GROUPING SETS (
        (shooting_player),
        (shooting_player, playlist),
        (shooting_player, helping_player, playlist)

    )
HAVING COUNT(DISTINCT match_id) >= 10
     ),
     playlist_averages AS (
         SELECT * FROM agged_matches WHERE playlist <> '(overall)' and helping_player = '(overall)'
     ),
     player_averages AS (
          SELECT * FROM agged_matches WHERE playlist <> '(overall)' and helping_player <> '(overall)'
     )

SELECT pa.*,
       pla.shooting_player_kdr AS overall_kdr,
       pla.win_percentage AS overall_win_percentage,
       pa.win_percentage / pla.win_percentage AS win_percentage_ratio,
       pa.shooting_player_kdr / pla.shooting_player_kdr AS kdr_ratio
FROM player_averages pa
    JOIN playlist_averages pla
        ON pa.shooting_player = pla.shooting_player
        AND pa.playlist = pla.playlist

