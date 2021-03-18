/datum/game_mode/revolution
	name = "Revolution"
	config_tag = "revolution"
	round_description = "Некоторые члены экипажа пытаются начать революцию!"
	extended_round_description = "Революционеры - Отстраните руководителей штабов от власти. Преобразуйте других членов команды в свое дело, используя глагол Convert Bourgeoise. Защитите своих лидеров."
	required_players = 12 //should be enough for a decent manifest, hopefully
	required_players_secret = 12 //pretty sure rev doesn't even appear in secret
	required_enemies = 3
	auto_recall_shuttle = 0 //un-wanted on polaris
	end_on_antag_death = 0
	antag_tags = list(MODE_REVOLUTIONARY, MODE_LOYALIST)
	require_all_templates = 1
