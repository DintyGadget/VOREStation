/mob/living/silicon/ai/death(gibbed)

	if(stat == DEAD)
		return

	if(deployed_shell)
		disconnect_shell("Отключение от удаленной оболочки из-за критического сбоя системы.")
	. = ..(gibbed)

	if(src.eyeobj)
		src.eyeobj.setLoc(get_turf(src))

	remove_ai_verbs(src)

	for(var/obj/machinery/ai_status_display/O in machines)
		spawn( 0 )
		O.mode = 2
		if (istype(loc, /obj/item/device/aicard))
			var/obj/item/device/aicard/card = loc
			card.update_icon()

	. = ..(gibbed,"издает один пронзительный звуковой сигнал, прежде чем упасть замертво.")
	density = 1
