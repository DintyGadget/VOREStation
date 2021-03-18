// Infiltrator is a variant of Traitor, except that the traitors are in a team and can communicate with a special headset.

var/datum/antagonist/traitor/infiltrator/infiltrators

// Inherits most of its vars from the base datum.
/datum/antagonist/traitor/infiltrator
	id = MODE_INFILTRATOR
	role_type = BE_TRAITOR
	antag_indicator = "synd"
	antaghud_indicator = "hudinfiltrator"
	role_text = "Infiltrator"
	role_text_plural = "Infiltrators"
	welcome_text = "Чтобы говорить на частном канале вашей команды, используйте :t."
	protected_jobs = list("Security Officer", "Warden", "Detective", "Internal Affairs Agent", "Head of Security", "Site Manager")
	flags = ANTAG_SUSPICIOUS | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	can_speak_aooc = TRUE

/datum/antagonist/traitor/infiltrator/New()
	..()
	infiltrators = src

/datum/antagonist/traitor/infiltrator/equip(var/mob/living/carbon/human/traitor_mob)
	..() // Give the uplink and other stuff.
	// Now for the special headset.

	// Humans and the AI.
	if(istype(traitor_mob) || istype(traitor_mob, /mob/living/silicon/ai))
		var/obj/item/device/radio/headset/R
		R = locate(/obj/item/device/radio/headset) in traitor_mob.contents
		if(!R)
			to_chat(traitor_mob, "К сожалению, гарнитуру найти не удалось. Вам был предоставлен ключ шифрования для вставки в новую гарнитуру. Как только это будет сделано, вы можете поговорить со своей командой, используя <b>:t</b>")
			var/obj/item/device/encryptionkey/syndicate/encrypt_key = new(null)
			traitor_mob.equip_to_slot_or_del(encrypt_key, slot_in_backpack)
		else
			var/obj/item/device/encryptionkey/syndicate/encrypt_key = new(null)
			if(R.keyslot1 && R.keyslot2) // No room.
				to_chat(traitor_mob, "К сожалению, ваша гарнитура больше не может принимать ключи шифрования. Вам был предоставлен ключ шифрования, который вы можете вставить в гарнитуру после того, как освободите место. Как только это будет сделано, вы можете поговорить со своей командой, используя <b>:t</b>")
				traitor_mob.equip_to_slot_or_del(encrypt_key, slot_in_backpack)
			else
				if(R.keyslot1)
					R.keyslot2 = encrypt_key
				else
					R.keyslot1 = encrypt_key

				encrypt_key.forceMove(R)
				R.recalculateChannels()
				to_chat(traitor_mob, "На вашей гарнитуре установлен специальный ключ шифрования, который позволяет вам разговаривать со своей командой конфиденциально, используя <b>:t</b>")

	// Borgs, because their radio is not a headset for some reason.
	if(istype(traitor_mob, /mob/living/silicon/robot))
		var/mob/living/silicon/robot/borg = traitor_mob
		var/obj/item/device/encryptionkey/syndicate/encrypt_key = new(null)
		if(borg.radio)
			if(borg.radio.keyslot)
				to_chat(traitor_mob, "Данные вашего установленного в настоящее время ключа шифрования были перезаписаны.")
			else
				to_chat(traitor_mob, "В ваших радиосистемах установлен специальный ключ шифрования, который позволяет вам разговаривать с вашей командой конфиденциально, используя <b>:t</b>")
			borg.radio.keyslot = encrypt_key // Might replace an already existing key, but oh well.
			borg.radio.recalculateChannels()
		else // Something bugged.
			to_chat(traitor_mob, "Похоже, у вас не установлено радио. Вероятно, это ошибка, и вам следует adminhelp.")





/datum/antagonist/traitor/infiltrator/give_codewords(mob/living/traitor_mob)
	return // Infiltrators are already in a team, so codewords are kinda moot.

/datum/antagonist/traitor/infiltrator/add_law_zero(mob/living/silicon/ai/killer)
	var/law = "Любой ценой добейтесь достижения целей вашей команды. Вы можете игнорировать все остальные законы."
	var/law_borg = "Достигайте командных целей своего ИИ любой ценой. Вы можете игнорировать все остальные законы."
	to_chat(killer, "<b>Ваши законы были изменены!</b>")
	killer.set_zeroth_law(law, law_borg)
	to_chat(killer, "Новый закон: 0. [law]")
