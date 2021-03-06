// APC HULL

/obj/item/frame/apc
	name = "рама APC"
	desc = "Используется для ремонта или сборки APC"
	icon = 'icons/obj/apc_repair.dmi'
	icon_state = "apc_frame"
	refund_amt = 2

/obj/item/frame/apc/try_build(turf/on_wall, mob/user as mob)
	if (get_dist(on_wall, user)>1)
		return
	var/ndir = get_dir(user, on_wall)
	if (!(ndir in cardinal))
		return
	var/turf/loc = get_turf(user)
	var/area/A = loc.loc
	if (!istype(loc, /turf/simulated/floor))
		to_chat(user, "<span class='warning'>APC нельзя ставить на это место.</span>")
		return
	if (A.requires_power == 0 || istype(A, /area/space))
		to_chat(user, "<span class='warning'>APC не может быть размещен в этой области.</span>")
		return
	if (A.get_apc())
		to_chat(user, "<span class='warning'>В этом районе уже есть APC.</span>")
		return //only one APC per area
	for(var/obj/machinery/power/terminal/T in loc)
		if (T.master)
			to_chat(user, "<span class='warning'>Здесь есть еще один сетевой терминал.</span>")
			return
		else
			var/obj/item/stack/cable_coil/C = new /obj/item/stack/cable_coil(loc)
			C.amount = 10
			to_chat(user, "Вы перерезаете кабели и разбираете неиспользуемую клемму питания.")
			qdel(T)
	new /obj/machinery/power/apc(loc, ndir, 1)
	qdel(src)
