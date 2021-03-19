//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

/obj/machinery/computer/aiupload
	name = "\improper AI upload console"
	desc = "Used to upload laws to the AI."
	icon_keyboard = "rd_key"
	icon_screen = "command"
	circuit = /obj/item/weapon/circuitboard/aiupload
	var/mob/living/silicon/ai/current = null
	var/opened = 0


/obj/machinery/computer/aiupload/verb/AccessInternals()
	set category = "Object"
	set name = "Доступ к внутреннему устройству компьютера"
	set src in oview(1)
	if(get_dist(src, usr) > 1 || usr.restrained() || usr.lying || usr.stat || istype(usr, /mob/living/silicon))
		return

	opened = !opened
	if(opened)
		to_chat(usr, "<span class='notice'>Панель доступа теперь открыта.</span>")
	else
		to_chat(usr, "<span class='notice'>Панель доступа теперь закрыта.</span>")
	return


/obj/machinery/computer/aiupload/attackby(obj/item/weapon/O as obj, mob/user as mob)
	if (using_map && !(user.z in using_map.contact_levels))
		to_chat(user, "<span class='danger'>Невозможно установить соединение:</span> Вы слишком далеко от станции!")
		return
	if(istype(O, /obj/item/weapon/aiModule))
		var/obj/item/weapon/aiModule/M = O
		M.install(src, user)
	else
		..()


/obj/machinery/computer/aiupload/attack_hand(var/mob/user as mob)
	if(src.stat & NOPOWER)
		to_chat(user, "На загрузочный компьютер не подается питание!")
		return
	if(src.stat & BROKEN)
		to_chat(user, "Загрузочный компьютер сломан!")
		return

	src.current = select_active_ai(user)

	if (!src.current)
		to_chat(user, "Активных ИИ не обнаружено.")
	else
		to_chat(user, "[src.current.name] выбран для изменения закона.")
	return

/obj/machinery/computer/aiupload/attack_ghost(user as mob)
	return 1


/obj/machinery/computer/borgupload
	name = "cyborg upload console"
	desc = "Used to upload laws to Cyborgs."
	icon_keyboard = "rd_key"
	icon_screen = "command"
	circuit = /obj/item/weapon/circuitboard/borgupload
	var/mob/living/silicon/robot/current = null


/obj/machinery/computer/borgupload/attackby(obj/item/weapon/aiModule/module as obj, mob/user as mob)
	if(istype(module, /obj/item/weapon/aiModule))
		module.install(src, user)
	else
		return ..()


/obj/machinery/computer/borgupload/attack_hand(var/mob/user as mob)
	if(src.stat & NOPOWER)
		to_chat(user, "На загрузочный компьютер не подается питание!")
		return
	if(src.stat & BROKEN)
		to_chat(user, "Загрузочный компьютер сломан!")
		return

	src.current = freeborg()

	if (!src.current)
		to_chat(user, "Свободных киборгов не обнаружено.")
	else
		to_chat(user, "[src.current.name] выбран для изменения закона.")
	return

/obj/machinery/computer/borgupload/attack_ghost(user as mob)
	return 1
