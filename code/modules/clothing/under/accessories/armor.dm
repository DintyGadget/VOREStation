/*
// This file holds all of the accessories used as part of the modular armor system. At some point it might be wise to split this into multiple files.
*/

/obj/item/clothing/accessory/armor
	name = "Аксессуар брони"
	desc = "По идее это описание не должно быть видно. Позовите админа."
	icon_override = 'icons/mob/modular_armor.dmi'
	icon = 'icons/obj/clothing/modular_armor.dmi'
	icon_state = "pouches"
	w_class = ITEMSIZE_NORMAL

/obj/item/clothing/accessory/armor/on_attached(var/obj/item/clothing/S, var/mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.wear_suit == S)
			if((body_parts_covered & ARMS) && istype(H.gloves, /obj/item/clothing))
				var/obj/item/clothing/G = H.gloves
				if(G.body_parts_covered & ARMS)
					to_chat(H, "<span class='warning'>Вы не можете надеть [ru_getcase(src, "acase")], так как на Вас уже [ru_getcase(G, "ncase")].</span>")
					S.accessories -= src
					return
			else if((body_parts_covered & LEGS) && istype(H.shoes, /obj/item/clothing))
				var/obj/item/clothing/Sh = H.shoes
				if(Sh.body_parts_covered & LEGS)
					to_chat(H, "<span class='warning'>Вы не можете надеть [ru_getcase(src, "acase")], так как на Вас уже [ru_getcase(Sh, "ncase")].</span>")
					S.accessories -= src
					return
	..()

///////////
//Pouches
///////////
/obj/item/clothing/accessory/storage/pouches
	name = "Мешочки"
	desc = "Несколько чёрных мешочков, которые можно прикрепить к разгрузочному жилету. В них помещается два предмета."
	icon_override = 'icons/mob/modular_armor.dmi'
	icon = 'icons/obj/clothing/modular_armor.dmi'
	icon_state = "pouches"
	w_class = ITEMSIZE_NORMAL
	gender = PLURAL
	slot = ACCESSORY_SLOT_ARMOR_S
	slots = 2

/obj/item/clothing/accessory/storage/pouches/blue
	desc = "Несколько синих мешочков, которые можно прикрепить к разгрузочному жилету. В них помещается два предмета."
	icon_state = "pouches_blue"

/obj/item/clothing/accessory/storage/pouches/navy
	desc = "Несколько тёмно-синих мешочков, которые можно прикрепить к разгрузочному жилету. В них помещается два предмета."
	icon_state = "pouches_navy"

/obj/item/clothing/accessory/storage/pouches/green
	desc = "Несколько зелёных мешочков, которые можно прикрепить к разгрузочному жилету. В них помещается два предмета."
	icon_state = "pouches_green"

/obj/item/clothing/accessory/storage/pouches/tan
	desc = "Несколько бежевых мешочков, которые можно прикрепить к разгрузочному жилету. В них помещается два предмета."
	icon_state = "pouches_tan"

/obj/item/clothing/accessory/storage/pouches/large
	name = "Большие мешочки"
	desc = "Несколько чёрных мешочков, которые можно прикрепить к разгрузочному жилету. В них помещается четыре предмета."
	icon_state = "lpouches"
	slots = 4
	slowdown = 0.25

/obj/item/clothing/accessory/storage/pouches/large/blue
	desc = "Несколько синих мешочков, которые можно прикрепить к разгрузочному жилету. В них помещается четыре предмета."
	icon_state = "lpouches_blue"

/obj/item/clothing/accessory/storage/pouches/large/navy
	desc = "Несколько тёмно-синих мешочков, которые можно прикрепить к разгрузочному жилету. В них помещается четыре предмета."
	icon_state = "lpouches_navy"

/obj/item/clothing/accessory/storage/pouches/large/green
	desc = "Несколько зелёных мешочков, которые можно прикрепить к разгрузочному жилету. В них помещается четыре предмета."
	icon_state = "lpouches_green"

/obj/item/clothing/accessory/storage/pouches/large/tan
	desc = "Несколько бежевых мешочков, которые можно прикрепить к разгрузочному жилету. В них помещается четыре предмета."
	icon_state = "lpouches_tan"

////////////////
//Armor plates
////////////////
/obj/item/clothing/accessory/armor/armorplate
	name = "Пластина лёгкой брони"
	desc = "Простая пластина брони, изготовленная из синтетических фибров, укреплённых сталью. Присоединяется к разгрузочному жилету."
	icon_state = "armor_light"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	armor = list(melee = 30, bullet = 15, laser = 40, energy = 10, bomb = 25, bio = 0, rad = 0)
	slot = ACCESSORY_SLOT_ARMOR_C

/obj/item/clothing/accessory/armor/armorplate/explorer
	name = "explorer armor plate"
	desc = "A flexible plate made of synthetic fibers, designed to protect from the Sivian fauna. Attaches to a plate carrier."
	icon_state = "armor_light"
	armor = list(melee = 30, bullet = 20, laser = 20, energy = 20, bomb = 35, bio = 75, rad = 35)

/obj/item/clothing/accessory/armor/armorplate/stab
	name = "Пластина сетчатой брони"
	desc = "Пластина сетчатой брони, изготовленная из синтетических фибров, укреплённых сталью, и защищающая от небольших лезвий. Присоединяется к разгрузочному жилету."
	icon_state = "armor_stab"
	armor = list(melee = 30, bullet = 5, laser = 20, energy = 10, bomb = 15, bio = 0, rad = 0)
	armorsoak = list(melee = 7, bullet = 5, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/accessory/armor/armorplate/blast
	name = "Пластина гелевой брони"
	desc = "Пластина гелевой брони из высококачественных полимеров, предназначенная для защиты от небольших взрывов. Присоединяется к разгрузочному жилету."
	icon_state = "armor_blast"
	armor = list(melee = 25, bullet = 25, laser = 10, energy = 0, bomb = 30, bio = 0, rad = 0)
	armorsoak = list(melee = 5, bullet = 7, laser = 0, energy = 0, bomb = 40, bio = 0, rad = 0)

/obj/item/clothing/accessory/armor/armorplate/medium
	name = "Пластина средней брони"
	desc = "Синтетическая пластина, укреплённая пласталью и предоставляющая ощутимую защиту. Присоединяется к разгрузочному жилету."
	icon_state = "armor_medium"
	armor = list(melee = 40, bullet = 40, laser = 40, energy = 25, bomb = 30, bio = 0, rad = 0)

/obj/item/clothing/accessory/armor/armorplate/tactical
	name = "Пластина тактической брони"
	desc = "Броня средней защиты с дополнительным абляционным покрытием. Присоединяется к разгрузочному жилету."
	icon_state = "armor_tactical"
	armor = list(melee = 40, bullet = 40, laser = 60, energy = 35, bomb = 30, bio = 0, rad = 0)

/obj/item/clothing/accessory/armor/armorplate/merc
	name = "Пластина тяжёлой брони"
	desc = "Синтетическая пластина, укреплённая керамикой и предоставляющая невиданную защиту. Присоединяется к разгрузочному жилету."
	icon_state = "armor_merc"
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)

/obj/item/clothing/accessory/armor/armorplate/bulletproof
	name = "Пластина баллистической брони"
	desc = "Тканая пластина брони с дополнительным укреплением, предоставляющая защиту от травм, вызванных высокоскоростными снарядами. Присоединяется к разгрузочному жилету."
	icon_state = "armor_ballistic"
	slowdown = 0.6
	armor = list(melee = 10, bullet = 70, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)
	armorsoak = list(melee = 0, bullet = 10, laser = 0, energy = 5, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.7

/obj/item/clothing/accessory/armor/armorplate/riot
	name = "Пластина милицейской брони"
	desc = "Толстая пластина с дополнительным подслоем, предоставляющая защиту от травм ближнего боя. Присоединяется к разгрузочному жилету."
	icon_state = "armor_riot"
	slowdown = 0.6
	armor = list(melee = 70, bullet = 10, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)
	armorsoak = list(melee = 10, bullet = 0, laser = 0, energy = 5, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.7

/obj/item/clothing/accessory/armor/armorplate/laserproof
	name = "Пластина абляционной брони"
	desc = "Синтетическая пластина, укреплённая дюрасталью и предоставляющая защиту от лазеров. Присоединяется к разгрузочному жилету."
	icon_state = "armor_medium"
	slowdown = 0.6
	armor = list(melee = 10, bullet = 10, laser = 70, energy = 50, bomb = 0, bio = 0, rad = 0)
	armorsoak = list(melee = 0, bullet = 0, laser = 10, energy = 15, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.1

/obj/item/clothing/accessory/armor/armorplate/ablative/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(istype(damage_source, /obj/item/projectile/energy) || istype(damage_source, /obj/item/projectile/beam))
		var/obj/item/projectile/P = damage_source

		if(P.reflected)
			return ..()

		var/reflectchance = 40 - round(damage/3)
		if(!(def_zone in list(BP_TORSO, BP_GROIN)))
			reflectchance /= 2
		if(P.starting && prob(reflectchance))
			visible_message("<span class='danger'>[capitalize(ru_getcase(src, "ncase"))] [user] отражает [attack_text]!</span>")


			var/new_x = P.starting.x + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
			var/new_y = P.starting.y + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
			var/turf/curloc = get_turf(user)

			P.redirect(new_x, new_y, curloc, user)
			P.reflected = 1

			return PROJECTILE_CONTINUE

//////////////
//Arm guards
//////////////
/obj/item/clothing/accessory/armor/armguards
	name = "Наручные пластины"
	desc = "Пара укрепляющих наручных пластин чёрного цвета. Присоединяются к разгрузочному жилету."
//	accessory_icons = list(slot_tie_str = 'icons/mob/modular_armor.dmi', slot_wear_suit_str = 'icons/mob/modular_armor.dmi')
	icon_state = "armguards"
	gender = PLURAL
	body_parts_covered = ARMS
	armor = list(melee = 40, bullet = 40, laser = 40, energy = 25, bomb = 30, bio = 0, rad = 0)
	slot = ACCESSORY_SLOT_ARMOR_A

/obj/item/clothing/accessory/armor/armguards/blue
	desc = "Пара укрепляющих наручных пластин синего цвета. Присоединяются к разгрузочному жилету."
	icon_state = "armguards_blue"

/obj/item/clothing/accessory/armor/armguards/navy
	desc = "Пара укрепляющих наручных пластин тёмно-синего цвета.  Присоединяются к разгрузочному жилету."
	icon_state = "armguards_navy"

/obj/item/clothing/accessory/armor/armguards/green
	desc = "Пара укрепляющих наручных пластин зелёного цвета.  Присоединяются к разгрузочному жилету."
	icon_state = "armguards_green"

/obj/item/clothing/accessory/armor/armguards/tan
	desc = "Пара укрепляющих наручных пластин бежевого цвета.  Присоединяются к разгрузочному жилету."
	icon_state = "armguards_tan"

/obj/item/clothing/accessory/armor/armguards/explorer
	name = "explorer arm guards"
	desc = "A pair of green arm pads reinforced with armor plating. Attaches to a plate carrier."
	icon_state = "armguards_green"
	armor = list(melee = 30, bullet = 20, laser = 20, energy = 20, bomb = 35, bio = 75, rad = 35)

/obj/item/clothing/accessory/armor/armguards/merc
	name = "Тяжёлые наручные пластины"
	desc = "Пара тяжёлых наручных пластин чёрно-красного цвета. Присоединяются к разгрузочному жилету."
	icon_state = "armguards_merc"
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)

/obj/item/clothing/accessory/armor/armguards/laserproof
	name = "Абляционные наручные пластины"
	desc = "Эти наручные пластины защищают руки от энергетического оружия."
	icon_state = "armguards_ablative"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	siemens_coefficient = 0.1 //These don't cover the hands, so the siemens doesn't need to be worse than normal ablative.
	armor = list(melee = 10, bullet = 10, laser = 80, energy = 50, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/accessory/armor/armguards/bulletproof
	name = "Пуленепробиваемые наручные пластины"
	desc = "Эти наручные пластины защищают руки от баллистического оружия."
	icon_state = "armguards_ballistic"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	siemens_coefficient = 0.7
	armor = list(melee = 10, bullet = 80, laser = 10, energy = 50, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/accessory/armor/armguards/riot
	name = "Милицейские наручные пластины"
	desc = "Эти наручные пластины защищают руки от оружия ближнего боя."
	icon_state = "armguards_riot"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	siemens_coefficient = 0.5
	armor = list(melee = 80, bullet = 10, laser = 10, energy = 50, bomb = 0, bio = 0, rad = 0)

//////////////
//Leg guards
//////////////
/obj/item/clothing/accessory/armor/legguards
	name = "Наколенники"
	desc = "Пара укрепляющих наколенников чёрного цвета. Присоединяются к разгрузочному жилету."
//	accessory_icons = list(slot_tie_str = 'icons/mob/modular_armor.dmi', slot_wear_suit_str = 'icons/mob/modular_armor.dmi')
	icon_state = "legguards"
	gender = PLURAL
	body_parts_covered = LEGS
	armor = list(melee = 40, bullet = 40, laser = 40, energy = 25, bomb = 30, bio = 0, rad = 0)
	slot = ACCESSORY_SLOT_ARMOR_L

/obj/item/clothing/accessory/armor/legguards/blue
	desc = "Пара укрепляющих наколенников синего цвета. Присоединяются к разгрузочному жилету."
	icon_state = "legguards_blue"

/obj/item/clothing/accessory/armor/legguards/navy
	desc = "Пара укрепляющих наколенников тёмно-синего цвета. Присоединяются к разгрузочному жилету."
	icon_state = "legguards_navy"

/obj/item/clothing/accessory/armor/legguards/green
	desc = "Пара укрепляющих наколенников зелёного цвета. Присоединяются к разгрузочному жилету."
	icon_state = "legguards_green"

/obj/item/clothing/accessory/armor/legguards/tan
	desc = "Пара укрепляющих наколенников бежевого цвета. Присоединяются к разгрузочному жилету."
	icon_state = "legguards_tan"

/obj/item/clothing/accessory/armor/legguards/explorer
	name = "explorer leg guards"
	desc = "A pair of armored leg pads in green. Attaches to a plate carrier."
	icon_state = "legguards_green"
	armor = list(melee = 30, bullet = 20, laser = 20, energy = 20, bomb = 35, bio = 75, rad = 35)

/obj/item/clothing/accessory/armor/legguards/merc
	name = "Тяжёлые наколенники"
	desc = "Пара тяжёлых наколенников чёрно-красного цвета. Присоединяются к разгрузочному жилету."
	icon_state = "legguards_merc"
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)

/obj/item/clothing/accessory/armor/legguards/laserproof
	name = "Абляционные наколенники"
	desc = "Эти наколенники защищают ноги от энергетического оружия."
	icon_state = "legguards_ablative"
	item_state_slots = list(slot_r_hand_str = "jackboots", slot_l_hand_str = "jackboots")
	siemens_coefficient = 0.1
	armor = list(melee = 10, bullet = 10, laser = 80, energy = 50, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/accessory/armor/legguards/bulletproof
	name = "Пуленепробиваемые наколенники"
	desc = "Эти наколенники защищают руки от баллистического оружия."
	icon_state = "legguards_ballistic"
	item_state_slots = list(slot_r_hand_str = "jackboots", slot_l_hand_str = "jackboots")
	siemens_coefficient = 0.7
	armor = list(melee = 10, bullet = 80, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/accessory/armor/legguards/riot
	name = "Милицейские наколенники"
	desc = "Эти наколенники защищают руки от оружия ближнего боя."
	icon_state = "legguards_riot"
	item_state_slots = list(slot_r_hand_str = "jackboots", slot_l_hand_str = "jackboots")
	siemens_coefficient = 0.5
	armor = list(melee = 80, bullet = 10, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)

//////////////////////////
//Decorative attachments
//////////////////////////
/obj/item/clothing/accessory/armor/tag
	name = "Нашивка с флагом ПКСС"
	desc = "Нашивка с флагом Правительства Конфедерации Солнечной Системы."
//	accessory_icons = list(slot_tie_str = 'icons/mob/modular_armor.dmi', slot_wear_suit_str = 'icons/mob/modular_armor.dmi')
	icon_state = "solflag"
	slot = ACCESSORY_SLOT_ARMOR_M
	w_class = ITEMSIZE_SMALL

/obj/item/clothing/accessory/armor/tag/sifguard
	name = "\improper Sif Defense Force crest"
	desc = "An emblem depicting the crest of the Sif Defense Force."
	icon_state = "ecflag"

/obj/item/clothing/accessory/armor/tag/sec
	name = "Нашивка 'ПОЛИЦИЯ'"
	desc = "Нашивка на броню с отпечатанным словом 'ПОЛИЦИЯ'."
	icon_state = "sectag"

/obj/item/clothing/accessory/armor/tag/com
	name = "\improper SCG tag"
	desc = "An armor tag with the words SOLAR CONFEDERATE GOVERNMENT printed in gold lettering on it."
	icon_state = "comtag"

/obj/item/clothing/accessory/armor/tag/nt
	name = "Нашивка 'КОРПОРАТИВНАЯ СЛУЖБА БЕЗОПАСНОСТИ'"
	desc = "Нашивка со словами 'КОРПОРАТИВНАЯ СЛУЖБА БЕЗОПАСНОСТИ', отпечатанными на ней красными буквами."
	icon_state = "nanotag"

/obj/item/clothing/accessory/armor/tag/pcrc
	name = "\improper PCRC tag"
	desc = "An armor tag with the words PROXIMA CENTAURI RISK CONTROL printed in cyan lettering on it."
	icon_state = "pcrctag"

/obj/item/clothing/accessory/armor/tag/saare
	name = "Нашивка SAARE"
	desc = "Нашивка на броню с отпечатанным зелёным цветом акронимом SAARE."
	icon_state = "saaretag"

/obj/item/clothing/accessory/armor/tag/opos
	name = "Нашивка группы крови O+"
	desc = "Нашивка, сообщающая о группе крови О+."
	icon_state = "opostag"

/obj/item/clothing/accessory/armor/tag/oneg
	name = "Нашивка группы крови O-"
	desc = "Нашивка, сообщающая о группе крови O-."
	icon_state = "onegtag"

/obj/item/clothing/accessory/armor/tag/apos
	name = "Нашивка группы крови A+"
	desc = "Нашивка, сообщающая о группе крови A+."
	icon_state = "apostag"

/obj/item/clothing/accessory/armor/tag/aneg
	name = "Нашивка группы крови A-"
	desc = "Нашивка, сообщающая о группе крови A-."
	icon_state = "anegtag"

/obj/item/clothing/accessory/armor/tag/bpos
	name = "Нашивка группы крови B+"
	desc = "Нашивка, сообщающая о группе крови B+."
	icon_state = "bpostag"

/obj/item/clothing/accessory/armor/tag/bneg
	name = "Нашивка группы крови B-"
	desc = "Нашивка, сообщающая о группе крови B-."
	icon_state = "bnegtag"

/obj/item/clothing/accessory/armor/tag/abpos
	name = "Нашивка группы крови AB+"
	desc = "Нашивка, сообщающая о группе крови AB+."
	icon_state = "abpostag"

/obj/item/clothing/accessory/armor/tag/abneg
	name = "Нашивка группы крови AB-"
	desc = "Нашивка, сообщающая о группе крови AB-."
	icon_state = "abnegtag"

/////////////////
// Helmet Covers
/////////////////

obj/item/clothing/accessory/armor/helmcover
	name = "Шлемовое покрытие"
	desc = "Тканевое покрытие для бронированных шлемов."
	icon_override = 'icons/mob/ties.dmi'
	icon = 'icons/obj/clothing/modular_armor.dmi'
	icon_state = "helmcover_blue"
	slot = ACCESSORY_SLOT_HELM_C

/obj/item/clothing/accessory/armor/helmcover/blue
	name = "Синее шлемовое покрытие"
	desc = "Тканевое покрытие синего цвета для бронированных шлемов."
	icon_state = "helmcover_blue"

/obj/item/clothing/accessory/armor/helmcover/navy
	name = "Тёмно-синее шлемовое покрытие"
	desc = "Тканевое покрытие тёмно-синего цвета для бронированных шлемов."
	icon_state = "helmcover_navy"

/obj/item/clothing/accessory/armor/helmcover/green
	name = "Зелёное шлемовое покрытие"
	desc = "Тканевое покрытие для бронированных шлемов. Это покрытие имеет лесной камуфляжный раскрас."
	icon_state = "helmcover_green"

/obj/item/clothing/accessory/armor/helmcover/tan
	name = "Бежевое шлемовое покрытие"
	desc = "Тканевое покрытие для бронированных шлемов. Это покрытие имеет пустынный камуфляжный раскрас."
	icon_state = "helmcover_tan"

/obj/item/clothing/accessory/armor/helmcover/nt
	name = "\improper NanoTrasen helmet cover"
	desc = "A fabric cover for armored helmets. This one has NanoTrasen's colors."
	icon_state = "helmcover_nt"

/obj/item/clothing/accessory/armor/helmcover/pcrc
	name = "\improper PCRC helmet cover"
	desc = "A fabric cover for armored helmets. This one is colored navy blue and has a tag in the back with the words PROXIMA CENTAURI RISK CONTROL printed in cyan lettering on it."
	icon_state = "helmcover_pcrc"

/obj/item/clothing/accessory/armor/helmcover/saare
	name = "Шлемовое покрытие SAARE"
	desc = "Тканевое покрытие для бронированных шлемов. Это покрытие в цветах SAARE."
	icon_state = "helmcover_saare"