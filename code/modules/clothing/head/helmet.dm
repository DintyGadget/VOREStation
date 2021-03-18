/obj/item/clothing/head/helmet
	name = "Шлем"
	desc = "Стандартный шлем службы безопасности. Защищает голову от ударов."
	icon_state = "helmet"
	valid_accessory_slots = (ACCESSORY_SLOT_HELM_C)
	restricted_accessory_slots = (ACCESSORY_SLOT_HELM_C)
	flags = THICKMATERIAL
	armor = list(melee = 40, bullet = 30, laser = 30, energy = 10, bomb = 10, bio = 0, rad = 0)
	flags_inv = HIDEEARS|BLOCKHEADHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.7
	w_class = ITEMSIZE_NORMAL
	ear_protection = 1
	drop_sound = 'sound/items/drop/helm.ogg'
	pickup_sound = 'sound/items/pickup/helm.ogg'

/obj/item/clothing/head/helmet/solgov
	name = "\improper Solar Confederate Government helmet"
	desc = "A helmet painted in Peacekeeper blue. Stands out like a sore thumb."
	icon_state = "helmet_sol"
	armor = list(melee = 50, bullet = 50, laser = 50,energy = 25, bomb = 30, bio = 0, rad = 0)
	valid_accessory_slots = null

/obj/item/clothing/head/helmet/solgov/command
	name = "command helmet"
	desc = "A helmet with 'Solar Confederate Government' printed on the back in gold lettering."
	icon_state = "helmet_command"

/obj/item/clothing/head/helmet/solgov/security
	name = "security helmet"
	desc = "A helmet with 'MASTER AT ARMS' printed on the back in silver lettering."
	icon_state = "helmet_security"

/obj/item/clothing/head/helmet/nt
	name = "\improper NanoTrasen helmet"
	desc = "A helmet with 'CORPORATE SECURITY' printed on the back in red lettering."
	icon_state = "helmet_nt"

/obj/item/clothing/head/helmet/pcrc
	name = "\improper PCRC helmet"
	desc = "A helmet with 'PRIVATE SECURITY' printed on the back in cyan lettering."
	icon_state = "helmet_pcrc"

//obj/item/clothing/head/helmet/tac
	name = "Тактический шлем"
	desc = "Защитный шлем из упрочнённой керамики. Удобный и прочный."
	icon_state = "helmet_tac"
	armor = list(melee = 50, bullet = 60, laser = 60, energy = 45, bomb = 30, bio = 0, rad = 0)
	siemens_coefficient = 0.6

/obj/item/clothing/head/helmet/merc
	name = "Боевой шлем"
	desc = "Сильно упрочнённый шлем с красными метками. Выглядит так, будто выдержит многое."
	icon_state = "helmet_merc"
	armor = list(melee = 70, bullet = 70, laser = 70, energy = 35, bomb = 30, bio = 0, rad = 0)
	siemens_coefficient = 0.5

/obj/item/clothing/head/helmet/riot
	name = "Милицейский шлем"
	desc = "Этот шлем предназначен для защиты от атак ближнего боя."
	icon_state = "riot"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	armor = list(melee = 80, bullet = 10, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.7
	valid_accessory_slots = null
	action_button_name = "Переключить Визор"

/obj/item/clothing/head/helmet/riot/attack_self(mob/user as mob)
	if(src.icon_state == initial(icon_state))
		src.icon_state = "[icon_state]up"
		to_chat(user, "Вы приподнимаете визор милицейского шлема.")
	else
		src.icon_state = initial(icon_state)
		to_chat(user, "Вы опускаете визор милицейского шлема.")
	update_clothing_icon()	//so our mob-overlays update

/obj/item/clothing/head/helmet/laserproof
	name = "Абляционный шлем"
	desc = "Этот шлем предназначен для защиты от энергетических снарядов."
	icon_state = "helmet_reflec"
	item_state_slots = list(slot_r_hand_str = "helmet", slot_l_hand_str = "helmet")
	armor = list(melee = 10, bullet = 10, laser = 80 ,energy = 50, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.1
	valid_accessory_slots = null

/obj/item/clothing/head/helmet/bulletproof
	name = "Пуленепробиваемый шлем"
	desc = "Этот шлем предназначен для защиты от баллистических снарядов"
	icon_state = "helmet_bulletproof"
	item_state_slots = list(slot_r_hand_str = "helmet", slot_l_hand_str = "helmet")
	armor = list(melee = 10, bullet = 80, laser = 10 ,energy = 10, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.7
	valid_accessory_slots = null

/obj/item/clothing/head/helmet/combat
	name = "Боевой шлем"
	desc = "Это военный шлем общего назначения, защищающий голову от самых распространённых угроз."
	icon_state = "helmet_combat"
	item_state_slots = list(slot_r_hand_str = "helmet", slot_l_hand_str = "helmet")
	armor = list(melee = 50, bullet = 50, laser = 50 ,energy = 30, bomb = 30, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES|BLOCKHEADHAIR
	siemens_coefficient = 0.6
	valid_accessory_slots = null

/obj/item/clothing/head/helmet/flexitac
	name = "Лёгкий тактический шлем"
	desc = "Защитный шлем из упрочнённой керамики со встроенным тактическим фонариком."
	icon_state = "flexitac"
	armor = list(melee = 40, bullet = 40, laser = 60, energy = 35, bomb = 30, bio = 0, rad = 0)
	siemens_coefficient = 0.6
	brightness_on = 6
	light_overlay = "helmet_light_dual_green"
	action_button_name = "Переключить Фонарик"
	min_cold_protection_temperature = T0C - 20
	cold_protection = HEAD

/obj/item/clothing/head/helmet/explorer
	name = "explorer hood"
	desc = "An armoured hood for exploring harsh environments."
	icon_state = "explorer"
	flags = THICKMATERIAL
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.9
	armor = list(melee = 30, bullet = 20, laser = 20, energy = 20, bomb = 35, bio = 75, rad = 35)

/obj/item/clothing/head/helmet/swat
	name = "Шлем СОБР"
	desc = "Такие часто используются элитными офицерами СОБР."
	icon_state = "swat"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 10, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES|BLOCKHEADHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.5

/obj/item/clothing/head/helmet/alien
	name = "Инопланетный шлем"
	desc = "Он гораздо больше Вашей головы, но все равно защитит."
	icon_state = "alienhelmet"
	siemens_coefficient = 0.4
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 50, bomb = 50, bio = 0, rad = 40)
	valid_accessory_slots = null

/obj/item/clothing/head/helmet/alien/tank
	name = "Военный инопланетный шлем"
	armor = list(melee = 70, bullet = 70, laser = 70, energy = 70, bomb = 70, bio = 0, rad = 40)

/obj/item/clothing/head/helmet/thunderdome
	name = "Шлем Громарены"
	desc = "<i>'Да начнётся битва!'</i>"
	icon_state = "thunderdome"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 25, bio = 10, rad = 0)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 1

/obj/item/clothing/head/helmet/gladiator
	name = "Шлем гладиатора"
	desc = "Ave, Imperator, morituri te salutant."
	icon_state = "gladiator"
	item_state_slots = list(slot_r_hand_str = "vhelmet", slot_l_hand_str = "vhelmet")
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR
	siemens_coefficient = 1
	valid_accessory_slots = null

/obj/item/clothing/head/helmet/tactical
	name = "Тактический шлем"
	desc = "Бронированный шлем, в который возможно поместить дополнительные примочки."
	icon_state = "swathelm"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	sprite_sheets = list(
		SPECIES_TAJ = 'icons/mob/species/tajaran/helmet.dmi',
		SPECIES_UNATHI = 'icons/mob/species/unathi/helmet.dmi',
		)

	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)
	flags_inv = HIDEEARS|BLOCKHAIR
	siemens_coefficient = 0.7
	valid_accessory_slots = null

/obj/item/clothing/head/helmet/augment
	name = "Модифицированный шлем"
	desc = "Шлем, обладающий с оптическими и черепными модификациями."
	icon_state = "v62"
	item_state_slots = list(slot_r_hand_str = "head_m", slot_l_hand_str = "head_m")
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 10, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES|BLOCKHEADHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.5
	valid_accessory_slots = null

//Non-hardsuit ERT helmets.
/obj/item/clothing/head/helmet/ert
	name = "emergency response team helmet"
	desc = "An in-atmosphere helmet worn by members of the NanoTrasen Emergency Response Team. Protects the head from impacts."
	icon_state = "erthelmet_cmd"
	item_state_slots = list(slot_r_hand_str = "syndicate-helm-green", slot_l_hand_str = "syndicate-helm-green")
	armor = list(melee = 62, bullet = 50, laser = 50,energy = 35, bomb = 10, bio = 2, rad = 0)
	valid_accessory_slots = null

//Commander
/obj/item/clothing/head/helmet/ert/command
	name = "emergency response team commander helmet"
	desc = "An in-atmosphere helmet worn by the commander of a NanoTrasen Emergency Response Team. Has blue highlights."

//Security
/obj/item/clothing/head/helmet/ert/security
	name = "emergency response team security helmet"
	desc = "An in-atmosphere helmet worn by security members of the NanoTrasen Emergency Response Team. Has red highlights."
	icon_state = "erthelmet_sec"

//Engineer
/obj/item/clothing/head/helmet/ert/engineer
	name = "emergency response team engineer helmet"
	desc = "An in-atmosphere helmet worn by engineering members of the NanoTrasen Emergency Response Team. Has orange highlights."
	icon_state = "erthelmet_eng"

//Medical
/obj/item/clothing/head/helmet/ert/medical
	name = "emergency response team medical helmet"
	desc = "A set of armor worn by medical members of the NanoTrasen Emergency Response Team. Has red and white highlights."
	icon_state = "erthelmet_med"
