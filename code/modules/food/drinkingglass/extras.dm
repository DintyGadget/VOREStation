/obj/item/weapon/reagent_containers/food/drinks/glass2/attackby(obj/item/I as obj, mob/user as mob)
	if(extras.len >= 2) return ..() // max 2 extras, one on each side of the drink

	if(istype(I, /obj/item/weapon/glass_extra))
		var/obj/item/weapon/glass_extra/GE = I
		if(can_add_extra(GE))
			extras += GE
			user.remove_from_mob(GE)
			GE.loc = src
			to_chat(user, "<span class=notice>Вы добавляет [GE] в [src].</span>")
			update_icon()
		else
			to_chat(user, "<span class=warning>Нет места для размещения [GE] в [src]!</span>")
	else if(istype(I, /obj/item/weapon/reagent_containers/food/snacks/fruit_slice))
		if(!rim_pos)
			to_chat(user, "<span class=warning>Нет места для [I] в [src]!</span>")
			return
		var/obj/item/weapon/reagent_containers/food/snacks/fruit_slice/FS = I
		extras += FS
		user.remove_from_mob(FS)
		FS.pixel_x = 0 // Reset its pixel offsets so the icons work!
		FS.pixel_y = 0
		FS.loc = src
		to_chat(user, "<span class=notice>Вы добавляете [FS] в [src].</span>")
		update_icon()
	else
		return ..()

/obj/item/weapon/reagent_containers/food/drinks/glass2/attack_hand(mob/user as mob)
	if(src != user.get_inactive_hand())
		return ..()

	if(!extras.len)
		to_chat(user, "<span class=warning>На стекле нечего убрать!</span>")
		return

	var/choice = input(user, "Что бы вы хотели удалить со стекла?") as null|anything in extras
	if(!choice || !(choice in extras))
		return

	if(user.put_in_active_hand(choice))
		to_chat(user, "<span class=notice>Вы удаляете [choice] с [src].</span>")
		extras -= choice
	else
		to_chat(user, "<span class=warning>Что-то пошло не так. Пожалуйста, попытайтесь еще раз.</span>")

	update_icon()

/obj/item/weapon/glass_extra
	name = "generic glass addition"
	desc = "Это идет на стакан."
	var/glass_addition
	var/glass_desc
	var/glass_color
	w_class = ITEMSIZE_TINY
	icon = DRINK_ICON_FILE

/obj/item/weapon/glass_extra/stick
	name = "stick"
	desc = "Это идет на стакан."
	glass_addition = "stick"
	glass_desc = "В стакане есть палка."
	icon_state = "stick"

/obj/item/weapon/glass_extra/straw
	name = "straw"
	desc = "Это идет на стакан."
	glass_addition = "straw"
	glass_desc = "В стакане есть трубочка."
	icon_state = "straw"

#undef DRINK_ICON_FILE
