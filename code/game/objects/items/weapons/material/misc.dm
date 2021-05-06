/obj/item/weapon/material/harpoon
	name = "harpoon"
	sharp = 1
	edge = 0
	desc = "Tharr she blows!"
	icon_state = "harpoon"
	item_state = "harpoon"
	force_divisor = 0.3 // 18 with hardness 60 (steel)
	attack_verb = list("jabbed","stabbed","ripped")

/obj/item/weapon/material/knife/machete/hatchet
	name = "топор"
	desc = "Очень острое лезвие топора на короткой ручке из волокнистого металла. Он имеет долгую историю рубки вещей, но теперь его используют для рубки дров."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "hatchet"
	force_divisor = 0.2 // 12 with hardness 60 (steel)
	thrown_force_divisor = 0.75 // 15 with weight 20 (steel)
	w_class = ITEMSIZE_SMALL
	sharp = 1
	edge = 1
	origin_tech = list(TECH_MATERIAL = 2, TECH_COMBAT = 1)
	attack_verb = list("chopped", "torn", "cut")
	applies_material_colour = 0
	drop_sound = 'sound/items/drop/axe.ogg'
	pickup_sound = 'sound/items/pickup/axe.ogg'

/obj/item/weapon/material/knife/machete/hatchet/unathiknife
	name = "дуэльный нож"
	desc = "Кусок дерева в кожаном переплете с острыми как бритва зубцами. Как грубо."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "unathiknife"
	attack_verb = list("ripped", "torn", "cut")
	can_cleave = FALSE
	var/hits = 0

/obj/item/weapon/material/knife/machete/hatchet/unathiknife/attack(mob/M as mob, mob/user as mob)
	if(hits > 0)
		return
	var/obj/item/I = user.get_inactive_hand()
	if(istype(I, /obj/item/weapon/material/knife/machete/hatchet/unathiknife))
		hits ++
		var/obj/item/weapon/W = I
		W.attack(M, user)
		W.afterattack(M, user)
	..()

/obj/item/weapon/material/knife/machete/hatchet/unathiknife/afterattack(mob/M as mob, mob/user as mob)
	hits = initial(hits)
	..()

/obj/item/weapon/material/minihoe // -- Numbers
	name = "мини-мотыга"
	desc = "Его используют для удаления сорняков или почесывания спины."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "hoe"
	force_divisor = 0.25 // 5 with weight 20 (steel)
	thrown_force_divisor = 0.25 // as above
	dulled_divisor = 0.75	//Still metal on a long pole
	w_class = ITEMSIZE_SMALL
	attack_verb = list("slashed", "sliced", "cut", "clawed")

/obj/item/weapon/material/snow/snowball
	name = "снежнок"
	desc = "Веселый снежок. Бросьте это своим друзьям!"
	icon = 'icons/obj/weapons.dmi'
	icon_state = "snowball"
	default_material = MAT_SNOW
	health = 1
	fragile = 1
	force_divisor = 0.01
	thrown_force_divisor = 0.10
	w_class = ITEMSIZE_SMALL
	attack_verb = list("mushed", "splatted", "splooshed", "splushed") // Words that totally exist.

/obj/item/weapon/material/snow/snowball/attack_self(mob/user as mob)
	if(user.a_intent == I_HURT)
		to_chat(user, SPAN_NOTICE("Вы разбиваете снежок в руке."))
		var/atom/S = new /obj/item/stack/material/snow(user.loc)
		qdel(src)
		user.put_in_hands(S)
	else
		to_chat(user, SPAN_NOTICE("Вы начинаете уплотнять снежок."))
		if(do_after(user, 2 SECONDS))
			var/atom/S = new /obj/item/weapon/material/snow/snowball/reinforced(user.loc)
			qdel(src)
			user.put_in_hands(S)

/obj/item/weapon/material/snow/snowball/reinforced
	name = "снежок"
	desc = "Грамотный и веселый снежок. Это выглядит опасно."
	//icon_state = "reinf-snowball"
	force_divisor = 0.20
	thrown_force_divisor = 0.25

/obj/item/weapon/material/whip
	name = "хлыст"
	desc = "Инструмент, используемый, чтобы дисциплинировать животных или выглядеть круто. В основном последнее."
	description_info = "Help - Стандартная атака, без модификаторов.<br>\
	Disarm - обезвреживающий удар. Пытается обезоружить цель на расстоянии, аналогично обезоруживанию без оружия. Кроме того, заставит цель (если возможно) отойти от вас.<br>\
	Grab - захватывающий удар. Пытается притянуть цель к себе. Это также может перемещать объекты.<br>\
	Harm - стандартный удар с небольшим шансом обезоружить."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "whip"
	item_state = "chain"
	default_material = MAT_LEATHER
	slot_flags = SLOT_BELT
	w_class = ITEMSIZE_NORMAL
	origin_tech = list(TECH_COMBAT = 2)
	attack_verb = list("flogged", "whipped", "lashed", "disciplined")
	force_divisor = 0.15
	thrown_force_divisor = 0.25
	reach = 2

	item_icons = list(
			slot_l_hand_str = 'icons/mob/items/lefthand_melee.dmi',
			slot_r_hand_str = 'icons/mob/items/righthand_melee.dmi',
			)

/obj/item/weapon/material/whip/afterattack(atom/A as mob|obj|turf|area, mob/user as mob, proximity)
	..()

	if(!proximity)
		return

	if(istype(A, /atom/movable))
		var/atom/movable/AM = A
		if(AM.anchored)
			to_chat(user, "<span class='notice'>[AM] не сдвинется с места.</span>")
			return

		else
			if(!istype(AM, /obj/item))
				user.visible_message("<span class='warning'>[AM] тянет за собой [src]!</span>")
				AM.Move(get_step(AM, get_dir(AM, src)))
				return

			else
				user.visible_message("<span class='warning'>[AM] перехватывается [src]!</span>")
				AM.throw_at(user, reach, 0.1, user)

/obj/item/weapon/material/whip/apply_hit_effect(mob/living/target, mob/living/user, var/hit_zone)
	if(user.a_intent)
		switch(user.a_intent)
			if(I_HURT)
				if(prob(10) && istype(target, /mob/living/carbon/human) && user.zone_sel in list(BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT, BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND))
					to_chat(target, "<span class='warning'>[src] разрывается в ваших руках!</span>")
					ranged_disarm(target)
			if(I_DISARM)
				if(prob(min(90, force * 3)) && istype(target, /mob/living/carbon/human) && user.zone_sel in list(BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT, BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND))
					ranged_disarm(target)
				else
					target.visible_message("<span class='danger'>[src] заставляет [target] спотыкаться.</span>")
					target.Move(get_step(target,get_dir(user,target)))
			if(I_GRAB)
				var/turf/STurf = get_turf(target)
				spawn(2)
					playsound(STurf, 'sound/effects/snap.ogg', 60, 1)
				target.visible_message("<span class='critical'>[src] подталкивает [target] к [user]!</span>")
				target.throw_at(get_turf(get_step(user,get_dir(user,target))), 2, 1, src)

	..()

/obj/item/weapon/material/whip/proc/ranged_disarm(var/mob/living/carbon/human/H, var/mob/living/user)
	if(istype(H))
		var/list/holding = list(H.get_active_hand() = 40, H.get_inactive_hand() = 20)

		if(user.zone_sel in list(BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND))
			for(var/obj/item/weapon/gun/W in holding)
				if(W && prob(holding[W]))
					var/list/turfs = list()
					for(var/turf/T in view())
						turfs += T
					if(turfs.len)
						var/turf/target = pick(turfs)
						visible_message("<span class='danger'>[W] [H] гаснет из-за [src]!</span>")
						return W.afterattack(target,H)

		if(!(H.species.flags & NO_SLIP) && prob(10) && user.zone_sel in list(BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT))
			var/armor_check = H.run_armor_check(user.zone_sel, "melee")
			H.apply_effect(3, WEAKEN, armor_check)
			playsound(src, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
			if(armor_check < 60)
				visible_message("<span class='danger'>[src] отключает [H]!</span>")
			else
				visible_message("<span class='warning'>[src] пытается сбить [H]!</span>")
			return

		else
			if(H.break_all_grabs(user))
				playsound(src, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
				return

			if(user.zone_sel in list(BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND))
				for(var/obj/item/I in holding)
					if(I && prob(holding[I]))
						H.drop_from_inventory(I)
						visible_message("<span class='danger'>[src] разоружает [H]!</span>")
						playsound(src, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
						return

/obj/item/weapon/material/whip/suicide_act(mob/user)
	var/datum/gender/T = gender_datums[user.get_visible_gender()]
	user.visible_message(span("danger", "\The [user] [T.is] strangling [T.himself] with \the [src]! It looks like [T.he] [T.is] trying to commit suicide."), span("danger", "Вы начинаете душить себя [src]!"), span("danger", "Вы слышите звук удушья!"))
	return (OXYLOSS)

/obj/item/weapon/material/whip/attack_self(mob/user)
	user.visible_message("<span class='warning'>[user] рассекает [src]!</span>")
	playsound(src, 'sound/effects/snap.ogg', 50, 1)
