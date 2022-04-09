create table medals_matches_players
(
	match_id varchar(50) not null references matches(match_id),
	player_gamertag varchar(50) not null references players(player_gamertag),
	medal_id varchar(50) not null references medals,
	count integer,
        primary key (match_id, medal_id, player_gamertag)
);
