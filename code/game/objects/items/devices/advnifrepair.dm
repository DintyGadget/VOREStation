//Programs nanopaste into NIF repair nanites
/obj/item/device/nifrepairer
	name = "расширенный инструмент восстановления NIF"
	desc = "Инструмент, который принимает нанопасту и превращает наниты в ремонтные наниты NIF для инъекций/проглатывания. Вставьте пасту, положите в емкость."
	icon = 'icons/obj/device_alt.dmi'
	icon_state = "hydro"
	item_state = "gun"
	slot_flags = SLOT_BELT
	throwforce = 3
	w_class = ITEMSIZE_SMALL
	throw_speed = 5
	throw_range = 10
	matter = list(DEFAULT_WALL_MATERIAL = 4000, "glass" = 6000)
	origin_tech = list(TECH_MAGNET = 5, TECH_BLUESPACE = 5, TECH_MATERIAL = 5, TECH_ENGINEERING = 5, TECH_DATA = 5)
	var/datum/reagents/supply
	var/efficiency = 15 //How many units reagent per 1 unit nanopaste


/obj/item/device/nifrepairer/New()
	..()

	supply = new(max = 60, A = src)

/obj/item/device/nifrepairer/attackby(obj/W, mob/user)
	if(istype(W,/obj/item/stack/nanopaste))
		var/obj/item/stack/nanopaste/np = W
		if(np.use(1) && supply.get_free_space() >= efficiency)
			to_chat(user, "<span class='notice'>Вы превращаете нанопасту в запрограммированные наниты внутри [src].</span>")
			supply.add_reagent(id = "nifrepairnanites", amount = efficiency)
			update_icon()
		else if(supply.get_free_space() < efficiency)
			to_chat(user, "<span class='warning'>[src] переполнен. Сначала вылейте его в контейнер.</span>")
			return

/obj/item/device/nifrepairer/update_icon()
	if(supply.total_volume)
		icon_state = "[initial(icon_state)]2"
	else
		icon_state = initial(icon_state)

/obj/item/device/nifrepairer/afterattack(var/atom/target, var/mob/user, var/proximity)
	if(!target.is_open_container() || !target.reagents)
		return 0

	if(!supply || !supply.total_volume)
		to_chat(user, "<span class='warning'>[src] пуст. Наполните его нанопастой.</span>")
		return 1

	if(!target.reagents.get_free_space())
		to_chat(user, "<span class='warning'>[target] полон.</span>")
		return 1

	var/trans = supply.trans_to(target, 15)
	to_chat(user, "<span class='notice'>Вы переносите [trans] единиц запрограммированных нанитов на [target].</span>")
	update_icon()
	return 1

/obj/item/device/nifrepairer/examine(mob/user)
	. = ..()
	if(Adjacent(user))
		if(supply.total_volume)
			. += "<span class='notice'>[src] содержит [supply.total_volume] единиц запрограммированных нанитов, готовых к выдаче.</span>"
		else
			. += "<span class='notice'>\The [src] is empty and ready to accept nanopaste.</span>"
