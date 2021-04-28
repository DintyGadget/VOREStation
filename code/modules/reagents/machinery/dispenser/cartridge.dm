/obj/item/weapon/reagent_containers/chem_disp_cartridge
	name = "картридж дозатора химикатов"
	desc = "Это идет в дозатор химикатов."
	icon_state = "cartridge"

	w_class = ITEMSIZE_NORMAL

	volume = CARTRIDGE_VOLUME_LARGE
	amount_per_transfer_from_this = 50
	// Large, but inaccurate. Use a chem dispenser or beaker for accuracy.
	possible_transfer_amounts = list(50, 100, 250, 500)
	unacidable = 1

	var/spawn_reagent = null
	var/label = ""

/obj/item/weapon/reagent_containers/chem_disp_cartridge/Initialize()
	. = ..()
	if(spawn_reagent)
		reagents.add_reagent(spawn_reagent, volume)
		var/datum/reagent/R = SSchemistry.chemical_reagents[spawn_reagent]
		setLabel(R.name)

/obj/item/weapon/reagent_containers/chem_disp_cartridge/examine(mob/user)
	. = ..()
	. += "Его емкость составляет [volume] единиц."
	if(reagents.total_volume <= 0)
		. += "Пусто."
	else
		. += "Емкость содержит [reagents.total_volume] единиц жидкости."
	if(!is_open_container())
		. += "Колпачок запломбирован."

/obj/item/weapon/reagent_containers/chem_disp_cartridge/verb/verb_set_label(L as text)
	set name = "Установить этикетку картриджа"
	set category = "Object"
	set src in view(usr, 1)

	setLabel(L, usr)

/obj/item/weapon/reagent_containers/chem_disp_cartridge/proc/setLabel(L, mob/user = null)
	if(L)
		if(user)
			to_chat(user, "<span class='notice'>Вы устанавливаете метку '[L]' на [src].</span>")

		label = L
		name = "[initial(name)] - '[L]'"
	else
		if(user)
			to_chat(user, "<span class='notice'>Вы убираете метку с [src].</span>")
		label = ""
		name = initial(name)

/obj/item/weapon/reagent_containers/chem_disp_cartridge/attack_self()
	..()
	if (is_open_container())
		to_chat(usr, "<span class = 'notice'>Вы пломбируете [src].</span>")
		flags ^= OPENCONTAINER
	else
		to_chat(usr, "<span class = 'notice'>Вы снимаете пломбу с [src].</span>")
		flags |= OPENCONTAINER

/obj/item/weapon/reagent_containers/chem_disp_cartridge/afterattack(obj/target, mob/user , flag)
	if (!is_open_container() || !flag)
		return

	else if(istype(target, /obj/structure/reagent_dispensers)) //A dispenser. Transfer FROM it TO us.
		target.add_fingerprint(user)

		if(!target.reagents.total_volume && target.reagents)
			to_chat(user, "<span class='warning'>[target] пуст.</span>")
			return

		if(reagents.total_volume >= reagents.maximum_volume)
			to_chat(user, "<span class='warning'>[src] полон.</span>")
			return

		var/trans = target.reagents.trans_to(src, target:amount_per_transfer_from_this)
		to_chat(user, "<span class='notice'>You fill \the [src] with [trans] units of the contents of \the [target].</span>")

	else if(target.is_open_container() && target.reagents) //Something like a glass. Player probably wants to transfer TO it.

		if(!reagents.total_volume)
			to_chat(user, "<span class='warning'>\The [src] is empty.</span>")
			return

		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, "<span class='warning'>\The [target] is full.</span>")
			return

		var/trans = src.reagents.trans_to(target, amount_per_transfer_from_this)
		to_chat(user, "<span class='notice'>You transfer [trans] units of the solution to \the [target].</span>")

	else
		return ..()
