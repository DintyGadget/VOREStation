//cleansed 9/15/2012 17:48

/*
CONTAINS:
MATCHES
CIGARETTES
CIGARS
SMOKING PIPES
CUSTOM CIGS
CHEAP LIGHTERS
ZIPPO

CIGARETTE PACKETS ARE IN FANCY.DM
*/

//For anything that can light stuff on fire
/obj/item/weapon/flame
	var/lit = 0

/obj/item/weapon/flame/is_hot()
	return lit

///////////
//MATCHES//
///////////
/obj/item/weapon/flame/match
	name = "спичка"
	desc = "Обыкновенная спичка для зажигания табака."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "match_unlit"
	var/burnt = 0
	var/smoketime = 5
	w_class = ITEMSIZE_TINY
	origin_tech = list(TECH_MATERIAL = 1)
	slot_flags = SLOT_EARS
	attack_verb = list("burnt", "singed")
	drop_sound = 'sound/items/drop/food.ogg'
	pickup_sound = 'sound/items/pickup/food.ogg'

/obj/item/weapon/flame/match/process()
	if(isliving(loc))
		var/mob/living/M = loc
		M.IgniteMob()
	var/turf/location = get_turf(src)
	smoketime--
	if(smoketime < 1)
		burn_out()
		return
	if(location)
		location.hotspot_expose(700, 5)
		return

/obj/item/weapon/flame/match/dropped(mob/user as mob)
	//If dropped, put ourselves out
	//not before lighting up the turf we land on, though.
	if(lit)
		spawn(0)
			var/turf/location = src.loc
			if(istype(location))
				location.hotspot_expose(700, 5)
			burn_out()
	return ..()

/obj/item/weapon/flame/match/proc/light(var/mob/user)
	playsound(src, 'sound/items/cigs_lighters/matchstick_lit.ogg', 25, 0, -1)
	lit = 1
	damtype = "burn"
	icon_state = "match_lit"
	name = "горящая спичка"
	desc = "Спичка. На данный момент горит."
	START_PROCESSING(SSobj, src)

/obj/item/weapon/flame/match/proc/burn_out()
	lit = 0
	burnt = 1
	damtype = "brute"
	icon_state = "match_burnt"
	item_state = "cigoff"
	name = "погасшая спичка"
	desc = "Спичка. Видала деньки получше."
	STOP_PROCESSING(SSobj, src)

//////////////////
//FINE SMOKABLES//
//////////////////
/obj/item/clothing/mask/smokable
	name = "что-то, что можно закурить"
	desc = "Вы без понятия, что это. Стоит прописать АХЕЛП."
	body_parts_covered = 0
	var/lit = 0
	var/icon_on
	var/type_butt = null
	var/chem_volume = 0
	var/max_smoketime = 0	//Related to sprites
	var/smoketime = 0
	var/is_pipe = 0		//Prevents a runtime with pipes
	var/matchmes = "USER зажигает NAME при помощи FLAME"
	var/lightermes = "USER зажигает NAME при помощи FLAME"
	var/zippomes = "USER зажигает NAME при помощи FLAME"
	var/weldermes = "USER зажигает NAME при помощи FLAME"
	var/ignitermes = "USER зажигает NAME при помощи FLAME"
	var/brand
	blood_sprite_state = null //Can't bloody these
	drop_sound = 'sound/items/cigs_lighters/cig_snuff.ogg'

/obj/item/clothing/mask/smokable/Initialize()
	. = ..()
	flags |= NOREACT // so it doesn't react until you light it
	create_reagents(chem_volume) // making the cigarrete a chemical holder with a maximum volume of 15
	if(smoketime && !max_smoketime)
		max_smoketime = smoketime

/obj/item/clothing/mask/smokable/proc/smoke(amount)
	if(smoketime > max_smoketime)
		smoketime = max_smoketime
	smoketime -= amount
	if(reagents && reagents.total_volume) // check if it has any reagents at all
		if(ishuman(loc))
			var/mob/living/carbon/human/C = loc
			if (src == C.wear_mask && C.check_has_mouth()) // if it's in the human/monkey mouth, transfer reagents to the mob
				reagents.trans_to_mob(C, REM, CHEM_INGEST, 0.2) // Most of it is not inhaled... balance reasons.
		else // else just remove some of the reagents
			reagents.remove_any(REM)

/obj/item/clothing/mask/smokable/process()
	var/turf/location = get_turf(src)
	smoke(1)
	if(smoketime < 1)
		die()
		return
	if(location)
		location.hotspot_expose(700, 5)

/obj/item/clothing/mask/smokable/update_icon()
	if(lit)
		icon_state = "[initial(icon_state)]_on"
		item_state = "[initial(item_state)]_on"
	else if(smoketime < max_smoketime)
		if(is_pipe)
			icon_state = initial(icon_state)
			item_state = initial(item_state)
		else
			icon_state = "[initial(icon_state)]_burnt"
			item_state = "[initial(item_state)]_burnt"
	if(ismob(loc))
		var/mob/living/M = loc
		M.update_inv_wear_mask(0)
		M.update_inv_l_hand(0)
		M.update_inv_r_hand(1)
	..()

/obj/item/clothing/mask/smokable/examine(mob/user)
	. = ..()

	if(!is_pipe)
		var/smoke_percent = round((smoketime / max_smoketime) * 100)
		switch(smoke_percent)
			if(90 to INFINITY)
				. += "[src] ещё свежая."
			if(60 to 90)
				. += "[src] ещё какое-то время будет гореть."
			if(30 to 60)
				. += "[src] будет гореть ещё столько же времени."
			if(10 to 30)
				. += "[src] начинает подзатухать"
			else
				. += "[src] почти затухает!"

/obj/item/clothing/mask/smokable/proc/light(var/flavor_text = "[usr] lights the [name].")
	if(!src.lit)
		src.lit = 1
		playsound(src, 'sound/items/cigs_lighters/cig_light.ogg', 75, 1, -1)
		damtype = "fire"
		if(reagents.get_reagent_amount("phoron")) // the phoron explodes when exposed to fire
			var/datum/effect/effect/system/reagents_explosion/e = new()
			e.set_up(round(reagents.get_reagent_amount("phoron") / 2.5, 1), get_turf(src), 0, 0)
			e.start()
			qdel(src)
			return
		if(reagents.get_reagent_amount("fuel")) // the fuel explodes, too, but much less violently
			var/datum/effect/effect/system/reagents_explosion/e = new()
			e.set_up(round(reagents.get_reagent_amount("fuel") / 5, 1), get_turf(src), 0, 0)
			e.start()
			qdel(src)
			return
		flags &= ~NOREACT // allowing reagents to react after being lit
		reagents.handle_reactions()
		var/turf/T = get_turf(src)
		T.visible_message(flavor_text)
		update_icon()
		set_light(2, 0.25, "#E38F46")
		START_PROCESSING(SSobj, src)

/obj/item/clothing/mask/smokable/proc/die(var/nomessage = 0)
	var/turf/T = get_turf(src)
	set_light(0)
	playsound(src, 'sound/items/cigs_lighters/cig_snuff.ogg', 50, 1)
	STOP_PROCESSING(SSobj, src)
	if (type_butt)
		var/obj/item/butt = new type_butt(T)
		transfer_fingerprints_to(butt)
		if(brand)
			butt.desc += " This one is \a [brand]."
		if(ismob(loc))
			var/mob/living/M = loc
			if (!nomessage)
				to_chat(M, "<span class='notice'>[name] затухает в Вашем рту.</span>")
			M.remove_from_mob(src) //un-equip it so the overlays can update
			M.update_inv_wear_mask(0)
			M.update_inv_l_hand(0)
			M.update_inv_r_hand(1)
		qdel(src)
	else
		new /obj/effect/decal/cleanable/ash(T)
		if(ismob(loc))
			var/mob/living/M = loc
			if (!nomessage)
				to_chat(M, "<span class='notice'>[name] затухает в Вашем рту, и Вы стряхиваете пепел.</span>")
				playsound(src, 'sound/items/cigs_lighters/cig_snuff.ogg', 50, 1)
			lit = 0
			icon_state = initial(icon_state)
			item_state = initial(item_state)
			M.update_inv_wear_mask(0)
			M.update_inv_l_hand(0)
			M.update_inv_r_hand(1)
			smoketime = 0
			reagents.clear_reagents()
			name = "empty [initial(name)]"

/obj/item/clothing/mask/smokable/proc/quench()
	lit = 0
	STOP_PROCESSING(SSobj, src)
	update_icon()

/obj/item/clothing/mask/smokable/attack(mob/living/carbon/human/H, mob/user, def_zone)
	if(lit && H == user && istype(H))
		var/obj/item/blocked = H.check_mouth_coverage()
		if(blocked)
			to_chat(H, "<span class='warning'>[blocked] не позволяет закурить!</span>")
			return 1
		to_chat(H, "<span class='notice'>Вы втягиваете дым.</span>")
		playsound(src, 'sound/items/cigs_lighters/inhale.ogg', 50, 0, -1)
		smoke(5)
		return 1
	return ..()

/obj/item/clothing/mask/smokable/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(W.is_hot())
		var/text = matchmes
		if(istype(W, /obj/item/weapon/flame/match))
			text = matchmes
		else if(istype(W, /obj/item/weapon/flame/lighter/zippo))
			text = zippomes
		else if(istype(W, /obj/item/weapon/flame/lighter))
			text = lightermes
		else if(istype(W, /obj/item/weapon/weldingtool))
			text = weldermes
		else if(istype(W, /obj/item/device/assembly/igniter))
			text = ignitermes
		text = replacetext(text, "USER", "[user]")
		text = replacetext(text, "NAME", "[name]")
		text = replacetext(text, "FLAME", "[W.name]")
		light(text)

/obj/item/clothing/mask/smokable/attack(var/mob/living/M, var/mob/living/user, def_zone)
	if(istype(M) && M.on_fire)
		user.do_attack_animation(M)
		light("<span class='notice'>[user] брутально зажигает [name] горящим телом [M].</span>")
		return 1
	else
		return ..()

/obj/item/clothing/mask/smokable/water_act(amount)
	if(amount >= 5)
		quench()

/obj/item/clothing/mask/smokable/cigarette
	name = "сигарета"
	desc = "Скрутка из табака и никотина."
	icon_state = "cig"
	item_state = "cig"
	throw_speed = 0.5
	w_class = ITEMSIZE_TINY
	slot_flags = SLOT_EARS | SLOT_MASK
	attack_verb = list("burnt", "singed")
	type_butt = /obj/item/trash/cigbutt
	chem_volume = 15
	max_smoketime = 300
	smoketime = 300
	var/nicotine_amt = 2
	matchmes = "<span class='notice'>USER поджигает сигарету при помощи спички.</span>"
	lightermes = "<span class='notice'>USER поджигает сигарету дешевой зажигалкой.</span>"
	zippomes = "<span class='rose'>Грациозным движением запястья, USER поджигает сигарету зажигалкой Зиппо.</span>"
	weldermes = "<span class='notice'>USER как ни в чём не бывало зажигает сигарету сварочным аппаратом.</span>"
	ignitermes = "<span class='notice'>USER играется с воспламенителем и успешно зажигает сигарету.</span>"

/obj/item/clothing/mask/smokable/cigarette/Initialize()
	. = ..()
	if(nicotine_amt)
		reagents.add_reagent("nicotine", nicotine_amt)

/obj/item/clothing/mask/smokable/cigarette/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()

	if(istype(W, /obj/item/weapon/melee/energy/sword))
		var/obj/item/weapon/melee/energy/sword/S = W
		if(S.active)
			light("<span class='warning'>[user] взмахивает своим энергетическим мечом, едва ли не попадая себе по носу. При этом воспламеняется [name] во рту.</span>")

	return

/obj/item/clothing/mask/smokable/cigarette/afterattack(obj/item/weapon/reagent_containers/glass/glass, mob/user as mob, proximity)
	..()
	if(!proximity)
		return
	if(istype(glass)) //you can dip cigarettes into beakers
		var/transfered = glass.reagents.trans_to_obj(src, chem_volume)
		if(transfered)	//if reagents were transfered, show the message
			to_chat(user, "<span class='notice'>Вы опускаете сигарету в стакан.</span>")
		else			//if not, either the beaker was empty, or the cigarette was full
			if(!glass.reagents.total_volume)
				to_chat(user, "<span class='notice'>Стакан пуст.</span>")
			else
				to_chat(user, "<span class='notice'>[src] полна.</span>")

/obj/item/clothing/mask/smokable/cigarette/attack_self(mob/user as mob)
	if(lit == 1)
		if(user.a_intent == I_HURT)
			user.visible_message("<span class='notice'>[user] бросает сигарету на пол и тушит её ногой.</span>")
			playsound(src, 'sound/items/cigs_lighters/cig_snuff.ogg', 50, 1)
			die(1)
		else
			user.visible_message("<span class='notice'>[user] тушит сигарету.</span>")
			quench()
	return ..()

////////////
// CIGARS //
////////////
/obj/item/clothing/mask/smokable/cigarette/cigar
	name = "премиум сигара"
	desc = "Коричневая скрутка из табака и... чего-то ещё. Огромная!"
	description_fluff = "На этикетке, конечно, написано, что это 'премиум сигара', однако она рядом не стояла с остальными сигарами на рынке. Качественная ли она? Возможно. Изговлена ли она вручную теми, кому не наплевать? Нет."
	icon_state = "cigar2"
	type_butt = /obj/item/trash/cigbutt/cigarbutt
	throw_speed = 0.5
	item_state = "cigar"
	max_smoketime = 1500
	smoketime = 1500
	chem_volume = 20
	nicotine_amt = 4
	matchmes = "<span class='notice'>USER зажигает свою сигару при помощи спички.</span>"
	lightermes = "<span class='notice'>USER оскобляет чувства своей сигары, зажигая её дешевой зажигалкой.</span>"
	zippomes = "<span class='rose'>Грациозным движением запястья, USER поджигает сигару зажигалкой Зиппо.</span>"
	weldermes = "<span class='notice'>USER оскобляет чувства своей сигары, зажигая её сварочным аппаратом.</span>"
	ignitermes = "<span class='notice'>USER играется с воспламенителем и успешно зажигает сигару силой науки.</span>"

/obj/item/clothing/mask/smokable/cigarette/cigar/cohiba
	name = "сигара Кохибо Робасто"
	desc = "Слегка превосходит ожидания."
	description_fluff = "Кохиба уже на протяжение многих веков остаётся известной маркой сигарет. Компания отказывается расширять своё производство дальше Кубы, в связи с чем их сигареты ограничены в количестве и распространены по всему космосу. Робасто - одна из наиболее популярных их скруток."
	icon_state = "cigar2"
	nicotine_amt = 7

/obj/item/clothing/mask/smokable/cigarette/cigar/havana
	name = "премиум сигара Гавана"
	desc = "Только самое лучшее."
	description_fluff = "Сигарой Гавана обычно прозывают любую самодельную сигару в кубинском стиле. Эта сигара изготовлена табачным отделением Гилтани и производится по всей галактике. Пускай такая методика изготовления сигар и была извращена до неузнаваемости с течением лет, качество за счёт этого не пострадало, даже при всей обширной разносортности сигар Гавана."
	icon_state = "cigar2"
	max_smoketime = 7200
	smoketime = 7200
	chem_volume = 30
	nicotine_amt = 10

/obj/item/trash/cigbutt
	name = "окурок сигары"
	desc = "Остаток от сигары."
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "cigbutt"
	randpixel = 10
	w_class = ITEMSIZE_TINY
	slot_flags = SLOT_EARS
	throwforce = 1

/obj/item/trash/cigbutt/Initialize()
	. = ..()
	randpixel_xy()
	transform = turn(transform,rand(0,360))

/obj/item/trash/cigbutt/cigarbutt
	name = "окурок сигары"
	desc = "Остаток от сигары."
	icon_state = "cigarbutt"

/obj/item/clothing/mask/smokable/cigarette/cigar/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()

	user.update_inv_wear_mask(0)
	user.update_inv_l_hand(0)
	user.update_inv_r_hand(1)

/////////////////
//SMOKING PIPES//
/////////////////
/obj/item/clothing/mask/smokable/pipe
	name = "smoking pipe"
	desc = "Трубка для курения. Изготовлена из дорогой вишневой древесины."
	description_fluff = " Аксессуары и Галантерея КлассиКо - корпорация, первоначально основанная на Марсе — гордятся своей продукцией для, по их словам, 'современных джентльменов'. Большинство их товаров крайне дороги и редки, однако они гарантируют в обмен на это высокое качество своей продукции и обычно с этим не обманывают."
	icon_state = "pipe"
	item_state = "pipe"
	smoketime = 0
	chem_volume = 50
	matchmes = "<span class='notice'>USER зажигает свою курительную трубку при помощи спички.</span>"
	lightermes = "<span class='notice'>USER зажигает курительную трубку при помощи зажигалки.</span>"
	zippomes = "<span class='rose'>С должной аккуратностью, USER грациозно воспламеняет курительную трубку зажигалкой Зиппо.</span>"
	weldermes = "<span class='notice'>USER бездумно поджигает курительную трубку сварочным аппаратом.</span>"
	ignitermes = "<span class='notice'>USER тыркает воспламенитель, и зажигает курительную трубку при помощи силы науки.</span>"
	is_pipe = 1

/obj/item/clothing/mask/smokable/pipe/New()
	..()
	name = "empty [initial(name)]"

/obj/item/clothing/mask/smokable/pipe/attack_self(mob/user as mob)
	if(lit == 1)
		if(user.a_intent == I_HURT)
			user.visible_message("<span class='notice'>[user] empties the lit [src] on the floor!.</span>")
			playsound(src, 'sound/items/cigs_lighters/cig_snuff.ogg', 50, 1)
			die(1)
		else
			user.visible_message("<span class='notice'>[user] puts out \the [src].</span>")
			quench()

/obj/item/clothing/mask/smokable/pipe/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/melee/energy/sword))
		return

	..()

	if (istype(W, /obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/food/snacks/grown/G = W
		if (!G.dry)
			to_chat(user, "<span class='notice'>[G] must be dried before you stuff it into [src].</span>")
			return
		if (smoketime)
			to_chat(user, "<span class='notice'>[src] is already packed.</span>")
			return
		max_smoketime = 1000
		smoketime = 1000
		if(G.reagents)
			G.reagents.trans_to_obj(src, G.reagents.total_volume)
		name = "[G.name]-packed [initial(name)]"
		qdel(G)

	else if(istype(W, /obj/item/weapon/flame/lighter))
		var/obj/item/weapon/flame/lighter/L = W
		if(L.lit)
			light("<span class='notice'>[user] поджигает трубку зажигалкой.</span>")

	else if(istype(W, /obj/item/weapon/flame/match))
		var/obj/item/weapon/flame/match/M = W
		if(M.lit)
			light("<span class='notice'>[user] поджигает трубку при помощи спички.</span>")

	else if(istype(W, /obj/item/device/assembly/igniter))
		light("<span class='notice'>[user] тыркает воспламенитель и успешно зажигает курительную трубку при помощи силы науки.</span>")

	user.update_inv_wear_mask(0)
	user.update_inv_l_hand(0)
	user.update_inv_r_hand(1)

/obj/item/clothing/mask/smokable/pipe/cobpipe
	name = "курительная трубка"
	desc = "Дозатор никотина, популяризованный ценителями из трущоб. Всё так же в моде, однако, благодаря, космическим хипстерам."
	icon_state = "cobpipe"
	item_state = "cobpipe"
	chem_volume = 35

///////////////
//CUSTOM CIGS//
///////////////
//and by custom cigs i mean craftable joints. smoke weed every day

/obj/item/clothing/mask/smokable/cigarette/joint
	name = "самокрутка"
	desc = "Этот текст не должно быть видно."
	icon_state = "joint"
	max_smoketime = 500
	smoketime = 500
	nicotine_amt = 0

/obj/item/weapon/rollingpaper
	name = "бумага для самокруток"
	desc = "Маленький тоненький кусочек легковоспламеняемой бумаги, обычно используемый для изготовления и закуривания самокруток."
	description_fluff = "Легализация определенных веществ привела к взлету продаж соответствующей бумаги. Теперь каждая трансгалактическая корпорация производит по нескольку вариаций, зачастую сомнительного качества."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cig paper"

/obj/item/weapon/rollingpaper/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/food/snacks/grown/G = W
		if (!G.dry)
			to_chat(user, "<span class='notice'>Это необходимо сперва высушить, прежде чем закатывать!</span>")
			return
		var/obj/item/clothing/mask/smokable/cigarette/joint/J = new /obj/item/clothing/mask/smokable/cigarette/joint(user.loc)
		to_chat(usr, "<span class='notice'>Вы закатываете самокрутку!</span>")
		J.add_fingerprint(user)
		if(G.reagents)
			G.reagents.trans_to_obj(J, G.reagents.total_volume)
		J.name = "самокрутка ([G.name])"
		J.desc = "Самокрутка, закатанная с любовью. Содержимое: [G.name]."
		qdel(G)
		qdel(src)

/////////
//ZIPPO//
/////////
/obj/item/weapon/flame/lighter
	name = "дешевая зажигалка"
	desc = "Чуть ли не бесплатная зажигалка."
	description_fluff = "'Изготовлено вручную на Альтаире' - какой-то очень странный способ назвать дешевый рабочий труд заключенных преступников. Ничего удивительного в том, что они продаются чуть ли не бесплатно."
	icon = 'icons/obj/items.dmi'
	icon_state = "lighter-g"
	item_state = "lighter-g"
	w_class = ITEMSIZE_TINY
	throwforce = 4
	slot_flags = SLOT_BELT
	attack_verb = list("поджигает", "singed")
	var/base_state
	var/activation_sound = 'sound/items/lighter_on.ogg'
	var/deactivation_sound = 'sound/items/lighter_off.ogg'

/obj/item/weapon/flame/lighter/zippo
	name = "зажигалка Зиппо"
	desc = "Зиппо."
	description_fluff = "Всё ещё не подводит спустя все эти годы."
	icon = 'icons/obj/zippo.dmi'
	icon_state = "zippo"
	item_state = "zippo"
	activation_sound = 'sound/items/zippo_on.ogg'
	deactivation_sound = 'sound/items/zippo_off.ogg'

/obj/item/weapon/flame/lighter/random
	New()
		icon_state = "lighter-[pick("r","c","y","g")]"
		item_state = icon_state
		base_state = icon_state

/obj/item/weapon/flame/lighter/attack_self(mob/living/user)
	if(!base_state)
		base_state = icon_state
	if(!lit)
		lit = 1
		icon_state = "[base_state]on"
		item_state = "[base_state]on"
		playsound(src, activation_sound, 75, 1)
		if(istype(src, /obj/item/weapon/flame/lighter/zippo) )
			user.visible_message("<span class='rose'>Уверенным и ловким движением, [user] расщелкивает зажигалку Зиппо.</span>")
		else
			if(prob(95))
				user.visible_message("<span class='notice'>Спустя пару попыток, [user] успешно зажигает дешевую зажигалку.</span>")
			else
				to_chat(user, "<span class='warning'>Вы случайно обжигаетесь в попытке включить зажигалку!</span>")
				if (user.get_left_hand() == src)
					user.apply_damage(2,BURN,"l_hand")
				else
					user.apply_damage(2,BURN,"r_hand")
				user.visible_message("<span class='notice'>Спустя несколько попыток, [user] зажигает дешевую зажигалку, однако задевает пламя пальцем!</span>")

		set_light(2)
		START_PROCESSING(SSobj, src)
	else
		lit = 0
		icon_state = "[base_state]"
		item_state = "[base_state]"
		playsound(src, deactivation_sound, 75, 1)
		if(istype(src, /obj/item/weapon/flame/lighter/zippo) )
			user.visible_message("<span class='rose'>Вы  видите, как [user] не глядя  захлапывает зажигалку Зиппо с тихим щелчком.</span>")
		else
			user.visible_message("<span class='notice'>[user] тихонько тушит зажигалку.</span>")

		set_light(0)
		STOP_PROCESSING(SSobj, src)
	return


/obj/item/weapon/flame/lighter/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M, /mob))
		return

	if(lit == 1)
		M.IgniteMob()
		add_attack_logs(user,M,"Подожжен: [src]")

	if(istype(M.wear_mask, /obj/item/clothing/mask/smokable/cigarette) && user.zone_sel.selecting == O_MOUTH && lit)
		var/obj/item/clothing/mask/smokable/cigarette/cig = M.wear_mask
		if(M == user)
			cig.attackby(src, user)
		else
			if(istype(src, /obj/item/weapon/flame/lighter/zippo))
				cig.light("<span class='rose'>[user] достаёт зажигалку Зиппо и подносит её к [M].</span>")
			else
				cig.light("<span class='notice'>[user] подносит зажигалку к [M] и даёт закурить.</span>")
	else
		..()

/obj/item/weapon/flame/lighter/process()
	var/turf/location = get_turf(src)
	if(location)
		location.hotspot_expose(700, 5)
	return

//Here we add Zippo skins.

/obj/item/weapon/flame/lighter/zippo/black
	name = "святая зажигалка Зиппо"
	desc = "Только в отношении христианства, конечно."
	icon_state = "blackzippo"

/obj/item/weapon/flame/lighter/zippo/blue
	name = "синяя зажигалка Зиппо"
	icon_state = "bluezippo"

/obj/item/weapon/flame/lighter/zippo/engraved
	name = "гравированная зажигалка Зиппо"
	icon_state = "engravedzippo"
	item_state = "zippo"

/obj/item/weapon/flame/lighter/zippo/gold
	name = "золотая зажигалка Зиппо"
	icon_state = "goldzippo"

/obj/item/weapon/flame/lighter/zippo/moff
	name = "мотыльковая зажигалка Зиппо"
	desc = "Too cute to be a Tymisian."
	icon_state = "moffzippo"

/obj/item/weapon/flame/lighter/zippo/red
	name = "красная зажигалка Зиппо"
	icon_state = "redzippo"

/obj/item/weapon/flame/lighter/zippo/ironic
	name = "ироничная зажигалка Зиппо"
	desc = "What a quiant idea."
	icon_state = "ironiczippo"

/obj/item/weapon/flame/lighter/zippo/capitalist
	name = "зажигалка Зиппо капиталиста"
	desc = "Изготовлена из золота и обсидиана и даже не стоит своих денег."
	icon_state = "cappiezippo"

/obj/item/weapon/flame/lighter/zippo/communist
	name = "зажигалка Зиппо коммуниста"
	desc = "Всё, что нужно, чтобы зажечь революцию."
	icon_state = "commiezippo"

/obj/item/weapon/flame/lighter/zippo/royal
	name = "королевская зажигалка Зиппо"
	desc = "Невероятно роскошная зажигалка, обрамленная цветами монархии."
	icon_state = "royalzippo"

/obj/item/weapon/flame/lighter/zippo/gonzo
	name = "зажигалка Зиппо в стиле Гонзо"
	desc = "Зажигалка с известным символом - кулаком Гонзо."
	icon_state = "gonzozippo"

/obj/item/weapon/flame/lighter/zippo/rainbow
	name = "радужная зажигалка Зиппо"
	icon_state = "rainbowzippo"