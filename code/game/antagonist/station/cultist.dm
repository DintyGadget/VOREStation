var/datum/antagonist/cultist/cult

/proc/iscultist(var/mob/player)
	if(!cult || !player.mind)
		return 0
	if(player.mind in cult.current_antagonists)
		return 1

/datum/antagonist/cultist
	id = MODE_CULTIST
	role_text = "Cultist"
	role_text_plural = "Cultists"
	bantype = "cultist"
	restricted_jobs = list("Chaplain")
	avoid_silicons = TRUE
	protected_jobs = list("Security Officer", "Warden", "Detective", "Internal Affairs Agent", "Head of Security", "Site Manager")
	roundstart_restricted = list("Internal Affairs Agent", "Head of Security", "Site Manager")
	role_type = BE_CULTIST
	feedback_tag = "cult_objective"
	antag_indicator = "cult"
	welcome_text = "У вас есть талисман; тот, который поможет вам создать культ на этой станции. Используйте его эффективно и помните - вы не одиноки."
	antag_sound = 'sound/effects/antag_notice/cult_alert.ogg'
	victory_text = "Культ побеждает! Ему удалось сослужить своим темным хозяевам!"
	loss_text = "Персоналу удалось остановить культ!"
	victory_feedback_tag = "win - cult win"
	loss_feedback_tag = "loss - staff stopped the cult"
	flags = ANTAG_SUSPICIOUS | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	hard_cap = 5
	hard_cap_round = 6
	initial_spawn_req = 4
	initial_spawn_target = 6
	antaghud_indicator = "hudcultist"

	var/allow_narsie = 1
	var/datum/mind/sacrifice_target
	var/list/startwords = list("кровь","присоединение","я","ад")
	var/list/allwords = list("путешествие","я","видимость","ад","кровь","присоединение","технологии","разрушение", "другое", "скрытность")
	var/list/sacrificed = list()
	var/list/harvested = list()

/datum/antagonist/cultist/New()
	..()
	cult = src

/datum/antagonist/cultist/create_global_objectives()

	if(!..())
		return

	global_objectives = list()
	if(prob(50))
		global_objectives |= new /datum/objective/cult/survive
	else
		global_objectives |= new /datum/objective/cult/eldergod

	var/datum/objective/cult/sacrifice/sacrifice = new()
	sacrifice.find_target()
	sacrifice_target = sacrifice.target
	global_objectives |= sacrifice

/datum/antagonist/cultist/equip(var/mob/living/carbon/human/player)

	if(!..())
		return 0

	var/obj/item/weapon/paper/talisman/supply/T = new(get_turf(player))
	var/list/slots = list (
		"backpack" = slot_in_backpack,
		"left pocket" = slot_l_store,
		"right pocket" = slot_r_store,
		"left hand" = slot_l_hand,
		"right hand" = slot_r_hand,
	)
	for(var/slot in slots)
		player.equip_to_slot(T, slot)
		if(T.loc == player)
			break
	var/obj/item/weapon/storage/S = locate() in player.contents
	if(S && istype(S))
		T.loc = S

/datum/antagonist/cultist/greet(var/datum/mind/player)
	if(!..())
		return 0
	grant_runeword(player.current)

/datum/antagonist/cultist/proc/grant_runeword(mob/living/carbon/human/cult_mob, var/word)

	if (!word)
		if(startwords.len > 0)
			word=pick(startwords)
			startwords -= word
		else
			word = pick(allwords)

	// Ensure runes are randomized.
	if(!cultwords["путешествие"])
		runerandom()

	var/wordexp = "[cultwords[word]] это [word]..."
	to_chat(cult_mob, "<span class='warning'>Вы помните одну вещь из темных учений вашего учителя ... [wordexp]</span>")
	cult_mob.mind.store_memory("Вы помните, что <B>[wordexp]</B>", 0, 0)

/datum/antagonist/cultist/remove_antagonist(var/datum/mind/player, var/show_message, var/implanted)
	if(!..())
		return 0
	to_chat(player.current, "<span class='danger'>Незнакомый белый свет вспыхивает в вашем разуме, смывая заразы темного и воспоминания о вашем времени в качестве его слуги.</span>")
	player.memory = ""
	if(show_message)
		player.current.visible_message("<FONT size = 3>[player.current] похоже, что он только что вернулся к своей старой вере!</FONT>")

/datum/antagonist/cultist/add_antagonist(var/datum/mind/player)
	. = ..()
	if(.)
		to_chat(player, "Вы мельком видите Царство Нар-Си, Геометра Крови. Теперь вы видите, насколько хрупок мир, вы видите, что он должен быть открыт для познания Того, Что ждет. Помогите своим новым соотечественникам в их мрачных делах. Их цели - ваши цели, а ваши цели - их цели. Вы служите Темному превыше всего.")
		if(player.current && !istype(player.current, /mob/living/simple_mob/construct))
			player.current.add_language(LANGUAGE_CULT)

/datum/antagonist/cultist/remove_antagonist(var/datum/mind/player, var/show_message, var/implanted)
	. = ..()
	if(. && player.current && !istype(player.current, /mob/living/simple_mob/construct))
		player.current.remove_language(LANGUAGE_CULT)

/datum/antagonist/cultist/can_become_antag(var/datum/mind/player)
	if(!..())
		return 0
	for(var/obj/item/weapon/implant/loyalty/L in player.current)
		if(L && (L.imp_in == player.current))
			return 0
	return 1
