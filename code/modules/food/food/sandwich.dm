/obj/item/weapon/reagent_containers/food/snacks/slice/bread/attackby(obj/item/W as obj, mob/user as mob)

	if(istype(W,/obj/item/weapon/material/shard) || istype(W,/obj/item/weapon/reagent_containers/food/snacks))
		var/obj/item/weapon/reagent_containers/food/snacks/csandwich/S = new(get_turf(src))
		S.attackby(W,user)
		qdel(src)
	..()

/obj/item/weapon/reagent_containers/food/snacks/csandwich
	name = "бутерброд"
	desc = "Лучшее после нарезанного хлеба."
	icon_state = "breadslice"
	trash = /obj/item/trash/plate
	bitesize = 2

	var/list/ingredients = list()

/obj/item/weapon/reagent_containers/food/snacks/csandwich/attackby(obj/item/W as obj, mob/user as mob)

	var/sandwich_limit = 4
	for(var/obj/item/O in ingredients)
		if(istype(O,/obj/item/weapon/reagent_containers/food/snacks/slice/bread))
			sandwich_limit += 4

	if(istype(W,/obj/item/weapon/material/shard))
		to_chat(user, "<font color='blue'>Вы прячете [W] в [src].</font>")
		user.drop_item()
		W.loc = src
		update()
		return
	else if(istype(W,/obj/item/weapon/reagent_containers/food/snacks))
		if(src.contents.len > sandwich_limit)
			to_chat(user, "<font color='red'>Если вы поместите что-нибудь еще в [src], он рухнет.</font>")
			return
		to_chat(user, "<font color='blue'>Вы накладываете [W] поверх [src].</font>")
		var/obj/item/weapon/reagent_containers/F = W
		F.reagents.trans_to_obj(src, F.reagents.total_volume)
		user.drop_item()
		W.loc = src
		ingredients += W
		update()
		return
	..()

/obj/item/weapon/reagent_containers/food/snacks/csandwich/proc/update()
	var/fullname = "" //We need to build this from the contents of the var.
	var/i = 0

	overlays.Cut()

	for(var/obj/item/weapon/reagent_containers/food/snacks/O in ingredients)

		i++
		if(i == 1)
			fullname += "[O.name]"
		else if(i == ingredients.len)
			fullname += " и [O.name]"
		else
			fullname += ", [O.name]"

		var/image/I = new(src.icon, "sandwich_filling")
		I.color = O.filling_color
		I.pixel_x = pick(list(-1,0,1))
		I.pixel_y = (i*2)+1
		overlays += I

	var/image/T = new(src.icon, "sandwich_top")
	T.pixel_x = pick(list(-1,0,1))
	T.pixel_y = (ingredients.len * 2)+1
	overlays += T

	name = lowertext("[fullname] бутерброд")
	if(length(name) > 80) name = "[pick(list("абсуржный","колоссальный","громадный","нелепый"))] бутерброд"
	w_class = n_ceil(CLAMP((ingredients.len/2),2,4))

/obj/item/weapon/reagent_containers/food/snacks/csandwich/Destroy()
	for(var/obj/item/O in ingredients)
		qdel(O)
	..()

/obj/item/weapon/reagent_containers/food/snacks/csandwich/examine(mob/user)
	. = ..()
	if(contents.len)
		var/obj/item/O = pick(contents)
		. += "<font color='blue'>Вы думаете, что видите там [O.name].</font>"

/obj/item/weapon/reagent_containers/food/snacks/csandwich/attack(mob/M as mob, mob/user as mob, def_zone)

	var/obj/item/shard
	for(var/obj/item/O in contents)
		if(istype(O,/obj/item/weapon/material/shard))
			shard = O
			break

	var/mob/living/H
	if(istype(M,/mob/living))
		H = M

	if(H && shard && M == user) //This needs a check for feeding the food to other people, but that could be abusable.
		to_chat(H, "<font color='red'>Вы разрываете рот о [shard.name] в бутерброде!</font>")
		H.adjustBruteLoss(5) //TODO: Target head if human. //This TODO has been here for 4 years.
	..()
