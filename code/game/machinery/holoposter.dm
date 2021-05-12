GLOBAL_LIST_EMPTY(holoposters)
/obj/machinery/holoposter
	name = "Holographic Poster"
	desc = "Настенный голографический проектор, показывающий рекламу всевозможных фракций. Сколько они платят за рекламу здесь?"
	icon = 'icons/obj/holoposter_vr.dmi'
	icon_state = "off"
	anchored = 1
	use_power = 1
	idle_power_usage = 80
	power_channel = ENVIRON
	var/icon_forced = FALSE
	var/examine_addon = "It appears to be powered off."
	var/mytimer
	var/alerting = FALSE

	var/list/postertypes = list(
		"hephaestus" = list(LIGHT_COLOR_CYAN, "Hephaestus Aeronautics, дочерняя компания Hephaestus Industries. Известно, что делает лучшие из дорогих атмосферных шаттлов и планеров для потребительского рынка."),
		"aether" = list(LIGHT_COLOR_CYAN, "Aether Atmospherics, одна из малоизвестных TSC. Они повсеместно распространены на Периферии - сам воздух, которым вы дышите, вероятно, был продан и доставлен ими."),
		"moreau" = list(LIGHT_COLOR_ORANGE, "Дети Моро. Голограмма - это призыв к действию местной секты Моро. «Terraform, процветайте и будьте устойчивы, дети!»"),
		"cybersun" = list(LIGHT_COLOR_GREEN, "Cybersun Industries. Сложная диаграмма без этикеток, показывающая внутреннюю работу резервного имплантата, продаваемого Cybersun. «Высочайшее качество по доступной цене!» гласит слоган."),
		"veymed" = list(LIGHT_COLOR_GREEN, "Вей-Мед. Это реклама местной клиники, расположенной в нескольких системах отсюда. Слоган гласит: «Признак истинно цивилизованной цивилизации переписывает то, чего не могла сделать эволюция»."),
		"grayson" = list(LIGHT_COLOR_ORANGE, "Grayson Manufactories Ltd. Объявление о распродаже от Grayson, включая скидку до 50% на детали для автолатов. Поистине восхищение для мастеров своими руками."),
		"ares" = list(LIGHT_COLOR_PINK, "Друзья Ареса. Кому удалось подсунуть этот плакат в ротацию? Местная благотворительная организация, созданная Конфедерацией Ареса, чтобы помочь рабочим объединиться в профсоюзы или основать свои собственные колонии. «Пожертвуйте сегодня!»"),
		"moebius" = list(LIGHT_COLOR_PURPLE, "Мебиус. Одна из немногих компаний, стоящих за пределами местного пузыря, полностью укомплектованная синтетикой. «Для синтов - от синтов».")
	)

/obj/machinery/holoposter/Initialize()
	. = ..()
	set_rand_sprite()
	GLOB.holoposters += src
	mytimer = addtimer(CALLBACK(src, .proc/set_rand_sprite), 30 MINUTES + rand(0, 5 MINUTES), TIMER_STOPPABLE | TIMER_LOOP)

/obj/machinery/holoposter/Destroy()
	GLOB.holoposters -= src
	return ..()

/obj/machinery/holoposter/process()
	return PROCESS_KILL

/obj/machinery/holoposter/examine(mob/user, infix, suffix)
	. = ..()
	. += examine_addon

/obj/machinery/holoposter/update_icon()
	if(stat & NOPOWER)
		icon_state = "off"
		examine_addon = "Похоже, он выключен."
		set_light(0)
		return
	var/new_color = LIGHT_COLOR_HALOGEN
	if(stat & BROKEN)
		icon_state = "glitch"
		examine_addon = "Похоже, он неисправен."
		new_color = "#6A6C71"
	else
		if((z in using_map.station_levels) && global.security_level) // 0 is fine, everything higher is alert levels
			icon_state = "attention"
			examine_addon = "Он предупреждает вас о том, чтобы сохранять спокойствие и как можно скорее связаться со своим руководителем."
			new_color =  "#AA7039"
			alerting = TRUE
		else if(alerting && !global.security_level) // coming out of alert
			alerting = FALSE
			set_rand_sprite()
			return
		else if(icon_state in postertypes)
			var/list/settings = postertypes[icon_state]
			new_color = settings[1]
			examine_addon = settings[2]

	set_light(l_range = 2, l_power = 2, l_color = new_color)

/obj/machinery/holoposter/proc/set_rand_sprite()
	if(alerting)
		return
	if(icon_forced && mytimer)
		deltimer(mytimer)
		return
	icon_state = pick(postertypes)
	update_icon()

/obj/machinery/holoposter/attackby(obj/item/W, mob/user)
	src.add_fingerprint(user)
	if(stat & (NOPOWER))
		return
	if (W.is_multitool())
		playsound(src, 'sound/items/penclick.ogg', 60, 1)
		icon_state = input("Available Posters", "Holographic Poster") as null|anything in postertypes + "random"
		if(!Adjacent(user))
			return
		if(icon_state == "random")
			stat &= ~BROKEN
			icon_forced = FALSE
			if(!mytimer)
				mytimer = addtimer(CALLBACK(src, .proc/set_rand_sprite), 30 MINUTES + rand(0, 5 MINUTES), TIMER_STOPPABLE | TIMER_LOOP)
			set_rand_sprite()
			return
		icon_forced = TRUE
		if(mytimer)
			deltimer(mytimer)
		stat &= ~BROKEN
		update_icon()
		return

/obj/machinery/holoposter/attack_ai(mob/user as mob)
	return attack_hand(user)

/obj/machinery/holoposter/power_change()
	var/wasUnpowered = stat & NOPOWER
	..()
	if(wasUnpowered != (stat & NOPOWER))
		update_icon()

/obj/machinery/holoposter/emp_act()
	stat |= BROKEN
	update_icon()

