/obj/item/clothing/suit/storage
	var/obj/item/weapon/storage/internal/pockets

/obj/item/clothing/suit/storage/New()
	..()
	pockets = new/obj/item/weapon/storage/internal(src)
	pockets.max_w_class = ITEMSIZE_SMALL		//fit only pocket sized items
	pockets.max_storage_space = ITEMSIZE_COST_SMALL * 2

/obj/item/clothing/suit/storage/Destroy()
	QDEL_NULL(pockets)
	return ..()

/obj/item/clothing/suit/storage/attack_hand(mob/user as mob)
	if (pockets.handle_attack_hand(user))
		..(user)

/obj/item/clothing/suit/storage/MouseDrop(obj/over_object as obj)
	if (pockets.handle_mousedrop(usr, over_object))
		..(over_object)

/obj/item/clothing/suit/storage/attackby(obj/item/W as obj, mob/user as mob)
	..()
	pockets.attackby(W, user)

/obj/item/clothing/suit/storage/emp_act(severity)
	pockets.emp_act(severity)
	..()

//Jackets with buttons, used for labcoats, IA jackets, First Responder jackets, and brown jackets.
/obj/item/clothing/suit/storage/toggle
	flags_inv = HIDEHOLSTER
	var/open = 0	//0 is closed, 1 is open, -1 means it won't be able to toggle
	verb/toggle()
		set name = "Пуговицы Верхней Одежды"
		set category = "Объект"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return 0

		if(open == 1) //Will check whether icon state is currently set to the "open" or "closed" state and switch it around with a message to the user
			open = 0
			icon_state = initial(icon_state)
			flags_inv = HIDETIE|HIDEHOLSTER
			to_chat(usr, "Вы застегиваете [ru_g_obj(src, "свой", "свою", "своё", "свои")] [ru_getcase(src, "acase")].")
		else if(open == 0)
			open = 1
			icon_state = "[icon_state]_open"
			flags_inv = HIDEHOLSTER
			to_chat(usr, "Вы расстегиваете [ru_g_obj(src, "сво", "й", "ю", "ё", "и")] [ru_getcase(src, "acase")].")
		else //in case some goofy admin switches icon states around without switching the icon_open or icon_closed
			to_chat(usr, "Вы пытаетесь застегнуть [ru_g_obj(src, "сво", "й", "ю", "ё", "и")] [ru_getcase(src, "acase")], прежде чем сразу понимаете, насколько Вы глупы.")
			return
		update_clothing_icon()	//so our overlays update


/obj/item/clothing/suit/storage/hooded/toggle
	flags_inv = HIDEHOLSTER
	var/open = 0	//0 is closed, 1 is open, -1 means it won't be able to toggle
	verb/toggle()
		set name = "Пуговицы Верхней Одежды"
		set category = "Объект"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return 0

		if(open == 1) //Will check whether icon state is currently set to the "open" or "closed" state and switch it around with a message to the user
			open = 0
			icon_state = initial(icon_state)
			flags_inv = HIDETIE|HIDEHOLSTER
			to_chat(usr, "Вы застегиваете [ru_g_obj(src, "сво", "й", "ю", "ё", "и")] [ru_getcase(src, "acase")].")
		else if(open == 0)
			open = 1
			icon_state = "[icon_state]_open"
			flags_inv = HIDEHOLSTER
			to_chat(usr, "Вы расстегиваете верхнюю одежду.")
		else //in case some goofy admin switches icon states around without switching the icon_open or icon_closed
			to_chat(usr, "Вы пытаетесь застегнуть [ru_g_obj(src, "сво", "й", "ю", "ё", "и")] [ru_getcase(src, "acase")], прежде чем сразу понимаете, насколько Вы глупы.")
			return
		update_clothing_icon()	//so our overlays update


//New Vest 4 pocket storage and badge toggles, until suit accessories are a thing.
/obj/item/clothing/suit/storage/vest/heavy/New()
	..()
	pockets = new/obj/item/weapon/storage/internal(src)
	pockets.max_w_class = ITEMSIZE_SMALL
	pockets.max_storage_space = ITEMSIZE_COST_SMALL * 4

/obj/item/clothing/suit/storage/vest
	var/icon_badge
	var/icon_nobadge
	verb/toggle()
		set name ="Отрегулировать Бейдж"
		set category = "Объект"
		set src in usr
		if(!usr.canmove || usr.stat || usr.restrained())
			return 0

		if(icon_state == icon_badge)
			icon_state = icon_nobadge
			to_chat(usr, "Вы скрываете бейдж на [ru_g_obj(src, "сво", "ём", "ей", "ём", "их")] [ru_getcase(src, "pcase")].")
		else if(icon_state == icon_nobadge)
			icon_state = icon_badge
			to_chat(usr, "Вы показываете бейдж на [ru_g_obj(src, "сво", "ём", "ей", "ём", "их")] [ru_getcase(src, "pcase")].")
		else
			to_chat(usr, "[capitalize(ru_getcase(src, "ncase"))] не имеет бейджа.")
			return
		update_clothing_icon()

