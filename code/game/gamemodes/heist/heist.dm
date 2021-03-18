/*
VOX HEIST ROUNDTYPE
*/

var/global/list/obj/cortical_stacks = list() //Stacks for 'leave nobody behind' objective. Clumsy, rewrite sometime.

/datum/game_mode/heist
	name = "Heist"
	config_tag = "heist"
	required_players = 12
	required_players_secret = 12
	required_enemies = 3
	round_description = "Неопознанная подпись bluespace приближается к станции!"
	extended_round_description = "Контроль компании над фороном в системе сделал эту станцию очень ценной целью \
		для многих конкурирующих организаций и частных лиц. Будучи колонией со значительным населением \
		и значительным достатком, она часто становится объектом \
		различных попыток грабежа, мошенничества и других злонамеренных действий."
	end_on_antag_death = 0
	antag_tags = list(MODE_RAIDER)