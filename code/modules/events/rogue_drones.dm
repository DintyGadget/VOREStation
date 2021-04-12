/datum/event/rogue_drone
	endWhen = 1000
	var/list/drones_list = list()

/datum/event/rogue_drone/start()
	//spawn them at the same place as carp
	var/list/possible_spawns = list()
	for(var/obj/effect/landmark/C in landmarks_list)
		if(C.name == "carpspawn")
			possible_spawns.Add(C)

	//25% chance for this to be a false alarm
	var/num
	if(prob(25))
		num = 0
	else
		num = rand(2,6)
	for(var/i=0, i<num, i++)
		var/mob/living/simple_mob/mechanical/combat_drone/event/D = new(get_turf(pick(possible_spawns)))
		drones_list.Add(D)

/datum/event/rogue_drone/announce()
	var/msg
	var/rng = rand(1,5)
	//VOREStation Edit Start
	switch(rng)
		if(1)
			msg = "Крыло боевого дрона, работающее на близкой орбите над Virgo 3b, не смогло вернуться после антипиратской атаки. Если они заметны, подходите к ним осторожно."
		if(2)
			msg = "Утерян контакт с крылом боевого дрона на орбите Virgo 3b. Если они обнаружены в этом районе, подходите к ним осторожно."
		if(3)
			msg = "Неизвестные хакеры нацелились на крыло боевого дрона, развернутое вокруг Virgo 3b. Если они обнаружены в этом районе, подходите к ним осторожно."
		if(4)
			msg = "Только что активировались системы защиты дронов проходящего заброшенного корабля. Если они обнаружены в этом районе, будьте осторожны."
		if(5)
			msg = "Мы обнаруживаем рой мелких объектов, приближающихся к вашей станции. Скорее всего куча дронов. Будьте осторожны, если увидите их."
	//VOREStation Edit End
	command_announcement.Announce(msg, "Оповещение о беспилотниках")

/datum/event/rogue_drone/end()
	var/num_recovered = 0
	for(var/mob/living/simple_mob/mechanical/combat_drone/D in drones_list)
		var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
		sparks.set_up(3, 0, D.loc)
		sparks.start()
		D.z = using_map.admin_levels[1]
		D.loot_list = list()

		qdel(D)
		num_recovered++

	if(num_recovered > drones_list.len * 0.75)
		command_announcement.Announce("Дроны, которые вышли из строя, были благополучно восстановлены.", "Оповещение о беспилотниках")
	else
		command_announcement.Announce("Мы разочарованы потерей дронов, но выжившие были восстановлены.", "Оповещение о беспилотниках")
