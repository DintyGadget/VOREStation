/obj/machinery/keycard_auth
	name = "Keycard Authentication Device"
	desc = "Это устройство используется для запуска функций станции, для аутентификации которых требуется более одной идентификационной карты."
	icon = 'icons/obj/monitors.dmi'
	icon_state = "auth_off"
	layer = ABOVE_WINDOW_LAYER
	circuit = /obj/item/weapon/circuitboard/keycard_auth
	var/active = 0 //This gets set to 1 on all devices except the one where the initial request was made.
	var/event = ""
	var/screen = 1
	var/confirmed = 0 //This variable is set by the device that confirms the request.
	var/confirm_delay = 20 //(2 seconds)
	var/busy = 0 //Busy when waiting for authentication or an event request has been sent from this device.
	var/obj/machinery/keycard_auth/event_source
	var/mob/event_triggered_by
	var/mob/event_confirmed_by
	//1 = select event
	//2 = authenticate
	anchored = 1.0
	use_power = USE_POWER_IDLE
	idle_power_usage = 2
	active_power_usage = 6
	power_channel = ENVIRON

/obj/machinery/keycard_auth/attack_ai(mob/user as mob)
	to_chat (user, "<span class='warning'>Брандмауэр не позволяет вам взаимодействовать с этим устройством!</span>")
	return

/obj/machinery/keycard_auth/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(stat & (NOPOWER|BROKEN))
		to_chat(user, "Это устройство не запитано.")
		return
	if(istype(W,/obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/ID = W
		if(access_keycard_auth in ID.access)
			if(active == 1)
				//This is not the device that made the initial request. It is the device confirming the request.
				if(event_source)
					event_source.confirmed = 1
					event_source.event_confirmed_by = usr
			else if(screen == 2)
				event_triggered_by = usr
				broadcast_request() //This is the device making the initial event request. It needs to broadcast to other devices

	if(W.is_screwdriver())
		to_chat(user, "Вы начинаете снимать лицевую панель с [src]")
		playsound(src, W.usesound, 50, 1)
		if(do_after(user, 10 * W.toolspeed))
			to_chat(user, "Вы снимаете лицевую панель с [src]")
			var/obj/structure/frame/A = new /obj/structure/frame(loc)
			var/obj/item/weapon/circuitboard/M = new circuit(A)
			A.frame_type = M.board_type
			A.need_circuit = 0
			A.pixel_x = pixel_x
			A.pixel_y = pixel_y
			A.set_dir(dir)
			A.circuit = M
			A.anchored = 1
			for (var/obj/C in src)
				C.forceMove(loc)
			A.state = 3
			A.update_icon()
			M.deconstruct(src)
			qdel(src)
			return

/obj/machinery/keycard_auth/power_change()
	..()
	if(stat &NOPOWER)
		icon_state = "auth_off"

/obj/machinery/keycard_auth/attack_hand(mob/user as mob)
	if(user.stat || stat & (NOPOWER|BROKEN))
		to_chat(user, "Это устройство не запитано.")
		return
	if(!user.IsAdvancedToolUser())
		return 0
	if(busy)
		to_chat(user, "Это устройство занято.")
		return

	user.set_machine(src)

	var/dat = "<meta charset=\"utf-8\"><h1>Keycard Authentication Device</h1>"

	dat += "Это устройство используется для запуска некоторых событий с высоким уровнем безопасности. Это требует одновременного считывания двух высокоуровневых ID карт."
	dat += "<br><hr><br>"

	if(screen == 1)
		dat += "Выберите событие для запуска:<ul>"
		dat += "<li><A href='?src=\ref[src];triggerevent=Red alert'>Красная тревога</A></li>"
		if(!config.ert_admin_call_only)
			dat += "<li><A href='?src=\ref[src];triggerevent=Emergency Response Team'>Группа аварийного реагирования</A></li>"

		dat += "<li><A href='?src=\ref[src];triggerevent=Grant Emergency Maintenance Access'>Предоставить доступ для аварийного обслуживания</A></li>"
		dat += "<li><A href='?src=\ref[src];triggerevent=Revoke Emergency Maintenance Access'>Отменить доступ для аварийного обслуживания</A></li>"
		dat += "</ul>"
		user << browse(dat, "window=keycard_auth;size=500x250")
	if(screen == 2)
		dat += "Пожалуйста, проведите своей картой, чтобы разрешить следующее событие: <b>[event]</b>"
		dat += "<p><A href='?src=\ref[src];reset=1'>Назад</A>"
		user << browse(dat, "window=keycard_auth;size=500x250")
	return


/obj/machinery/keycard_auth/Topic(href, href_list)
	..()
	if(busy)
		to_chat(usr, "Это устройство занято.")
		return
	if(usr.stat || stat & (BROKEN|NOPOWER))
		to_chat(usr, "Это устройство обесточено.")
		return
	if(href_list["triggerevent"])
		event = href_list["triggerevent"]
		screen = 2
	if(href_list["reset"])
		reset()

	updateUsrDialog()
	add_fingerprint(usr)
	return

/obj/machinery/keycard_auth/proc/reset()
	active = 0
	event = ""
	screen = 1
	confirmed = 0
	event_source = null
	icon_state = "auth_off"
	event_triggered_by = null
	event_confirmed_by = null

/obj/machinery/keycard_auth/proc/broadcast_request()
	icon_state = "auth_on"
	for(var/obj/machinery/keycard_auth/KA in machines)
		if(KA == src) continue
		KA.reset()
		spawn()
			KA.receive_request(src)

	sleep(confirm_delay)
	if(confirmed)
		confirmed = 0
		trigger_event(event)
		log_game("[key_name(event_triggered_by)] triggered and [key_name(event_confirmed_by)] confirmed event [event]")
		message_admins("[key_name(event_triggered_by)] triggered and [key_name(event_confirmed_by)] confirmed event [event]", 1)
	reset()

/obj/machinery/keycard_auth/proc/receive_request(var/obj/machinery/keycard_auth/source)
	if(stat & (BROKEN|NOPOWER))
		return
	event_source = source
	busy = 1
	active = 1
	icon_state = "auth_on"

	sleep(confirm_delay)

	event_source = null
	icon_state = "auth_off"
	active = 0
	busy = 0

/obj/machinery/keycard_auth/proc/trigger_event()
	switch(event)
		if("Red alert")
			set_security_level(SEC_LEVEL_RED)
			feedback_inc("alert_keycard_auth_red",1)
		if("Grant Emergency Maintenance Access")
			make_maint_all_access()
			feedback_inc("alert_keycard_auth_maintGrant",1)
		if("Revoke Emergency Maintenance Access")
			revoke_maint_all_access()
			feedback_inc("alert_keycard_auth_maintRevoke",1)
		if("Emergency Response Team")
			if(is_ert_blocked())
				to_chat(usr, "<font color='red'>Все группы аварийного реагирования отправлены и не могут быть вызваны в настоящее время.</font>")
				return

			trigger_armed_response_team(1)
			feedback_inc("alert_keycard_auth_ert",1)

/obj/machinery/keycard_auth/proc/is_ert_blocked()
	if(config.ert_admin_call_only) return 1
	return ticker.mode && ticker.mode.ert_disabled

var/global/maint_all_access = 0

/proc/make_maint_all_access()
	maint_all_access = 1
	to_world("<font size=4 color='red'>Внимание!</font>")
	to_world("<font color='red'>Требование доступа для обслуживания было отменено для всех шлюзов.</font>")

/proc/revoke_maint_all_access()
	maint_all_access = 0
	to_world("<font size=4 color='red'>Внимание!</font>")
	to_world("<font color='red'>Требование доступа для обслуживания было изменено на все шлюзы для обслуживания.</font>")

/obj/machinery/door/airlock/allowed(mob/M)
	if(maint_all_access && src.check_access_list(list(access_maint_tunnels)))
		return 1
	return ..(M)