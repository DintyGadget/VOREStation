var/datum/antagonist/ninja/ninjas

/datum/antagonist/ninja
	id = MODE_NINJA
	role_type = BE_NINJA
	role_text = "Ninja"
	role_text_plural = "Ninja"
	bantype = "ninja"
	landmark_id = "ninjastart"
	welcome_text = "<span class='info'>Вы элитный наемный убийца из клана Пауков. В вашем распоряжении множество способностей, благодаря вашей наноусиленной кибер-броне.</span>"
	flags = ANTAG_OVERRIDE_JOB | ANTAG_CLEAR_EQUIPMENT | ANTAG_CHOOSE_NAME | ANTAG_RANDSPAWN | ANTAG_VOTABLE | ANTAG_SET_APPEARANCE
	antaghud_indicator = "hudninja"

	initial_spawn_req = 1
	initial_spawn_target = 1
	hard_cap = 1
	hard_cap_round = 3

	id_type = /obj/item/weapon/card/id/syndicate

/datum/antagonist/ninja/New()
	..()
	ninjas = src

/datum/antagonist/ninja/attempt_random_spawn()
	if(config.ninjas_allowed) ..()

/datum/antagonist/ninja/create_objectives(var/datum/mind/ninja)

	if(!..())
		return

	var/objective_list = list(1,2,3,4,5)
	for(var/i=rand(2,4),i>0,i--)
		switch(pick(objective_list))
			if(1)//Kill
				var/datum/objective/assassinate/ninja_objective = new
				ninja_objective.owner = ninja
				ninja_objective.target = ninja_objective.find_target()
				if(ninja_objective.target != "Свободная цель")
					ninja.objectives += ninja_objective
				else
					i++
				objective_list -= 1 // No more than one kill objective
			if(2)//Steal
				var/datum/objective/steal/ninja_objective = new
				ninja_objective.owner = ninja
				ninja_objective.target = ninja_objective.find_target()
				ninja.objectives += ninja_objective
			if(3)//Protect
				var/datum/objective/protect/ninja_objective = new
				ninja_objective.owner = ninja
				ninja_objective.target = ninja_objective.find_target()
				if(ninja_objective.target != "Свободная цель")
					ninja.objectives += ninja_objective
				else
					i++
					objective_list -= 3
			if(4)//Download
				var/datum/objective/download/ninja_objective = new
				ninja_objective.owner = ninja
				ninja_objective.gen_amount_goal()
				ninja.objectives += ninja_objective
				objective_list -= 4
			if(5)//Harm
				var/datum/objective/harm/ninja_objective = new
				ninja_objective.owner = ninja
				ninja_objective.target = ninja_objective.find_target()
				if(ninja_objective.target != "Свободная цель")
					ninja.objectives += ninja_objective
				else
					i++
					objective_list -= 5

	var/datum/objective/ninja_highlander/ninja_obj = new
	ninja_obj.owner = ninja
	ninja.objectives += ninja_obj

	var/datum/objective/survive/ninja_objective = new
	ninja_objective.owner = ninja
	ninja.objectives += ninja_objective

/datum/antagonist/ninja/greet(var/datum/mind/player)

	if(!..())
		return 0
	var/directive = generate_ninja_directive("heel")
	player.store_memory("<B>Директива:</B> <span class='danger'>[directive]</span><br>")
	to_chat(player, "<b>Помните свою директиву:</b> [directive].")

/datum/antagonist/ninja/update_antag_mob(var/datum/mind/player)
	..()
	var/ninja_title = pick(ninja_titles)
	var/ninja_name = pick(ninja_names)
	var/mob/living/carbon/human/H = player.current
	if(istype(H))
		H.real_name = "[ninja_title] [ninja_name]"
		H.name = H.real_name
	player.name = H.name

/datum/antagonist/ninja/equip(var/mob/living/carbon/human/player)

	if(!..())
		return 0

	var/obj/item/device/radio/R = new /obj/item/device/radio/headset(player)
	player.equip_to_slot_or_del(R, slot_l_ear)
	player.equip_to_slot_or_del(new /obj/item/clothing/under/color/black(player), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/device/flashlight(player), slot_belt)
	create_id("Infiltrator", player)

	var/obj/item/weapon/rig/light/ninja/ninjasuit = new(get_turf(player))
	ninjasuit.seal_delay = 0
	player.put_in_hands(ninjasuit)
	player.equip_to_slot_or_del(ninjasuit,slot_back)
	if(ninjasuit)
		ninjasuit.toggle_seals(src,1)
		ninjasuit.seal_delay = initial(ninjasuit.seal_delay)

	if(istype(player.back,/obj/item/weapon/rig))
		var/obj/item/weapon/rig/rig = player.back
		if(rig.air_supply)
			player.internal = rig.air_supply

	spawn(10)
		if(player.internal)
			player.internals.icon_state = "internal1"
		else
			to_chat(player, "<span class='danger'>Вы забыли включить свои внутренние устройства! Быстро переключай вентиль!</span>")

/datum/antagonist/ninja/proc/generate_ninja_directive(side)
	var/directive = "[side=="face"?"[using_map.company_name]":"Преступный синдикат"] - ваш работодатель. "//Let them know which side they're on.
	switch(rand(1,19))
		if(1)
			directive += "Клан Паука не должен быть связан с этой операцией. По возможности оставайтесь скрытыми."
		if(2)
			directive += "[station_name()] финансируется врагами клана пауков. Вызовите столько структурных повреждений, сколько нужно."
		if(3)
			directive += "Богатый защитник прав животных обратился с просьбой, в которой мы не можем отказать. По возможности отдавайте приоритет спасению жизней животных."
		if(4)
			directive += "Клан Паука никак не может быть связан с этой операцией. Устраняйте свидетелей по своему усмотрению."
		if(5)
			directive += "В настоящее время мы ведем переговоры с [using_map.company_name] [using_map.boss_name]. Ставьте приоритет в спасение человеческих жизней, а не их уничтожения."
		if(6)
			directive += "Мы вовлечены в судебный спор по поводу [station_name()]. Если на судне присутствует секретарь/адвокат, заставьте его сотрудничать в этом вопросе."
		if(7)
			directive += "Финансовый спонсор сделал предложение, от которого мы не можем отказаться. Вовлеките экипаж в преступное участие операции."
		if(8)
			directive += "Пусть никто не сомневается в милосердии клана пауков. Обеспечьте безопасность всего существенного персонала, с которым вы столкнетесь."
		if(9)
			directive += "Свободный агент предложил выгодную коммерческую сделку. Сообщите об участии [using_map.company_name] в операции."
		if(10)
			directive += "На кону наша репутация. Наносите вред как можно меньшему количеству мирных жителей и невинных людей."
		if(11)
			directive += "На кону наша честь. Используйте только благородную тактику при общении с противниками."
		if(12)
			directive += "В настоящее время мы ведем переговоры с лидером наемников. Маскируйте убийства под самоубийство или другие естественные причины."
		if(13)
			directive += "Некоторые недовольные сотрудники [using_map.company_name] поддерживали нашу деятельность. Остерегайтесь жестокого обращения со стороны командного состава."
		if(14)
			var/xenorace = pick(SPECIES_UNATHI, SPECIES_TAJ, SPECIES_SKRELL)
			directive += "Группа радикалов [xenorace] были верными сторонниками клана Паука. По возможности отдайте предпочтение команде [xenorace]."
		if(15)
			directive += "Клан Паука недавно был обвинен в нечувствительности к религии. Попытайтесь поговорить с священником и доказать ложность этих обвинений."
		if(16)
			directive += "Клан пауков ведет переговоры с конкурирующим производителем протезов. Попробуйте рассказать про протезы  [using_map.company_name] не в лучшем виде."
		if(17)
			directive += "Клан Паука недавно начал вербовать посторонних. Рассмотрите подходящих кандидатов и оцените их поведение в команде."
		if(18)
			directive += "Группа освобождения киборгов проявила интерес к нашим услугам. Докажите, что клан пауков милосерден по отношению к запрещенной законом синтетике."
		else
			directive += "В настоящее время нет никаких специальных дополнительных инструкций."
	return directive
