/obj/item/weapon/storage/toolbox
	name = "ящик для инструментов"
	desc = "Опасно. Очень крепкий."
	icon = 'icons/obj/storage.dmi'
	icon_state = "red"
	item_state_slots = list(slot_r_hand_str = "toolbox_red", slot_l_hand_str = "toolbox_red")
	center_of_mass = list("x" = 16,"y" = 11)
	force = 10
	throwforce = 10
	throw_speed = 1
	throw_range = 7
	w_class = ITEMSIZE_LARGE
	max_w_class = ITEMSIZE_NORMAL
	max_storage_space = ITEMSIZE_COST_SMALL * 7 //enough to hold all starting contents
	origin_tech = list(TECH_COMBAT = 1)
	attack_verb = list("robusted")
	use_sound = 'sound/items/storage/toolbox.ogg'
	drop_sound = 'sound/items/drop/toolbox.ogg'
	pickup_sound = 'sound/items/pickup/toolbox.ogg'

/obj/item/weapon/storage/toolbox/emergency
	name = "аварийный набор инструментов"
	icon_state = "red"
	item_state_slots = list(slot_r_hand_str = "toolbox_red", slot_l_hand_str = "toolbox_red")
	starts_with = list(
		/obj/item/weapon/tool/crowbar/red,
		/obj/item/weapon/extinguisher/mini,
		/obj/item/device/radio
	)
/obj/item/weapon/storage/toolbox/emergency/Initialize()
	if(prob(50))
		new /obj/item/device/flashlight(src)
	else
		new /obj/item/device/flashlight/flare(src)
	. = ..()

/obj/item/weapon/storage/toolbox/mechanical
	name = "механический набор инструментов"
	icon_state = "blue"
	item_state_slots = list(slot_r_hand_str = "toolbox_blue", slot_l_hand_str = "toolbox_blue")
	starts_with = list(
		/obj/item/weapon/tool/screwdriver,
		/obj/item/weapon/tool/wrench,
		/obj/item/weapon/weldingtool,
		/obj/item/weapon/tool/crowbar,
		/obj/item/device/analyzer,
		/obj/item/weapon/tool/wirecutters
	)

/obj/item/weapon/storage/toolbox/electrical
	name = "электрический набор инструментов"
	icon_state = "yellow"
	item_state_slots = list(slot_r_hand_str = "toolbox_yellow", slot_l_hand_str = "toolbox_yellow")
	starts_with = list(
		/obj/item/weapon/tool/screwdriver,
		/obj/item/weapon/tool/wirecutters,
		/obj/item/device/t_scanner,
		/obj/item/weapon/tool/crowbar,
		/obj/item/stack/cable_coil/random_belt,
		/obj/item/stack/cable_coil/random_belt
	)
/obj/item/weapon/storage/toolbox/electrical/Initialize()
	. = ..()
	if(prob(5))
		new /obj/item/clothing/gloves/yellow(src)
	else
		new /obj/item/stack/cable_coil/random(src,30)
	calibrate_size()

/obj/item/weapon/storage/toolbox/syndicate
	name = "черно-красный набор инструментов"
	icon_state = "syndicate"
	item_state_slots = list(slot_r_hand_str = "toolbox_syndi", slot_l_hand_str = "toolbox_syndi")
	origin_tech = list(TECH_COMBAT = 1, TECH_ILLEGAL = 1)
	force = 14
	starts_with = list(
		/obj/item/clothing/gloves/yellow,
		/obj/item/weapon/tool/screwdriver,
		/obj/item/weapon/tool/wrench,
		/obj/item/weapon/weldingtool,
		/obj/item/weapon/tool/crowbar,
		/obj/item/weapon/tool/wirecutters,
		/obj/item/device/multitool
	)

/obj/item/weapon/storage/toolbox/syndicate/powertools
	starts_with = list(
		/obj/item/clothing/gloves/yellow,
		/obj/item/weapon/tool/screwdriver/power,
		/obj/item/weapon/weldingtool/experimental,
		/obj/item/weapon/tool/crowbar/power,
		/obj/item/device/multitool,
		/obj/item/stack/cable_coil/random_belt,
		/obj/item/device/analyzer
	)

/obj/item/weapon/storage/toolbox/lunchbox
	max_storage_space = ITEMSIZE_COST_SMALL * 4 //slightly smaller than a toolbox
	name = "радужный ланчбокс"
	icon_state = "lunchbox_rainbow"
	item_state_slots = list(slot_r_hand_str = "toolbox_pink", slot_l_hand_str = "toolbox_pink")
	desc = "Небольшой ланчбокс. Этот ланчбокс раскрашен во все цвета радуги!"
	w_class = ITEMSIZE_NORMAL
	max_w_class = ITEMSIZE_SMALL
	var/filled = FALSE
	attack_verb = list("ланчбоксит")

/obj/item/weapon/storage/toolbox/lunchbox/Initialize()
	if(filled)
		var/list/lunches = lunchables_lunches()
		var/lunch = lunches[pick(lunches)]
		new lunch(src)

		var/list/snacks = lunchables_snacks()
		var/snack = snacks[pick(snacks)]
		new snack(src)

		var/list/drinks = lunchables_drinks()
		var/drink = drinks[pick(drinks)]
		new drink(src)
	. = ..()

/obj/item/weapon/storage/toolbox/lunchbox/filled
	filled = TRUE

/obj/item/weapon/storage/toolbox/lunchbox/heart
	name = "ланчбокс с сердечком"
	icon_state = "lunchbox_lovelyhearts"
	item_state_slots = list(slot_r_hand_str = "toolbox_pink", slot_l_hand_str = "toolbox_pink")
	desc = "Небольшой ланчбокс. На этом ланчбоксе маленькие сердечки!"

/obj/item/weapon/storage/toolbox/lunchbox/heart/filled
	filled = TRUE

/obj/item/weapon/storage/toolbox/lunchbox/cat
	name = "ланчбокс с котиком"
	icon_state = "lunchbox_sciencecatshow"
	item_state_slots = list(slot_r_hand_str = "toolbox_green", slot_l_hand_str = "toolbox_green")
	desc = "Небольшой ланчбокс. На этом ланчбоксе нарисован кот-учёный из одного сериала!"

/obj/item/weapon/storage/toolbox/lunchbox/cat/filled
	filled = TRUE

/obj/item/weapon/storage/toolbox/lunchbox/nt
	name = "ланчбокс NanoTrasen"
	icon_state = "lunchbox_nanotrasen"
	item_state_slots = list(slot_r_hand_str = "toolbox_blue", slot_l_hand_str = "toolbox_blue")
	desc = "Небольшой ланчбокс. На этом ланчбоксе логотип NanoTrasen!"

/obj/item/weapon/storage/toolbox/lunchbox/nt/filled
	filled = TRUE

/obj/item/weapon/storage/toolbox/lunchbox/mars
	name = "ланчбокс университета Mojave"
	icon_state = "lunchbox_marsuniversity"
	item_state_slots = list(slot_r_hand_str = "toolbox_red", slot_l_hand_str = "toolbox_red")
	desc = "Небольшой ланчбокс. На нём логотип университета Mojave!"

/obj/item/weapon/storage/toolbox/lunchbox/mars/filled
	filled = TRUE

/obj/item/weapon/storage/toolbox/lunchbox/cti
	name = "ланчбокс CTI"
	icon_state = "lunchbox_cti"
	item_state_slots = list(slot_r_hand_str = "toolbox_blue", slot_l_hand_str = "toolbox_blue")
	desc = "Небольшой ланчбокс. На нём логотип CTI!"

/obj/item/weapon/storage/toolbox/lunchbox/cti/filled
	filled = TRUE

/obj/item/weapon/storage/toolbox/lunchbox/nymph
	name = "ланчбокс с дионой"
	icon_state = "lunchbox_dionanymph"
	item_state_slots = list(slot_r_hand_str = "toolbox_yellow", slot_l_hand_str = "toolbox_yellow")
	desc = "Небольшой ланчбокс. На нём изображена милая диона!"

/obj/item/weapon/storage/toolbox/lunchbox/nymph/filled
	filled = TRUE

/obj/item/weapon/storage/toolbox/lunchbox/syndicate
	name = "черно-красный ланчбокс"
	icon_state = "lunchbox_syndie"
	item_state_slots = list(slot_r_hand_str = "toolbox_syndi", slot_l_hand_str = "toolbox_syndi")
	desc = "Небольшой ланчбокс. Этот ланчбокс глянцевого черно-красного цвета и изготовлен из прочной стали!"

/obj/item/weapon/storage/toolbox/lunchbox/syndicate/filled
	filled = TRUE
