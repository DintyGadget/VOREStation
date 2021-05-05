//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/obj/item/weapon/tank/jetpack
	name = "реактивный ранец (пустой)"
	desc = "Резервуар со сжатым газом для использования в качестве движителя в условиях невесомости. Используйте с осторожностью."
	icon = 'icons/obj/tank_vr.dmi' //VOREStation Edit
	icon_state = "jetpack"
	gauge_icon = null
	w_class = ITEMSIZE_LARGE
	item_icons = list(
			slot_l_hand_str = 'icons/mob/items/lefthand_storage.dmi',
			slot_r_hand_str = 'icons/mob/items/righthand_storage.dmi',
			)
	item_state_slots = list(slot_r_hand_str = "jetpack", slot_l_hand_str = "jetpack")
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	var/datum/effect/effect/system/ion_trail_follow/ion_trail
	var/on = 0.0
	var/stabilization_on = 0
	var/volume_rate = 500              //Needed for borg jetpack transfer
	action_button_name = "Переключить реактивный ранец"

/obj/item/weapon/tank/jetpack/New()
	..()
	ion_trail = new /datum/effect/effect/system/ion_trail_follow()
	ion_trail.set_up(src)

/obj/item/weapon/tank/jetpack/Destroy()
	QDEL_NULL(ion_trail)
	return ..()

/obj/item/weapon/tank/jetpack/examine(mob/user)
	. = ..()
	if(air_contents.total_moles < 5)
		. += "<span class='danger'>Счетчик на [src] показывает, что у вас почти закончился газ!</span>"
		playsound(src, 'sound/effects/alert.ogg', 50, 1)

/obj/item/weapon/tank/jetpack/verb/toggle_rockets()
	set name = "Переключить стабилизацию реактивного ранца"
	set category = "Object"
	stabilization_on = !( stabilization_on )
	to_chat(usr, "Вы [stabilization_on? "включаете":"отключаете"] стабилизацию ранца.")

/obj/item/weapon/tank/jetpack/verb/toggle()
	set name = "Переключить реактивный ранец"
	set category = "Object"

	on = !on
	if(on)
		icon_state = "[icon_state]-on"
		ion_trail.start()
	else
		icon_state = initial(icon_state)
		ion_trail.stop()

	if (ismob(usr))
		var/mob/M = usr
		M.update_inv_back()
		M.update_action_buttons()

	to_chat(usr, "Вы [on? "включаете":"отключаете"] двигатели.")

/obj/item/weapon/tank/jetpack/proc/get_gas_supply()
	return air_contents

/obj/item/weapon/tank/jetpack/proc/can_thrust(num)
	if(!on)
		return 0

	var/datum/gas_mixture/fuel = get_gas_supply()
	if(num < 0.005 || !fuel || fuel.total_moles < num)
		ion_trail.stop()
		return 0

	return 1

/obj/item/weapon/tank/jetpack/proc/do_thrust(num, mob/living/user)
	if(!can_thrust(num))
		return 0

	var/datum/gas_mixture/fuel = get_gas_supply()
	fuel.remove(num)
	return 1

/obj/item/weapon/tank/jetpack/ui_action_click()
	toggle()

/obj/item/weapon/tank/jetpack/void
	name = "Пустотный реактивный ранец (кислород)"
	desc = "Он хорошо работает в пустоте."
	icon_state = "jetpack-void"
	item_state_slots = list(slot_r_hand_str = "jetpack-void", slot_l_hand_str = "jetpack-void")

/obj/item/weapon/tank/jetpack/void/Initialize()
	. = ..()
	air_contents.adjust_gas("oxygen", (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/weapon/tank/jetpack/oxygen
	name = "реактивный ранец (кислород)"
	desc = "Резервуар со сжатым кислородом для использования в качестве двигателя в условиях невесомости. Используйте с осторожностью."
	icon_state = "jetpack"
	item_state_slots = list(slot_r_hand_str = "jetpack", slot_l_hand_str = "jetpack")

/obj/item/weapon/tank/jetpack/oxygen/Initialize()
	. = ..()
	air_contents.adjust_gas("oxygen", (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/weapon/tank/jetpack/carbondioxide
	name = "реактивный ранец (углекислый газ)"
	desc = "Резервуар сжатого углекислого газа для использования в качестве движителя в условиях невесомости. Окрашено в черный цвет, чтобы указать, что его не следует использовать в качестве источника для внутренних устройств."
	distribute_pressure = 0
	icon_state = "jetpack-black"
	item_state_slots = list(slot_r_hand_str = "jetpack-black", slot_l_hand_str = "jetpack-black")

/obj/item/weapon/tank/jetpack/carbondioxide/Initialize()
	. = ..()
	air_contents.adjust_gas("carbon_dioxide", (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/weapon/tank/jetpack/rig
	name = "jetpack"
	var/obj/item/weapon/rig/holder

/obj/item/weapon/tank/jetpack/rig/examine()
	. = ..()
	. += "Это реактивный ранец. Если вы это видите, сообщите об этом в системе отслеживания ошибок."

/obj/item/weapon/tank/jetpack/rig/get_gas_supply()
	return holder?.air_supply?.air_contents
