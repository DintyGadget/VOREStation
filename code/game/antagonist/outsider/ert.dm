var/datum/antagonist/ert/ert

/datum/antagonist/ert
	id = MODE_ERT
	bantype = "Emergency Response Team"
	role_type = BE_OPERATIVE
	role_text = "Emergency Responder"
	role_text_plural = "Emergency Responders"
	welcome_text = "Как член группы реагирования на чрезвычайные ситуации, вы подчиняетесь только своему руководителю и должностным лицам компании."
	antag_sound = 'sound/effects/antag_notice/general_goodie_alert.ogg'
	antag_text = "Вы <b>анти</b> антагонист! В рамках правил постарайтесь, \
		спасти станцию и ее экипаж от продолжающегося кризиса. \
		Постарайтесь, чтобы другие игроки тоже <i>развлекались от вашей игры</i>! Если вы запутались или растерялись, всегда обращайтесь за помощью к администратору, \
		а прежде чем предпринимать крайние меры, попробуйте также связаться с администрацией! \
		Продумайте свои действия и сделайте ролевую игру захватывающей! <b>Пожалуйста, помните, что все правила, \
		кроме некоторых, без явных исключений, применяются к анти антагонистам.</b>"
	leader_welcome_text = "Как руководитель группы реагирования на чрезвычайные ситуации вы отвечаете только перед Компанией и имеете право игнорировать Директора Колонии, если это необходимо для достижения целей вашей миссии. Однако рекомендуется попытаться сотрудничать с ним, когда это возможно."
	landmark_id = "Response Team"
	id_type = /obj/item/weapon/card/id/centcom/ERT

	flags = ANTAG_OVERRIDE_JOB | ANTAG_SET_APPEARANCE | ANTAG_HAS_LEADER | ANTAG_CHOOSE_NAME
	antaghud_indicator = "hudloyalist"

	hard_cap = 5
	hard_cap_round = 7
	initial_spawn_req = 5
	initial_spawn_target = 7

	can_hear_aooc = FALSE // They're the good guys.
	can_speak_aooc = FALSE	// Just in case the above var bugs, or gets touched.

/datum/antagonist/ert/create_default(var/mob/source)
	var/mob/living/carbon/human/M = ..()
	if(istype(M)) M.age = rand(25,45)

/datum/antagonist/ert/New()
	..()
	ert = src

/datum/antagonist/ert/greet(var/datum/mind/player)
	if(!..())
		return
	to_chat(player.current, "Группа реагирования на чрезвычайные ситуации работает для защиты активов; Ваша задача - защищать задницы [using_map.company_name]. На [station_name()], отображается красный код предупреждения, вам нужно пойти и исправить проблему.")
	to_chat(player.current, "Вы должны сначала подготовиться и обсудить план со своей командой. Возможно, присоединятся другие участники, не уходите, пока не будете готовы.")

/datum/antagonist/ert/equip(var/mob/living/carbon/human/player)

	//Special radio setup
	player.equip_to_slot_or_del(new /obj/item/device/radio/headset/ert(src), slot_l_ear)
	player.equip_to_slot_or_del(new /obj/item/clothing/under/ert(src), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/boots/swat(src), slot_shoes)
	player.equip_to_slot_or_del(new /obj/item/clothing/gloves/swat(src), slot_gloves)
	player.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(src), slot_glasses)

	create_id(role_text, player)
	return 1
