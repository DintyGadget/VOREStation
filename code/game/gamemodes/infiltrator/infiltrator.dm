/datum/game_mode/infiltrator
	name = "Team Traitor"
	round_description = "На борту группа тайных лазутчиков! Будь осторожны!"
	extended_round_description = "Команда секретных людей разыграла долгую аферу и сумела получить доступ на объект. \
	Каковы их цели, кто их работодатели и почему люди будут работать на них - загадка, \
	но, возможно, вы их перехитрите, а может быть, это все часть их плана?"
	config_tag = "infiltrator"
	required_players = 2
	required_players_secret = 5
	required_enemies = 2 // Bit pointless if there is only one, since its basically traitor.
	end_on_antag_death = 0
	antag_scaling_coeff = 5
	antag_tags = list(MODE_INFILTRATOR)