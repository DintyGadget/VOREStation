/obj/item/clothing/mask/chewable
	name = "chewable item master"
	desc = "If you are seeing this, ahelp it."
	icon = 'icons/obj/clothing/masks.dmi'
	drop_sound = 'sound/items/drop/food.ogg'
	body_parts_covered = 0

	var/type_butt = null
	var/chem_volume = 0
	var/chewtime = 0
	var/brand
	var/list/filling = list()
	var/wrapped = FALSE

/obj/item/clothing/mask/chewable/attack_self(mob/user)
	if(wrapped)
		wrapped = FALSE
		to_chat(user, span("notice", "You unwrap \the [name]."))
		playsound(src.loc, 'sound/items/drop/wrapper.ogg', 50, 1)
		slot_flags = SLOT_EARS | SLOT_MASK
		update_icon()

/obj/item/clothing/mask/chewable/update_icon()
	cut_overlays()
	if(wrapped)
		add_overlay("[initial(icon_state)]_wrapper")

obj/item/clothing/mask/chewable/Initialize()
	. = ..()
	flags |= NOREACT // so it doesn't react until you light it
	create_reagents(chem_volume) // making the cigarrete a chemical holder with a maximum volume of 15
	for(var/R in filling)
		reagents.add_reagent(R, filling[R])
	if(wrapped)
		slot_flags = null

/obj/item/clothing/mask/chewable/equipped(var/mob/living/user, var/slot)
	..()
	if(slot == slot_wear_mask)
		var/mob/living/carbon/human/C = user
		if(C.check_has_mouth())
			START_PROCESSING(SSprocessing, src)
		else
			to_chat(user, span("notice", "You don't have a mouth, and can't make much use of \the [src]."))

/obj/item/clothing/mask/chewable/dropped()
	STOP_PROCESSING(SSprocessing, src)
	..()

obj/item/clothing/mask/chewable/Destroy()
	. = ..()
	STOP_PROCESSING(SSprocessing, src)

/obj/item/clothing/mask/chewable/proc/chew()
	chewtime--
	if(reagents && reagents.total_volume)
		if(ishuman(loc))
			var/mob/living/carbon/human/C = loc
			if (src == C.wear_mask && C.check_has_mouth())
				reagents.trans_to_mob(C, REM, CHEM_INGEST, 0.2)
		else
			STOP_PROCESSING(SSprocessing, src)

/obj/item/clothing/mask/chewable/process()
	chew()
	if(chewtime < 1)
		spitout()

/obj/item/clothing/mask/chewable/tobacco
	name = "пыж"
	desc = "Жевательная пачка табака. Нарежьте длинные пряди и обработайте сиропом, чтобы он не походил на пепельницу, когда вы набиваете его себе на лицо."
	throw_speed = 0.5
	icon_state = "chew"
	type_butt = /obj/item/trash/spitwad
	w_class = 1
	slot_flags = SLOT_EARS | SLOT_MASK
	chem_volume = 50
	chewtime = 300
	brand = "tobacco"


/obj/item/clothing/mask/chewable/proc/spitout(var/transfer_color = 1, var/no_message = 0)
	if(type_butt)
		var/obj/item/butt = new type_butt(src.loc)
		transfer_fingerprints_to(butt)
		if(transfer_color)
			butt.color = color
		if(brand)
			butt.desc += " Это [brand]."
		if(ismob(loc))
			var/mob/living/M = loc
			if(!no_message)
				to_chat(M, SPAN_NOTICE("The [name] runs out of flavor."))
			if(M.wear_mask)
				M.remove_from_mob(src) //un-equip it so the overlays can update
				M.update_inv_wear_mask(0)
				if(!M.equip_to_slot_if_possible(butt, slot_wear_mask))
					M.update_inv_l_hand(0)
					M.update_inv_r_hand(1)
					M.put_in_hands(butt)
	STOP_PROCESSING(SSprocessing, src)
	qdel(src)

/obj/item/clothing/mask/chewable/tobacco/cheap
	name = "жевательный табак"
	desc = "Жевательная пачка табака. Нарежьте длинные пряди и обработайте сиропом, чтобы он не походил на пепельницу, когда вы кладете его себе на лицо."
	filling = list("nicotine" = 2)

/obj/item/clothing/mask/chewable/tobacco/fine
	name = "роскошный жевательный табак"
	desc = "Жевательная пачка прекрасного табака. Нарежьте длинные пряди и обработайте сиропом, чтобы он не походил на пепельницу, когда вы набиваете его себе на лицо."
	filling = list("nicotine" = 3)

/obj/item/clothing/mask/chewable/tobacco/nico
	name = "никотиновая жвачка"
	desc = "Жевательный комок из синтетического каучука с добавлением никотина. Возможно, наименее отвратительный способ доставки никотина."
	icon_state = "nic_gum"
	type_butt = /obj/item/trash/spitgum
	wrapped = TRUE

/obj/item/clothing/mask/chewable/tobacco/nico/Initialize()
	. = ..()
	reagents.add_reagent("nicotine", 2)
	color = reagents.get_color()

/obj/item/weapon/storage/chewables
	name = "коробка никотиновой жвачки master"
	desc = "Универсальная марка вафельных колбас, жевательных конфет без вкуса. Почему они существуют?"
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cigpacket"
	item_state = "cigpacket"
	drop_sound = 'sound/items/drop/shovel.ogg'
	use_sound = 'sound/items/storage/pillbottle.ogg'
	w_class = 2
	throwforce = 2
	slot_flags = SLOT_BELT
	starts_with = list(/obj/item/clothing/mask/chewable/tobacco = 6)
	make_exact_fit()

//Tobacco Tins

/obj/item/weapon/storage/chewables/tobacco
	name = "банка жевательного табака Al Mamun Smooth"
	desc = "Упаковано и отправлено прямо из Кишара, популяризированного биосферными фермерами Канондаги."
	icon_state = "chew_generic"
	item_state = "cigpacket"
	starts_with = list(/obj/item/clothing/mask/chewable/tobacco/cheap = 6)
	storage_slots = 6

/obj/item/weapon/storage/chewables/tobacco/fine
	name = "банка жевательного табака Suamalie"
	desc = "Когда-то зарезервированный для первоклассных туристов Оазиса, этот премиальный купаж был выпущен для всеобщего ознакомления."
	icon_state = "chew_fine"
	item_state = "Dpacket"
	starts_with = list(/obj/item/clothing/mask/chewable/tobacco/fine = 6)

/obj/item/weapon/storage/box/fancy/chewables/tobacco/nico
	name = "box of Nico-Tine gum"
	desc = "A government doctor approved brand of nicotine gum. Cut out the middleman for your addiction fix."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "chew_nico"
	item_state = "Epacket"
	starts_with = list(/obj/item/clothing/mask/chewable/tobacco/nico = 6)
	storage_slots = 6
	drop_sound = 'sound/items/drop/box.ogg'
	use_sound = 'sound/items/storage/box.ogg'

/obj/item/weapon/storage/box/fancy/chewables/tobacco/update_icon()
	icon_state = "[initial(icon_state)][contents.len]"


/obj/item/clothing/mask/chewable/candy
	name = "пыж"
	desc = "Жевательный комок ватного материала."
	throw_speed = 0.5
	icon_state = "chew"
	type_butt = /obj/item/trash/spitgum
	w_class = 1
	slot_flags = SLOT_EARS | SLOT_MASK
	chem_volume = 50
	chewtime = 300
	filling = list("sugar" = 2)

/obj/item/clothing/mask/chewable/candy/gum
	name = "жвачка"
	desc = "Жевательный комок из высококачественного синтетического каучука и искусственного ароматизатора. Обязательно разверни его, гений."
	icon_state = "gum"
	item_state = "gum"
	wrapped = TRUE

/obj/item/clothing/mask/chewable/candy/gum/Initialize()
	. = ..()
	reagents.add_reagent(pick("banana","berryjuice","grapejuice","lemonjuice","limejuice","orangejuice","watermelonjuice"),10)
	color = reagents.get_color()
	update_icon()

/obj/item/weapon/storage/box/gum
	name = "\improper Frooty-Choos flavored gum"
	desc = "A small pack of chewing gum in various flavors."
	description_fluff = "Frooty-Choos is NanoTrasen's top-selling brand of artificially flavoured fruit-adjacent non-swallowable chew-product. This extremely specific definition places sales figures safely away from competing 'gum' brands."
	icon = 'icons/obj/food_snacks.dmi'
	icon_state = "gum_pack"
	item_state = "candy"
	slot_flags = SLOT_EARS
	w_class = 1
	starts_with = list(/obj/item/clothing/mask/chewable/candy/gum = 5)
	can_hold = list(/obj/item/clothing/mask/chewable/candy/gum,
					/obj/item/trash/spitgum)
	use_sound = 'sound/items/drop/paper.ogg'
	drop_sound = 'sound/items/drop/wrapper.ogg'
	max_storage_space = 5
	foldable = null
	trash = /obj/item/trash/gumpack

/obj/item/clothing/mask/chewable/candy/lolli
	name = "леденец"
	desc = "Простая искусственно ароматизированная сфера сахара на ручке, в просторечии известная как присоска. Якобы каждую минуту кто-то рождается. Обязательно разверни его, гений."
	type_butt = /obj/item/trash/lollibutt
	icon_state = "lollipop"
	item_state = "lollipop"
	wrapped = TRUE

/obj/item/clothing/mask/chewable/candy/lolli/process()
	chew()
	if(chewtime < 1)
		spitout(0)

/obj/item/clothing/mask/chewable/candy/lolli/Initialize()
	. = ..()
	reagents.add_reagent(pick("banana","berryjuice","grapejuice","lemonjuice","limejuice","orangejuice","watermelonjuice"),20)
	color = reagents.get_color()
	update_icon()

