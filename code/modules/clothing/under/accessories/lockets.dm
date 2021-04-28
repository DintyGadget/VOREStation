/obj/item/clothing/accessory/locket
	name = "Серебряный медальон"
	desc = "Небольшой медальон из высококачественного металла."
	icon_state = "locket"
	drop_sound = 'sound/items/drop/ring.ogg'
	pickup_sound = 'sound/items/pickup/ring.ogg'
	w_class = ITEMSIZE_SMALL
	slot_flags = SLOT_MASK | SLOT_TIE
	slot = ACCESSORY_SLOT_DECOR
	var/base_icon
	var/open
	var/obj/item/held //Item inside locket.

/obj/item/clothing/accessory/locket/attack_self(mob/user as mob)
	if(!base_icon)
		base_icon = icon_state

	if(!("[base_icon]_open" in cached_icon_states(icon)))
		to_chat(user, "[ru_g_obj(src, "", "Этот", "Эта", "Это", "Эти")] [ru_getcase(src, "ncase")] [ru_g_obj(src, "закрыт", "", "а", "о", "ы")].")
		return

	open = !open
	to_chat(user, "Вы [open ? "открываете" : "закрываете"] медальон.")
	if(open)
		icon_state = "[base_icon]_open"
		if(held)
			to_chat(user, "Из медальона выпадает [ru_getcase(held, "ncase")]!")
			held.loc = get_turf(user)
			held = null
	else
		icon_state = "[base_icon]"

/obj/item/clothing/accessory/locket/attackby(var/obj/item/O as obj, mob/user as mob)
	if(!open)
		to_chat(user, "Необходимо сперва открыть медальон.")
		return

	if(istype(O,/obj/item/weapon/paper) || istype(O, /obj/item/weapon/photo))
		if(held)
			to_chat(usr, "[ru_g_obj(src, "", "Этот", "Эта", "Это", "Эти")] [ru_getcase(src, "ncase")] уже содержит что-то внутри.")
		else
			to_chat(usr, "Вы помещаете [ru_getcase(O, "acase")] в [ru_getcase(src, "acase")].")
			user.drop_item()
			O.loc = src
			held = O
		return
	..()
