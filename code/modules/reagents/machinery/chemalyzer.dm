// Detects reagents inside most containers, and acts as an infinite identification system for reagent-based unidentified objects.

/obj/machinery/chemical_analyzer
	name = "chem analyzer"
	desc = "Используется для точного сканирования химических веществ и других жидкостей внутри различных контейнеров. \
	Он также может идентифицировать жидкое содержимое неизвестных объектов."
	description_info = "Эта машина попытается сказать вам, какие реагенты находятся внутри чего-то, способного удерживать реагенты. \
	Он также используется для «идентификации» конкретных объектов на основе реагентов, чьи свойства скрыты от проверки обычными средствами."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "chem_analyzer"
	density = TRUE
	anchored = TRUE
	use_power = TRUE
	idle_power_usage = 20
	clicksound = "button"
	var/analyzing = FALSE

/obj/machinery/chemical_analyzer/update_icon()
	icon_state = "chem_analyzer[analyzing ? "-working":""]"

/obj/machinery/chemical_analyzer/attackby(obj/item/I, mob/living/user)
	if(!istype(I))
		return ..()

	if(default_deconstruction_screwdriver(user, I))
		return
	if(default_deconstruction_crowbar(user, I))
		return

	if(istype(I,/obj/item/weapon/reagent_containers))
		analyzing = TRUE
		update_icon()
		to_chat(user, span("notice", "Анализ [I], пожалуйста подождите..."))

		if(!do_after(user, 2 SECONDS, src))
			to_chat(user, span("warning", "Образец переместился за пределы диапазона сканирования, попробуйте еще раз и не двигайтесь."))
			analyzing = FALSE
			update_icon()
			return

		// First, identify it if it isn't already.
		if(!I.is_identified(IDENTITY_FULL))
			var/datum/identification/ID = I.identity
			if(ID.identification_type == IDENTITY_TYPE_CHEMICAL) // This only solves chemical-based mysteries.
				I.identify(IDENTITY_FULL, user)

		// Now tell us everything that is inside.
		if(I.reagents && I.reagents.reagent_list.len)
			to_chat(user, "<br>") // To add padding between regular chat and the output.
			for(var/datum/reagent/R in I.reagents.reagent_list)
				if(!R.name)
					continue
				to_chat(user, span("notice", "Содержит единиц [R.volume] в <b>[R.name]</b>.<br>[R.description]<br>"))

		// Last, unseal it if it's an autoinjector.
		if(istype(I,/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector) && !(I.flags & OPENCONTAINER))
			I.flags |= OPENCONTAINER
			to_chat(user, span("notice", "Контейнер для образца открыт.<br>"))

		to_chat(user, span("notice", "Сканирование[I] завершено."))
		analyzing = FALSE
		update_icon()
		return