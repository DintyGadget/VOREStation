/datum/game_mode/infestation
	name = "Borers & Changelings"
	round_description = "В стенах что-то есть!"
	extended_round_description = "В этом раунде появляются два инопланетных антагониста (Кортикальные Черви или Подменыши)."
	config_tag = "infestation"
	required_players = 15
	required_enemies = 5
	end_on_antag_death = 1
	antag_tags = list(MODE_BORER, MODE_CHANGELING)
	require_all_templates = 1
	votable = 0

/datum/game_mode/infestation/create_antagonists()
	// Two of the three.
	antag_tags -= pick(antag_tags)
	..()