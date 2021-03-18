/* Surgery Tools
 * Contains:
 *		Retractor
 *		Hemostat
 *		Cautery
 *		Surgical Drill
 *		Scalpel
 *		Circular Saw
 */

/obj/item/weapon/surgical
	name = "Хирургический инструмент"
	desc = "Вы по идее не должны этого видеть, напишите в админхелп."
	icon = 'icons/obj/surgery.dmi'
	w_class = ITEMSIZE_SMALL
	drop_sound = 'sound/items/drop/weldingtool.ogg'
	pickup_sound = 'sound/items/pickup/weldingtool.ogg'
	var/helpforce = 0	//For help intent things

/obj/item/weapon/surgical/attack(mob/M, mob/user)
	if(user.a_intent == I_HELP)	//A tad messy, but this should stop people from smacking their patients in surgery
		return 0
	..()

/*
 * Retractor
 */

/obj/item/weapon/surgical/retractor
	name = "Расширитель"
	desc = "Расширяет там всякое."
	icon_state = "retractor"
	matter = list(DEFAULT_WALL_MATERIAL = 10000, "glass" = 5000)
	origin_tech = list(TECH_MATERIAL = 1, TECH_BIO = 1)
	drop_sound = 'sound/items/drop/scrap.ogg'

/*
 * Hemostat
 */
/obj/item/weapon/surgical/hemostat
	name = "Зажим"
	desc = "Где-то Вы это уже видели."
	icon_state = "hemostat"
	matter = list(DEFAULT_WALL_MATERIAL = 5000, "glass" = 2500)
	origin_tech = list(TECH_MATERIAL = 1, TECH_BIO = 1)
	attack_verb = list("ударяет", "зажимает")
	drop_sound = 'sound/items/drop/scrap.ogg'

/*
 * Cautery
 */
/obj/item/weapon/surgical/cautery
	name = "Каутер"
	desc = "Позволяет остановить кровотечение."
	icon_state = "cautery"
	matter = list(DEFAULT_WALL_MATERIAL = 5000, "glass" = 2500)
	origin_tech = list(TECH_MATERIAL = 1, TECH_BIO = 1)
	attack_verb = list("обжигает")
	drop_sound = 'sound/items/drop/scrap.ogg'

/*
 * Surgical Drill
 */
/obj/item/weapon/surgical/surgicaldrill
	name = "Хирургическая дрель"
	desc = "Этим предметом можно сверлить. Ну не просто взглядом же."
	icon_state = "drill"
	hitsound = 'sound/weapons/circsawhit.ogg'
	matter = list(DEFAULT_WALL_MATERIAL = 15000, "glass" = 10000)
	force = 15.0
	w_class = ITEMSIZE_NORMAL
	origin_tech = list(TECH_MATERIAL = 1, TECH_BIO = 1)
	attack_verb = list("сверлит")
	drop_sound = 'sound/items/drop/accessory.ogg'

	suicide_act(mob/user)
		var/datum/gender/TU = gender_datums[user.get_visible_gender()]
		to_chat(viewers(user),pick("<span class='danger'>[user] [ru_g_mob(user, "прижал")] [ru_getcase(src, "acase")] к своим вискам и нажимает на кнопку! Похоже, [TU.ru_g_ncase] [ru_g_mob(user, "пыта", "ется", "ется", "ется", "ются")] совершить самоубийство.</span>",
		                       "<span class='danger'>[user] [ru_g_mob(user, "прижал")] [ru_getcase(src, "acase")] к своей груди и нажимает на кнопку! Похоже, [TU.ru_g_ncase] [ru_g_mob(user, "пыта", "ется", "ется", "ется", "ются")] совершить самоубийство.</span>"))
		return (BRUTELOSS)

/*
 * Scalpel
 */
/obj/item/weapon/surgical/scalpel
	name = "Скальпель"
	desc = "Режьте, режьте и ещё раз режьте."
	icon_state = "scalpel"
	force = 10.0
	sharp = 1
	edge = 1
	w_class = ITEMSIZE_TINY
	slot_flags = SLOT_EARS
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	origin_tech = list(TECH_MATERIAL = 1, TECH_BIO = 1)
	matter = list(DEFAULT_WALL_MATERIAL = 10000, "glass" = 5000)
	attack_verb = list("нападает", "режет", "зарезает", "разрубает", "ранит", "шинкует")
	drop_sound = 'sound/items/drop/knife.ogg'

	suicide_act(mob/user)
		var/datum/gender/TU = gender_datums[user.get_visible_gender()]
		to_chat(viewers(user),pick("<span class='danger'>[user] [ru_g_mob(user, "перерезал")] свои запястья при помощи [ru_getcase(src, "gcase")]! Похоже, [TU.ru_g_ncase] [ru_g_mob(user, "пыта", "ется", "ется", "ется", "ются")] совершить самоубийство.</span>", \
		                      "<span class='danger'>[user] [ru_g_mob(user, "перерезал")] себе глотку при помощи [ru_getcase(src, "gcase")]! Похоже, [TU.ru_g_ncase] [ru_g_mob(user, "пыта", "ется", "ется", "ется", "ются")] совершить самоубийство.</span>", \
		                      "<span class='danger'>[user] [ru_g_mob(user, "вскрыл")] себе живот при помощи [ru_getcase(src, "gcase")]! Похоже, [TU.ru_g_ncase] [ru_g_mob(user, "пыта", "ется", "ется", "ется", "ются")] совершить сеппуку.</span>"))
		return (BRUTELOSS)

/*
 * Researchable Scalpels
 */
/obj/item/weapon/surgical/scalpel/laser1
	name = "Лазерный скальпель"
	desc = "Скальпель с направленным лазером для более точной резки без попадания крови. Этот скальпель на вид довольно простой и может быть улучшен."
	icon_state = "scalpel_laser1_on"
	damtype = "fire"

/obj/item/weapon/surgical/scalpel/laser2
	name = "Лазерный скальпель"
	desc = "Скальпель с направленным лазером для более точной резки без попадания крови. Этот скальпель выглядит более-менее продвинутым."
	icon_state = "scalpel_laser2_on"
	damtype = "fire"
	force = 12.0

/obj/item/weapon/surgical/scalpel/laser3
	name = "Лазерный скальпель"
	desc = "Скальпель с направленным лазером для более точной резки без попадания крови на поле. Этот скальпель выглядит как лучшее, чего смогла достичь индустрия высокоточной резки!"
	icon_state = "scalpel_laser3_on"
	damtype = "fire"
	force = 15.0

/obj/item/weapon/surgical/scalpel/manager
	name = "Инструмент высокоточных надрезов"
	desc = "Самый лучший друг хирурга: это чудо науки моментально подготавливает надрез за него, позволяя пропустить некоторые шаги в операции."
	icon_state = "scalpel_manager_on"
	force = 7.5

/obj/item/weapon/surgical/scalpel/ripper
	name = "Щипцы для органов"
	desc = "Ужасающий инструмент с лезвиями и большим металлическим шипом в центре. Инструмент используется для быстрого удаления органов у пациентов -- желательно, с их согласием."
	icon_state = "organ_ripper"
	item_state = "bone_setter"
	force = 15.0
	toolspeed = 0.75
	origin_tech = list(TECH_MATERIAL = 5, TECH_BIO = 3, TECH_ILLEGAL = 2)

/*
 * Circular Saw
 */
/obj/item/weapon/surgical/circular_saw
	name = "Циркулярная пила"
	desc = "Для проведения операций тяжёлой резки."
	icon_state = "saw3"
	hitsound = 'sound/weapons/circsawhit.ogg'
	drop_sound = 'sound/items/drop/accessory.ogg'
	force = 15.0
	w_class = ITEMSIZE_NORMAL
	throwforce = 9.0
	throw_speed = 3
	throw_range = 5
	origin_tech = list(TECH_MATERIAL = 1, TECH_BIO = 1)
	matter = list(DEFAULT_WALL_MATERIAL = 20000,"glass" = 10000)
	attack_verb = list("атакует", "разрубает", "пилит", "режет")
	sharp = 1
	edge = 1

/obj/item/weapon/surgical/circular_saw/manager
	name = "Энергетический разделитель костей"
	desc = "Для проведения операций тяжёлой резки (и запечатывания) силой науки!"
	icon_state = "adv_saw"
	item_state = "saw3"
	hitsound = 'sound/weapons/emitter2.ogg'
	damtype = SEARING
	w_class = ITEMSIZE_LARGE
	origin_tech = list(TECH_BIO = 4, TECH_MATERIAL = 6, TECH_MAGNET = 6)
	matter = list(DEFAULT_WALL_MATERIAL = 12500)
	attack_verb = list("ударяет", "разрезает", "обжигает", "разрубает")
	toolspeed = 0.75

//misc, formerly from code/defines/weapons.dm
/obj/item/weapon/surgical/bonegel
	name = "Костяной гель"
	desc = "Для фиксации костей."
	icon_state = "bone-gel"
	force = 0
	throwforce = 1.0
	drop_sound = 'sound/items/drop/bottle.ogg'

/obj/item/weapon/surgical/FixOVein
	name = "Веночинитель"
	desc = "Как костяной гель. Только для вен."
	icon_state = "fixovein"
	force = 0
	throwforce = 1.0
	origin_tech = list(TECH_MATERIAL = 1, TECH_BIO = 3)
	var/usage_amount = 10
	drop_sound = 'sound/items/drop/accessory.ogg'

/obj/item/weapon/surgical/bonesetter
	name = "Располагатель костей"
	desc = "Вставляет их на место."
	icon_state = "bone_setter"
	force = 8.0
	throwforce = 9.0
	throw_speed = 3
	throw_range = 5
	attack_verb = list("ударяет", "врезает", "стукает")
	drop_sound = 'sound/items/drop/scrap.ogg'

/obj/item/weapon/surgical/bone_clamp
	name = "Костяной зажим"
	desc = "Самый надёжный способ исправить кость быстро."
	icon_state = "bone_clamp"
	force = 8
	throwforce = 9
	throw_speed = 3
	throw_range = 5
	attack_verb = list("ударяет", "врезает", "стукает")

// Cyborg Tools

/obj/item/weapon/surgical/retractor/cyborg
	toolspeed = 0.5

/obj/item/weapon/surgical/hemostat/cyborg
	toolspeed = 0.5

/obj/item/weapon/surgical/cautery/cyborg
	toolspeed = 0.5

/obj/item/weapon/surgical/surgicaldrill/cyborg
	toolspeed = 0.5

/obj/item/weapon/surgical/scalpel/cyborg
	toolspeed = 0.5

/obj/item/weapon/surgical/circular_saw/cyborg
	toolspeed = 0.5

/obj/item/weapon/surgical/bonegel/cyborg
	toolspeed = 0.5

/obj/item/weapon/surgical/FixOVein/cyborg
	toolspeed = 0.5

/obj/item/weapon/surgical/bonesetter/cyborg
	toolspeed = 0.5


// Alien Tools
/obj/item/weapon/surgical/retractor/alien
	icon = 'icons/obj/abductor.dmi'
	toolspeed = 0.25

/obj/item/weapon/surgical/hemostat/alien
	icon = 'icons/obj/abductor.dmi'
	toolspeed = 0.25

/obj/item/weapon/surgical/cautery/alien
	icon = 'icons/obj/abductor.dmi'
	toolspeed = 0.25

/obj/item/weapon/surgical/surgicaldrill/alien
	icon = 'icons/obj/abductor.dmi'
	toolspeed = 0.25

/obj/item/weapon/surgical/scalpel/alien
	icon = 'icons/obj/abductor.dmi'
	toolspeed = 0.25

/obj/item/weapon/surgical/circular_saw/alien
	icon = 'icons/obj/abductor.dmi'
	toolspeed = 0.25

/obj/item/weapon/surgical/FixOVein/alien
	icon = 'icons/obj/abductor.dmi'
	toolspeed = 0.25

/obj/item/weapon/surgical/bone_clamp/alien
	icon = 'icons/obj/abductor.dmi'
	toolspeed = 0.75
