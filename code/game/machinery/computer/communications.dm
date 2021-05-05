//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

// The communications computer
/obj/machinery/computer/communications
	name = "command and communications console"
	desc = "Используется для управления станцией. Может ретранслировать связь на большие расстояния."
	icon_keyboard = "tech_key"
	icon_screen = "comm"
	light_color = "#0099ff"
	req_access = list(access_heads)
	circuit = /obj/item/weapon/circuitboard/communications

	var/datum/tgui_module/communications/communications

/obj/machinery/computer/communications/Initialize()
	. = ..()
	communications = new(src)

/obj/machinery/computer/communications/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		emagged = TRUE
		communications.emagged = TRUE
		to_chat(user, "Вы шифруете схемы маршрутизации связи!")
		return TRUE

/obj/machinery/computer/communications/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/computer/communications/attack_hand(mob/user)
	if(..())
		return
	communications.tgui_interact(user)
