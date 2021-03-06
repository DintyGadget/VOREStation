/datum/game_mode/changeling
	name = "Changeling"
	round_description = "На станции есть инопланетные подменыши. Не дайте подменышам добиться успеха!"
	extended_round_description = "LЖизнь всегда находит выход. Однако жизнь иногда может принять более тревожный маршрут. \
		Обширные знания человечества о ксенобиологических образцах сделали их самоуверенными и высокомерными. \
		И все же что-то промелькнуло в их глазах. Что-то опасное. Что-то живое. Но самое страшное, \
		однако, то, что это нечто есть кто-то. Неизвестный инопланетный экземпляр вошел в состав \
		экипажа станции. Его уникальная биология позволяет ему манипулировать своей собственной или чьей-либо еще ДНК. \
		Обладая способностью копировать лица, голоса, животных, а также изменять химический состав собственного тела, \
		его существование представляет угрозу не только вашей личной безопасности, но и жизни всех находящихся на борту. \
		Никто не знает, откуда оно взялось. Никто не знает, что оно \
		и чего хочет. Но одно можно сказать наверняка... оно не одно. Удачи."
	config_tag = "changeling"
	required_players = 2
	required_players_secret = 3
	required_enemies = 1
	end_on_antag_death = 0
	antag_scaling_coeff = 10
	antag_tags = list(MODE_CHANGELING)
