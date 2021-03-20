/datum/power/changeling/space_suit
	name = "Organic Space Suit"
	desc = "Мы выращиваем органический костюм, чтобы защитить себя от воздействия космоса."
	helptext = "To remove the suit, use the ability again."
	ability_icon_state = "ling_space_suit"
	genomecost = 1
	verbpath = /mob/proc/changeling_spacesuit

/mob/proc/changeling_spacesuit()
	set category = "Changeling"
	set name = "Organic Space Suit (20)"
	if(changeling_generic_armor(/obj/item/clothing/suit/space/changeling,/obj/item/clothing/head/helmet/space/changeling,/obj/item/clothing/shoes/magboots/changeling, 20))
		return 1
	return 0

/datum/power/changeling/armor
	name = "Chitinous Spacearmor"
	desc = "Мы превращаем нашу кожу в прочный хитин, чтобы защитить себя от повреждений и воздействия космоса."
	helptext = "Чтобы снять броню, используйте способность еще раз."
	ability_icon_state = "ling_armor"
	genomecost = 3
	verbpath = /mob/proc/changeling_spacearmor

/mob/proc/changeling_spacearmor()
	set category = "Changeling"
	set name = "Органическая космическая броня (20)"

	if(changeling_generic_armor(/obj/item/clothing/suit/space/changeling/armored,/obj/item/clothing/head/helmet/space/changeling/armored,/obj/item/clothing/shoes/magboots/changeling/armored, 20))
		return 1
	return 0

//Space suit

/obj/item/clothing/suit/space/changeling
	name = "flesh mass"
	icon_state = "lingspacesuit"
	desc = "Огромная, громоздкая масса устойчивой к давлению и температуре органической ткани, созданной для облегчения космических путешествий."
	flags = 0	//Not THICKMATERIAL because it's organic tissue, so if somebody tries to inject something into it,
				//it still ends up in your blood. (also balance but muh fluff)
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/tank/oxygen)
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0) //No armor at all.
	canremove = 0

/obj/item/clothing/suit/space/changeling/New()
	..()
	if(ismob(loc))
		loc.visible_message("<span class='warning'>Плоть [loc.name] быстро раздувается, образуя вздутие вокруг их тела!</span>",
		"<span class='warning'>Мы надуваем нашу плоть, создавая космический костюм!</span>",
		"<span class='italics'>Вы слышите, как рвется органическое вещество!</span>")

/obj/item/clothing/suit/space/changeling/dropped()
	qdel(src)

/obj/item/clothing/head/helmet/space/changeling
	name = "flesh mass"
	icon_state = "lingspacehelmet"
	desc = "Покрытие из устойчивой к давлению и температуре органической ткани со стекловидной хитиновой лицевой стороной."
	flags = BLOCKHAIR //Again, no THICKMATERIAL.
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	body_parts_covered = HEAD|FACE|EYES
	canremove = 0

/obj/item/clothing/head/helmet/space/changeling/dropped()
	qdel(src)

/obj/item/clothing/shoes/magboots/changeling
	desc = "Чашечная масса из плоти в форме ступни."
	name = "fleshy grippers"
	icon_state = "lingspacesuit"
	action_button_name = "Toggle Grippers"
	canremove = 0

/obj/item/clothing/shoes/magboots/changeling/set_slowdown()
	slowdown = shoes? max(SHOES_SLOWDOWN, shoes.slowdown): SHOES_SLOWDOWN	//So you can't put on magboots to make you walk faster.
	if (magpulse)
		slowdown += 1		//It's already tied to a slowdown suit, 6 slowdown is huge.

/obj/item/clothing/shoes/magboots/changeling/attack_self(mob/user)
	if(magpulse)
		item_flags &= ~NOSLIP
		magpulse = 0
		set_slowdown()
		force = 3
		to_chat(user, "Освобождаем хватку от пола.")
	else
		item_flags |= NOSLIP
		magpulse = 1
		set_slowdown()
		force = 5
		to_chat(user, "Мы цепляемся за местность под нами.")

/obj/item/clothing/shoes/magboots/changeling/dropped()
	..()
	qdel(src)

//Armor

/obj/item/clothing/suit/space/changeling/armored
	name = "chitinous mass"
	desc = "Плотное, твердое покрытие из черного хитина."
	icon_state = "lingarmor"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	armor = list(melee = 75, bullet = 60, laser = 60, energy = 60, bomb = 60, bio = 0, rad = 0) //It costs 3 points, so it should be very protective.
	siemens_coefficient = 0.3
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	slowdown = 3

/obj/item/clothing/suit/space/changeling/armored/New()
	..()
	if(ismob(loc))
		loc.visible_message("<span class='warning'>Плоть [loc.name] становится черной, быстро превращаясь в твердую хитиновую массу!</span>",
		"<span class='warning'>Мы закаляем нашу плоть, создавая доспехи!</span>",
		"<span class='italics'>Вы слышите, как рвется органическое вещество!</span>")

/obj/item/clothing/head/helmet/space/changeling/armored
	name = "chitinous mass"
	desc = "Плотное, твердое покрытие из черного хитина с прозрачным хитином спереди."
	icon_state = "lingarmorhelmet"
	armor = list(melee = 75, bullet = 60, laser = 60,energy = 60, bomb = 60, bio = 0, rad = 0)
	siemens_coefficient = 0.3
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/shoes/magboots/changeling/armored
	desc = "Твердая, твердая масса из хитина с длинными когтями для копания в местности."
	name = "chitinous talons"
	icon_state = "lingarmor"
	action_button_name = "Toggle Talons"

/obj/item/clothing/gloves/combat/changeling //Combined insulated/fireproof gloves
	name = "chitinous gauntlets"
	desc = "Очень прочные рукавицы из черного хитина. Он выглядит очень прочным и, вероятно, может противостоять электрическому удару в дополнение к элементам."
	icon_state = "lingarmorgloves"
	armor = list(melee = 75, bullet = 60, laser = 60,energy = 60, bomb = 60, bio = 0, rad = 0) //No idea if glove armor gets checked
	siemens_coefficient = 0

/obj/item/clothing/shoes/boots/combat/changeling //Noslips
	name = "chitinous boots"
	desc = "Обувь из твердого хитинового материала черного цвета. На их дне, кажется, есть шипы, которые могут выступать или выдвигаться в пол и выходить из него по желанию, обеспечивая устойчивость владельца."
	icon_state = "lingboots"
	armor = list(melee = 75, bullet = 60, laser = 70,energy = 60, bomb = 60, bio = 0, rad = 0)
	siemens_coefficient = 0.3
	cold_protection = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE
