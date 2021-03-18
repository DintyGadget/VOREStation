/datum/game_mode/conflux
	name = "Technomancers & Cult"
	round_description = "На станцию вторглись космический волшебник и культ!"
	extended_round_description = "Во время этого раунда появляются сектанты и волшебники."
	config_tag = "conflux"
	required_players = 15
	required_players_secret = 15
	required_enemies = 5
	end_on_antag_death = 1
	antag_tags = list(MODE_TECHNOMANCER, MODE_CULTIST)
	require_all_templates = 1
	votable = 1