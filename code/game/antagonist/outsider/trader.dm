var/datum/antagonist/trader/traders

/datum/antagonist/trader
	id = MODE_TRADE
	role_type = BE_OPERATIVE
	role_text = "Trader"
	role_text_plural = "Traders"
	welcome_text = "Как член экипажа Беруанг, вы отвечаете своему капитану и международным космическим законам."
	antag_sound = 'sound/effects/antag_notice/general_goodie_alert.ogg'
	antag_text = "Вы <b>не антагонист</b>, а посетитель! В рамках правил, \
		постарайтесь обеспечить интересное взаимодействие для экипажа. \
		Постарайтесь, чтобы другие игроки тоже <i>развлекались от вашей игры</i>! Если вы запутались или растерялись, всегда обращайтесь за помощью к администратору, \
		а прежде чем предпринимать крайние меры, попробуйте также связаться с администрацией! \
		Продумайте свои действия и сделайте ролевую игру захватывающей! <b>Пожалуйста, помните, что все правила, \
		так же применяются к вам</b>"
	leader_welcome_text = "Как капитан Беруанга, вы контролируете свою команду и груз. Возможно, стоит вкратце обсудить общую предысторию с вашей командой."
	landmark_id = "Trader"

	id_type = /obj/item/weapon/card/id/external

	flags = ANTAG_OVERRIDE_JOB | ANTAG_SET_APPEARANCE | ANTAG_HAS_LEADER | ANTAG_CHOOSE_NAME

	hard_cap = 5
	hard_cap_round = 7
	initial_spawn_req = 5
	initial_spawn_target = 7

	can_speak_aooc = FALSE // They're not real antags.

/datum/antagonist/trader/create_default(var/mob/source)
	var/mob/living/carbon/human/M = ..()
	if(istype(M)) M.age = rand(25,45)

/datum/antagonist/trader/New()
	..()
	traders = src

/datum/antagonist/trader/greet(var/datum/mind/player)
	if(!..())
		return
	to_chat(player.current, "Беруанг является независимым грузовым перевозчиком, если вы не решите иначе. Вы на пути к [station_name()].")
	to_chat(player.current, "Вы можете обсудить коллективную историю с остальной частью вашей команды. Возможно, присоединятся другие участники, так что не уходите сразу же!")

/datum/antagonist/trader/equip(var/mob/living/carbon/human/player)
	player.equip_to_slot_or_del(new /obj/item/clothing/under/rank/cargotech(src), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(src), slot_shoes)
	player.equip_to_slot_or_del(new /obj/item/clothing/gloves/brown(src), slot_gloves)
	player.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(src), slot_glasses)

	create_radio(PUB_FREQ, player) //Assume they tune their headsets into the station's public radio as they approach

	var/obj/item/weapon/card/id/id = create_id("Trader", player, equip = 0)
	id.name = "[player.real_name]'s Passport"
	id.assignment = "Trader"
	id.access |= access_trader
	var/obj/item/weapon/storage/wallet/W = new(player)
	W.handle_item_insertion(id)
	player.equip_to_slot_or_del(W, slot_wear_id)
	spawn_money(rand(50,150)*10,W)

	return 1

/datum/antagonist/trader/update_access(var/mob/living/player)
	for(var/obj/item/weapon/storage/wallet/W in player.contents)
		for(var/obj/item/weapon/card/id/id in W.contents)
			id.name = "[player.real_name]'s Passport"
			id.registered_name = player.real_name
			W.name = "[initial(W.name)] ([id.name])"