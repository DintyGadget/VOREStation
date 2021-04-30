////////////////////////////////////////////////////////////////////////////////
/// Pills.
////////////////////////////////////////////////////////////////////////////////
/obj/item/weapon/reagent_containers/pill
	name = "таблетка"
	desc = "Это таблет.ка"
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	item_state = "pill"
	drop_sound = 'sound/items/drop/food.ogg'
	pickup_sound = 'sound/items/pickup/food.ogg'

	var/base_state = "pill"

	possible_transfer_amounts = null
	w_class = ITEMSIZE_TINY
	slot_flags = SLOT_EARS
	volume = 60

/obj/item/weapon/reagent_containers/pill/Initialize()
	. = ..()
	if(!icon_state)
		icon_state = "[base_state][rand(1, 4)]" //preset pills only use colour changing or unique icons

/obj/item/weapon/reagent_containers/pill/attack(mob/M as mob, mob/user as mob)
	if(M == user)
		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			if(!H.check_has_mouth())
				to_chat(user, "Куда вы собираетесь поместить [src]? У вас нет рта!")
				return
			var/obj/item/blocked = H.check_mouth_coverage()
			if(blocked)
				to_chat(user, "<span class='warning'>[blocked] мешает!</span>")
				return

			to_chat(M, "<span class='notice'>Вы глотаете [src].</span>")
			M.drop_from_inventory(src) //icon update
			if(reagents.total_volume)
				reagents.trans_to_mob(M, reagents.total_volume, CHEM_INGEST)
			qdel(src)
			return 1

	else if(istype(M, /mob/living/carbon/human))

		var/mob/living/carbon/human/H = M
		if(!H.check_has_mouth())
			to_chat(user, "Куда вы собираетесь поместить [src]? У [H] нет рта!")
			return
		var/obj/item/blocked = H.check_mouth_coverage()
		if(blocked)
			to_chat(user, "<span class='warning'>[blocked] мешает!</span>")
			return

		user.visible_message("<span class='warning'>[user] пытается заставить [M] проглотить [src].</span>")

		user.setClickCooldown(user.get_attack_speed(src))
		if(!do_mob(user, M))
			return

		user.drop_from_inventory(src) //icon update
		user.visible_message("<span class='warning'>[user] заставляет [M] проглотить [src].</span>")

		var/contained = reagentlist()
		add_attack_logs(user,M,"Накормил таблеткой, содержащую [contained]")

		if(reagents && reagents.total_volume)
			reagents.trans_to_mob(M, reagents.total_volume, CHEM_INGEST)
		qdel(src)

		return 1

	return 0

/obj/item/weapon/reagent_containers/pill/afterattack(obj/target, mob/user, proximity)
	if(!proximity) return

	if(target.is_open_container() && target.reagents)
		if(!target.reagents.total_volume)
			to_chat(user, "<span class='notice'>[target] пуст. Невозможно растворить [src].</span>")
			return
		to_chat(user, "<span class='notice'>Вы растворяете [src] в [target].</span>")

		add_attack_logs(user,null,"Spiked [target.name] with a pill containing [reagentlist()]")

		reagents.trans_to(target, reagents.total_volume)
		for(var/mob/O in viewers(2, user))
			O.show_message("<span class='warning'>[user] помещает что-то в [target].</span>", 1)

		qdel(src)

	return

////////////////////////////////////////////////////////////////////////////////
/// Pills. END
////////////////////////////////////////////////////////////////////////////////

//Pills
/obj/item/weapon/reagent_containers/pill/antitox
	name = "Диловен (30 ед.)" //VOREStation Edit
	desc = "Нейтрализует многие распространенные токсины."
	icon_state = "pill1"

/obj/item/weapon/reagent_containers/pill/antitox/Initialize()
	. = ..()
	reagents.add_reagent("anti_toxin", 30) //VOREStation Edit
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/tox
	name = "Таблетка токсин"
	desc = "Сильно токсична."
	icon_state = "pill4"

/obj/item/weapon/reagent_containers/pill/tox/Initialize()
	. = ..()
	reagents.add_reagent("toxin", 50)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/cyanide
	name = "Странная таблетка"
	desc = "Она помечена как «KCN». Слабо пахнет миндалем."
	icon_state = "pill9"

/obj/item/weapon/reagent_containers/pill/cyanide/Initialize()
	. = ..()
	reagents.add_reagent("cyanide", 50)


/obj/item/weapon/reagent_containers/pill/adminordrazine
	name = "Админордразин в таблетках"
	desc = "Это магия. Нам не нужно это объяснять."
	icon_state = "pillA"

/obj/item/weapon/reagent_containers/pill/adminordrazine/Initialize()
	. = ..()
	reagents.add_reagent("adminordrazine", 5)


/obj/item/weapon/reagent_containers/pill/stox
	name = "Снотворное (15 ед.)"
	desc = "Обычно используется для лечения бессонницы."
	icon_state = "pill2"

/obj/item/weapon/reagent_containers/pill/stox/Initialize()
	. = ..()
	reagents.add_reagent("stoxin", 15)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/kelotane
	name = "Келотан (20 ед.)" //VOREStation Edit
	desc = "Используется для лечения ожогов."
	icon_state = "pill3"

/obj/item/weapon/reagent_containers/pill/kelotane/Initialize()
	. = ..()
	reagents.add_reagent("kelotane", 20) //VOREStation Edit
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/paracetamol
	name = "Парацетамол (15 ед.)"
	desc = "Парацетамол! Обезболивающее на века. Жевательные таблетки!"
	icon_state = "pill3"

/obj/item/weapon/reagent_containers/pill/paracetamol/Initialize()
	. = ..()
	reagents.add_reagent("paracetamol", 15)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/tramadol
	name = "Трамадол (15 ед.)"
	desc = "Простое обезболивающее."
	icon_state = "pill3"

/obj/item/weapon/reagent_containers/pill/tramadol/Initialize()
	. = ..()
	reagents.add_reagent("tramadol", 15)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/methylphenidate
	name = "Метилфенидат (15 ед.)"
	desc = "Улучшает способность концентрироваться."
	icon_state = "pill2"

/obj/item/weapon/reagent_containers/pill/methylphenidate/Initialize()
	. = ..()
	reagents.add_reagent("methylphenidate", 15)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/citalopram
	name = "Циталопрам (15 ед.)"
	desc = "Мягкий антидепрессант."
	icon_state = "pill4"

/obj/item/weapon/reagent_containers/pill/citalopram/Initialize()
	. = ..()
	reagents.add_reagent("citalopram", 15)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/dexalin
	name = "Дексалин (7.5 ед.)" //VOREstation Edit
	desc = "Используется для лечения кислородного голодания."
	icon_state = "pill1"

/obj/item/weapon/reagent_containers/pill/dexalin/Initialize()
	. = ..()
	reagents.add_reagent("dexalin", 7.5) //VOREStation Edit
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/dexalin_plus
	name = "Дексалин Плюс (15 ед.)"
	desc = "Используется для лечения крайнего кислородного голодания."
	icon_state = "pill2"

/obj/item/weapon/reagent_containers/pill/dexalin_plus/Initialize()
	. = ..()
	reagents.add_reagent("dexalinp", 15)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/dermaline
	name = "Дермалин (15 ед.)"
	desc = "Используется для лечения ожоговых ран."
	icon_state = "pill2"

/obj/item/weapon/reagent_containers/pill/dermaline/Initialize()
	. = ..()
	reagents.add_reagent("dermaline", 15)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/dylovene
	name = "Диловен (15 ед.)"
	desc = "Антитоксин широкого спектра действия."
	icon_state = "pill1"

/obj/item/weapon/reagent_containers/pill/dylovene/Initialize()
	. = ..()
	reagents.add_reagent("anti_toxin", 15)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/inaprovaline
	name = "Инапровалин (30 ед.)"
	desc = "Используется для стабилизации состояния пациентов."
	icon_state = "pill2"

/obj/item/weapon/reagent_containers/pill/inaprovaline/Initialize()
	. = ..()
	reagents.add_reagent("inaprovaline", 30)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/bicaridine
	name = "Бикаридин (20 ед.)"
	desc = "Используется для лечения физических травм."
	icon_state = "pill2"

/obj/item/weapon/reagent_containers/pill/bicaridine/Initialize()
	. = ..()
	reagents.add_reagent("bicaridine", 20)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/spaceacillin
	name = "Космоциллин (15 ед.)" //VOREStation Edit
	desc = "Тета-лактамный антибиотик. Эффективен против многих болезней, которые могут встретиться в космосе."
	icon_state = "pill3"

/obj/item/weapon/reagent_containers/pill/spaceacillin/Initialize()
	. = ..()
	reagents.add_reagent("spaceacillin", 15)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/carbon
	name = "Углерод (30 ед.)" //VOREStation Edit
	desc = "Используется для нейтрализации химических веществ в желудке."
	icon_state = "pill3"

/obj/item/weapon/reagent_containers/pill/carbon/Initialize()
	. = ..()
	reagents.add_reagent("carbon", 30) //VOREStation Edit
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/iron
	name = "Железо (30 ед.)" //VOREStation Edit
	desc = "Используется для регенерации крови после кровотечения."
	icon_state = "pill1"

/obj/item/weapon/reagent_containers/pill/iron/Initialize()
	. = ..()
	reagents.add_reagent("iron", 30) //VOREStation Edit
	color = reagents.get_color()

//Not-quite-medicine
/obj/item/weapon/reagent_containers/pill/happy
	name = "Веселая таблеточка"
	desc = "Счастливого счастья радости и радости!"
	icon_state = "pill4"

/obj/item/weapon/reagent_containers/pill/happy/Initialize()
	. = ..()
	reagents.add_reagent("space_drugs", 15)
	reagents.add_reagent("sugar", 15)
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/zoom
	name = "Таблетка увеличения"
	desc = "Zoooom!"
	icon_state = "pill4"

/obj/item/weapon/reagent_containers/pill/zoom/Initialize()
	. = ..()
	if(prob(50))						//VOREStation edit begin: Zoom pill adjustments
		reagents.add_reagent("mold", 2)	//Chance to be more dangerous
	reagents.add_reagent("expired_medicine", 5)
	reagents.add_reagent("stimm", 5)	//VOREStation edit end: Zoom pill adjustments
	color = reagents.get_color()

/obj/item/weapon/reagent_containers/pill/diet
	name = "таблетки для похудения"
	desc = "Гарантированно сделает вас стройными!"
	icon_state = "pill4"

/obj/item/weapon/reagent_containers/pill/diet/Initialize()
	. = ..()
	reagents.add_reagent("lipozine", 15) //VOREStation Edit
	color = reagents.get_color()
