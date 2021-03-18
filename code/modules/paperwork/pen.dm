/* Pens!
 * Contains:
 *		Pens
 *		Sleepy Pens
 *		Parapens
 */


/*
 * Pens
 */
/obj/item/weapon/pen
	desc = "Обыкновенная ручка с черными чернилами."
	name = "ручка"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pen"
	item_state = "pen"
	slot_flags = SLOT_BELT | SLOT_EARS
	throwforce = 0
	w_class = ITEMSIZE_TINY
	throw_speed = 7
	throw_range = 15
	matter = list(DEFAULT_WALL_MATERIAL = 10)
	var/colour = "black"	//what colour the ink is!
	pressure_resistance = 2
	drop_sound = 'sound/items/drop/accessory.ogg'
	pickup_sound = 'sound/items/pickup/accessory.ogg'

/obj/item/weapon/pen/attack_self(var/mob/user)
	if(!user.checkClickCooldown())
		return
	user.setClickCooldown(1 SECOND)
	to_chat(user, "<span class='notice'>Щёлк.</span>")
	playsound(src, 'sound/items/penclick.ogg', 50, 1)

/obj/item/weapon/pen/blue
	desc = "Обыкновенная ручка с синими чернилами."
	icon_state = "pen_blue"
	colour = "blue"

/obj/item/weapon/pen/red
	desc = "Обыкновенная ручка с красными чернилами."
	icon_state = "pen_red"
	colour = "red"

/obj/item/weapon/pen/fountain
	desc = "Качественная перьевая ручка."
	icon_state = "pen_fountain"

/obj/item/weapon/pen/multi
	desc = "Ручка с несколькими цветами чернил!"
	var/selectedColor = 1
	var/colors = list("black","blue","red")

/obj/item/weapon/pen/AltClick(mob/user)
	to_chat(user, "<span class='notice'>Щёлк.</span>")
	playsound(src, 'sound/items/penclick.ogg', 50, 1)
	return

/obj/item/weapon/pen/multi/attack_self(mob/user)
	if(++selectedColor > 3)
		selectedColor = 1

	colour = colors[selectedColor]

	if(colour == "black")
		icon_state = "pen"
	else
		icon_state = "pen_[colour]"

	to_chat(user, "<span class='notice'>Вы поменяли цвет чернил в ручке.</span>")

/obj/item/weapon/pen/invisible
	desc = "Ручка с прозрачными чернилами."
	icon_state = "pen"
	colour = "white"

/*
 * Reagent pens
 */

/obj/item/weapon/pen/reagent
	flags = OPENCONTAINER
	origin_tech = list(TECH_MATERIAL = 2, TECH_ILLEGAL = 5)

/obj/item/weapon/pen/reagent/New()
	..()
	create_reagents(30)

/obj/item/weapon/pen/reagent/attack(mob/living/M as mob, mob/user as mob)

	if(!istype(M))
		return

	. = ..()

	if(M.can_inject(user,1))
		if(reagents.total_volume)
			if(M.reagents)
				var/contained = reagents.get_reagents()
				var/trans = reagents.trans_to_mob(M, 30, CHEM_BLOOD)
				add_attack_logs(user,M,"Injected with [src.name] containing [contained], trasferred [trans] units")

/*
 * Blade pens.
 */

/obj/item/weapon/pen/blade
	desc = "Обыкновенная ручка с черными чернилами."
	description_antag = "Альт+клик превращает эту ручку в смертоносное метательное оружие ближнего боя. Поймать его без вреда не возможно."
	name = "ручка"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pen"
	item_state = "pen"
	slot_flags = SLOT_BELT | SLOT_EARS
	throwforce = 3
	w_class = ITEMSIZE_TINY
	throw_speed = 7
	throw_range = 15
	armor_penetration = 20

	var/active = 0
	var/active_embed_chance = 0
	var/active_force = 15
	var/active_throwforce = 30
	var/active_w_class = ITEMSIZE_NORMAL
	var/active_icon_state
	var/default_icon_state

/obj/item/weapon/pen/blade/Initialize()
	. = ..()
	active_icon_state = "[icon_state]-x"
	default_icon_state = icon_state

/obj/item/weapon/pen/blade/AltClick(mob/user)
	..()
	if(active)
		deactivate(user)
	else
		activate(user)

	to_chat(user, "<span class='notice'>Вы [active ? "де" : ""]активируете лезвие в ручке.</span>")

/obj/item/weapon/pen/blade/proc/activate(mob/living/user)
	if(active)
		return
	active = 1
	icon_state = active_icon_state
	embed_chance = active_embed_chance
	force = active_force
	throwforce = active_throwforce
	sharp = 1
	edge = 1
	w_class = active_w_class
	playsound(src, 'sound/weapons/saberon.ogg', 15, 1)
	damtype = SEARING
	catchable = FALSE

	attack_verb |= list(\
		"разрезает",\
		"разрубает",\
		"режет",\
		"зарезает"\
		)

/obj/item/weapon/pen/blade/proc/deactivate(mob/living/user)
	if(!active)
		return
	playsound(src, 'sound/weapons/saberoff.ogg', 15, 1)
	active = 0
	icon_state = default_icon_state
	embed_chance = initial(embed_chance)
	force = initial(force)
	throwforce = initial(throwforce)
	sharp = initial(sharp)
	edge = initial(edge)
	w_class = initial(w_class)
	damtype = BRUTE
	catchable = TRUE

/obj/item/weapon/pen/blade/blue
	desc = "Обыкновенная ручка с синими чернилами."
	icon_state = "pen_blue"
	colour = "blue"

/obj/item/weapon/pen/blade/red
	desc = "Обыкновенная ручка с красными чернилами."
	icon_state = "pen_red"
	colour = "red"

/obj/item/weapon/pen/blade/fountain
	desc = "Качественная перьевая ручка."
	icon_state = "pen_fountain"

/*
 * Sleepy Pens
 */
/obj/item/weapon/pen/reagent/sleepy
	desc = "Черная ручка с острым стержнем и гравировкой \"Waffle Co.\"."
	origin_tech = list(TECH_MATERIAL = 2, TECH_ILLEGAL = 5)

/obj/item/weapon/pen/reagent/sleepy/New()
	..()
	reagents.add_reagent("chloralhydrate", 1)	//VOREStation Edit
	reagents.add_reagent("stoxin", 14)	//VOREStation Add


/*
 * Parapens
 */
/obj/item/weapon/pen/reagent/paralysis
	origin_tech = list(TECH_MATERIAL = 2, TECH_ILLEGAL = 5)

/obj/item/weapon/pen/reagent/paralysis/New()
	..()
	reagents.add_reagent("zombiepowder", 5)
	reagents.add_reagent("cryptobiolin", 10)

/*
 * Chameleon pen
 */
/obj/item/weapon/pen/chameleon
	var/signature = ""

/obj/item/weapon/pen/chameleon/attack_self(mob/user as mob)
	/*
	// Limit signatures to official crew members
	var/personnel_list[] = list()
	for(var/datum/data/record/t in data_core.locked) //Look in data core locked.
		personnel_list.Add(t.fields["name"])
	personnel_list.Add("Anonymous")

	var/new_signature = input("Enter new signature pattern.", "New Signature") as null|anything in personnel_list
	if(new_signature)
		signature = new_signature
	*/
	signature = sanitize(input("Введите новую подпись. Оставьте поле пустым для анонимности.", "Новая подпись", signature))

/obj/item/weapon/pen/proc/get_signature(var/mob/user)
	return (user && user.real_name) ? user.real_name : "Anonymous"

/obj/item/weapon/pen/chameleon/get_signature(var/mob/user)
	return signature ? signature : "Anonymous"

/obj/item/weapon/pen/chameleon/verb/set_colour()
	set name = "Сменить Цвет Ручки"
	set category = "Object"

	var/list/possible_colours = list ("Желтый", "Зеленый", "Розовый", "Синий", "Оранжевый", "Бирюзовый", "Красный", "Прозрачный", "Черный")
	var/selected_type = input("Выберите новый цвет.", "Цвет Ручки", null, null) as null|anything in possible_colours

	if(selected_type)
		switch(selected_type)
			if("Желтый")
				colour = COLOR_YELLOW
			if("Зеленый")
				colour = COLOR_LIME
			if("Розовый")
				colour = COLOR_PINK
			if("Синий")
				colour = COLOR_BLUE
			if("Оранжевый")
				colour = COLOR_ORANGE
			if("Бирюзовый")
				colour = COLOR_CYAN
			if("Красный")
				colour = COLOR_RED
			if("Прозрачный")
				colour = COLOR_WHITE
			else
				colour = COLOR_BLACK
		to_chat(usr, "<span class='info'>Вы выбираете [lowertext(selected_type)] цвет ручки.</span>")


/*
 * Crayons
 */

/obj/item/weapon/pen/crayon
	name = "восковой мелок"
	desc = "Цветной мелок. Пожалуйста, не ешьте и не суйте его в нос."
	icon = 'icons/obj/crayons.dmi'
	icon_state = "crayonred"
	w_class = ITEMSIZE_TINY
	attack_verb = list("ударяет", "раскрашивает")
	colour = "#FF0000" //RGB
	var/shadeColour = "#220000" //RGB
	var/uses = 30 //0 for unlimited uses
	var/instant = 0
	var/colourName = "red" //for updateIcon purposes
	drop_sound = 'sound/items/drop/gloves.ogg'
	pickup_sound = 'sound/items/pickup/gloves.ogg'

/obj/item/weapon/pen/crayon/suicide_act(mob/user)
	var/datum/gender/TU = gender_datums[user.get_visible_gender()]
	to_chat(viewers(user),"<font color='red'><b>[user] запихивает восковой мелок себе в нос и прямо к мозгу. Похоже, [TU.he] пытается покончить с собой.</b></font>")
	return (BRUTELOSS|OXYLOSS)

/obj/item/weapon/pen/crayon/New()
	name = "восковой мелок"

/obj/item/weapon/pen/crayon/marker
	name = "маркер"
	desc = "Маркер с широким кончиком. Будем надеяться, что не токсичный."
	icon_state = "markerred"

/obj/item/weapon/pen/crayon/marker/New()
	name = "[colourName] маркер"
