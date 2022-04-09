create table matches
(
	match_id varchar(50) not null primary key,
	mapid varchar(50) references maps(mapid),
	is_team_game boolean,
	playlist_id varchar(50) references playlists(playlist_id),
	game_variant_id varchar(50) references game_base_variants(game_variant_id),
	is_match_over boolean,
	completion_date timestamp,
	match_duration varchar(25),
	game_mode text,
	map_variant_id text
);
