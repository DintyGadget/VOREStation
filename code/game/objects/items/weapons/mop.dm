GLOBAL_LIST_BOILERPLATE(all_mops, /obj/item/weapon/mop)

/obj/item/weapon/mop
	desc = "Мир уборнии не был бы полным без швабры."
	name = "швабра"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "mop"
	force = 3.0
	throwforce = 10.0
	throw_speed = 5
	throw_range = 10
	w_class = ITEMSIZE_NORMAL
	flags = NOCONDUCT
	attack_verb = list("mopped", "bashed", "bludgeoned", "whacked")
	var/mopping = 0
	var/mopcount = 0

/obj/item/weapon/mop/New()
	create_reagents(30)
	..()

/obj/item/weapon/mop/afterattack(atom/A, mob/user, proximity)
	if(!proximity) return
	if(istype(A, /turf) || istype(A, /obj/effect/decal/cleanable) || istype(A, /obj/effect/overlay) || istype(A, /obj/effect/rune))
		if(reagents.total_volume < 1)
			to_chat(user, "<span class='notice'>Ваша швабра сухая!</span>")
			return

		user.visible_message("<span class='warning'>[user] начинает чистить [get_turf(A)].</span>")

		if(do_after(user, 40))
			var/turf/T = get_turf(A)
			if(T)
				T.clean(src, user)
			to_chat(user, "<span class='notice'>Вы закончили мыть шваброй!</span>")


/obj/effect/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/mop) || istype(I, /obj/item/weapon/soap))
		return
	..()
