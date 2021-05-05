/*
 * Donut Box
 */

/obj/item/weapon/storage/box/donut
	icon = 'icons/obj/food.dmi'
	icon_state = "donutbox"
	name = "коробка для пончиков"
	desc = "Коробка с вкусными пончиками, если вам повезет."
	center_of_mass = list("x" = 16,"y" = 9)
	max_storage_space = ITEMSIZE_COST_SMALL * 6
	can_hold = list(/obj/item/weapon/reagent_containers/food/snacks/donut)
	foldable = /obj/item/stack/material/cardboard
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/donut/normal = 6)

/obj/item/weapon/storage/box/donut/Initialize()
	. = ..()
	update_icon()

/obj/item/weapon/storage/box/donut/update_icon()
	overlays.Cut()
	var/i = 0
	for(var/obj/item/weapon/reagent_containers/food/snacks/donut/D in contents)
		overlays += image('icons/obj/food.dmi', "[i][D.overlay_state]")
		i++

/obj/item/weapon/storage/box/donut/empty
	empty = TRUE

/obj/item/weapon/storage/box/wormcan
	icon = 'icons/obj/food.dmi'
	icon_state = "wormcan"
	name = "банка червей"
	desc = "Вы, вероятно, захотите открыть эту банку с червями."
	max_storage_space = ITEMSIZE_COST_TINY * 6
	can_hold = list(
		/obj/item/weapon/reagent_containers/food/snacks/wormsickly,
		/obj/item/weapon/reagent_containers/food/snacks/worm,
		/obj/item/weapon/reagent_containers/food/snacks/wormdeluxe
	)
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/worm = 6)

/obj/item/weapon/storage/box/wormcan/Initialize()
	. = ..()
	update_icon()

/obj/item/weapon/storage/box/wormcan/update_icon(var/itemremoved = 0)
	if (contents.len == 0)
		icon_state = "wormcan_empty"

/obj/item/weapon/storage/box/wormcan/sickly
	icon_state = "wormcan_sickly"
	name = "банка болезненных червей"
	desc = "Вы, вероятно, не захотите открывать эту банку с червями."
	max_storage_space = ITEMSIZE_COST_TINY * 6
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/wormsickly = 6)

/obj/item/weapon/storage/box/wormcan/sickly/update_icon(var/itemremoved = 0)
	if (contents.len == 0)
		icon_state = "wormcan_empty_sickly"

/obj/item/weapon/storage/box/wormcan/deluxe
	icon_state = "wormcan_deluxe"
	name = "банка роскошных червей"
	desc = "Вы обязательно захотите открыть эту банку с червями."
	max_storage_space = ITEMSIZE_COST_TINY * 6
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/wormdeluxe = 6)

/obj/item/weapon/storage/box/wormcan/deluxe/update_icon(var/itemremoved = 0)
	if (contents.len == 0)
		icon_state = "wormcan_empty_deluxe"