/datum/game_mode/traitorling
	name = "Traitors & Changelings"
	round_description = "На станции есть предатели и инопланетные подменыши. Не дайте подменышам добиться успеха!"
	extended_round_description = "В этом режиме появляются как предатели, так и подменыши."
	config_tag = "traitorling"
	required_players = 10
	required_players_secret = 10
	required_enemies = 5
	end_on_antag_death = 1
	require_all_templates = 1
	antag_tags = list(MODE_CHANGELING, MODE_TRAITOR)
