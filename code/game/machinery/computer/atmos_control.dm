/obj/item/weapon/circuitboard/atmoscontrol
	name = "\improper Central Atmospherics Computer Circuitboard"
	build_path = /obj/machinery/computer/atmoscontrol

/obj/machinery/computer/atmoscontrol
	name = "\improper Central Atmospherics Computer"
	desc = "Control the station's atmospheric systems from afar! Certified atmospherics technicians only."
	icon_keyboard = "generic_key"
	icon_screen = "comm_logs"
	light_color = "#00b000"
	density = 1
	anchored = 1.0
	circuit = /obj/item/weapon/circuitboard/atmoscontrol
	req_access = list(access_ce)
	var/list/monitored_alarm_ids = null
	var/datum/tgui_module/atmos_control/atmos_control

/obj/machinery/computer/atmoscontrol/New()
	..()

/obj/machinery/computer/atmoscontrol/laptop
	name = "Atmospherics Laptop"
	desc = "A cheap laptop."
	icon_screen = "medlaptop"
	icon_state = "laptop"
	icon_keyboard = "laptop_key"
	density = 0

/obj/machinery/computer/atmoscontrol/attack_ai(var/mob/user as mob)
	tgui_interact(user)

/obj/machinery/computer/atmoscontrol/attack_hand(mob/user)
	if(..())
		return 1
	tgui_interact(user)

/obj/machinery/computer/atmoscontrol/emag_act(var/remaining_carges, var/mob/user)
	if(!emagged)
		user.visible_message("<span class='warning'>[user] что-то делает с [src], заставляя экран мигать!</span>",\
			"<span class='warning'>Вы заставляете экран мигать, когда получаете полный контроль.</span>",\
			"Вы слышите электронную трель.")
		atmos_control.emagged = 1
		return 1

/obj/machinery/computer/atmoscontrol/tgui_interact(var/mob/user)
	if(!atmos_control)
		atmos_control = new(src, req_access, req_one_access, monitored_alarm_ids)
	atmos_control.tgui_interact(user)
