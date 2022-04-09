create table match_details
(
	match_id varchar(50) not null
		constraint match_details_match_id_fkey
			references matches,
	player_gamertag varchar(25) not null
		constraint match_details_player_gamertag_fkey
			references players,
	previous_spartan_rank integer,
	spartan_rank integer,
	previous_total_xp integer,
	total_xp integer,
	previous_csr_tier integer,
	previous_csr_designation integer,
	previous_csr integer,
	previous_csr_percent_to_next_tier integer,
	previous_csr_rank integer,
	current_csr_tier integer,
	current_csr_designation integer,
	current_csr integer,
	current_csr_percent_to_next_tier integer,
	current_csr_rank integer,
	player_rank_on_team integer,
	player_finished boolean,
	player_average_life varchar(30),
	player_total_kills integer,
	player_total_headshots integer,
	player_total_weapon_damage double precision,
	player_total_shots_landed integer,
	player_total_melee_kills integer,
	player_total_melee_damage double precision,
	player_total_assassinations integer,
	player_total_ground_pound_kills integer,
	player_total_shoulder_bash_kills integer,
	player_total_grenade_damage double precision,
	player_total_power_weapon_damage double precision,
	player_total_power_weapon_grabs integer,
	player_total_deaths integer,
	player_total_assists integer,
	player_total_grenade_kills integer,
	did_win integer,
	team_id text,
	primary key (match_id, player_gamertag)
);

