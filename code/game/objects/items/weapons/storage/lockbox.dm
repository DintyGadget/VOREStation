//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/obj/item/weapon/storage/lockbox
	name = "сейф"
	desc = "Запертый ящик."
	icon_state = "lockbox+l"
	item_state_slots = list(slot_r_hand_str = "syringe_kit", slot_l_hand_str = "syringe_kit")
	w_class = ITEMSIZE_LARGE
	max_w_class = ITEMSIZE_NORMAL
	max_storage_space = ITEMSIZE_COST_NORMAL * 4 //The sum of the w_classes of all the items in this storage item.
	req_access = list(access_armory)
	preserve_item = 1
	var/locked = 1
	var/broken = 0
	var/icon_locked = "lockbox+l"
	var/icon_closed = "lockbox"
	var/icon_broken = "lockbox+b"


	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if (istype(W, /obj/item/weapon/card/id))
			if(src.broken)
				to_chat(user, "<span class='warning'>Похоже, он сломан.</span>")
				return
			if(src.allowed(user))
				src.locked = !( src.locked )
				if(src.locked)
					src.icon_state = src.icon_locked
					to_chat(user, "<span class='notice'>Вы закрываете [src]!</span>")
					close_all()
					return
				else
					src.icon_state = src.icon_closed
					to_chat(user, "<span class='notice'>Вы открываете [src]!</span>")
					return
			else
				to_chat(user, "<span class='warning'>Доступ запрещен</span>")
		else if(istype(W, /obj/item/weapon/melee/energy/blade))
			if(emag_act(INFINITY, user, W, "Шкафчик был вскрыт [user] энергетическим лезвием!", "Вы слышите, как режут металл и летят искры."))
				var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
				spark_system.set_up(5, 0, src.loc)
				spark_system.start()
				playsound(src, 'sound/weapons/blade1.ogg', 50, 1)
				playsound(src, "sparks", 50, 1)
		if(!locked)
			..()
		else
			to_chat(user, "<span class='warning'>Заперто!</span>")
		return


	show_to(mob/user as mob)
		if(locked)
			to_chat(user, "<span class='warning'>Заперто!</span>")
		else
			..()
		return

/obj/item/weapon/storage/lockbox/emag_act(var/remaining_charges, var/mob/user, var/emag_source, var/visual_feedback = "", var/audible_feedback = "")
	if(!broken)
		if(visual_feedback)
			visual_feedback = "<span class='warning'>[visual_feedback]</span>"
		else
			visual_feedback = "<span class='warning'>Шкафчик вскрывает [user] электромагнитной картой!</span>"
		if(audible_feedback)
			audible_feedback = "<span class='warning'>[audible_feedback]</span>"
		else
			audible_feedback = "<span class='warning'>Вы слышите слабую электрическую искру.</span>"

		broken = 1
		locked = 0
		desc = "Похоже, он сломан."
		icon_state = src.icon_broken
		visible_message(visual_feedback, audible_feedback)
		return 1

/obj/item/weapon/storage/lockbox/loyalty
	name = "сейф имплантатов лояльности"
	req_access = list(access_security)
	starts_with = list(
		/obj/item/weapon/implantcase/loyalty = 3,
		/obj/item/weapon/implanter/loyalty
	)

/obj/item/weapon/storage/lockbox/clusterbang
	name = "сейф кластерных взрывов"
	desc = "У вас плохое предчувствие, перед открытием этого."
	req_access = list(access_security)
	starts_with = list(/obj/item/weapon/grenade/flashbang/clusterbang)

/obj/item/weapon/storage/lockbox/medal
	name = "ящик медалей"
	desc = "Сундук с памятными медалями, на нем выгравирован логотип NanoTrasen."
	req_access = list(access_heads)
	storage_slots = 7
	starts_with = list(
		/obj/item/clothing/accessory/medal/conduct,
		/obj/item/clothing/accessory/medal/bronze_heart,
		/obj/item/clothing/accessory/medal/nobel_science,
		/obj/item/clothing/accessory/medal/silver/valor,
		/obj/item/clothing/accessory/medal/silver/security,
		/obj/item/clothing/accessory/medal/gold/captain,
		/obj/item/clothing/accessory/medal/gold/heroism
	)
