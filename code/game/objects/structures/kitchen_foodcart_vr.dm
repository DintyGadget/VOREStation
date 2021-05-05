/obj/structure/foodcart
	name = "Продуктовая тележка"
	icon = 'icons/obj/kitchen_vr.dmi'
	icon_state = "foodcart-0"
	desc = "Лучший транспорт для еды! При открытии вы замечаете два отделения со странным синим светом. Одному очень тепло, а другому очень холодно."
	anchored = 0
	opacity = 0
	density = 1

/obj/structure/foodcart/Initialize()
	. = ..()
	for(var/obj/item/I in loc)
		if(istype(I, /obj/item/weapon/reagent_containers/food))
			I.loc = src
	update_icon()

/obj/structure/foodcart/attackby(obj/item/O as obj, mob/user as mob)
	if(istype(O, /obj/item/weapon/reagent_containers/food))
		user.drop_item()
		O.loc = src
		update_icon()
	else
		return

/obj/structure/foodcart/attack_hand(var/mob/user as mob)
	if(contents.len)
		var/obj/item/weapon/reagent_containers/food/choice = input("Что бы вы хотели взять из тележки?") as null|obj in contents
		if(choice)
			if(!usr.canmove || usr.stat || usr.restrained() || !in_range(loc, usr))
				return
			if(ishuman(user))
				if(!user.get_active_hand())
					user.put_in_hands(choice)
			else
				choice.loc = get_turf(src)
			update_icon()

/obj/structure/foodcart/update_icon()
	if(contents.len < 5)
		icon_state = "foodcart-[contents.len]"
	else
		icon_state = "foodcart-5"