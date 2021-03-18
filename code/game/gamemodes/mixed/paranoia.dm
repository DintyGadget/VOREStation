/datum/game_mode/paranoia
	name = "Malf AI, Renegades & Changelings"
	round_description = "ИИ дал сбой, и подрывные элементы наводнили команду ..."
	extended_round_description = "В этом режиме появляются безудержные ИИ, ренегаты и подменыши."
	config_tag = "paranoia"
	required_players = 2
	required_players_secret = 7
	required_enemies = 1
	end_on_antag_death = 1
	require_all_templates = 1
	votable = 0
	antag_tags = list(MODE_MALFUNCTION, MODE_RENEGADE, MODE_CHANGELING)
