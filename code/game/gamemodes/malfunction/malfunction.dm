/datum/game_mode/malfunction
	name = "AI Malfunction"
	round_description = "ИИ ведет себя ненормально, и его необходимо остановить."
	extended_round_description = "ИИ попытается взломать APC на всей станции, чтобы получить как можно больше контроля."
	config_tag = "malfunction"
	required_players = 2
	required_players_secret = 2
	required_enemies = 1
	end_on_antag_death = 0
	auto_recall_shuttle = 0
	antag_tags = list(MODE_MALFUNCTION)
	disabled_jobs = list("AI")
	votable = 0
