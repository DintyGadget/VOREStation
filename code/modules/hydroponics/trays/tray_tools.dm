//Analyzer, pestkillers, weedkillers, nutrients, hatchets, cutters.

/obj/item/weapon/tool/wirecutters/clippers
	name = "plant clippers"
	desc = "Инструмент, используемый для отбора проб с растений."

/obj/item/weapon/tool/wirecutters/clippers/trimmers
    name = "hedgetrimmers"
    desc = "Старая пара триммеров с довольно затупившимся лезвием. Вам, вероятно, будет сложно срезать с его помощью что-либо, кроме растений."
    icon_state = "hedget"
    item_state = "hedget"
    force = 7 //One point extra than standard wire cutters.

/obj/item/device/analyzer/plant_analyzer
	name = "plant analyzer"
	icon = 'icons/obj/device.dmi'
	icon_state = "hydro"
	item_state = "analyzer"
	var/datum/seed/last_seed
	var/list/last_reagents

/obj/item/device/analyzer/plant_analyzer/Destroy()
	. = ..()
	QDEL_NULL(last_seed)

/obj/item/device/analyzer/plant_analyzer/attack_self(mob/user)
	tgui_interact(user)

/obj/item/device/analyzer/plant_analyzer/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PlantAnalyzer", name)
		ui.open()

/obj/item/device/analyzer/plant_analyzer/tgui_state(mob/user)
	return GLOB.tgui_inventory_state

/obj/item/device/analyzer/plant_analyzer/tgui_data(mob/user, datum/tgui/ui, datum/tgui_state/state)
	var/list/data = ..()

	var/datum/seed/grown_seed = last_seed
	if(!istype(grown_seed))
		return list("no_seed" = TRUE)

	data["no_seed"] = FALSE
	data["seed"] = grown_seed.get_tgui_analyzer_data(user)
	data["reagents"] = last_reagents

	return data

/obj/item/device/analyzer/plant_analyzer/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	switch(action)
		if("print")
			print_report(usr)
			return TRUE
		if("close")
			last_seed = null
			last_reagents = null
			return TRUE

/obj/item/device/analyzer/plant_analyzer/afterattack(obj/target, mob/user, flag)
	if(!flag)
		return

	var/datum/seed/grown_seed
	var/datum/reagents/grown_reagents
	if(istype(target,/obj/structure/table))
		return ..()
	else if(istype(target,/obj/item/weapon/reagent_containers/food/snacks/grown))

		var/obj/item/weapon/reagent_containers/food/snacks/grown/G = target
		grown_seed = SSplants.seeds[G.plantname]
		grown_reagents = G.reagents

	else if(istype(target,/obj/item/weapon/grown))

		var/obj/item/weapon/grown/G = target
		grown_seed = SSplants.seeds[G.plantname]
		grown_reagents = G.reagents

	else if(istype(target,/obj/item/seeds))

		var/obj/item/seeds/S = target
		grown_seed = S.seed

	else if(istype(target,/obj/machinery/portable_atmospherics/hydroponics))

		var/obj/machinery/portable_atmospherics/hydroponics/H = target
		if(H.frozen == 1)
			to_chat(user, "<span class='warning'>Сначала отключите криогенное замораживание!</span>")
			return
		grown_seed = H.seed
		grown_reagents = H.reagents

	if(!grown_seed)
		to_chat(user, "<span class='danger'>[src] ничего не может сказать вам о [target].</span>")
		return

	last_seed = grown_seed.diverge()
	if(!istype(last_seed))
		last_seed = grown_seed // TRAIT_IMMUTABLE makes diverge() return null

	user.visible_message("<span class='notice'>[user] запускает сканер над [target].</span>")

	last_reagents = list()
	if(grown_reagents && grown_reagents.reagent_list && grown_reagents.reagent_list.len)
		for(var/datum/reagent/R in grown_reagents.reagent_list)
			last_reagents.Add(list(list(
				"name" = R.name,
				"volume" = grown_reagents.get_reagent_amount(R.id),
			)))

	tgui_interact(user)

/obj/item/device/analyzer/plant_analyzer/proc/print_report_verb()
	set name = "Распечатать отчет о растении"
	set category = "Object"
	set src = usr

	if(usr.stat || usr.restrained() || usr.lying)
		return
	print_report(usr)

/obj/item/device/analyzer/plant_analyzer/proc/print_report(var/mob/living/user)
	var/datum/seed/grown_seed = last_seed
	if(!istype(grown_seed))
		to_chat(user, "<span class='warning'>Нет данных сканирования для печати.</span>")
		return

	var/form_title = "[grown_seed.seed_name] (#[grown_seed.uid])"
	var/dat = "<meta charset=\"utf-8\"><h3>Данные о [form_title]</h3>"
	dat += "<h2>Общие данные</h2>"
	dat += "<table>"
	dat += "<tr><td><b>Выносливость</b></td><td>[grown_seed.get_trait(TRAIT_ENDURANCE)]</td></tr>"
	dat += "<tr><td><b>Урожай</b></td><td>[grown_seed.get_trait(TRAIT_YIELD)]</td></tr>"
	dat += "<tr><td><b>Время созревания</b></td><td>[grown_seed.get_trait(TRAIT_MATURATION)]</td></tr>"
	dat += "<tr><td><b>Сроки изготовления</b></td><td>[grown_seed.get_trait(TRAIT_PRODUCTION)]</td></tr>"
	dat += "<tr><td><b>Потенция</b></td><td>[grown_seed.get_trait(TRAIT_POTENCY)]</td></tr>"
	dat += "</table>"

	if(LAZYLEN(last_reagents))
		dat += "<h2>Reagent Data</h2>"
		dat += "<br>Этот образец содержит: "
		for(var/i in 1 to LAZYLEN(last_reagents))
			dat += "<br>- [last_reagents[i]["name"]], [last_reagents[i]["volume"]] unit(s)"

	dat += "<h2>Other Data</h2>"

	var/list/tgui_data = grown_seed.get_tgui_analyzer_data()

	dat += jointext(tgui_data["trait_info"], "<br>\n")

	var/obj/item/weapon/paper/P = new /obj/item/weapon/paper(get_turf(src))
	P.name = "paper - [form_title]"
	P.info = "[dat]"
	if(istype(user,/mob/living/carbon/human))
		user.put_in_hands(P)
	user.visible_message("\The [src] spits out a piece of paper.")
	return

/datum/seed/proc/get_tgui_analyzer_data(mob/user)
	var/list/data = list()

	data["name"] = seed_name
	data["uid"] = uid
	data["endurance"] = get_trait(TRAIT_ENDURANCE)
	data["yield"] = get_trait(TRAIT_YIELD)
	data["maturation_time"] = get_trait(TRAIT_MATURATION)
	data["production_time"] = get_trait(TRAIT_PRODUCTION)
	data["potency"] = get_trait(TRAIT_POTENCY)

	data["trait_info"] = list()
	if(get_trait(TRAIT_HARVEST_REPEAT))
		data["trait_info"] += "Это растение можно собирать неоднократно."

	if(get_trait(TRAIT_IMMUTABLE) == -1)
		data["trait_info"] += "Это растение очень изменчиво."
	else if(get_trait(TRAIT_IMMUTABLE) > 0)
		data["trait_info"] += "Это растение не обладает генетикой, которую можно изменить."

	if(get_trait(TRAIT_REQUIRES_NUTRIENTS))
		if(get_trait(TRAIT_NUTRIENT_CONSUMPTION) < 0.05)
			data["trait_info"] += "Оно потребляет небольшое количество питательной жидкости."
		else if(get_trait(TRAIT_NUTRIENT_CONSUMPTION) > 0.2)
			data["trait_info"] += "Требует большой запас питательной жидкости."
		else
			data["trait_info"] += "Требует запас питательной жидкости."

	if(get_trait(TRAIT_REQUIRES_WATER))
		if(get_trait(TRAIT_WATER_CONSUMPTION) < 1)
			data["trait_info"] += "Требует очень мало воды."
		else if(get_trait(TRAIT_WATER_CONSUMPTION) > 5)
			data["trait_info"] += "Требует большое количество воды."
		else
			data["trait_info"] += "Требует стабильную подача воды."

	if(mutants && mutants.len)
		data["trait_info"] += "Он демонстрирует высокую степень потенциального сдвига подвидов."

	data["trait_info"] += "Он процветает при температуре [get_trait(TRAIT_IDEAL_HEAT)] Кельвинов."

	if(get_trait(TRAIT_LOWKPA_TOLERANCE) < 20)
		data["trait_info"] += "Он хорошо приспособлен к низким уровням давления."
	if(get_trait(TRAIT_HIGHKPA_TOLERANCE) > 220)
		data["trait_info"] += "Он хорошо приспособлен к высоким уровням давления."

	if(get_trait(TRAIT_HEAT_TOLERANCE) > 30)
		data["trait_info"] += "Он хорошо приспособлен к различным температурам."
	else if(get_trait(TRAIT_HEAT_TOLERANCE) < 10)
		data["trait_info"] += "Он очень чувствителен к температурным сдвигам."

	data["trait_info"] += "Он процветает на световом уровне [get_trait(TRAIT_IDEAL_LIGHT)] люмен[get_trait(TRAIT_IDEAL_LIGHT) == 1 ? "" : "ов"]."

	if(get_trait(TRAIT_LIGHT_TOLERANCE) > 10)
		data["trait_info"] += "Он хорошо адаптирован к различным уровням освещенности."
	else if(get_trait(TRAIT_LIGHT_TOLERANCE) < 3)
		data["trait_info"] += "Он очень чувствителен к изменениям уровня света."

	if(get_trait(TRAIT_TOXINS_TOLERANCE) < 3)
		data["trait_info"] += "Он очень чувствителен к токсинам."
	else if(get_trait(TRAIT_TOXINS_TOLERANCE) > 6)
		data["trait_info"] += "Он удивительно устойчив к токсинам."

	if(get_trait(TRAIT_PEST_TOLERANCE) < 3)
		data["trait_info"] += "Он очень чувствителен к вредителям."
	else if(get_trait(TRAIT_PEST_TOLERANCE) > 6)
		data["trait_info"] += "Он удивительно устойчив к вредителям."

	if(get_trait(TRAIT_WEED_TOLERANCE) < 3)
		data["trait_info"] += "Он очень чувствителен к сорнякам."
	else if(get_trait(TRAIT_WEED_TOLERANCE) > 6)
		data["trait_info"] += "Он удивительно устойчив к сорнякам."

	switch(get_trait(TRAIT_SPREAD))
		if(1)
			data["trait_info"] += "Он может быть посажен вне лотка."
		if(2)
			data["trait_info"] += "Это крепкая и энергичная лоза, которая будет быстро распространяться."

	switch(get_trait(TRAIT_CARNIVOROUS))
		if(1)
			data["trait_info"] += "Он плотояден и будет питаться вредителями лотков для пропитания."
		if(2)
			data["trait_info"] += "Он плотояден и представляет значительную угрозу для окружающих его живых существ."

	if(get_trait(TRAIT_PARASITE))
		data["trait_info"] += "Он способен паразитировать и получать пропитание от лотковых сорняков."

/*
	There's currently no code that actually changes the temperature of the local environment, so let's not show it until there is.
	if(get_trait(TRAIT_ALTER_TEMP))
		data["trait_info"] += "It will periodically alter the local temperature by [get_trait(TRAIT_ALTER_TEMP)] degrees Kelvin."
*/

	if(get_trait(TRAIT_BIOLUM))
		data["trait_info"] += "Он [get_trait(TRAIT_BIOLUM_COLOUR)  ? "<font color='[get_trait(TRAIT_BIOLUM_COLOUR)]'>bio-luminescent</font>" : "биолюминесцентный"]."

	if(get_trait(TRAIT_PRODUCES_POWER))
		data["trait_info"] += "Плод будет функционировать как аккумулятор, если его правильно приготовить."

	if(get_trait(TRAIT_STINGS))
		data["trait_info"] += "Плод покрыт жалящими шипами."

	if(get_trait(TRAIT_JUICY) == 1)
		data["trait_info"] += "Плоды мягкокожие и сочные."
	else if(get_trait(TRAIT_JUICY) == 2)
		data["trait_info"] += "Плод чересчур сочный."

	if(get_trait(TRAIT_EXPLOSIVE))
		data["trait_info"] += "Плод внутренне неустойчив."

	if(get_trait(TRAIT_TELEPORTING))
		data["trait_info"] += "Плод нестабилен во времени и пространстве."

	if(exude_gasses && exude_gasses.len)
		for(var/gas in exude_gasses)
			var/amount = ""
			if (exude_gasses[gas] > 7)
				amount = "большое количество "
			else if (exude_gasses[gas] < 5)
				amount = "небольшое количетво "
			data["trait_info"] += "Он выпустит в окружающую среду [amount][gas_data.name[gas]]."

	if(consume_gasses && consume_gasses.len)
		for(var/gas in consume_gasses)
			var/amount = ""
			if (consume_gasses[gas] > 7)
				amount = "большое количество "
			else if (consume_gasses[gas] < 5)
				amount = "небольшое количетво "
			data["trait_info"] += "Он будет потреблять [amount][gas_data.name[gas]] из окружающей среды."

	return data
