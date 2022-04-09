create table players
(
	gamertag varchar(25) not null primary key,
	arena_game_count integer,
	warzone_game_count integer,
	data json,
	last_updated timestamp
);
