/* Toys!
 * Contains:
 *		Balloons
 *		Fake telebeacon
 *		Fake singularity
 *		Toy gun
 *		Toy crossbow
 *		Toy swords
 *		Toy bosun's whistle
 *		Snap pops
 *		Water flower
 *      Therapy dolls
 *      Toddler doll
 *      Inflatable duck
 *		Action figures
 *		Plushies
 *		Toy cult sword
 *		Bouquets
 		Stick Horse
 */


/obj/item/toy
	throwforce = 0
	throw_speed = 4
	throw_range = 20
	force = 0
	drop_sound = 'sound/items/drop/gloves.ogg'


/*
 * Balloons
 */
/obj/item/toy/balloon
	name = "водяной шарик"
	desc = "Прозрачный резиновый шарик. Внутри ничего нет."
	icon = 'icons/obj/toy.dmi'
	icon_state = "waterballoon-e"
	drop_sound = 'sound/items/drop/rubber.ogg'

/obj/item/toy/balloon/New()
	var/datum/reagents/R = new/datum/reagents(10)
	reagents = R
	R.my_atom = src

/obj/item/toy/balloon/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/toy/balloon/afterattack(atom/A as mob|obj, mob/user as mob, proximity)
	if(!proximity) return
	if (istype(A, /obj/structure/reagent_dispensers/watertank) && get_dist(src,A) <= 1)
		A.reagents.trans_to_obj(src, 10)
		to_chat(user, "<span class='notice'>Вы наполняете водяной шарик содержимым сосуда.</span>")
		src.desc = "Прозрачный резиновый шарик с некой бултыхающейся жидкостью внутри."
		src.update_icon()
	return

/obj/item/toy/balloon/attackby(obj/O as obj, mob/user as mob)
	if(istype(O, /obj/item/weapon/reagent_containers/glass))
		if(O.reagents)
			if(O.reagents.total_volume < 1)
				to_chat(user, "Этот [O] пуст.")
			else if(O.reagents.total_volume >= 1)
				if(O.reagents.has_reagent("pacid", 1))
					to_chat(user, "Кислота прожигает шарик!")
					O.reagents.splash(user, reagents.total_volume)
					qdel(src)
				else
					src.desc = "Прозрачный резиновый шарик с некой бултыхающейся жидкостью внутри."
					to_chat(user, "<span class='notice'>Вы наполняете водяной шарик содержимым сосуда.</span>")
					O.reagents.trans_to_obj(src, 10)
	src.update_icon()
	return

/obj/item/toy/balloon/throw_impact(atom/hit_atom)
	if(src.reagents.total_volume >= 1)
		src.visible_message("<span class='warning'>Водяной шарик лопается!</span>","Вы слышите, как что-то лопается и расплескивается.")
		src.reagents.touch_turf(get_turf(hit_atom))
		for(var/atom/A in get_turf(hit_atom))
			src.reagents.touch(A)
		src.icon_state = "burst"
		spawn(5)
			if(src)
				qdel(src)
	return

/obj/item/toy/balloon/update_icon()
	if(src.reagents.total_volume >= 1)
		icon_state = "waterballoon"
	else
		icon_state = "waterballoon-e"

/obj/item/toy/syndicateballoon
	name = "преступный шарик"
	desc = "На тыльной стороне бирка с надписью \"НТ СОСАТТ!11!\"."
	throwforce = 0
	throw_speed = 4
	throw_range = 20
	force = 0
	icon = 'icons/obj/weapons.dmi'
	icon_state = "syndballoon"
	w_class = ITEMSIZE_LARGE
	drop_sound = 'sound/items/drop/rubber.ogg'

/obj/item/toy/nanotrasenballoon
	name = "преступный шарик"
	desc = "По всему шарику распластана надпись: \"Блин, я тааааак тащусь от НТ. Я использую только товары НТ, вы даже не представляете.\""
	throwforce = 0
	throw_speed = 4
	throw_range = 20
	force = 0
	icon = 'icons/obj/weapons.dmi'
	icon_state = "ntballoon"
	w_class = ITEMSIZE_LARGE
	drop_sound = 'sound/items/drop/rubber.ogg'

/obj/item/toy/colorballoon /// To color it, VV the 'color' var with a hex color code with the # included.
	name = "balloon"
	desc = "It's a plain little balloon. Comes in many colors!"
	throwforce = 0
	throw_speed = 4
	throw_range = 20
	force = 0
	icon = 'icons/obj/weapons.dmi'
	icon_state = "colorballoon"
	w_class = ITEMSIZE_LARGE
	drop_sound = 'sound/items/drop/rubber.ogg'

/*
 * Fake telebeacon
 */
/obj/item/toy/blink
	name = "электронная мигалка"
	desc = "Пик. Пик. Пик. Детям от 8 лет."
	icon = 'icons/obj/radio.dmi'
	icon_state = "beacon"
	item_state = "signaler"

/*
 * Fake singularity
 */
/obj/item/toy/spinningtoy
	name = "гравитационная сингулярность"
	desc = "Спиннер бренда \"Сингуло\"."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "singularity_s1"

/*
 * Toy crossbow
 */

/obj/item/toy/crossbow
	name = "пенный арбалет"
	desc = "Любимое оружие среди множества гиперактивных детей. Детям от 8 лет."
	icon = 'icons/obj/gun.dmi'
	icon_state = "crossbow"
	item_icons = list(
		icon_l_hand = 'icons/mob/items/lefthand_guns.dmi',
		icon_r_hand = 'icons/mob/items/righthand_guns.dmi',
		)
	slot_flags = SLOT_HOLSTER
	w_class = ITEMSIZE_SMALL
	attack_verb = list("attacked", "struck", "hit")
	var/bullets = 5
	drop_sound = 'sound/items/drop/gun.ogg'

	examine(mob/user)
		. = ..()
		if(bullets && get_dist(user, src) <= 2)
			. += "<span class='notice'>В него заправлено [bullets] дротиков!</span>"

	attackby(obj/item/I as obj, mob/user as mob)
		if(istype(I, /obj/item/toy/ammo/crossbow))
			if(bullets <= 4)
				user.drop_item()
				qdel(I)
				bullets++
				to_chat(user, "<span class='notice'>Вы заправляете пенный дротик в арбалет!</span>")
			else
				to_chat(usr, "<span class='warning'>В арбалете больше нет места!</span>")


	afterattack(atom/target as mob|obj|turf|area, mob/user as mob, flag)
		if(!isturf(target.loc) || target == user) return
		if(flag) return

		if (locate (/obj/structure/table, src.loc))
			return
		else if (bullets)
			var/turf/trg = get_turf(target)
			var/obj/effect/foam_dart_dummy/D = new/obj/effect/foam_dart_dummy(get_turf(src))
			bullets--
			D.icon_state = "foamdart"
			D.name = "пенный дротик"
			playsound(src, 'sound/items/syringeproj.ogg', 50, 1)

			for(var/i=0, i<6, i++)
				if (D)
					if(D.loc == trg) break
					step_towards(D,trg)

					for(var/mob/living/M in D.loc)
						if(!istype(M,/mob/living)) continue
						if(M == user) continue
						for(var/mob/O in viewers(world.view, D))
							O.show_message(text("<span class='warning'>В [] попадает пенный дротик!</span>", M), 1)
						new /obj/item/toy/ammo/crossbow(M.loc)
						qdel(D)
						return

					for(var/atom/A in D.loc)
						if(A == user) continue
						if(A.density)
							new /obj/item/toy/ammo/crossbow(A.loc)
							qdel(D)

				sleep(1)

			spawn(10)
				if(D)
					new /obj/item/toy/ammo/crossbow(D.loc)
					qdel(D)

			return
		else if (bullets == 0)
			user.Weaken(5)
			for(var/mob/O in viewers(world.view, user))
				O.show_message(text("<span class='warning'>[] осознает, что в арбалете закончились снаряды, и начинает трепетно искать оставшиеся!</span>", user), 1)


	attack(mob/M as mob, mob/user as mob)
		src.add_fingerprint(user)

// ******* Check

		if (src.bullets > 0 && M.lying)

			for(var/mob/O in viewers(M, null))
				if(O.client)
					O.show_message(text("<span class='danger'>[] как ни в чем ни бывало целится в голову [] и нажимает на курок!</span>", user, M), 1, "<span class='warning'>Вы слышите звук удара пенного дротика об череп.</span>", 2)
					O.show_message(text("<span class='warning'>\The [] was hit in the head by the foam dart!</span>", M), 1)

			playsound(src, 'sound/items/syringeproj.ogg', 50, 1)
			new /obj/item/toy/ammo/crossbow(M.loc)
			src.bullets--
		else if (M.lying && src.bullets == 0)
			for(var/mob/O in viewers(M, null))
				if (O.client)	O.show_message(text("<span class='danger'>[] как ни в чем ни бывало целится в голову [] и нажимает на курок, однако осознаёт, что патронов не осталось, и бросается собирать их по полу!</span>", user, M), 1, "<span class='warning'>Вы слышите, как кто-то упал.</span>", 2)
			user.Weaken(5)
		return

/obj/item/toy/ammo/crossbow
	name = "пенный дротик"
	desc = "Нёрф. Всё или ничего! Детям от 8 лет."
	icon = 'icons/obj/toy.dmi'
	icon_state = "foamdart"
	w_class = ITEMSIZE_TINY
	slot_flags = SLOT_EARS
	drop_sound = 'sound/items/drop/food.ogg'

/obj/effect/foam_dart_dummy
	name = ""
	desc = ""
	icon = 'icons/obj/toy.dmi'
	icon_state = "null"
	anchored = 1
	density = 0

/*
 * Toy swords
 */
/obj/item/toy/sword
	name = "игрушечный меч"
	desc = "Дешевая пластиковая копия энергетического меча. Реалистичные звуки! Детям от 8 лет."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "esword"
	drop_sound = 'sound/items/drop/gun.ogg'
	var/lcolor
	var/rainbow = FALSE
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_melee.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_melee.dmi',
		)
	var/active = 0
	w_class = ITEMSIZE_SMALL
	attack_verb = list("атакует", "ударяет")

	attack_self(mob/user as mob)
		src.active = !( src.active )
		if (src.active)
			to_chat(user, "<span class='notice'>Вы выдвигаете пластиковый клинок быстрым движением запястья.</span>")
			playsound(src, 'sound/weapons/saberon.ogg', 50, 1)
			src.item_state = "[icon_state]_blade"
			src.w_class = ITEMSIZE_LARGE
		else
			to_chat(user, "<span class='notice'>Вы проталкиваете пластиковый клинок обратно в рукоятку.</span>")
			playsound(src, 'sound/weapons/saberoff.ogg', 50, 1)
			src.item_state = "[icon_state]"
			src.w_class = ITEMSIZE_SMALL
		update_icon()
		src.add_fingerprint(user)
		return

/obj/item/toy/sword/update_icon()
	. = ..()
	var/mutable_appearance/blade_overlay = mutable_appearance(icon, "[icon_state]_blade")
	blade_overlay.color = lcolor
	cut_overlays()		//So that it doesn't keep stacking overlays non-stop on top of each other
	if(active)
		add_overlay(blade_overlay)
	if(istype(usr,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = usr
		H.update_inv_l_hand()
		H.update_inv_r_hand()

/obj/item/toy/sword/AltClick(mob/living/user)
	if(!in_range(src, user))	//Basic checks to prevent abuse
		return
	if(user.incapacitated() || !istype(user))
		to_chat(user, "<span class='warning'>Вы не можете сейчас это сделать!</span>")
		return

	if(alert("Хотите ли Вы перекрасить свой меч?", "Подтвердить Перекрас", "Да", "Нет") == "Да")
		var/energy_color_input = input(usr,"","Выберите Цвет",lcolor) as color|null
		if(energy_color_input)
			lcolor = sanitize_hexcolor(energy_color_input)
		update_icon()

/obj/item/toy/sword/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Альт+клик, чтобы перекрасить.</span>"

/obj/item/toy/sword/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/device/multitool) && !active)
		if(!rainbow)
			rainbow = TRUE
		else
			rainbow = FALSE
		to_chat(user, "<span class='notice'>Вы настраиваете цветовой модуль игрушечного меча.</span>")
		update_icon()
/obj/item/toy/katana
	name = "поддельная катана"
	desc = "Крайне слаба в д20."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "katana"
	item_state = "katana"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_material.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_material.dmi',
		)
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 5
	throwforce = 5
	w_class = ITEMSIZE_NORMAL
	attack_verb = list("attacked", "slashed", "stabbed", "sliced")

/*
 * Snap pops
 */
/obj/item/toy/snappop
	name = "хлопушка"
	desc = "Вау!"
	icon = 'icons/obj/toy.dmi'
	icon_state = "snappop"
	w_class = ITEMSIZE_TINY
	drop_sound = null

	throw_impact(atom/hit_atom)
		..()
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
		s.set_up(3, 1, src)
		s.start()
		new /obj/effect/decal/cleanable/ash(src.loc)
		src.visible_message("<span class='warning'>Хлопушка лопается!</span>","<span class='warning'>Вы услышали, как что-то хлопнуло!</span>")
		playsound(src, 'sound/effects/snap.ogg', 50, 1)
		qdel(src)

/obj/item/toy/snappop/Crossed(atom/movable/H as mob|obj)
	if(H.is_incorporeal())
		return
	if((ishuman(H))) //i guess carp and shit shouldn't set them off
		var/mob/living/carbon/M = H
		if(M.m_intent == "run")
			to_chat(M, "<span class='warning'>Вы наступаете на хлопушку!</span>")

			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
			s.set_up(2, 0, src)
			s.start()
			new /obj/effect/decal/cleanable/ash(src.loc)
			src.visible_message("<span class='warning'>Хлопушка лопается!</span>","<span class='warning'>Вы услышали, как что-то хлопнуло!</span>")
			playsound(src, 'sound/effects/snap.ogg', 50, 1)
			qdel(src)

/*
 * Bosun's whistle
 */

/obj/item/toy/bosunwhistle
	name = "свисток Босуна"
	desc = "Настоящий свисток Адмирала Краш Босуна для любого, кто мечтает стать капитаном корабля! Предназачен детям от 8 лет, не проглатывать."
	icon = 'icons/obj/toy.dmi'
	icon_state = "bosunwhistle"
	drop_sound = 'sound/items/drop/card.ogg'
	var/cooldown = 0
	w_class = ITEMSIZE_TINY
	slot_flags = SLOT_EARS | SLOT_HOLSTER

/obj/item/toy/bosunwhistle/attack_self(mob/user as mob)
	if(cooldown < world.time - 35)
		to_chat(user, "<span class='notice'>Вы свистите [src], создавая режущий уши звук!</span>")
		playsound(src, 'sound/misc/boatswain.ogg', 20, 1)
		cooldown = world.time

/*
 * Action figures
 */
/obj/item/toy/figure
	name = "какая-то коллекционная фигурка"
	desc = "Бренд \"Space Life\"... стоп, это вообще что?"
	icon = 'icons/obj/toy.dmi'
	icon_state = "nuketoy"
	var/cooldown = 0
	var/toysay = "Ты че натворил вообще?"
	drop_sound = 'sound/items/drop/accessory.ogg'

/obj/item/toy/figure/New()
	..()
	desc = "Это [name] бренда \"Space Life\""

/obj/item/toy/figure/attack_self(mob/user as mob)
	if(cooldown < world.time)
		cooldown = (world.time + 30) //3 second cooldown
		user.visible_message("<span class='notice'>Эта [src] говорит \"[toysay]\".</span>")
		playsound(src, 'sound/machines/click.ogg', 20, 1)

/obj/item/toy/figure/cmo
	name = "коллекционная фигурка Главврача"
	desc = "Коллекционная фигурка Главврача бренда \"Space Life\"."
	icon_state = "cmo"
	toysay = "Не забываем про датчики!"

/obj/item/toy/figure/assistant
	name = "коллекционная фигурка ассистента"
	desc = "Коллекционная фигурка ассистента бренда \"Space Life\"."
	icon_state = "assistant"
	toysay = "Набегаем, пацаны!"

/obj/item/toy/figure/atmos
	name = "коллекционная фигурка атмосферного техника"
	desc = "Коллекционная фигурка атмосферного техника бренда \"Space Life\"."
	icon_state = "atmos"
	toysay = "Слава Атмосии!"

/obj/item/toy/figure/bartender
	name = "коллекционная фигурка бармена"
	desc = "Коллекционная фигурка бармена бренда \"Space Life\"."
	icon_state = "bartender"
	toysay = "Где моя мартышка?"

/obj/item/toy/figure/borg
	name = "коллекционная фигурка дрона"
	desc = "Коллекционная фигурка дрона бренда \"Space Life\"."
	icon_state = "borg"
	toysay = "Я. СНОВА. ЖИВ."

/obj/item/toy/figure/gardener
	name = "коллекционная фигурка садовника"
	desc = "Коллекционная фигурка садовника бренда \"Space Life\"."
	icon_state = "botanist"
	toysay = "Бро, я вижу радугу..."

/obj/item/toy/figure/captain
	name = "коллекционная фигурка Директора Колонии"
	desc = "Коллекционная фигурка Директора Колонии бренда \"Space Life\"."
	icon_state = "captain"
	toysay = "Как открыть эту витрину?"

/obj/item/toy/figure/cargotech
	name = "коллекционная фигурка грузчика"
	desc = "Коллекционная фигурка грузчика бренда \"Space Life\"."
	icon_state = "cargotech"
	toysay = "За Каргонию!"

/obj/item/toy/figure/ce
	name = "коллекционная фигурка Главного Инженера"
	desc = "Коллекционная фигурка Главного Инженера бренда \"Space Life\"."
	icon_state = "ce"
	toysay = "Подключите солярки!"

/obj/item/toy/figure/chaplain
	name = "коллекционная фигурка капеллана"
	desc = "Коллекционная фигурка капеллана бренда \"Space Life\"."
	icon_state = "chaplain"
	toysay = "Боги, даруйте мне орудие убийств!"

/obj/item/toy/figure/chef
	name = "коллекционная фигурка повара"
	desc = "Коллекционная фигурка повара бренда \"Space Life\"."
	icon_state = "chef"
	toysay = "Клянусь, это не человеческое мясо."

/obj/item/toy/figure/chemist
	name = "коллекционная фигурка химика"
	desc = "Коллекционная фигурка химика бренда \"Space Life\"."
	icon_state = "chemist"
	toysay = "Забирайте свои таблетки!"

/obj/item/toy/figure/clown
	name = "коллекционная фигурка клоуна"
	desc = "Коллекционная фигурка клоуна бренда \"Space Life\"."
	icon_state = "clown"
	toysay = "<font face='comic sans ms'><b>Хонк!</b></font>"

/obj/item/toy/figure/corgi
	name = "коллекционная фигурка корги"
	desc = "Коллекционная фигурка корги бренда \"Space Life\"."
	icon_state = "ian"
	toysay = "Арф!"

/obj/item/toy/figure/detective
	name = "коллекционная фигурка детектива"
	desc = "Коллекционная фигурка детектива бренда \"Space Life\"."
	icon_state = "detective"
	toysay = "На этом шлюзе остались фибры серого комбинезона и резиновых перчаток."

/obj/item/toy/figure/dsquad
	name = "коллекционная фигурка коммандо"
	desc = "Коллекционная фигурка коммандо бренда \"Space Life\"."
	icon_state = "dsquad"
	toysay = "Устранить все угрозы!"

/obj/item/toy/figure/engineer
	name = "коллекционная фигурка инженера"
	desc = "Коллекционная фигурка инженера бренда \"Space Life\"."
	icon_state = "engineer"
	toysay = "О боже, движок щас полетит!"

/obj/item/toy/figure/geneticist
	name = "коллекционная фигурка генетика"
	desc = "Коллекционная фигурка генетика бренда \"Space Life\", которую больше уже не делают."
	icon_state = "geneticist"
	toysay = "Эта работа не для меня."

/obj/item/toy/figure/hop
	name = "коллекционная фигурка Главы Персонала"
	desc = "Коллекционная фигурка Главы Персонала бренда \"Space Life\"."
	icon_state = "hop"
	toysay = "Раздаю доступы!"

/obj/item/toy/figure/hos
	name = "коллекционная фигурка Главы Службы Безопасности"
	desc = "Коллекционная фигурка Главы Службы Безопасности бренда \"Space Life\"."
	icon_state = "hos"
	toysay = "Я здесь, чтобы побеждать, а остальное уже потом."

/obj/item/toy/figure/qm
	name = "коллекционная фигурка Квартирмейстера"
	desc = "Коллекционная фигурка Квартирмейстера бренда \"Space Life\"."
	icon_state = "qm"
	toysay = "Славься, Каргония!"

/obj/item/toy/figure/janitor
	name = "коллекционная фигурка уборщика"
	desc = "Коллекционная фигурка уборщика бренда \"Space Life\"."
	icon_state = "janitor"
	toysay = "Смотри на таблички, кретин."

/obj/item/toy/figure/agent
	name = "коллекционная фигурка агента внутренних дел"
	desc = "Коллекционная фигурка агента внутренних дел бренда \"Space Life\"."
	icon_state = "agent"
	toysay = "Согласно Стандартам Операционного Порядка, он виновен! Взлом доказывает, что он враг корпорации!"

/obj/item/toy/figure/librarian
	name = "коллекционная фигурка библиотекаря"
	desc = "Коллекционная фигурка библиотекаря бренда \"Space Life\"."
	icon_state = "librarian"
	toysay = "Жили-были..."

/obj/item/toy/figure/md
	name = "коллекционная фигурка врача"
	desc = "Коллекционная фигурка врача бренда \"Space Life\"."
	icon_state = "md"
	toysay = "Пациент уже мертв!"

/obj/item/toy/figure/mime
	name = "коллекционная фигурка мима"
	desc = "Коллекционная фигурка мима бренда \"Space Life\"."
	icon_state = "mime"
	toysay = "..."

/obj/item/toy/figure/miner
	name = "коллекционная фигурка шахтера"
	desc = "Коллекционная фигурка шахтера бренда \"Space Life\"."
	icon_state = "miner"
	toysay = "О боже, оно жрёт мои внутренности!"

/obj/item/toy/figure/ninja
	name = "коллекционная фигурка космического ниндзя"
	desc = "Коллекционная фигурка космического ниндзя бренда \"Space Life\"."
	icon_state = "ninja"
	toysay = "Господи, хватит стрелять, я не враг!"

/obj/item/toy/figure/wizard
	name = "коллекционная фигурка волшебника"
	desc = "Коллекционная фигурка волшебника бренда \"Space Life\"."
	icon_state = "wizard"
	toysay = "Ei Nath!"

/obj/item/toy/figure/rd
	name = "коллекционная фигурка Директора Исследований"
	desc = "Коллекционная фигурка Директора Исследований бренда \"Space Life\"."
	icon_state = "rd"
	toysay = "Взрываем всех боргов!"

/obj/item/toy/figure/roboticist
	name = "коллекционная фигурка робототехника"
	desc = "Коллекционная фигурка робототехника бренда \"Space Life\"."
	icon_state = "roboticist"
	toysay = "Он сам попросил сделать его боргом!"

/obj/item/toy/figure/scientist
	name = "коллекционная фигурка ученого"
	desc = "Коллекционная фигурка ученого бренда \"Space Life\"."
	icon_state = "scientist"
	toysay = "Эти бомбы сделал кто-то другой!"

/obj/item/toy/figure/syndie
	name = "коллекционная фигурка спецоператора"
	desc = "Коллекционная фигурка спецоператора бренда \"Space Life\"."
	icon_state = "syndie"
	toysay = "Где этот блядский диск?!"

/obj/item/toy/figure/secofficer
	name = "коллекционная фигурка офицера службы безопасности"
	desc = "Коллекционная фигурка офицера службы безопасности бренда \"Space Life\"."
	icon_state = "secofficer"
	toysay = "Я есть закон!"

/obj/item/toy/figure/virologist
	name = "коллекционная фигурка вирусолога"
	desc = "Коллекционная фигурка вирусолога бренда \"Space Life\"."
	icon_state = "virologist"
	toysay = "Всё лечится калием!"

/obj/item/toy/figure/warden
	name = "коллекционная фигурка надзирателя"
	desc = "Коллекционная фигурка надзирателя бренда \"Space Life\"."
	icon_state = "warden"
	toysay = "Казнить его за взлом и проникновение!"

/obj/item/toy/figure/psychologist
	name = "коллекционная фигурка психолога"
	desc = "Коллекционная фигурка психолога бренда \"Space Life\"."
	icon_state = "psychologist"
	toysay = "На анализаторе написано, что ты в порядке!"

/obj/item/toy/figure/paramedic
	name = "коллекционная фигурка парамедика"
	desc = "Коллекционная фигурка парамедика бренда \"Space Life\"."
	icon_state = "paramedic"
	toysay = "ГДЕ ТЫ??"

/obj/item/toy/figure/ert
	name = "коллекционная фигурка командира групп экстренного реагирования"
	desc = "Коллекционная фигурка командира групп экстренного реагирования бренда \"Space Life\"."
	icon_state = "ert"
	toysay = "Мы хорошие ребята, наверное!"

/*
 * Plushies
 */

/*
 * Carp plushie
 */

/obj/item/toy/plushie/carp
	name = "плюшевый космический карпик"
	desc = "Милая плюшевая игрушка, похожая на космического карпа."
	icon = 'icons/obj/toy.dmi'
	icon_state = "basecarp"
	attack_verb = list("укусил", "схвавал", "шлепнул плавником")
	var/bitesound = 'sound/weapons/bite.ogg'

// Attack mob
/obj/item/toy/plushie/carp/attack(mob/M as mob, mob/user as mob)
	playsound(src, bitesound, 20, 1)	// Play bite sound in local area
	return ..()

// Attack self
/obj/item/toy/plushie/carp/attack_self(mob/user as mob)
	playsound(src, bitesound, 20, 1)
	return ..()


/obj/random/carp_plushie
	name = "случайный плюшевый карпик"
	desc = "Случайная плюшевая игрушка."
	icon = 'icons/obj/toy.dmi'
	icon_state = "basecarp"

/obj/random/carp_plushie/item_to_spawn()
	return pick(typesof(/obj/item/toy/plushie/carp)) //can pick any carp plushie, even the original.

/obj/item/toy/plushie/carp/ice
	name = "плюшевый ледяной карпик"
	icon_state = "icecarp"

/obj/item/toy/plushie/carp/silent
	name = "плюшевый монохромный карпик"
	icon_state = "silentcarp"

/obj/item/toy/plushie/carp/electric
	name = "плюшевый электрический карпик"
	icon_state = "electriccarp"

/obj/item/toy/plushie/carp/gold
	name = "плюшевый золотой карпик"
	icon_state = "goldcarp"

/obj/item/toy/plushie/carp/toxin
	name = "плюшевый токсичный карпик"
	icon_state = "toxincarp"

/obj/item/toy/plushie/carp/dragon
	name = "плюшевый драконовидный карпик"
	icon_state = "dragoncarp"

/obj/item/toy/plushie/carp/pink
	name = "плюшевый розовый карпик"
	icon_state = "pinkcarp"

/obj/item/toy/plushie/carp/candy
	name = "плюшевый конфетный карпик"
	icon_state = "candycarp"

/obj/item/toy/plushie/carp/nebula
	name = "плюшевый туманный карпик"
	icon_state = "nebulacarp"

/obj/item/toy/plushie/carp/void
	name = "плюшевый вакуумный карпик"
	icon_state = "voidcarp"

//Large plushies.
/obj/structure/plushie
	name = "плюшевая игрушка"
	desc = "Обыкновенная плюшевая игрушка. Похоже, она не хочет существовать."
	icon = 'icons/obj/toy.dmi'
	icon_state = "ianplushie"
	anchored = 0
	density = 1
	var/phrase = "Я не хочу существовать!"
	var/searching = FALSE
	var/opened = FALSE	// has this been slit open? this will allow you to store an object in a plushie.
	var/obj/item/stored_item	// Note: Stored items can't be bigger than the plushie itself.

/obj/structure/plushie/examine(mob/user)
	. = ..()
	if(opened)
		. += "<i>Вы видите на этой игрушке надрез...</i>"
		if(in_range(user, src) && stored_item)
			. += "<i>Вам виднеется что-то внутри...</i>"

/obj/structure/plushie/attack_hand(mob/user)
	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)

	if(stored_item && opened && !searching)
		searching = TRUE
		if(do_after(user, 10))
			to_chat(user, "Вы находите \icon[stored_item] [stored_item] внутри игрушки!")
			stored_item.forceMove(get_turf(src))
			stored_item = null
			searching = FALSE
			return
		else
			searching = FALSE

	if(user.a_intent == I_HELP)
		user.visible_message("<span class='notice'><b>[user]</b> обнимает [src]!</span>","<span class='notice'>Вы обнимаете [src]!</span>")
	else if (user.a_intent == I_HURT)
		user.visible_message("<span class='warning'><b>[user]</b> ударяет [src]!</span>","<span class='warning'>Вы ударяете [src]!</span>")
	else if (user.a_intent == I_GRAB)
		user.visible_message("<span class='warning'><b>[user]</b> пытается задушить [src]!</span>","<span class='warning'>Вы пытаетесь задушить [src]!</span>")
	else
		user.visible_message("<span class='notice'><b>[user]</b> тыкает [src].</span>","<span class='notice'>Вы тыкаете [src].</span>")
		visible_message("[src] говорит, \"[phrase]\"")


/obj/structure/plushie/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/device/threadneedle) && opened)
		to_chat(user, "Вы зашиваете дырку в [src].")
		opened = FALSE
		return

	if(is_sharp(I) && !opened)
		to_chat(user, "Вы раскрываете небольшую дырочку в [src]. Внутри можно поместить крохотные предметы.")
		opened = TRUE
		return

	if(opened)
		if(stored_item)
			to_chat(user, "Внутри уже что-то есть.")
			return

		if(!(I.w_class > w_class))
			to_chat(user, "Вы вкладываете [I] в [src].")
			user.drop_from_inventory(I, src)
			I.forceMove(src)
			stored_item = I
			return
		else
			to_chat(user, "Вы раскрываете небольшую дырочку в [src]. Внутри можно поместить крохотные предметы.")


	..()

/obj/structure/plushie/ian
	name = "плюшевый корги"
	desc = "Милый плюшевый корги! Так и хочется его потискать и прозвать Ианом!"
	icon_state = "ianplushie"
	phrase = "Арф!"

/obj/structure/plushie/drone
	name = "плюшевый дрончик"
	desc = "Плюшевый дрон! Выглядит так, будто улыбается."
	icon_state = "droneplushie"
	phrase = "Бип буп!"

/obj/structure/plushie/carp
	name = "плюшевый карпик"
	desc = "Радостный плюшевый карп! Прямиком из неиследованных краев границ Вир, теперь в Ваших руках."
	icon_state = "carpplushie"
	phrase = "Глорф!"

/obj/structure/plushie/beepsky
	name = "плюшевый офицер Бипски"
	desc = "Плюшевая версия известного робоуборщика! Если бы он умел чувствовать, он бы Вас полюбил."
	icon_state = "beepskyplushie"
	phrase = "Бип!"

//Small plushies.
/obj/item/toy/plushie
	name = "маленькая плюшевая игрушка"
	desc = "Маленькая плюшевая игрушка. Очень милая."
	icon = 'icons/obj/toy.dmi'
	icon_state = "nymphplushie"
	drop_sound = 'sound/items/drop/plushie.ogg'
	w_class = ITEMSIZE_TINY
	var/last_message = 0
	var/pokephrase = "Увв!"
	var/searching = FALSE
	var/opened = FALSE	// has this been slit open? this will allow you to store an object in a plushie.
	var/obj/item/stored_item	// Note: Stored items can't be bigger than the plushie itself.


/obj/item/toy/plushie/examine(mob/user)
	. = ..()
	if(opened)
		. += "<i>Вы видите на этой игрушке надрез.</i>"
		if(in_range(user, src) && stored_item)
			. += "<i>Вам видится что-то внутри...</i>"

/obj/item/toy/plushie/attack_self(mob/user as mob)
	if(stored_item && opened && !searching)
		searching = TRUE
		if(do_after(user, 10))
			to_chat(user, "Вы находите \icon[stored_item] [stored_item] внутри [src]!")
			stored_item.forceMove(get_turf(src))
			stored_item = null
			searching = FALSE
			return
		else
			searching = FALSE

	if(world.time - last_message <= 1 SECOND)
		return
	if(user.a_intent == I_HELP)
		user.visible_message("<span class='notice'><b>[user]</b> обнимает [src]!</span>","<span class='notice'>Вы обнимаете [src]!</span>")
	else if (user.a_intent == I_HURT)
		user.visible_message("<span class='warning'><b>[user]</b> ударяет [src]!</span>","<span class='warning'>Вы ударяете [src]!</span>")
	else if (user.a_intent == I_GRAB)
		user.visible_message("<span class='warning'><b>[user]</b> пытается задушить [src]!</span>","<span class='warning'>Вы пытаетесь задушить [src]!</span>")
	else
		user.visible_message("<span class='notice'><b>[user]</b> тыкает [src].</span>","<span class='notice'>Вы тыкаете [src].</span>")
		playsound(src, 'sound/items/drop/plushie.ogg', 25, 0)
		visible_message("[src] говорит, \"[pokephrase]\"")
	last_message = world.time

/obj/item/toy/plushie/verb/rename_plushie()
	set name = "Дать Игрушке Имя"
	set category = "Object"
	set desc = "Дать Вашей игрушке милое имя!"
	var/mob/M = usr
	if(!M.mind)
		return 0

	var/input = sanitizeSafe(input("Как Вы хотите назвать свою игрушку?", ,""), MAX_NAME_LEN)

	if(src && input && !M.stat && in_range(M,src))
		name = input
		to_chat(M, "Вы называете свою игрушку [input] и нежно её обнимаете на удачу.")
		return 1

/obj/item/toy/plushie/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/toy/plushie) || istype(I, /obj/item/organ/external/head))
		user.visible_message("<span class='notice'>[user] заставляет [I] и [src] поцеловаться!.</span>", \
		"<span class='notice'>Вы заставляете [I] и [src] поцеловаться!.</span>")
		return


	if(istype(I, /obj/item/device/threadneedle) && opened)
		to_chat(user, "Вы зашиваете дырочку под [src].")
		opened = FALSE
		return

	if(is_sharp(I) && !opened)
		to_chat(user, "Вы делаете надрез на [src]. Внутри можно поместить небольшие предметы.")
		opened = TRUE
		return

	if( (!(I.w_class > w_class)) && opened)
		if(stored_item)
			to_chat(user, "Внутри уже что-то есть.")
			return

		to_chat(user, "Вы помещаете [I] внутрь [src].")
		user.drop_from_inventory(I, src)
		I.forceMove(src)
		stored_item = I
		to_chat(user, "Вы поместили [I] в [src].")
		return

	return ..()

/obj/item/toy/plushie/nymph
	name = "плюшевая дионочка"
	desc = "Милая плюшевая дионочка! Уровень её интеллекта пока ещё подлежит спору, а вот уровень милоты явно нет."
	icon_state = "nymphplushie"
	pokephrase = "Чирик!"

/obj/item/toy/plushie/teshari
	name = "плюшевая тешарька"
	desc = "Плюшевая тешарька. Очень мягкий, с помпончиком на хвосте. Игрушка качественная, будто живая. Выглядит так, будто спит. Тссссс."
	icon_state = "teshariplushie"
	pokephrase = "Ря!"

/obj/item/toy/plushie/mouse
	name = "плюшевая мышка"
	desc = "Милая плюшевая мышка. То, что все привыкли видеть как надоедливого грызуна, отныне Ваш самый лучший друг."
	icon_state = "mouseplushie"	//TFF 12/11/19 - updated icon to show a sprite that doesn't replicate a dead mouse. Heck you for that! >:C
	pokephrase = "Пик!"

/obj/item/toy/plushie/kitten
	name = "плюшевый котенок"
	desc = "Милый плюшевый котёнок! От одного мурлыканья тает сердце."
	icon_state = "kittenplushie"
	pokephrase = "Мряу!"

/obj/item/toy/plushie/lizard
	name = "плюшевая ящеричка"
	desc = "Плющевая ящеричка! Очень противоречивая игрушка с тех пор, как Унати прозвали её \"расистской\"."
	icon_state = "lizardplushie"
	pokephrase = "Хсс!"

/obj/item/toy/plushie/spider
	name = "плюшевай паучок"
	desc = "Пушистый плюшевый паучок! Восемь ножек, дабы лучше Вас обнимать."
	icon_state = "spiderplushie"
	pokephrase = "Ск-ск-ск!"

/obj/item/toy/plushie/farwa
	name = "плюшевая фарвочка"
	desc = "Плюшевая фарвочка, мягкая и теплая."
	icon_state = "farwaplushie"
	pokephrase = "Кар!"

/obj/item/toy/plushie/corgi
	name = "плюшевый корги"
	icon_state = "corgi"
	pokephrase = "Вуф!"

/obj/item/toy/plushie/girly_corgi
	name = "плюшевая корги"
	icon_state = "girlycorgi"
	pokephrase = "Арф!"

/obj/item/toy/plushie/robo_corgi
	name = "плюшевый борги"
	icon_state = "robotcorgi"
	pokephrase = "Гав."

/obj/item/toy/plushie/octopus
	name = "плюшевый осминожка"
	icon_state = "loveable"
	pokephrase = "Пшш!"

/obj/item/toy/plushie/face_hugger
	name = "плюшевый хедкрабик"
	icon_state = "huggable"
	pokephrase = "Обнимашка!"

//foxes are basically the best

/obj/item/toy/plushie/red_fox
	name = "плюшевая рыжая лисичка"
	icon_state = "redfox"
	pokephrase = "Гекеке!"

/obj/item/toy/plushie/black_fox
	name = "плюшевая черная лисичка"
	icon_state = "blackfox"
	pokephrase = "Ак!"

/obj/item/toy/plushie/marble_fox
	name = "плюшевая мраморная лисичка"
	icon_state = "marblefox"
	pokephrase = "Ауууу!"

/obj/item/toy/plushie/blue_fox
	name = "плюшевая синя лисичка"
	icon_state = "bluefox"
	pokephrase = "Яуу!"

/obj/item/toy/plushie/orange_fox
	name = "плюшевая оранжевая лисичка"
	icon_state = "orangefox"
	pokephrase = "Ях!"

/obj/item/toy/plushie/coffee_fox
	name = "плюшевая кофейная лисичка"
	icon_state = "coffeefox"
	pokephrase = "Герр!"

/obj/item/toy/plushie/pink_fox
	name = "плюшевая розовая лисичка"
	icon_state = "pinkfox"
	pokephrase = "Якк!"

/obj/item/toy/plushie/purple_fox
	name = "плюшевая фиолетовая лисичка"
	icon_state = "purplefox"
	pokephrase = "Ммнн!"

/obj/item/toy/plushie/crimson_fox
	name = "плюшевая алая лисичка"
	icon_state = "crimsonfox"
	pokephrase = "Ауу!"

/obj/item/toy/plushie/deer
	name = "плюшевый олененок"
	icon_state = "deer"
	pokephrase = "Бее!"

/obj/item/toy/plushie/black_cat
	name = "плюшевый черный котенок"
	icon_state = "blackcat"
	pokephrase = "Млем!"

/obj/item/toy/plushie/grey_cat
	name = "плюшевый серый котенок"
	icon_state = "greycat"
	pokephrase = "Мрау!"

/obj/item/toy/plushie/white_cat
	name = "плюшевый белый котенок"
	icon_state = "whitecat"
	pokephrase = "Меу!"

/obj/item/toy/plushie/orange_cat
	name = "плюшевый оранжевый котенок"
	icon_state = "orangecat"
	pokephrase = "Мяу!"

/obj/item/toy/plushie/siamese_cat
	name = "плюшевый сиамский котенок"
	icon_state = "siamesecat"
	pokephrase = "Мреу?"

/obj/item/toy/plushie/tabby_cat
	name = "плюшевый рыжий котенок"
	icon_state = "tabbycat"
	pokephrase = "Мурр!"

/obj/item/toy/plushie/tuxedo_cat
	name = "плюшевый пятнистый котенок"
	icon_state = "tuxedocat"
	pokephrase = "Мряууу!!"

// nah, squids are better than foxes :>

/obj/item/toy/plushie/squid/green
	name = "плюшевый зеленый осьминожка"
	desc = "Маленький милый друг-осьминожка. Этот осьминог зеленого цвета."
	icon = 'icons/obj/toy.dmi'
	icon_state = "greensquid"
	slot_flags = SLOT_HEAD
	pokephrase = "Squrr!"

/obj/item/toy/plushie/squid/mint
	name = "плюшевый мятный осьминожка"
	desc = "Маленький милый друг-осьминожка. Этот осьминог мятного цвета."
	icon = 'icons/obj/toy.dmi'
	icon_state = "mintsquid"
	slot_flags = SLOT_HEAD
	pokephrase = "Blurble!"

/obj/item/toy/plushie/squid/blue
	name = "плюшевый синий осьминожка"
	desc = "Маленький милый друг-осьминожка. Этот осьминог синего цвета."
	icon = 'icons/obj/toy.dmi'
	icon_state = "bluesquid"
	slot_flags = SLOT_HEAD
	pokephrase = "Blob!"

/obj/item/toy/plushie/squid/orange
	name = "плюшевый оранжевый осьминожка"
	desc = "Маленький милый друг-осьминожка. Этот осьминог оранжевого цвета."
	icon = 'icons/obj/toy.dmi'
	icon_state = "orangesquid"
	slot_flags = SLOT_HEAD
	pokephrase = "Squash!"

/obj/item/toy/plushie/squid/yellow
	name = "плюшевый желтый осьминожка"
	desc = "Маленький милый друг-осьминожка. Этот осьминог желтого цвета."
	icon = 'icons/obj/toy.dmi'
	icon_state = "yellowsquid"
	slot_flags = SLOT_HEAD
	pokephrase = "Glorble!"

/obj/item/toy/plushie/squid/pink
	name = "плюшевый розовый осьминожка"
	desc = "Маленький милый друг-осьминожка. Этот осьминог розового цвета."
	icon = 'icons/obj/toy.dmi'
	icon_state = "pinksquid"
	slot_flags = SLOT_HEAD
	pokephrase = "Wobble!"

/obj/item/toy/plushie/therapy/red
	name = "красная кукла"
	desc = "Игрушка как для развлечения, так и для терапии. Эта кукла красного цвета."
	icon = 'icons/obj/toy.dmi'
	icon_state = "therapyred"
	item_state = "egg4" // It's the red egg in items_left/righthand

/obj/item/toy/plushie/therapy/purple
	name = "фиолетовая кукла"
	desc = "Игрушка как для развлечения, так и для терапии. Эта кукла фиолетового цвета."
	icon = 'icons/obj/toy.dmi'
	icon_state = "therapypurple"
	item_state = "egg1" // It's the magenta egg in items_left/righthand

/obj/item/toy/plushie/therapy/blue
	name = "синяя кукла"
	desc = "Игрушка как для развлечения, так и для терапии. Эта кукла синего цвета."
	icon = 'icons/obj/toy.dmi'
	icon_state = "therapyblue"
	item_state = "egg2" // It's the blue egg in items_left/righthand

/obj/item/toy/plushie/therapy/yellow
	name = "желтая кукла"
	desc = "Игрушка как для развлечения, так и для терапии. Эта кукла желтого цвета."
	icon = 'icons/obj/toy.dmi'
	icon_state = "therapyyellow"
	item_state = "egg5" // It's the yellow egg in items_left/righthand

/obj/item/toy/plushie/therapy/orange
	name = "оранжевая кукла"
	desc = "Игрушка как для развлечения, так и для терапии. Эта кукла оранжевого цвета."
	icon = 'icons/obj/toy.dmi'
	icon_state = "therapyorange"
	item_state = "egg4" // It's the red one again, lacking an orange item_state and making a new one is pointless

/obj/item/toy/plushie/therapy/green
	name = "зеленая кукла"
	desc = "Игрушка как для развлечения, так и для терапии. Эта кукла зеленого цвета."
	icon = 'icons/obj/toy.dmi'
	icon_state = "therapygreen"
	item_state = "egg3" // It's the green egg in items_left/righthand


//Toy cult sword
/obj/item/toy/cultsword
	name = "пенопластовый меч"
	desc = "Мистическое оружие (из пенопласта), принадлежащее последователям популярного субботнего шоу \"Король Нарсий и Приспешники Героизма\"."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "cultblade"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_melee.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_melee.dmi',
		)
	w_class = ITEMSIZE_LARGE
	attack_verb = list("ударил", "разрубил", "зарезал", "потыкал")

//Flowers fake & real

/obj/item/toy/bouquet
	name = "букет"
	desc = "Замечательный букет цветов. Отлично пахнет!"
	icon = 'icons/obj/items.dmi'
	icon_state = "bouquet"
	w_class = ITEMSIZE_SMALL

/obj/item/toy/bouquet/fake
	name = "искусственный букет"
	desc = "Дешевый букет из пластмассовых цветов. Пахнет как дешевая пластмасса."

/obj/item/toy/stickhorse
	name = "лошадь на палке"
	desc = "Игого. На таких катаются юные ковбои."
	icon = 'icons/obj/toy.dmi'
	icon_state = "stickhorse"
	w_class = ITEMSIZE_LARGE

//////////////////////////////////////////////////////
//				Magic 8-Ball / Conch				//
//////////////////////////////////////////////////////

/obj/item/toy/eight_ball
	name = "Волшебный Шар"
	desc = "Мистический! Волшебный! Детям от 8 лет!"
	icon = 'icons/obj/toy.dmi'
	icon_state = "eight-ball"
	var/use_action = "встряхивает волшебный шар."
	var/cooldown = 0
	var/list/possible_answers = list("Абсолютно да.", "Знаки говорят - \"Да\"", "Вероятнее всего.", "Да.", "Спроси позже.", "Лучше пока не рассказывать.", "Будущее не ясно.", "Может быть.", "Сомнительно.", "Нет.", "Не расчитывай на это.", "Ни в коем случае.")

/obj/item/toy/eight_ball/attack_self(mob/user as mob)
	if(!cooldown)
		var/answer = pick(possible_answers)
		user.visible_message("<span class='notice'>[user] focuses on their question and [use_action]...</span>")
		user.visible_message("<span class='notice'>The [src] says \"[answer]\"</span>")
		spawn(30)
			cooldown = 0
		return

/obj/item/toy/eight_ball/conch
	name = "Волшебная Ракушка"
	desc = "Славься, Волшебная Ракушка!"
	icon_state = "conch"
	use_action = "тянет за ниточку."
	possible_answers = list("Да.", "Нет.", "Спроси ещё раз.", "Ответа нет.", "Я так не думаю.", "Ни то, ни другое.", "Может быть, когда-нибудь.")

// DND Character minis. Use the naming convention (type)character for the icon states.
/obj/item/toy/character
	icon = 'icons/obj/toy.dmi'
	w_class = ITEMSIZE_SMALL
	pixel_z = 5

/obj/item/toy/character/alien
	name = "фигурка ксеноморфа"
	desc = "Миниксеноморф. Жуть!"
	icon_state = "aliencharacter"
/obj/item/toy/character/cleric
	name = "фигурка жреца"
	desc = "Маленький жрец размахивает своим маленьким посохом."
	icon_state = "clericcharacter"
/obj/item/toy/character/warrior
	name = "фигурка воина"
	desc = "Из такого меча вышла бы неплохая зубочистка."
	icon_state = "warriorcharacter"
/obj/item/toy/character/thief
	name = "фигурка вора"
	desc = "Эй, а куда делся мой кошелёк?!"
	icon_state = "thiefcharacter"
/obj/item/toy/character/wizard
	name = "фигурка мага"
	desc = "МАГИЯ!"
	icon_state = "wizardcharacter"
/obj/item/toy/character/voidone
	name = "фигурка порождения бездны"
	desc = "Тёмный лорд восстал!"
	icon_state = "darkmastercharacter"
/obj/item/toy/character/lich
	name = "фигурка лича"
	desc = "Эксперт в массовых убийствах."
	icon_state = "lichcharacter"
/obj/item/weapon/storage/box/characters
	name = "коробка фигурок"
	desc = "Лучшие друзья ботана."
	icon_state = "box"
/obj/item/weapon/storage/box/characters/starts_with = list(
//	/obj/item/toy/character/alien,
	/obj/item/toy/character/cleric,
	/obj/item/toy/character/warrior,
	/obj/item/toy/character/thief,
	/obj/item/toy/character/wizard,
	/obj/item/toy/character/voidone,
	/obj/item/toy/character/lich
	)

/obj/item/toy/AI
	name = "игрушечный ИИ"
	desc = "Маленькое игрушечное ядро ИИ!"// with real law announcing action!" //Alas, requires a rewrite of how ion laws work.
	icon = 'icons/obj/toy.dmi'
	icon_state = "ИИ"
	w_class = ITEMSIZE_SMALL
	var/cooldown = 0
/*
/obj/item/toy/AI/attack_self(mob/user)
	if(!cooldown) //for the sanity of everyone
		var/message = generate_ion_law()
		to_chat(user, "<span class='notice'>You press the button on [src].</span>")
		playsound(src, 'sound/machines/click.ogg', 20, 1)
		visible_message("<span class='danger'>[message]</span>")
		cooldown = 1
		spawn(30) cooldown = 0
		return
	..()
*/
/obj/item/toy/owl
	name = "фигурка Филина"
	desc = "Фигурка Филина, защитника справедливости."
	icon = 'icons/obj/toy.dmi'
	icon_state = "owlprize"
	w_class = ITEMSIZE_SMALL
	var/cooldown = 0

/obj/item/toy/owl/attack_self(mob/user)
	if(!cooldown) //for the sanity of everyone
		var/message = pick("На этот раз тебе не убежать, Грифон!", "Ни с места, преступник!", "Хуу! Хуу!!", "Я есть ночь!")
		to_chat(user, "<span class='notice'>Вы тянете ниточку фигурки Филина.</span>")
		//playsound(src, 'sound/misc/hoot.ogg', 25, 1)
		visible_message("<span class='danger'>[message]</span>")
		cooldown = 1
		spawn(30) cooldown = 0
		return
	..()

/obj/item/toy/griffin
	name = "фигурка Грифона"
	desc = "Фигурка Грифона, преступного гения."
	icon = 'icons/obj/toy.dmi'
	icon_state = "griffinprize"
	w_class = ITEMSIZE_SMALL
	var/cooldown = 0

/obj/item/toy/griffin/attack_self(mob/user)
	if(!cooldown) //for the sanity of everyone
		var/message = pick("Тебе не остановить меня, Филин!", "Мой план безупречен! Хранилище будет моим!", "Карррррр!", "Тебе меня не поймать!")
		to_chat(user, "<span class='notice'>Вы тянете ниточку фигурки Грифона.</span>")
		//playsound(src, 'sound/misc/caw.ogg', 25, 1)
		visible_message("<span class='danger'>[message]</span>")
		cooldown = 1
		spawn(30) cooldown = 0
		return
	..()

/* NYET.
/obj/item/weapon/toddler
	icon_state = "toddler"
	name = "toddler"
	desc = "This baby looks almost real. Wait, did it just burp?"
	force = 5
	w_class = ITEMSIZE_LARGE
	slot_flags = SLOT_BACK
*/

//This should really be somewhere else but I don't know where. w/e

/obj/item/weapon/inflatable_duck
	name = "резиновая утка"
	desc = "Зачем опускаться или плавать, если можно держаться на плаву?"
	icon_state = "inflatable"
	icon = 'icons/obj/clothing/belts.dmi'
	slot_flags = SLOT_BELT
	drop_sound = 'sound/items/drop/rubber.ogg'

/obj/item/toy/xmastree
	name = "миниатюрная новогодняя елка"
	desc = "Малюсенькая рождественская ёлочка."
	icon = 'icons/obj/toy.dmi'
	icon_state = "tinyxmastree"
	w_class = ITEMSIZE_TINY
	force = 1
	throwforce = 1
	drop_sound = 'sound/items/drop/box.ogg'

//////////////////////////////////////////////////////
//					Chess Pieces					//
//////////////////////////////////////////////////////

/obj/item/toy/chess
	name = "шахматная фигурка"
	desc = "Этот текст не должно быть видно."
	icon = 'icons/obj/chess.dmi'
	w_class = ITEMSIZE_SMALL
	force = 1
	throwforce = 1
	drop_sound = 'sound/items/drop/glass.ogg'

/obj/item/toy/chess/pawn_white
	name = "синяя пешка"
	desc = "Большая пешка для игры в шахматы. Сделана из синего стекла."
	description_info = "Пешки могут передвигаться на одну клетку вперёд, если эта клетка не занята. Если пешка ещё не ходила, она может сделать шаг на две клетки вперед, если обе клетки перед ней не заняты. Пешка не может сделать шаг назад. Пешка может захватить вражескую фигуру только на одной из двух клеток по диагонали спереди от неё, но не на клетке перед собой."
	icon_state = "w-pawn"
/obj/item/toy/chess/pawn_black
	name = "фиолетовая пешка"
	desc = "Большая пешка для игры в шахматы. Сделана из фиолетового стекла"
	description_info = "Пешки могут передвигаться на одну клетку вперёд, если эта клетка не занята. Если пешка ещё не ходила, она может сделать шаг на две клетки вперед, если обе клетки перед ней не заняты. Пешка не может сделать шаг назад. Пешка может захватить вражескую фигуру только на одной из двух клеток по диагонали спереди от неё, но не на клетке перед собой."
	icon_state = "b-pawn"
/obj/item/toy/chess/rook_white
	name = "синяя ладья"
	desc = "Большая ладья для игры в шахматы. Сделана из синего стекла."
	description_info = "Ладья может сходить на любое количество свободных клеток по горизонтали или вертикали."
	icon_state = "w-rook"
/obj/item/toy/chess/rook_black
	name = "фиолетовая ладья"
	desc = "Большая пешка для игры в шахматы. Сделана из фиолетового стекла."
	description_info = "Ладья может сходить на любое количество свободных клеток по горизонтали или вертикали."
	icon_state = "b-rook"
/obj/item/toy/chess/knight_white
	name = "синий конь"
	desc = "Большой конь для игры в шахматы. Сделан из синего стекла. К сожалению, на нём не прокатишься."
	description_info = "Конь может сходить либо на две клетки по горизонтали и одну по вертикали, либо на две по вертикали и одну по горизонтали, т.е. в форме буквы Г."
	icon_state = "w-knight"
/obj/item/toy/chess/knight_black
	name = "фиолетовый конь"
	desc = "Большой конь для игры в шахматы. Сделан из фиолетового стекла. Лишь царапина."
	description_info = "Конь может сходить либо на две клетки по горизонтали и одну по вертикали, либо на две по вертикали и одну по горизонтали, т.е. в форме буквы Г."
	icon_state = "b-knight"
/obj/item/toy/chess/bishop_white
	name = "синий слон"
	desc = "Большой слон для игры в шахматы. Сделан из синего стекла."
	description_info = "Слон может сходить на любое количество свободных клеток по диагонали."
	icon_state = "w-bishop"
/obj/item/toy/chess/bishop_black
	name = "фиолетовый слон"
	desc = "Большой слон для игры в шахматы. Сделан из фиолетового стекла."
	description_info = "Слон может сходить на любое количество свободных клеток по диагонали."
	icon_state = "b-bishop"
/obj/item/toy/chess/queen_white
	name = "синий ферзь"
	desc = "Большой ферзь для игры в шахматы. Сделан из синего стекла."
	description_info = "Ферзь может сходить на любое количество свободных клеток по горизонтали, вертикали или диагонали."
	icon_state = "w-queen"
/obj/item/toy/chess/queen_black
	name = "фиолетовый ферзь"
	desc = "Большой ферзь для игры в шахматы. Сделан из фиолетового стекла."
	description_info = "Ферзь может сходить на любое количество свободных клеток по горизонтали, вертикали или диагонали."
	icon_state = "b-queen"
/obj/item/toy/chess/king_white
	name = "синий король"
	desc = "Большой король для игры в шахматы. Сделан из синего стекла."
	description_info = "Король может сходить на одну клетку по горизонтали, вертикали или диагонали. Если оппонент захватит эту фигуру, он выигрывает."
	icon_state = "w-king"
/obj/item/toy/chess/king_black
	name = "фиолетовый король"
	desc = "Большой король для игры в шахматы. Сделан из фиолетового стекла."
	description_info = "Король может сходить на одну клетку по горизонтали, вертикали или диагонали. Если оппонент захватит эту фигуру, он выигрывает."
	icon_state = "b-king"

/// Balloon structures

/obj/structure/balloon
	name = "обыкновенный шарик"
	desc = "Самый что ни на есть обыкновенный шарик. Скукотища."
	icon = 'icons/obj/toy.dmi'
	icon_state = "ghostballoon"
	anchored = 0
	density = 0

/obj/structure/balloon/attack_hand(mob/user)
	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)

	if(user.a_intent == I_HELP)
		user.visible_message("<span class='notice'><b>[user]</b> тыкает [src]!</span>","<span class='notice'>Вы тыкаете [src]!</span>")
	else if (user.a_intent == I_HURT)
		user.visible_message("<span class='warning'><b>[user]</b> стукает [src]!</span>","<span class='warning'>Вы стукаете [src]!</span>")
	else if (user.a_intent == I_GRAB)
		user.visible_message("<span class='warning'><b>[user]</b> пытается лопнуть [src]!</span>","<span class='warning'>Вы пытаетесь лопнуть [src]!</span>")
	else
		user.visible_message("<span class='notice'><b>[user]</b> легонько стукает [src].</span>","<span class='notice'>Вы легонько стукаете [src].</span>")

/obj/structure/balloon/bat
	name = "шарик в виде летучей мыши"
	desc = "Большой воздушный шар в форме страшной летучей мыши с оранжевыми глазами."
	icon_state = "batballoon"

/obj/structure/balloon/ghost
	name = "шарик в виде привидения"
	desc = "О нет, привидение! А, нет, всего лишь воздушный шарик. Фух!"
	icon_state = "ghostballoon"