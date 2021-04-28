/obj/item/clothing/accessory/storage
	name = "Аксессуар для переноски груза"
	desc = "Иногда двух рук бывает маловато."
	icon_state = "webbing"
	slot = ACCESSORY_SLOT_UTILITY
	show_messages = 1

	var/slots = 5
	var/obj/item/weapon/storage/internal/hold
	w_class = ITEMSIZE_NORMAL
	on_rolled = list("down" = "none")
	var/hide_on_roll = FALSE

/obj/item/clothing/accessory/storage/Initialize()
	..()
	hold = new/obj/item/weapon/storage/internal(src)
	hold.max_storage_space = slots * 2
	hold.max_w_class = ITEMSIZE_SMALL
	if (!hide_on_roll)
		on_rolled["down"] = icon_state

/obj/item/clothing/accessory/storage/attack_hand(mob/user as mob)
	if (has_suit)	//if we are part of a suit
		hold.open(user)
		return

	if (hold.handle_attack_hand(user))	//otherwise interact as a regular storage item
		..(user)

/obj/item/clothing/accessory/storage/MouseDrop(obj/over_object as obj)
	if (has_suit)
		return

	if (hold.handle_mousedrop(usr, over_object))
		..(over_object)

/obj/item/clothing/accessory/storage/attackby(obj/item/W as obj, mob/user as mob)
	return hold.attackby(W, user)

/obj/item/clothing/accessory/storage/emp_act(severity)
	hold.emp_act(severity)
	..()

/obj/item/clothing/accessory/storage/attack_self(mob/user as mob)
	to_chat(user, "<span class='notice'>Вы опустошаете [ru_getcase(src, "acase")].</span>")
	var/turf/T = get_turf(src)
	hold.hide_from(usr)
	for(var/obj/item/I in hold.contents)
		hold.remove_from_storage(I, T)
	add_fingerprint(user)

/obj/item/clothing/accessory/storage/webbing
	name = "Жилет из лямок"
	desc = "Куча различных ремешков и застёжек, готовых помочь Вам с грузом."
	icon_state = "webbing"
	slots = 3

/obj/item/clothing/accessory/storage/black_vest
	name = "Чёрный жилет из лямок"
	desc = "Прочный синтехлопковый жилет из лямок с кучей карманов для всего, что не вмещается в руки."
	icon_state = "vest_black"

/obj/item/clothing/accessory/storage/brown_vest
	name = "Коричневый жилет из лямок"
	desc = "Поношенный синтехлопковый жилет из лямок коричневого цвета с кучей карманов."
	icon_state = "vest_brown"

/obj/item/clothing/accessory/storage/white_vest
	name = "Белый жилет из лямок"
	desc = "Надёжный синтехлопковый жилет белого цвета с карманами для всего необходимого."
	icon_state = "vest_white"

/obj/item/clothing/accessory/storage/black_drop_pouches
	name = "Чёрные сумочки"
	gender = PLURAL
	desc = "Прочные сумочки чёрного цвета для всего, что не вмещается в руки."
	icon_state = "thigh_black"

/obj/item/clothing/accessory/storage/brown_drop_pouches
	name = "Коричневые сумочки"
	gender = PLURAL
	desc = "Прочные сумочки коричневого цвета для всего, что не вмещается в руки."
	icon_state = "thigh_brown"

/obj/item/clothing/accessory/storage/white_drop_pouches
	name = "Белые сумочки"
	gender = PLURAL
	desc = "Надёжные сумочки белого цвета для всего, что не вмещается в руки."
	icon_state = "thigh_white"

/obj/item/clothing/accessory/storage/knifeharness
	name = "Украшенная упряжь"
	desc = "Декорированная упряжь из сухожилий и кожи с двумя петельками для ножей."
	icon_state = "unathiharness2"
	slots = 2

/obj/item/clothing/accessory/storage/knifeharness/Initialize()
	..()
	hold.max_storage_space = ITEMSIZE_COST_SMALL * 2
	hold.can_hold = list(/obj/item/weapon/material/knife/machete/hatchet/unathiknife,\
	/obj/item/weapon/material/knife,\
	/obj/item/weapon/material/knife/plastic)

	new /obj/item/weapon/material/knife/machete/hatchet/unathiknife(hold)
	new /obj/item/weapon/material/knife/machete/hatchet/unathiknife(hold)
