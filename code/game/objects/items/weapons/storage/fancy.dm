/*
 * The 'fancy' path is for objects like donut boxes that show how many items are in the storage item on the sprite itself
 * .. Sorry for the shitty path name, I couldnt think of a better one.
 *
 * WARNING: var/icon_type is used for both examine text and sprite name. Please look at the procs below and adjust your sprite names accordingly
 *
 * Contains:
 *		Donut Box
 *		Egg Box
 *		Candle Box
 *		Crayon Box
 *		Cigarette Box
 *		Vial Box
 *		Box of Chocolates
 */

/obj/item/weapon/storage/fancy/
	icon = 'icons/obj/food.dmi'
	icon_state = "donutbox6"
	name = "Коробка для пончиков"
	var/icon_type = "donut"
	drop_sound = 'sound/items/drop/cardboardbox.ogg'
	pickup_sound = 'sound/items/pickup/cardboardbox.ogg'

/obj/item/weapon/storage/fancy/update_icon(var/itemremoved = 0)
	var/total_contents = contents.len - itemremoved
	icon_state = "[icon_type]box[total_contents]"
	return

var/ru_icon_type_1 = "пончик"
var/ru_icon_type_2 = "пончика"
var/ru_icon_type_3 = "пончиков"
var/ru_icon_type_4 = "остался последний пончик"

/obj/item/weapon/storage/fancy/examine(mob/user)
	. = ..()
	var/ru_counter = ru_countitems(contents, single_text = ru_icon_type_1, few_text = ru_icon_type_2, many_text = ru_icon_type_3)
	if(Adjacent(user))
		if(!contents.len)
			. += "В [ru_getcase(src, "pcase")] не осталось [ru_icon_type_3]."
		else if(contents.len == 1)
			. += "В [ru_getcase(src, "pcase")] [ru_icon_type_4]."
		else
			. += "В [ru_getcase(src, "pcase")] [ru_counter]."

/*
 * Egg Box
 */

/obj/item/weapon/storage/fancy/egg_box
	icon = 'icons/obj/food.dmi'
	icon_state = "eggbox"
	icon_type = "egg"
	name = "Коробка яиц"
	center_of_mass = list("x" = 16,"y" = 7)
	storage_slots = 12
	can_hold = list(
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/boiledegg
		)
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/egg = 12)

/*
 * Candle Boxes
 */

/obj/item/weapon/storage/fancy/candle_box
	name = "Набор красных свечек"
	desc = "Комплект красных свечек."
	icon = 'icons/obj/candle.dmi'
	icon_state = "candlebox5"
	icon_type = "candle"
	item_state = "candlebox5"
	throwforce = 2
	slot_flags = SLOT_BELT
	max_storage_space = ITEMSIZE_COST_SMALL * 5
	starts_with = list(/obj/item/weapon/flame/candle = 5)

/obj/item/weapon/storage/fancy/whitecandle_box
	name = "Набор белых свечек"
	desc = "Комплект белых свечек."
	icon = 'icons/obj/candle.dmi'
	icon_state = "whitecandlebox5"
	icon_type = "whitecandle"
	item_state = "whitecandlebox5"
	throwforce = 2
	slot_flags = SLOT_BELT
	max_storage_space = ITEMSIZE_COST_SMALL * 5
	starts_with = list(/obj/item/weapon/flame/candle/white = 5)

/obj/item/weapon/storage/fancy/blackcandle_box
	name = "Набор чёрных свечек"
	desc = "Комплект черных свечек."
	icon = 'icons/obj/candle.dmi'
	icon_state = "blackcandlebox5"
	icon_type = "blackcandle"
	item_state = "blackcandlebox5"
	throwforce = 2
	slot_flags = SLOT_BELT
	max_storage_space = ITEMSIZE_COST_SMALL * 5
	starts_with = list(/obj/item/weapon/flame/candle/black = 5)


/*
 * Crayon Box
 */

/obj/item/weapon/storage/fancy/crayons
	name = "Коробка мелков"
	desc = "Коробка восковых мелков для всех Ваших рунических нужд."
	icon = 'icons/obj/crayons.dmi'
	icon_state = "crayonbox"
	w_class = ITEMSIZE_SMALL
	icon_type = "crayon"
	can_hold = list(
		/obj/item/weapon/pen/crayon
	)
	starts_with = list(
		/obj/item/weapon/pen/crayon/red,
		/obj/item/weapon/pen/crayon/orange,
		/obj/item/weapon/pen/crayon/yellow,
		/obj/item/weapon/pen/crayon/green,
		/obj/item/weapon/pen/crayon/blue,
		/obj/item/weapon/pen/crayon/purple
	)

/obj/item/weapon/storage/fancy/crayons/Initialize()
	. = ..()
	update_icon()

/obj/item/weapon/storage/fancy/crayons/update_icon()
	var/mutable_appearance/ma = new(src)
	ma.overlays = list()
	for(var/obj/item/weapon/pen/crayon/crayon in contents)
		ma.overlays += image('icons/obj/crayons.dmi',crayon.colourName)
	appearance = ma

/obj/item/weapon/storage/fancy/crayons/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/pen/crayon))
		switch(W:colourName)
			if("mime")
				to_chat(user, "Этот мелок слишком грустный, чтобы храниться в коробке.")
				return
			if("rainbow")
				to_chat(user, "Этот мелок слишком силён, чтобы коробка могла его сдержать.")
				return
	..()

/obj/item/weapon/storage/fancy/markers
	name = "Коробка маркеров"
	desc = "Очень профессиональная на вид коробка перманентных маркеров."
	icon = 'icons/obj/crayons.dmi'
	icon_state = "markerbox"
	w_class = ITEMSIZE_SMALL
	icon_type = "marker"
	can_hold = list(
		/obj/item/weapon/pen/crayon/marker
	)
	starts_with = list(
		/obj/item/weapon/pen/crayon/marker/black,
		/obj/item/weapon/pen/crayon/marker/red,
		/obj/item/weapon/pen/crayon/marker/orange,
		/obj/item/weapon/pen/crayon/marker/yellow,
		/obj/item/weapon/pen/crayon/marker/green,
		/obj/item/weapon/pen/crayon/marker/blue,
		/obj/item/weapon/pen/crayon/marker/purple
	)

/obj/item/weapon/storage/fancy/markers/Initialize()
	. = ..()
	update_icon()

/obj/item/weapon/storage/fancy/markers/update_icon()
	var/mutable_appearance/ma = new(src)
	ma.overlays = list()
	for(var/obj/item/weapon/pen/crayon/marker/marker in contents)
		ma.overlays += image('icons/obj/crayons.dmi',"m"+marker.colourName)
	appearance = ma

/obj/item/weapon/storage/fancy/markers/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/pen/crayon/marker))
		switch(W:colourName)
			if("mime")
				to_chat(user, "Этот маркер слишком угнетающий, чтобы содержаться в этой коробке.")
				return
			if("rainbow")
				to_chat(user, "Этот маркер слишком детский, чтобы содержаться в этой коробке.")
				return
	..()

/*
 * Cracker Packet
 */

/obj/item/weapon/storage/fancy/crackers
	name = "Пачка крекеров Getmore"
	icon = 'icons/obj/food.dmi'
	icon_state = "crackerbox"
	icon_type = "cracker"
	max_storage_space = ITEMSIZE_COST_TINY * 6
	max_w_class = ITEMSIZE_TINY
	w_class = ITEMSIZE_SMALL
	can_hold = list(/obj/item/weapon/reagent_containers/food/snacks/cracker)
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/cracker = 6)

////////////
//CIG PACK//
////////////
/obj/item/weapon/storage/fancy/cigarettes
	name = "Пачка Транскосмических Дюти Фри"
	desc = "Распространенная марка сигарет, которую можно встретить в любой корпорации во вселенной. Безвкуснее некуда."
	description_fluff = "Сигаретная Компания Транскосмических Дюти Фри была создана непосредственно NanoTrasen. Это самые скучные, безвкусные и сухие сигареты на рынке, но благодаря своей неприметности (и уж тем более дешевизне), их можно найти на любом конце галактики."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cigpacket"
	item_state_slots = list(slot_r_hand_str = "cigpacket", slot_l_hand_str = "cigpacket")
	w_class = ITEMSIZE_TINY
	throwforce = 2
	slot_flags = SLOT_BELT
	storage_slots = 6
	can_hold = list(/obj/item/clothing/mask/smokable/cigarette, /obj/item/weapon/flame/lighter, /obj/item/trash/cigbutt)
	icon_type = "cigarette"
	starts_with = list(/obj/item/clothing/mask/smokable/cigarette = 6)
	var/brand = "Транскосмическая Дюти Фри"

/obj/item/weapon/storage/fancy/cigarettes/Initialize()
	. = ..()
	flags |= NOREACT
	create_reagents(15 * storage_slots)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one
	flags |= OPENCONTAINER
	if(brand)
		for(var/obj/item/clothing/mask/smokable/cigarette/C in src)
			C.brand = brand
			C.desc += " Эта сигарета - [brand]."

/obj/item/weapon/storage/fancy/cigarettes/update_icon()
	icon_state = "[initial(icon_state)][contents.len]"
	return

/obj/item/weapon/storage/fancy/cigarettes/remove_from_storage(obj/item/W as obj, atom/new_location)
	// Don't try to transfer reagents to lighters
	if(istype(W, /obj/item/clothing/mask/smokable/cigarette))
		var/obj/item/clothing/mask/smokable/cigarette/C = W
		reagents.trans_to_obj(C, (reagents.total_volume/contents.len))
	..()

/obj/item/weapon/storage/fancy/cigarettes/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M, /mob))
		return

	if(M == user && user.zone_sel.selecting == O_MOUTH)
		// Find ourselves a cig. Note that we could be full of lighters.
		var/obj/item/clothing/mask/smokable/cigarette/cig = locate() in src

		if(cig == null)
			to_chat(user, "<span class='notice'>Похоже, в пачке кончились сигареты.</span>")
			return

		// Instead of running equip_to_slot_if_possible() we check here first,
		// to avoid dousing cig with reagents if we're not going to equip it
		if(!cig.mob_can_equip(user, slot_wear_mask))
			return

		// We call remove_from_storage first to manage the reagent transfer and
		// UI updates.
		remove_from_storage(cig, null)
		user.equip_to_slot(cig, slot_wear_mask)

		reagents.maximum_volume = 15 * contents.len
		to_chat(user, "<span class='notice'>Вы достаёте сигарету из пачки.</span>")
		update_icon()
	else
		..()

/obj/item/weapon/storage/fancy/cigarettes/dromedaryco
	name = "Пачка ДромедариКо"
	desc = "Пачка раковых палочек ДромедариКо земляного экспорта. На упаковке написано \"Медленная смерть - не так уж и банально.\"."
	description_fluff = "ДромедариКо - одна из самых старых сигаретных марок Сол, производитель которой очень гордится использованием один их и тех же индийских плантаций с 2044. Для тех, кто не против подраскошелиться на ностальгию."
	icon_state = "Dpacket"
	brand = "ДромедариКо"

/obj/item/weapon/storage/fancy/cigarettes/killthroat
	name = "Пачка АкмеКо"
	desc = "Пачка шести сигарет АкмеКо. Для тех, кто подыскивает себе самый бюджетный рак."
	description_fluff = "Доступны везде, где дышашие люди желают дышать поменьше. АкмеКо - самая дешевая и распространенная марка в галактике. На вкус позорные, но когда находишь их в своем комбинезоне после 16-часовой смены, то сойдёт и это."
	icon_state = "Apacket"
	brand = "АкмеКо"

// New exciting ways to kill your lungs! - Earthcrusher //

/obj/item/weapon/storage/fancy/cigarettes/luckystars
	name = "Пачка Лаки Старов"
	desc = "Скромная смесь из синтетически выращенного табака. Напевка из рекламы имеет свойство застревать в голове."
	description_fluff = "В Лаки Старс работают одни из самых амбициозных маркетологов на рынке, и их слоганы Gilthari Exports пластают абсолютно на всё, что можно, начиная с видеоинструктажей по безопасности на рабочем месте и заканчивая гоночными мотоциклами. 'Почувствуй тепло Лаки Стар.'."
	icon_state = "LSpacket"
	brand = "Лаки Стар"

/obj/item/weapon/storage/fancy/cigarettes/jerichos
	name = "Пачка Джерико"
	desc = "Обычно свисают с губ ветеранов флота и приграничных торговцев. На вкус как кариевый дым, по ощущениям словно жидкая смерть, что стекает в твои легкие."
	description_fluff = "Бренду Джерико пришлось долго восстанавливать свой 'потертый' имидж после своей совершенно случайно ассоциации с войной между ПравСол и гегемонией в связи со своим корпоративным присутствием в регионе. До войны Джерико ассоциировались с алкашами и разведенными мужчинами."
	icon_state = "Jpacket"
	brand = "Джерико"

/obj/item/weapon/storage/fancy/cigarettes/menthols
	name = "Пачка Темпераменто с ментолом"
	desc = "Неотъемлемый атрибут научно-исследовательского персонала, эти Темпераменто обладают резким натуральным вкусом ментола. Все уже и забыли, какие на вкус обычные!"
	description_fluff = "Темпераменто с ментолом изготавливаются Aether Atmospherics and Recyling. Вкус ментола по слухам придаётся за счет более прибыльного и дешевого химического вещества."
	icon_state = "TMpacket"
	brand = "Темпераменто с ментолом"

/obj/item/weapon/storage/fancy/cigarettes/carcinomas
	name = "Пачка Карцинома Эйнджелов"
	desc = "Прежде известный как вымирающий бренд до того, как их публично одобрила некая важная персона со старой Земли. Остальная история как в тумане. А ещё они продаёт особые сигареты для котов."
	description_fluff = "Горький вкус Карцинома Эйнджелов высоко ценится настолько же горькими типами, которые считают себя личностями 'сильной закалки'. Запах ассоциируется с городскими постами охраны порядка, а также стариками с экзонетными шоу."
	brand = "Карцинома Эйнджел"

/obj/item/weapon/storage/fancy/cigarettes/professionals
	name = "Пачка Профессиональных 120-ок"
	desc = "Будем честны, если Вы отдаёте предпочтение этим сигаретами, то либо Вы играете в богача, либо Вам за 80. Третьего не дано. Правда, они довольно высокого качества."
	description_fluff = "Выращенные и скрученные в тщательно обработанной биосфере, П120-ки рекламируются как 'чуть ли не лучшие в галактике'. Наверное, в виду своей цены, а также факта того, что большинство потребителей не учует разницу между П120-ками и любым другим ведущим брендом."
	icon_state = "P100packet"
	brand = "Профессиональная 120-ка"

/obj/item/weapon/storage/fancy/cigar
	name = "Чехол для сигар"
	desc = "Чехолчик для хранения сигар тогда, когда они Вам не нужны."
	description_fluff = "Замечательно обработанное пальмовое дерево говорит о том, что эти премиум-сигары 'Palma Grande' продаются только на роскошных лайнерах и курортах Оазиса, но на самом деле такие делают аж десять разных компаний по всей галактике. Качество, однако, весьма хорошее."
	icon_state = "cigarcase"
	icon = 'icons/obj/cigarettes.dmi'
	w_class = ITEMSIZE_TINY
	throwforce = 2
	slot_flags = SLOT_BELT
	storage_slots = 7
	can_hold = list(/obj/item/clothing/mask/smokable/cigarette/cigar, /obj/item/trash/cigbutt/cigarbutt)
	icon_type = "cigar"
	starts_with = list(/obj/item/clothing/mask/smokable/cigarette/cigar = 7)

/obj/item/weapon/storage/fancy/cigar/Initialize()
	. = ..()
	flags |= NOREACT
	create_reagents(15 * storage_slots)

/obj/item/weapon/storage/fancy/cigar/update_icon()
	icon_state = "[initial(icon_state)][contents.len]"
	return

/obj/item/weapon/storage/fancy/cigar/remove_from_storage(obj/item/W as obj, atom/new_location)
	var/obj/item/clothing/mask/smokable/cigarette/cigar/C = W
	if(!istype(C)) return
	reagents.trans_to_obj(C, (reagents.total_volume/contents.len))
	..()

/obj/item/weapon/storage/rollingpapers
	name = "Пачка закруточной бумаги"
	desc = "Небольшая пачка бумаги для самокруток."
	icon_state = "paperbox"
	icon = 'icons/obj/cigarettes.dmi'
	w_class = ITEMSIZE_TINY
	throwforce = 2
	slot_flags = SLOT_BELT
	storage_slots = 14
	can_hold = list(/obj/item/weapon/reagent_containers/rollingpaper)
	starts_with = list(/obj/item/weapon/reagent_containers/rollingpaper = 14)

/obj/item/weapon/storage/rollingpapers/blunt
	name = "blunt wrap pack"
	desc = "A small cardboard pack containing several folded blunt wraps."
	icon_state = "bluntbox"
	storage_slots = 7
	can_hold = list(/obj/item/weapon/reagent_containers/rollingpaper/blunt)
	starts_with = list(/obj/item/weapon/reagent_containers/rollingpaper/blunt = 7)

/*
 * Vial Box
 */

/obj/item/weapon/storage/fancy/vials
	icon = 'icons/obj/vialbox.dmi'
	icon_state = "vialbox6"
	icon_type = "vial"
	name = "Подставка для пробирок"
	desc = "Полезная подставка для пробирок."
	storage_slots = 6
	can_hold = list(/obj/item/weapon/reagent_containers/glass/beaker/vial)
	starts_with = list(/obj/item/weapon/reagent_containers/glass/beaker/vial = 6)

/obj/item/weapon/storage/lockbox/vials
	name = "Надёжная коробка для пробирок"
	desc = "Запертая коробка для всего, что не игрушка детям."
	icon = 'icons/obj/vialbox.dmi'
	icon_state = "vialbox0"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	max_w_class = ITEMSIZE_SMALL
	can_hold = list(/obj/item/weapon/reagent_containers/glass/beaker/vial)
	max_storage_space = ITEMSIZE_COST_SMALL * 6 //The sum of the w_classes of all the items in this storage item.
	storage_slots = 6
	req_access = list(access_virology)

/obj/item/weapon/storage/lockbox/vials/Initialize()
	. = ..()
	update_icon()

/obj/item/weapon/storage/lockbox/vials/update_icon(var/itemremoved = 0)
	var/total_contents = contents.len - itemremoved
	icon_state = "vialbox[total_contents]"
	overlays.Cut()
	if (!broken)
		overlays += image(icon, src, "led[locked]")
		if(locked)
			overlays += image(icon, src, "cover")
	else
		overlays += image(icon, src, "ledb")
	return

/obj/item/weapon/storage/lockbox/vials/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	update_icon()

/*
 * Box of Chocolates/Heart Box
 */

/obj/item/weapon/storage/fancy/heartbox
	icon_state = "heartbox"
	name = "Коробка шоколадных конфет"
	icon_type = "chocolate"

	var/startswith = 6
	max_storage_space = ITEMSIZE_COST_SMALL * 6
	can_hold = list(
		/obj/item/weapon/reagent_containers/food/snacks/chocolatepiece,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatepiece/white,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatepiece/truffle
		)
	starts_with = list(
		/obj/item/weapon/reagent_containers/food/snacks/chocolatepiece,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatepiece,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatepiece,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatepiece/white,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatepiece/white,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatepiece/truffle
	)

/obj/item/weapon/storage/fancy/heartbox/Initialize()
	. = ..()
	update_icon()

/obj/item/weapon/storage/fancy/heartbox/update_icon(var/itemremoved = 0)
	if (contents.len == 0)
		icon_state = "heartbox_empty"
