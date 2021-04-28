// Hooded suits

//Hoods for winter coats and chaplain hoodie etc

/obj/item/clothing/suit/storage/hooded
	var/obj/item/clothing/head/hood
	var/hoodtype = null //so the chaplain hoodie or other hoodies can override this
	var/hood_up = FALSE
	var/toggleicon
	action_button_name = "Отрегулировать Капюшон"

/obj/item/clothing/suit/storage/hooded/New()
	toggleicon = "[initial(icon_state)]"
	MakeHood()
	..()

/obj/item/clothing/suit/storage/hooded/Destroy()
	qdel(hood)
	return ..()

/obj/item/clothing/suit/storage/hooded/proc/MakeHood()
	if(!hood)
		var/obj/item/clothing/head/hood/H = new hoodtype(src)
		hood = H

/obj/item/clothing/suit/storage/hooded/ui_action_click()
	ToggleHood()

/obj/item/clothing/suit/storage/hooded/equipped(mob/user, slot)
	if(slot != slot_wear_suit)
		RemoveHood()
	..()

/obj/item/clothing/suit/storage/hooded/proc/RemoveHood()
	icon_state = toggleicon
	hood_up = FALSE
	hood.canremove = TRUE // This shouldn't matter anyways but just incase.
	if(ishuman(hood.loc))
		var/mob/living/carbon/H = hood.loc
		H.unEquip(hood, 1)
		H.update_inv_wear_suit()
	hood.forceMove(src)

/obj/item/clothing/suit/storage/hooded/dropped()
	RemoveHood()

/obj/item/clothing/suit/storage/hooded/proc/ToggleHood()
	if(!hood_up)
		if(ishuman(loc))
			var/mob/living/carbon/human/H = src.loc
			if(H.wear_suit != src)
				to_chat(H, "<span class='warning'>Нужно сперва надеть на себя [ru_getcase(src, "acase")]!</span>")
				return
			if(H.head)
				to_chat(H, "<span class='warning'>У Вас уже надето что-то на голову!</span>")
				return
			else
				H.equip_to_slot_if_possible(hood,slot_head,0,0,1)
				hood_up = TRUE
				hood.canremove = FALSE
				icon_state = "[toggleicon]_t"
				H.update_inv_wear_suit()
	else
		RemoveHood()

/obj/item/clothing/suit/storage/hooded/carp_costume
	name = "Костюм карпа"
	desc = "Костюм, изготовленный из 'синтетической' чешуи карпа. Воняет."
	icon_state = "carp_casual"
	item_state_slots = list(slot_r_hand_str = "carp_casual", slot_l_hand_str = "carp_casual") //Does not exist -S2-
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	flags_inv = HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	cold_protection = UPPER_TORSO|LOWER_TORSO|ARMS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE	//Space carp like space, so you should too
	action_button_name = "Отрегулировать Капюшон Карпа"
	hoodtype = /obj/item/clothing/head/hood/carp_hood

/obj/item/clothing/suit/storage/hooded/ian_costume	//It's Ian, rub his bell- oh god what happened to his inside parts?
	name = "Костюм корги"
	desc = "Костюм, исполненный в виде человекоподобного корги. Не гарантирует, что Вам погладят пузик."
	icon_state = "ian"
	item_state_slots = list(slot_r_hand_str = "ian", slot_l_hand_str = "ian") //Does not exist -S2-
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	flags_inv = HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	action_button_name = "Отрегулировать Капюшон Иана"
	hoodtype = /obj/item/clothing/head/hood/ian_hood

/obj/item/clothing/suit/storage/hooded/wintercoat
	name = "Зимнее пальто"
	desc = "Тяжелая верхняя одежда, изготовленная из 'синтетической' шерсти."
	icon_state = "coatwinter"
	item_state_slots = list(slot_r_hand_str = "coatwinter", slot_l_hand_str = "coatwinter")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	flags_inv = HIDEHOLSTER
	cold_protection = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	hoodtype = /obj/item/clothing/head/hood/winter
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes,
	/obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit)

/obj/item/clothing/suit/storage/hooded/wintercoat/captain
	name = "Зимнее пальто Директора колонии"
	icon_state = "coatcaptain"
	item_state_slots = list(slot_r_hand_str = "coatcaptain", slot_l_hand_str = "coatcaptain")
	armor = list(melee = 20, bullet = 15, laser = 20, energy = 10, bomb = 15, bio = 0, rad = 0)
	hoodtype = /obj/item/clothing/head/hood/winter/captain
	allowed =  list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes,
	/obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/weapon/gun/energy,
	/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,
	/obj/item/weapon/handcuffs,/obj/item/clothing/head/helmet)

/obj/item/clothing/suit/storage/hooded/wintercoat/security
	name = "Зимнее пальто службы безопасности"
	icon_state = "coatsecurity"
	item_state_slots = list(slot_r_hand_str = "coatsecurity", slot_l_hand_str = "coatsecurity")
	armor = list(melee = 25, bullet = 20, laser = 20, energy = 15, bomb = 20, bio = 0, rad = 0)
	hoodtype = /obj/item/clothing/head/hood/winter/security
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes,
	/obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/weapon/gun/energy,
	/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,
	/obj/item/weapon/handcuffs,/obj/item/clothing/head/helmet)

/obj/item/clothing/suit/storage/hooded/wintercoat/medical
	name = "Зимнее пальто врача"
	icon_state = "coatmedical"
	item_state_slots = list(slot_r_hand_str = "coatmedical", slot_l_hand_str = "coatmedical")
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 50, rad = 0)
	hoodtype = /obj/item/clothing/head/hood/winter/medical
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes,
	/obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/device/analyzer,/obj/item/stack/medical,
	/obj/item/weapon/dnainjector,/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,/obj/item/weapon/reagent_containers/hypospray,
	/obj/item/device/healthanalyzer,/obj/item/weapon/reagent_containers/glass/bottle,/obj/item/weapon/reagent_containers/glass/beaker,
	/obj/item/weapon/reagent_containers/pill,/obj/item/weapon/storage/pill_bottle)

/obj/item/clothing/suit/storage/hooded/wintercoat/science
	name = "Зимнее пальто учёного"
	icon_state = "coatscience"
	item_state_slots = list(slot_r_hand_str = "coatscience", slot_l_hand_str = "coatscience")
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)
	hoodtype = /obj/item/clothing/head/hood/winter/science
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes,
	/obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/device/analyzer,/obj/item/stack/medical,
	/obj/item/weapon/dnainjector,/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,/obj/item/weapon/reagent_containers/hypospray,
	/obj/item/device/healthanalyzer,/obj/item/weapon/reagent_containers/glass/bottle,/obj/item/weapon/reagent_containers/glass/beaker,
	/obj/item/weapon/reagent_containers/pill,/obj/item/weapon/storage/pill_bottle)

/obj/item/clothing/suit/storage/hooded/wintercoat/engineering
	name = "Зимнее пальто инженера"
	icon_state = "coatengineer"
	item_state_slots = list(slot_r_hand_str = "coatengineer", slot_l_hand_str = "coatengineer")
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 20)
	hoodtype = /obj/item/clothing/head/hood/winter/engineering
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes,
	/obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/device/analyzer, /obj/item/device/flashlight,
	/obj/item/device/multitool, /obj/item/device/pipe_painter, /obj/item/device/radio, /obj/item/device/t_scanner, /obj/item/weapon/tool/crowbar, /obj/item/weapon/tool/screwdriver,
	/obj/item/weapon/weldingtool, /obj/item/weapon/tool/wirecutters, /obj/item/weapon/tool/wrench, /obj/item/weapon/tank/emergency/oxygen, /obj/item/clothing/mask/gas, /obj/item/taperoll/engineering)

/obj/item/clothing/suit/storage/hooded/wintercoat/engineering/atmos
	name = "Зимнее пальто атмосферщика"
	icon_state = "coatatmos"
	item_state_slots = list(slot_r_hand_str = "coatatmos", slot_l_hand_str = "coatatmos")
	hoodtype = /obj/item/clothing/head/hood/winter/engineering/atmos

/obj/item/clothing/suit/storage/hooded/wintercoat/hydro
	name = "Зимнее пальто ботаника"
	icon_state = "coathydro"
	item_state_slots = list(slot_r_hand_str = "coathydro", slot_l_hand_str = "coathydro")
	hoodtype = /obj/item/clothing/head/hood/winter/hydro
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes,
	/obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/weapon/reagent_containers/spray/plantbgone,
	/obj/item/device/analyzer/plant_analyzer, /obj/item/seeds, /obj/item/weapon/reagent_containers/glass/bottle, /obj/item/weapon/material/minihoe)

/obj/item/clothing/suit/storage/hooded/wintercoat/cargo
	name = "Зимнее пальто грузчика"
	icon_state = "coatcargo"
	item_state_slots = list(slot_r_hand_str = "coatcargo", slot_l_hand_str = "coatcargo")
	hoodtype = /obj/item/clothing/head/hood/winter/cargo

/obj/item/clothing/suit/storage/hooded/wintercoat/miner
	name = "Зимнее пальто шахтёра"
	icon_state = "coatminer"
	item_state_slots = list(slot_r_hand_str = "coatminer", slot_l_hand_str = "coatminer")
	armor = list(melee = 10, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	hoodtype = /obj/item/clothing/head/hood/winter/miner
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches,
	/obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/weapon/tank, /obj/item/device/radio, /obj/item/weapon/pickaxe, /obj/item/weapon/storage/bag/ore)

/obj/item/clothing/suit/storage/hooded/explorer
	name = "Костюм искателя"
	desc = "Бронированный костюм для исследования в суровых условиях."
	icon_state = "explorer"
	item_state = "explorer"
	flags = THICKMATERIAL
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	hoodtype = /obj/item/clothing/head/hood/explorer
	siemens_coefficient = 0.9
	armor = list(melee = 30, bullet = 20, laser = 20, energy = 20, bomb = 35, bio = 75, rad = 35) // Inferior to sec vests in bullet/laser but better for environmental protection.
	allowed = list(
		/obj/item/device/flashlight,
		/obj/item/weapon/gun,
		/obj/item/ammo_magazine,
		/obj/item/weapon/melee,
		/obj/item/weapon/material/knife,
		/obj/item/weapon/tank,
		/obj/item/device/radio,
		/obj/item/weapon/pickaxe
		)