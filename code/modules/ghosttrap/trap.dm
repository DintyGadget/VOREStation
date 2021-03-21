// This system is used to grab a ghost from observers with the required preferences and
// lack of bans set. See posibrain.dm for an example of how they are called/used. ~Z

var/list/ghost_traps

proc/get_ghost_trap(var/trap_key)
	if(!ghost_traps)
		populate_ghost_traps()
	return ghost_traps[trap_key]

proc/populate_ghost_traps()
	ghost_traps = list()
	for(var/traptype in typesof(/datum/ghosttrap))
		var/datum/ghosttrap/G = new traptype
		ghost_traps[G.object] = G

/datum/ghosttrap
	var/object = "positronic brain"
	var/list/ban_checks = list("AI","Cyborg")
	var/pref_check = BE_AI
	var/ghost_trap_message = "Сейчас они занимают позитронный мозг."
	var/ghost_trap_role = "Positronic Brain"

// Check for bans, proper atom types, etc.
/datum/ghosttrap/proc/assess_candidate(var/mob/observer/dead/candidate)
	if(!istype(candidate) || !candidate.client || !candidate.ckey)
		return 0
	if(!candidate.MayRespawn())
		to_chat(candidate, "Вы использовали AntagHUD и, следовательно, не можете войти в игру как [object].")
		return 0
	if(islist(ban_checks))
		for(var/bantype in ban_checks)
			if(jobban_isbanned(candidate, "[bantype]"))
				to_chat(candidate, "Вам запрещена одна или несколько обязательных ролей, и поэтому вы не можете войти в игру в качестве [object].")
				return 0
	return 1

// Print a message to all ghosts with the right prefs/lack of bans.
/datum/ghosttrap/proc/request_player(var/mob/target, var/request_string)
	if(!target)
		return
	for(var/mob/observer/dead/O in player_list)
		if(!O.MayRespawn())
			continue
		if(islist(ban_checks))
			for(var/bantype in ban_checks)
				if(jobban_isbanned(O, "[bantype]"))
					continue
		if(pref_check && !(O.client.prefs.be_special & pref_check))
			continue
		if(O.client)
			to_chat(O, "[request_string]<a href='?src=\ref[src];candidate=\ref[O];target=\ref[target]'>Нажмите</a> чтобы выбрать эфу опцию.")

// Handles a response to request_player().
/datum/ghosttrap/Topic(href, href_list)
	if(..())
		return 1
	if(href_list["candidate"] && href_list["target"])
		var/mob/observer/dead/candidate = locate(href_list["candidate"]) // BYOND magic.
		var/mob/target = locate(href_list["target"])                     // So much BYOND magic.
		if(!target || !candidate)
			return
		if(candidate == usr && assess_candidate(candidate) && !target.ckey)
			transfer_personality(candidate,target)
		return 1

// Shunts the ckey/mind into the target mob.
/datum/ghosttrap/proc/transfer_personality(var/mob/candidate, var/mob/target)
	if(!assess_candidate(candidate))
		return 0
	target.ckey = candidate.ckey
	if(target.mind)
		target.mind.assigned_role = "[ghost_trap_role]"
	announce_ghost_joinleave(candidate, 0, "[ghost_trap_message]")
	welcome_candidate(target)
	set_new_name(target)
	return 1

// Fluff!
/datum/ghosttrap/proc/welcome_candidate(var/mob/target)
	to_chat(target, "<b>Вы - позитронный мозг, появившийся на [station_name()].</b>")
	to_chat(target, "<b>Как синтетический интеллект, вы отвечаете перед всеми членами экипажа, а также перед ИИ.</b>")
	to_chat(target, "<b>Помните, цель вашего существования - служить экипажу и станции. Прежде всего, не навредидть.</b>")
	to_chat(target, "<b>Используйте #b, чтобы общаться с другими искусственными интеллектами.</b>")
	var/turf/T = get_turf(target)
	T.visible_message("<span class='notice'>[src] тихо дзынькает.</span>")
	var/obj/item/device/mmi/digital/posibrain/P = target.loc
	if(!istype(P)) //wat
		return
	P.searching = 0
	P.name = "positronic brain ([P.brainmob.name])"
	P.icon_state = "posibrain-occupied"

// Allows people to set their own name. May or may not need to be removed for posibrains if people are dumbasses.
/datum/ghosttrap/proc/set_new_name(var/mob/target)
	var/newname = sanitizeSafe(input(target,"Введите имя или оставьте поле пустым для имени по умолчанию.", "Name change","") as text, MAX_NAME_LEN)
	if (newname != "")
		target.real_name = newname
		target.name = target.real_name

// Doona pods and walking mushrooms.
/datum/ghosttrap/plant
	object = "living plant"
	ban_checks = list("Dionaea")
	pref_check = BE_PLANT
	ghost_trap_message = "Сейчас они занимают живое растение."
	ghost_trap_role = "Plant"

/datum/ghosttrap/plant/welcome_candidate(var/mob/target)
	to_chat(target, "<span class='alium'><B>Вы медленно просыпаетесь, переходя в медленное движение, пока вас ласкает воздух.</B></span>")
	// This is a hack, replace with some kind of species blurb proc.
	if(istype(target,/mob/living/carbon/alien/diona))
		to_chat(target, "<B>Вы [target], один из расы дрейфующих межзвездных существ, похожих на растения, которые иногда делятся своими семенами с людьми-торговцами.</B>")
		to_chat(target, "<B>Слишком много тьмы вызовет у вас шок и голод, но свет поможет вам исцелиться.</B>")