/*
 *	Everything derived from the common cardboard box.
 *	Basically everything except the original is a kit (starts full).
 *
 *	Contains:
 *		Empty box, starter boxes (survival/engineer),
 *		Latex glove and sterile mask boxes,
 *		Syringe, beaker, dna injector boxes,
 *		Blanks, flashbangs, and EMP grenade boxes,
 *		Tracking and chemical implant boxes,
 *		Prescription glasses and drinking glass boxes,
 *		Condiment bottle and silly cup boxes,
 *		Donkpocket and monkeycube boxes,
 *		ID and security PDA cart boxes,
 *		Handcuff, mousetrap, and pillbottle boxes,
 *		Snap-pops and matchboxes,
 *		Replacement light boxes.
 *
 *		For syndicate call-ins see uplink_kits.dm
 */

/obj/item/weapon/storage/box
	name = "Коробка"
	desc = "Это просто обыкновенная коробка."
	icon_state = "box"
	item_state = "syringe_kit"
	center_of_mass = list("x" = 13,"y" = 10)
	var/foldable = /obj/item/stack/material/cardboard	// BubbleWrap - if set, can be folded (when empty) into a sheet of cardboard
	var/trash = null  // if set, can be crushed into a trash item when empty
	max_w_class = ITEMSIZE_SMALL
	max_storage_space = INVENTORY_BOX_SPACE
	use_sound = 'sound/items/storage/box.ogg'
	drop_sound = 'sound/items/drop/cardboardbox.ogg'
	pickup_sound = 'sound/items/pickup/cardboardbox.ogg'

// BubbleWrap - A box can be folded up to make card
/obj/item/weapon/storage/box/attack_self(mob/user as mob)
	if(..()) return

	//try to fold it
	if(ispath(foldable))
		if (contents.len)
			return
		var/found = 0
		// Close any open UI windows first
		for(var/mob/M in range(1))
			if (M.s_active == src)
				close(M)
			if (M == user)
				found = 1
		if (!found)	// User is too far away
			return
		// Now make the cardboard
		to_chat(user, "<span class='notice'>Вы сдавливаете [ru_getcase(src, "acase")] в плоскую форму.</span>")
		playsound(src, 'sound/items/storage/boxfold.ogg', 30, 1)
		new foldable(get_turf(src))
		qdel(src)

	//try to crush it
	if(ispath(trash))
		if(contents.len &&  user.a_intent == I_HURT)  // only crumple with things inside on harmintent.
			user.visible_message(SPAN_DANGER("[user] [ru_g_mob(user, "смина", "ет", "ет", "ет", "ют")] [ru_getcase(src, "acase")], выбрасывая содержимое!"), SPAN_DANGER("Вы сминаете [ru_getcase(src, "acase")], выбрасывая содержимое!"))
			spill()
		else
			to_chat(user, SPAN_NOTICE("Вы сминаете [ru_getcase(src, "acase")].")) //make trash
		playsound(src.loc, 'sound/items/drop/wrapper.ogg', 30, 1)
		var/obj/item/trash = new src.trash()
		qdel(src)
		user.put_in_hands(trash)


/obj/item/weapon/storage/box/survival
	name = "Коробка аварийных припасов"
	desc = "Коробка, содержащая припасы на случай чрезвычайных ситуаций."
	starts_with = list(
		/obj/item/clothing/mask/breath
	)

/obj/item/weapon/storage/box/survival/synth
	name = "Коробка синтетических припасов"
	desc = "Коробка, содержащая припасы для синтетических членов экипажа на случай чрезвычайных ситуаций."
	starts_with = list(
	)

/obj/item/weapon/storage/box/survival/comp
	name = "Коробка аварийных припасов"
	desc = "Коробка, содержащая большое количество припасов на случай чрезвычайных ситуаций."
	icon_state = "survival"
	starts_with = list(
		/obj/item/weapon/reagent_containers/hypospray/autoinjector,
		/obj/item/stack/medical/bruise_pack,
		/obj/item/device/flashlight/glowstick,
		/obj/item/weapon/reagent_containers/food/snacks/candy/proteinbar,
		/obj/item/clothing/mask/breath
	)

/obj/item/weapon/storage/box/gloves
	name = "Коробка латексных перчаток"
	desc = "Содержит белые перчатки."
	icon_state = "latex"
	starts_with = list(/obj/item/clothing/gloves/sterile/latex = 7)

/obj/item/weapon/storage/box/masks
	name = "Коробка стерильных масок"
	desc = "Содержит стерильные маски."
	icon_state = "sterile"
	starts_with = list(/obj/item/clothing/mask/surgical = 7)

/obj/item/weapon/storage/box/syringes
	name = "Коробка шприцов"
	desc = "Коробка, доверху забитая шприцами."
	icon_state = "syringe"
	starts_with = list(/obj/item/weapon/reagent_containers/syringe = 7)

/obj/item/weapon/storage/box/syringegun
	name = "Коробка картриджей для шприцемёта"
	desc = "Коробка, доверху забитая картриджами сжатого газа."
	icon_state = "syringe"
	starts_with = list(/obj/item/weapon/syringe_cartridge = 7)

/obj/item/weapon/storage/box/beakers
	name = "Коробка мензурок"
	desc = "Коробка, доверху забитая мензурками."
	icon_state = "beaker"
	starts_with = list(/obj/item/weapon/reagent_containers/glass/beaker = 7)

/obj/item/weapon/storage/box/injectors
	name = "Коробка инъекторов ДНК"
	desc = "В этой коробке много инъекторов, видимо."
	starts_with = list(
		/obj/item/weapon/dnainjector/h2m = 3,
		/obj/item/weapon/dnainjector/m2h = 3
	)

/obj/item/weapon/storage/box/blanks
	name = "Коробка пустых патронов"
	desc = "На ней изображение ружья и несколько предупреждающих символов."
	icon_state = "blankshot_box"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	starts_with = list(/obj/item/ammo_casing/a12g/blank = 8)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/blanks/large
	starts_with = list(/obj/item/ammo_casing/a12g/blank = 16)

/obj/item/weapon/storage/box/beanbags
	name = "Коробка пластиковых патронов"
	desc = "На ней изображение ружья и несколько предупреждающих символов.<br>ВНИМАНИЕ: Настоящие патроны. Неправильное использование может привести к травме или гибели."
	icon_state = "beanshot_box"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	starts_with = list(/obj/item/ammo_casing/a12g/beanbag = 8)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/beanbags/large/New()
	starts_with = list(/obj/item/ammo_casing/a12g/beanbag = 16)

/obj/item/weapon/storage/box/shotgunammo
	name = "Коробка ружейных жаканов"
	desc = "На ней изображение ружья и несколько предупреждающих символов.<br>ВНИМАНИЕ: Настоящие патроны. Неправильное использование может привести к травме или гибели."
	icon_state = "lethalshellshot_box"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	starts_with = list(/obj/item/ammo_casing/a12g = 8)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/shotgunammo/large
	starts_with = list(/obj/item/ammo_casing/a12g = 16)

/obj/item/weapon/storage/box/shotgunshells
	name = "Коробка ружейных патронов"
	desc = "На ней изображение ружья и несколько предупреждающих символов.<br>ВНИМАНИЕ: Настоящие патроны. Неправильное использование может привести к травме или гибели."
	icon_state = "lethalslug_box"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	starts_with = list(/obj/item/ammo_casing/a12g/pellet = 8)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/shotgunshells/large
	starts_with = list(/obj/item/ammo_casing/a12g/pellet = 16)

/obj/item/weapon/storage/box/flashshells
	name = "Коробка световых патронов"
	desc = "На ней изображение ружья и несколько предупреждающих символов.<br>ВНИМАНИЕ: Настоящие патроны. Неправильное использование может привести к травме или гибели."
	icon_state = "illumshot_box"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	starts_with = list(/obj/item/ammo_casing/a12g/flash = 8)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/flashshells/large
	starts_with = list(/obj/item/ammo_casing/a12g/flash = 16)

/obj/item/weapon/storage/box/stunshells
	name = "Коробка оглушающих патронов"
	desc = "На ней изображение ружья и несколько предупреждающих символов.<br>ВНИМАНИЕ: Настоящие патроны. Неправильное использование может привести к травме или гибели."
	icon_state = "stunshot_box"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	starts_with = list(/obj/item/ammo_casing/a12g/stunshell = 8)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/stunshells/large
	starts_with = list(/obj/item/ammo_casing/a12g/stunshell = 16)

/obj/item/weapon/storage/box/practiceshells
	name = "Коробка учебных патронов"
	desc = "На ней изображение ружья и несколько предупреждающих символов.<br>ВНИМАНИЕ: Настоящие патроны. Неправильное использование может привести к травме или гибели."
	icon_state = "blankshot_box"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	starts_with = list(/obj/item/ammo_casing/a12g/practice = 8)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/practiceshells/large
	starts_with = list(/obj/item/ammo_casing/a12g/practice = 16)

/obj/item/weapon/storage/box/empshells
	name = "Коробка ЭМИ-патронов"
	desc = "На ней изображение ружья и несколько предупреждающих символов."
	icon_state = "empshot_box"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	starts_with = list(/obj/item/ammo_casing/a12g/emp = 8)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/empshells/large
	starts_with = list(/obj/item/ammo_casing/a12g/emp = 16)

/obj/item/weapon/storage/box/flechetteshells
	name = "Коробка стреловидных патронов"
	desc = "На ней изображение ружья и несколько предупреждающих символов.<br>ВНИМАНИЕ: Настоящие патроны. Неправильное использование может привести к травме или гибели."
	icon_state = "lethalslug_box"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	starts_with = list(/obj/item/ammo_casing/a12g/flechette = 8)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/flechetteshells/large
	starts_with = list(/obj/item/ammo_casing/a12g/flechette = 16)

/obj/item/weapon/storage/box/sniperammo
	name = "Коробка патронов 14.5 мм"
	desc = "На ней изображение ружья и несколько предупреждающих символов.<br>ВНИМАНИЕ: Настоящие патроны. Неправильное использование может привести к травме или гибели."
	starts_with = list(/obj/item/ammo_casing/a145 = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/sniperammo/highvel
	name = "Коробка саботажных патронов 14.5 мм"
	desc = "На ней изображение ружья и несколько предупреждающих символов.<br>ВНИМАНИЕ: Настоящие патроны. Неправильное использование может привести к травме или гибели."
	starts_with = list(/obj/item/ammo_casing/a145/highvel = 7)

/obj/item/weapon/storage/box/flashbangs
	name = "Коробка светошумовых гранат (ОСТОРОЖНО)"
	desc = "<B>ВНИМАНИЕ: Эти приспособления крайне опасны и могут привести к слепоте и глухоте при многократном использовании.</B>"
	icon_state = "flashbang"
	starts_with = list(/obj/item/weapon/grenade/flashbang = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/emps
	name = "Коробка ЭМИ-гранат"
	desc = "Коробка, содержащая 5 ЭМИ-гранат военного качества.<br> ВНИМАНИЕ: Не использовать близи незащищенной электроники или биомеханических компонентов в связис с риском гибели или перманентного паралича."
	icon_state = "emp"
	starts_with = list(/obj/item/weapon/grenade/empgrenade = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/empslite
	name = "Коробка слабых ЭМИ-гранат"
	desc = "Коробка, содержащая 5 ЭМИ-гранат слабой мощности.<br> ВНИМАНИЕ: Не использовать близи незащищенной электроники или биомеханических компонентов в связис с риском гибели или перманентного паралича."
	icon_state = "emp"
	starts_with = list(/obj/item/weapon/grenade/empgrenade/low_yield = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/smokes
	name = "Коробка дымовых гранат"
	desc = "Коробка, содержащая 7 дымовых гранат."
	icon_state = "flashbang"
	starts_with = list(/obj/item/weapon/grenade/smokebomb = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/anti_photons
	name = "Коробка антифотоновых гранат"
	desc = "Коробка, содержащая 7 экспериментальных антифотоновых гранат."
	icon_state = "flashbang"
	starts_with = list(/obj/item/weapon/grenade/anti_photon = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/frags
	name = "Коробка осколочных гранат (ОСТОРОЖНО)"
	desc = "Коробка, содержащая 7 осколочных гранат военного качества. <br> ВНИМАНИЕ: Эти приспособления крайне опасны и могут привести к утрате конечностей или смерти при многократном использовании."
	icon_state = "frag"
	starts_with = list(/obj/item/weapon/grenade/explosive = 7)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/frags_half_box
	name = "Коробка осколочных гранат (ОСТОРОЖНО)"
	desc = "Коробка, содержащая 4 осколочных гранат военного качества. <br> ВНИМАНИЕ: Эти приспособления крайне опасны и могут привести к утрате конечностей или смерти при многократном использовании."
	icon_state = "frag"
	starts_with = list(/obj/item/weapon/grenade/explosive = 4)
	drop_sound = 'sound/items/drop/ammobox.ogg'
	pickup_sound = 'sound/items/pickup/ammobox.ogg'

/obj/item/weapon/storage/box/metalfoam
	name = "Коробка металлопенных гранат"
	desc = "Коробка, содержащая 7 металлопенных гранат."
	icon_state = "flashbang"
	starts_with = list(/obj/item/weapon/grenade/chem_grenade/metalfoam = 7)

/obj/item/weapon/storage/box/teargas
	name = "Коробка гранат со слезоточивым газом"
	desc = "Коробка, содержащая 7 гранат со слезоточивым газом."
	icon_state = "flashbang"
	starts_with = list(/obj/item/weapon/grenade/chem_grenade/teargas = 7)

/obj/item/weapon/storage/box/flare
	name = "Коробка сигнальных ракет"
	desc = "Коробка, содержащая 4 сигнальных ракеты."
	starts_with = list(/obj/item/device/flashlight/flare = 4)

/obj/item/weapon/storage/box/trackimp
	name = "Набор имплантантов отслеживания"
	desc = "Коробка, забитая доверху приспособлениями для отслеживания отморозков."
	icon_state = "implant"
	starts_with = list(
		/obj/item/weapon/implantcase/tracking = 4,
		/obj/item/weapon/implanter,
		/obj/item/weapon/implantpad,
		/obj/item/weapon/locator
	)

/obj/item/weapon/storage/box/chemimp
	name = "Набор химических имплантантов"
	desc = "Коробка приспособлений для вживления химических имплантантов."
	icon_state = "implant"
	starts_with = list(
		/obj/item/weapon/implantcase/chem = 5,
		/obj/item/weapon/implanter,
		/obj/item/weapon/implantpad
	)

/obj/item/weapon/storage/box/camerabug
	name = "Коробка подвижных камер слежки"
	desc = "Коробка, содержащая несколько подвижных камер слежки."
	icon_state = "pda"
	starts_with = list(
		/obj/item/device/camerabug = 6,
		/obj/item/device/bug_monitor
	)

/obj/item/weapon/storage/box/rxglasses
	name = "Коробка рецептурных очков"
	desc = "Эта коробка содержит очки для ботанов."
	icon_state = "glasses"
	starts_with = list(/obj/item/clothing/glasses/regular = 7)

/obj/item/weapon/storage/box/cdeathalarm_kit
	name = "Набор сигнализации о гибели"
	desc = "Коробка с принадлежностями для вживления имплантанта, сигнализирующего о смерти."
	icon_state = "implant"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	starts_with = list(
		/obj/item/weapon/implantcase/death_alarm = 7,
		/obj/item/weapon/implanter
	)

/obj/item/weapon/storage/box/condimentbottles
	name = "Коробка бутылок для ингредиентов"
	desc = "На ней огромный след от кетчупа."
	starts_with = list(/obj/item/weapon/reagent_containers/food/condiment = 7)

/obj/item/weapon/storage/box/cups
	name = "Коробка бумажных стаканчиков"
	desc = "На ней картинки с бумажными стаканчиками."
	starts_with = list(/obj/item/weapon/reagent_containers/food/drinks/sillycup = 7)

/obj/item/weapon/storage/box/donkpockets
	name = "Коробка донк-покетов"
	desc = "<B>Инструкция по приготовлению:</B> <I>Разогрейте в микроволновке. Продукт остывает спустя семь минут.</I>"
	icon_state = "donk_kit"
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/donkpocket = 7)

/obj/item/weapon/storage/box/sinpockets
	name = "Коробка син-покетов"
	desc = "<B>Инструкция:</B> <I>Придавите нижнюю часть коробки для активации химического разогрева. Подождите 20 секунд перед употреблением. Продукт остывает спустя семь минут.</I>"
	icon_state = "donk_kit"
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/donkpocket/sinpocket = 7)

/obj/item/weapon/storage/box/buns
	name = "Коробка хлебных булок"
	desc = "Словно только что из духовки, месяц или два назад."
	icon_state = "bun_box"
	max_storage_space = ITEMSIZE_COST_NORMAL * 5
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/bun = 12)

/obj/item/weapon/storage/box/monkeycubes
	name = "Коробка обезьяньих кубов"
	desc = "Обезьяньи кубы бренда Drymate. Просто добавьте воды!"
	icon = 'icons/obj/food.dmi'
	icon_state = "monkeycubebox"
	can_hold = list(/obj/item/weapon/reagent_containers/food/snacks/monkeycube)
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped = 4)

/obj/item/weapon/storage/box/monkeycubes/farwacubes
	name = "Коробка фарвовых кубов"
	desc = "Фарвовые кубы бренда Drymate. Просто добавьте воды!"
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/farwacube = 4)

/obj/item/weapon/storage/box/monkeycubes/stokcubes
	name = "Коробка стоковых кубов"
	desc = "Стоковые кубы бренда Drymate. Просто добавьте воды!"
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/stokcube = 4)

/obj/item/weapon/storage/box/monkeycubes/neaeracubes
	name = "Коробка нееровых кубов"
	desc = "Нееровы кубы бренда Drymate. Просто добавьте воды!"
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube = 4)

/obj/item/weapon/storage/box/ids
	name = "Коробка запасных ID-карт"
	desc = "В ней очень много пустых ID-карт."
	icon_state = "id"
	starts_with = list(/obj/item/weapon/card/id = 7)

/obj/item/weapon/storage/box/seccarts
	name = "Коробка запасных картриджей R.O.B.U.S.T."
	desc = "Коробка, полная запасных картриджей R.O.B.U.S.T., используемых службой безопасности."
	icon_state = "pda"
	starts_with = list(/obj/item/weapon/cartridge/security = 7)

/obj/item/weapon/storage/box/handcuffs
	name = "Коробка запасных наручников"
	desc = "Коробка, забитая доверху наручниками."
	icon_state = "handcuff"
	starts_with = list(/obj/item/weapon/handcuffs = 7)

/obj/item/weapon/storage/box/mousetraps
	name = "Коробка мышеловок Pest-B-Gon"
	desc = "<B><FONT color='red'>ВНИМАНИЕ:</FONT></B> <I>Хранить в недоступном для детей месте</I>."
	icon_state = "mousetraps"
	starts_with = list(/obj/item/device/assembly/mousetrap = 7)

/obj/item/weapon/storage/box/pillbottles
	name = "Коробка пузырьков для таблеток"
	desc = "На ней нарисованы пузырьки для таблеток."
	starts_with = list(/obj/item/weapon/storage/pill_bottle = 7)

/obj/item/weapon/storage/box/snappops
	name = "Коробка хлопушек"
	desc = "Всего восемь хлопушек, зато сколько эмоций! Детям от восьми лет."
	icon = 'icons/obj/toy.dmi'
	icon_state = "spbox"
	can_hold = list(/obj/item/toy/snappop)
	starts_with = list(/obj/item/toy/snappop = 8)

/obj/item/weapon/storage/box/matches
	name = "Коробок спичек"
	desc = "Маленький коробок космонепроницаемых спичек премиум-качества."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "matchbox"
	w_class = ITEMSIZE_TINY
	slot_flags = SLOT_BELT
	can_hold = list(/obj/item/weapon/flame/match)
	starts_with = list(/obj/item/weapon/flame/match = 10)
	drop_sound = 'sound/items/drop/matchbox.ogg'
	pickup_sound =  'sound/items/pickup/matchbox.ogg'

/obj/item/weapon/storage/box/matches/attackby(var/obj/item/weapon/flame/match/W, var/mob/user)
	if(istype(W) && !W.lit && !W.burnt)
		if(prob(25))
			W.light(user)
			user.visible_message("<span class='notice'>[user] зажигает спичку о коробок.</span>")
		else
			playsound(src, 'sound/items/cigs_lighters/matchstick_hit.ogg', 25, 0, -1)
	W.update_icon()
	return

/obj/item/weapon/storage/box/autoinjectors
	name = "Коробка инъекторов"
	desc = "Содержит автоинъекторы."
	icon_state = "syringe"
	starts_with = list(/obj/item/weapon/reagent_containers/hypospray/autoinjector = 7)

/obj/item/weapon/storage/box/lights
	name = "Коробка запасных лампочек"
	icon = 'icons/obj/storage.dmi'
	icon_state = "light"
	desc = "В этой коробке подложка, в которую влезают только лампочки."
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	storage_slots = 24
	can_hold = list(/obj/item/weapon/light/tube, /obj/item/weapon/light/bulb)
	max_storage_space = ITEMSIZE_COST_SMALL * 24 //holds 24 items of w_class 2
	use_to_pickup = 1 // for picking up broken bulbs, not that most people will try

/obj/item/weapon/storage/box/lights/bulbs
	starts_with = list(/obj/item/weapon/light/bulb = 24)

/obj/item/weapon/storage/box/lights/tubes
	name = "Коробка запасных лампочек"
	icon_state = "lighttube"
	starts_with = list(/obj/item/weapon/light/tube = 24)

/obj/item/weapon/storage/box/lights/mixed
	name = "Коробка запасных лампочек"
	icon_state = "lightmixed"
	starts_with = list(
		/obj/item/weapon/light/tube = 16,
		/obj/item/weapon/light/bulb = 8
	)

/obj/item/weapon/storage/box/freezer
	name = "Переносной морозильник"
	desc = "Очень удобное и прочное приспособление, в котором Ваши 'продукты' точно не испортятся."
	icon = 'icons/obj/storage.dmi'
	icon_state = "portafreezer"
	item_state_slots = list(slot_r_hand_str = "medicalpack", slot_l_hand_str = "medicalpack")
	foldable = null
	max_w_class = ITEMSIZE_NORMAL
	can_hold = list(/obj/item/organ)
	max_storage_space = ITEMSIZE_COST_NORMAL * 5 // Formally 21.  Odd numbers are bad.
	use_to_pickup = 1 // for picking up broken bulbs, not that most people will try

/obj/item/weapon/storage/box/freezer/Entered(var/atom/movable/AM)
	if(istype(AM, /obj/item/organ))
		var/obj/item/organ/O = AM
		O.preserved = 1
		for(var/obj/item/organ/organ in O)
			organ.preserved = 1
	..()

/obj/item/weapon/storage/box/freezer/Exited(var/atom/movable/AM)
	if(istype(AM, /obj/item/organ))
		var/obj/item/organ/O = AM
		O.preserved = 0
		for(var/obj/item/organ/organ in O)
			organ.preserved = 0
	..()

/obj/item/weapon/storage/box/ambrosia
	name = "Коробка семян амброзии"
	desc = "Содержит все необходимые семена для того, чтобы словить немножко кайфа."
	starts_with = list(/obj/item/seeds/ambrosiavulgarisseed = 7)

/obj/item/weapon/storage/box/ambrosiadeus
	name = "Коробка семян амброзии деус"
	desc = "Содержит все необходимые семена для того, чтобы словить прилично кайфа."
	starts_with = list(/obj/item/seeds/ambrosiadeusseed = 7)