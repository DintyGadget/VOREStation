/obj/item/weapon/storage/box/syndicate/Initialize()
	switch (pickweight(list("bloodyspai" = 1, "stealth" = 1, "screwed" = 1, "guns" = 1, "murder" = 1, "freedom" = 1, "hacker" = 1, "lordsingulo" = 1, "smoothoperator" = 1)))
		if("bloodyspai")
			new /obj/item/clothing/under/chameleon(src)
			new /obj/item/clothing/mask/gas/voice(src)
			new /obj/item/weapon/card/id/syndicate(src)
			new /obj/item/clothing/shoes/syndigaloshes(src)

		if("stealth")
			new /obj/item/weapon/gun/energy/crossbow(src)
			new /obj/item/weapon/pen/reagent/paralysis(src)
			new /obj/item/device/chameleon(src)

		if("screwed")
			new /obj/effect/spawner/newbomb/timer/syndicate(src)
			new /obj/effect/spawner/newbomb/timer/syndicate(src)
			new /obj/item/device/powersink(src)
			new /obj/item/clothing/suit/space/syndicate(src)
			new /obj/item/clothing/head/helmet/space/syndicate(src)
			new /obj/item/clothing/mask/gas/syndicate(src)
			new /obj/item/weapon/tank/emergency/oxygen/double(src)

		if("guns")
			new /obj/item/weapon/gun/projectile/revolver(src)
			new /obj/item/ammo_magazine/s357(src)
			new /obj/item/weapon/card/emag(src)
			new /obj/item/weapon/plastique(src)
			new /obj/item/weapon/plastique(src)

		if("murder")
			new /obj/item/weapon/melee/energy/sword(src)
			new /obj/item/clothing/glasses/thermal/syndi(src)
			new /obj/item/weapon/card/emag(src)
			new /obj/item/clothing/shoes/syndigaloshes(src)

		if("freedom")
			var/obj/item/weapon/implanter/O = new /obj/item/weapon/implanter(src)
			O.imp = new /obj/item/weapon/implant/freedom(O)
			var/obj/item/weapon/implanter/U = new /obj/item/weapon/implanter(src)
			U.imp = new /obj/item/weapon/implant/uplink(U)

		if("hacker")
			new /obj/item/device/encryptionkey/syndicate(src)
			new /obj/item/weapon/aiModule/syndicate(src)
			new /obj/item/weapon/card/emag(src)
			new /obj/item/device/encryptionkey/binary(src)

		if("lordsingulo")
			new /obj/item/device/radio/beacon/syndicate(src)
			new /obj/item/clothing/suit/space/syndicate(src)
			new /obj/item/clothing/head/helmet/space/syndicate(src)
			new /obj/item/clothing/mask/gas/syndicate(src)
			new /obj/item/weapon/tank/emergency/oxygen/double(src)
			new /obj/item/weapon/card/emag(src)

		if("smoothoperator")
			new /obj/item/weapon/storage/box/syndie_kit/g9mm(src)
			new /obj/item/weapon/storage/bag/trash(src)
			new /obj/item/weapon/soap/syndie(src)
			new /obj/item/bodybag(src)
			new /obj/item/clothing/under/suit_jacket(src)
			new /obj/item/clothing/shoes/laceup(src)
	. = ..()

/obj/item/weapon/storage/box/syndie_kit
	name = "коробка"
	desc = "Элегантная прочная коробка"
	icon_state = "box_of_doom"

/obj/item/weapon/storage/box/syndie_kit/imp_freedom
	name = "имплант свободы в коробке (с инжектором)"

/obj/item/weapon/storage/box/syndie_kit/imp_freedom/Initialize()
	var/obj/item/weapon/implanter/O = new(src)
	O.imp = new /obj/item/weapon/implant/freedom(O)
	O.update()
	. = ..()

/obj/item/weapon/storage/box/syndie_kit/imp_compress
	name = "коробка (C)"
	starts_with = list(/obj/item/weapon/implanter/compressed)

/obj/item/weapon/storage/box/syndie_kit/imp_explosive
	name = "коробка (E)"
	starts_with = list(/obj/item/weapon/implanter/explosive)

/obj/item/weapon/storage/box/syndie_kit/imp_uplink
	name = "boxed uplink implant (with injector)"

/obj/item/weapon/storage/box/syndie_kit/imp_uplink/Initialize()
	var/obj/item/weapon/implanter/O = new(src)
	O.imp = new /obj/item/weapon/implant/uplink(O)
	O.update()
	. = ..()

/obj/item/weapon/storage/box/syndie_kit/imp_aug
	name = "упакованный аугментарный имплант (с инжектором)"
	var/case_type = /obj/item/weapon/implantcase/shades

/obj/item/weapon/storage/box/syndie_kit/imp_aug/Initialize()
	new /obj/item/weapon/implanter(src)
	new case_type(src)
	. = ..()

/obj/item/weapon/storage/box/syndie_kit/imp_aug/taser
	case_type = /obj/item/weapon/implantcase/taser

/obj/item/weapon/storage/box/syndie_kit/imp_aug/laser
	case_type = /obj/item/weapon/implantcase/laser

/obj/item/weapon/storage/box/syndie_kit/imp_aug/dart
	case_type = /obj/item/weapon/implantcase/dart

/obj/item/weapon/storage/box/syndie_kit/imp_aug/toolkit
	case_type = /obj/item/weapon/implantcase/toolkit

/obj/item/weapon/storage/box/syndie_kit/imp_aug/medkit
	case_type = /obj/item/weapon/implantcase/medkit

/obj/item/weapon/storage/box/syndie_kit/imp_aug/surge
	case_type = /obj/item/weapon/implantcase/surge

/obj/item/weapon/storage/box/syndie_kit/imp_aug/analyzer
	case_type = /obj/item/weapon/implantcase/analyzer

/obj/item/weapon/storage/box/syndie_kit/imp_aug/sword
	case_type = /obj/item/weapon/implantcase/sword

/obj/item/weapon/storage/box/syndie_kit/imp_aug/sprinter
	case_type = /obj/item/weapon/implantcase/sprinter

/obj/item/weapon/storage/box/syndie_kit/imp_aug/armblade
	case_type = /obj/item/weapon/implantcase/armblade

/obj/item/weapon/storage/box/syndie_kit/imp_aug/handblade
	case_type = /obj/item/weapon/implantcase/handblade

/obj/item/weapon/storage/box/syndie_kit/space
	name = "boxed space suit and helmet"
	starts_with = list(
		/obj/item/clothing/suit/space/syndicate,
		/obj/item/clothing/head/helmet/space/syndicate,
		/obj/item/clothing/mask/gas/syndicate,
		/obj/item/weapon/tank/emergency/oxygen/double
	)

/obj/item/weapon/storage/box/syndie_kit/chameleon
	name = "набор хамелеон"
	desc = "Поставляется со всей одеждой, которая вам понадобится, чтобы выдать себя за большинство людей. Уроки актерского мастерства продаются отдельно."
	starts_with = list(
		/obj/item/weapon/storage/backpack/chameleon/full,
		/obj/item/weapon/gun/energy/chameleon
	)

/obj/item/weapon/storage/box/syndie_kit/clerical
	name = "канцелярский набор"
	desc = "Поставляется со всем необходимым для фальшивых документов. Предполагается, что вы прошли базовые уроки письма."
	starts_with = list(
		/obj/item/weapon/stamp/chameleon,
		/obj/item/weapon/pen/chameleon,
		/obj/item/device/destTagger,
		/obj/item/weapon/packageWrap,
		/obj/item/weapon/hand_labeler
	)

/obj/item/weapon/storage/box/syndie_kit/spy
	name = "набор шпиона"
	desc = "Когда вы хотите провести вуайеризм издалека."
	starts_with = list(
		/obj/item/device/camerabug/spy = 6,
		/obj/item/device/bug_monitor/spy
	)

/obj/item/weapon/storage/box/syndie_kit/g9mm
	name = "\improper Smooth operator"
	desc = "Компактный 9мм с комплектом глушителя."
	starts_with = list(
		/obj/item/weapon/gun/projectile/pistol,
		/obj/item/weapon/silencer
	)

/obj/item/weapon/storage/box/syndie_kit/toxin
	name = "набор токсинов"
	desc = "После этого одного яблока будет недостаточно, чтобы привести врача."
	starts_with = list(
		/obj/item/weapon/reagent_containers/glass/beaker/vial/random/toxin,
		/obj/item/weapon/reagent_containers/syringe
	)

/obj/item/weapon/storage/box/syndie_kit/cigarette
	name = "\improper Tricky smokes"
	desc = "Поставляется с сигаретами следующих марок в указанном порядке: 2xFlash, 2xSmoke, 1xMindBreaker, 1xTricordrazine. Не смешивайте их."

/obj/item/weapon/storage/box/syndie_kit/cigarette/Initialize()
	. = ..()
	var/obj/item/weapon/storage/fancy/cigarettes/pack

	pack = new /obj/item/weapon/storage/fancy/cigarettes(src)
	fill_cigarre_package(pack, list("aluminum" = 5, "potassium" = 5, "sulfur" = 5))
	pack.desc += " 'F' has been scribbled on it."

	pack = new /obj/item/weapon/storage/fancy/cigarettes(src)
	fill_cigarre_package(pack, list("aluminum" = 5, "potassium" = 5, "sulfur" = 5))
	pack.desc += " 'F' has been scribbled on it."

	pack = new /obj/item/weapon/storage/fancy/cigarettes(src)
	fill_cigarre_package(pack, list("potassium" = 5, "sugar" = 5, "phosphorus" = 5))
	pack.desc += " 'S' has been scribbled on it."

	pack = new /obj/item/weapon/storage/fancy/cigarettes(src)
	fill_cigarre_package(pack, list("potassium" = 5, "sugar" = 5, "phosphorus" = 5))
	pack.desc += " 'S' has been scribbled on it."

	pack = new /obj/item/weapon/storage/fancy/cigarettes(src)
	// Dylovene. Going with 1.5 rather than 1.6666666...
	fill_cigarre_package(pack, list("potassium" = 1.5, "nitrogen" = 1.5, "silicon" = 1.5))
	// Mindbreaker
	fill_cigarre_package(pack, list("silicon" = 4.5, "hydrogen" = 4.5))

	pack.desc += " 'MB' has been scribbled on it."

	pack = new /obj/item/weapon/storage/fancy/cigarettes(src)
	pack.reagents.add_reagent("tricordrazine", 15 * pack.storage_slots)
	pack.desc += " 'T' has been scribbled on it."

	new /obj/item/weapon/flame/lighter/zippo(src)

	calibrate_size()

/proc/fill_cigarre_package(var/obj/item/weapon/storage/fancy/cigarettes/C, var/list/reagents)
	for(var/reagent in reagents)
		C.reagents.add_reagent(reagent, reagents[reagent] * C.storage_slots)

/obj/item/weapon/storage/box/syndie_kit/ewar_voice
	name = "Комплект электрооборудования и синтезатора голоса"
	desc = "Набор для смешения как органических, так и синтетических сущностей."
	starts_with = list(
		/obj/item/rig_module/electrowarfare_suite,
		/obj/item/rig_module/voice
	)

/obj/item/weapon/storage/secure/briefcase/money
	name = "подозрительный портфель"
	desc = "Зловещий портфель, от которого безошибочно пахнет старым, затхлым сигаретным дымом и доставляет неприятные ощущения тем, кто на него смотрит."
	starts_with = list(/obj/item/weapon/spacecash/c1000 = 10)

/obj/item/weapon/storage/box/syndie_kit/combat_armor
	name = "комплект боевой брони"
	desc = "Содержит полный комплект боевой брони."
	starts_with = list(
		/obj/item/clothing/head/helmet/combat,
		/obj/item/clothing/suit/armor/combat,
		/obj/item/clothing/gloves/arm_guard/combat,
		/obj/item/clothing/shoes/leg_guard/combat
	)

/obj/item/weapon/storage/box/syndie_kit/demolitions
	starts_with = list(
		/obj/item/weapon/syndie/c4explosive,
		/obj/item/weapon/tool/screwdriver
	)

/obj/item/weapon/storage/box/syndie_kit/demolitions_heavy
	starts_with = list(
		/obj/item/weapon/syndie/c4explosive/heavy,
		/obj/item/weapon/tool/screwdriver
	)

/obj/item/weapon/storage/box/syndie_kit/demolitions_super_heavy
	starts_with = list(
		/obj/item/weapon/syndie/c4explosive/heavy/super_heavy,
		/obj/item/weapon/tool/screwdriver
	)

/obj/item/weapon/storage/box/syndie_kit/voidsuit
	starts_with = list(
		/obj/item/clothing/suit/space/void/merc,
		/obj/item/clothing/head/helmet/space/void/merc,
		/obj/item/clothing/shoes/magboots,
		/obj/item/weapon/tank/jetpack/oxygen
	)

/obj/item/weapon/storage/box/syndie_kit/voidsuit/fire
	starts_with = list(
		/obj/item/clothing/suit/space/void/merc/fire,
		/obj/item/clothing/head/helmet/space/void/merc/fire,
		/obj/item/clothing/shoes/magboots,
		/obj/item/weapon/tank/jetpack/oxygen
	)

/obj/item/weapon/storage/box/syndie_kit/concussion_grenade
	starts_with = list(
		/obj/item/weapon/grenade/concussion = 8
		)

/obj/item/weapon/storage/box/syndie_kit/deadliest_game
	starts_with = list(
		/obj/item/weapon/beartrap/hunting = 4
		)

/obj/item/weapon/storage/box/syndie_kit/viral
	starts_with = list(
		/obj/item/weapon/virusdish/random = 3
		)

/obj/item/weapon/storage/secure/briefcase/rifle
	name = "secure briefcase"
	starts_with = list(
		/obj/item/sniper_rifle_part/barrel,
		/obj/item/sniper_rifle_part/stock,
		/obj/item/sniper_rifle_part/trigger_group,
		/obj/item/ammo_casing/a145 = 4
	)

/obj/item/weapon/storage/secure/briefcase/flamer
	name = "secure briefcase"
	starts_with = list(
		/obj/item/weapon/gun/magnetic/gasthrower,
		/obj/item/weapon/cell/super,
		/obj/item/weapon/stock_parts/capacitor/adv,
		/obj/item/weapon/tank/phoron/pressurized = 2
	)

/obj/item/weapon/storage/secure/briefcase/fuelrod
	name = "тяжелый портфель"
	desc = "Тяжелый закрытый портфель."
	description_fluff = "При открытии контейнера кажется, что в упаковке есть несколько углублений странной формы."
	description_antag = "В этом ящике, вероятно, будет заряженная пушка с топливными стержнями и несколько топливных стержней. В нем можно разместить только топливный стержень, топливные стержни, батареи, отвертку и стандартные детали машин."
	force = 12 //Anti-rad lined i.e. Lead, probably gonna hurt a bit if you get bashed with it.
	can_hold = list(/obj/item/weapon/gun/magnetic/fuelrod, /obj/item/weapon/fuel_assembly, /obj/item/weapon/cell, /obj/item/weapon/stock_parts, /obj/item/weapon/tool/screwdriver)
	cant_hold = list(/obj/item/weapon/tool/screwdriver/power)
	starts_with = list(
		/obj/item/weapon/gun/magnetic/fuelrod,
		/obj/item/weapon/fuel_assembly/deuterium,
		/obj/item/weapon/fuel_assembly/deuterium,
		/obj/item/weapon/fuel_assembly/tritium,
		/obj/item/weapon/fuel_assembly/tritium,
		/obj/item/weapon/fuel_assembly/phoron,
		/obj/item/weapon/tool/screwdriver
	)
