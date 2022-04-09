create table medals
(
	medal_id varchar(50) not null primary key,
	sprite_uri varchar(150),
	sprite_left integer,
	sprite_top integer,
	sprite_sheet_width integer,
	sprite_sheet_height integer,
	sprite_width integer,
	sprite_height integer,
	classification varchar(50),
	description varchar(150),
	name varchar(50),
	difficulty integer
);
