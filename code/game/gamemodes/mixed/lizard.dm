/datum/game_mode/lizard
	name = "Technomancers & Changelings"
	round_description = "Космический волшебник и подменыши вторглись на станцию!"
	extended_round_description = "В этом раунде появляются подменыши и волшебник."
	config_tag = "lizard"
	required_players = 2
	required_players_secret = 8
	required_enemies = 3
	end_on_antag_death = 0
	antag_tags = list(MODE_TECHNOMANCER, MODE_CHANGELING)
	require_all_templates = 1
	votable = 1