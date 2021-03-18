/datum/game_mode/uprising
	name = "Revolution & Cult"
	config_tag = "uprising"
	round_description = "Некоторые члены команды пытаются начать революцию, в то время как культ заговора скрывается в тени!"
	extended_round_description = "В этом раунде появляются сектанты и революционеры."
	required_players = 15
	required_players_secret = 15
	required_enemies = 3
	end_on_antag_death = 1
	antag_tags = list(MODE_REVOLUTIONARY, MODE_LOYALIST, MODE_CULTIST)
	require_all_templates = 1
	votable = 0