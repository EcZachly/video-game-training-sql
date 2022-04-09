create table game_variants
(
	game_id varchar(50) not null primary key,
	icon_url varchar(75),
	game_base_id varchar(50) references game_base_variants(game_base_id),
	name varchar(50),
	description varchar(100)
);
