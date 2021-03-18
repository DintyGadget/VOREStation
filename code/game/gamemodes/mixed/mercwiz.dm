/datum/game_mode/mercwiz
	name = "Mercenaries & Technomancer"
	round_description = "Команда наемников и волшебник вторглись на станцию!"
	extended_round_description = "В этом раунде появляются наемники и волшебники."
	config_tag = "mercwiz"
	required_players = 15			//I don't think we can have it lower and not need an ERT every round.
	required_players_secret = 15	//I don't think we can have it lower and not need an ERT every round.
	required_enemies = 7
	end_on_antag_death = 0
	antag_tags = list(MODE_MERCENARY, MODE_TECHNOMANCER)
	require_all_templates = 1
	votable = 0