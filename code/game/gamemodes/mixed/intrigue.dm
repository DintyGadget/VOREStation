/datum/game_mode/intrigue
	name = "Traitors & Ninja"
	round_description = "С членами экипажа связываются внешние элементы, в то время как другой проникает в колонию."
	extended_round_description = "В этом раунде появляются предатели и ниндзя."
	config_tag = "intrigue"
	required_players = 6
	required_players_secret = 8
	required_enemies = 3
	end_on_antag_death = 0
	antag_tags = list(MODE_NINJA, MODE_AUTOTRAITOR)
	round_autoantag = 1
	require_all_templates = 1