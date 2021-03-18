/datum/game_mode/traitorren
	name = "Traitors & Renegades"
	round_description = "Подрывные элементы вторглись на станцию, и некоторые люди не уверены в своей безопасности."
	extended_round_description = "В этом раунде появляются предатели и ренегаты."
	config_tag = "traitorren"
	required_players = 11			//I don't think we can have it lower and not need an ERT every round.
	required_players_secret = 11	//I don't think we can have it lower and not need an ERT every round.
	required_enemies = 4
	end_on_antag_death = 0
	antag_tags = list(MODE_AUTOTRAITOR, MODE_RENEGADE)
	require_all_templates = 1
