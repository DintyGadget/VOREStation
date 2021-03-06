/datum/artifact_effect
	var/name = "unknown"
	var/effect = EFFECT_TOUCH
	var/effectrange = 4
	var/trigger = TRIGGER_TOUCH
	var/atom/holder
	var/activated = 0
	var/chargelevel = 0
	var/chargelevelmax = 10
	var/artifact_id = ""
	var/effect_type = 0

/datum/artifact_effect/New(var/atom/location)
	..()
	holder = location
	effect = rand(0, MAX_EFFECT)
	trigger = rand(0, MAX_TRIGGER)

	//this will be replaced by the excavation code later, but it's here just in case
	artifact_id = "[pick("kappa","sigma","antaeres","beta","omicron","iota","epsilon","omega","gamma","delta","tau","alpha")]-[rand(100,999)]"

	//random charge time and distance
	switch(pick(100;1, 50;2, 25;3))
		if(1)
			//short range, short charge time
			chargelevelmax = rand(3, 20)
			effectrange = rand(1, 3)
		if(2)
			//medium range, medium charge time
			chargelevelmax = rand(15, 40)
			effectrange = rand(5, 15)
		if(3)
			//large range, long charge time
			chargelevelmax = rand(20, 120)
			effectrange = rand(20, 100) //VOREStation Edit - Map size.

/datum/artifact_effect/proc/ToggleActivate(var/reveal_toggle = 1)
	//so that other stuff happens first
	spawn(0)
		if(activated)
			activated = 0
		else
			activated = 1
		if(reveal_toggle && holder)
			if(istype(holder, /obj/machinery/artifact))
				var/obj/machinery/artifact/A = holder
				A.icon_state = "ano[A.icon_num][activated]"
			var/display_msg
			if(activated)
				display_msg = pick("на мгновение ярко светится!","слегка искажается на мгновение!","слегка мерцает!","вибрирует!","слегка мерцает на мгновение!")
			else
				display_msg = pick("становится скучной!","блекнет интенсивно!","внезапно становится неподвижной!","вдруг становится очень тихой!")
			var/atom/toplevelholder = holder
			while(!istype(toplevelholder.loc, /turf))
				toplevelholder = toplevelholder.loc
			toplevelholder.visible_message("<font color='red'>[bicon(toplevelholder)] [toplevelholder] [display_msg]</font>")

/datum/artifact_effect/proc/DoEffectTouch(var/mob/user)
/datum/artifact_effect/proc/DoEffectAura(var/atom/holder)
/datum/artifact_effect/proc/DoEffectPulse(var/atom/holder)
/datum/artifact_effect/proc/UpdateMove()

/datum/artifact_effect/process()
	if(chargelevel < chargelevelmax)
		chargelevel++

	if(activated)
		if(effect == EFFECT_AURA)
			DoEffectAura()
		else if(effect == EFFECT_PULSE && chargelevel >= chargelevelmax)
			chargelevel = 0
			DoEffectPulse()

/datum/artifact_effect/proc/getDescription()
	. = "<b>"
	switch(effect_type)
		if(EFFECT_ENERGY)
			. += "Концентрированные выбросы энергии"
		if(EFFECT_PSIONIC)
			. += "Прерывистые псионические волновые потоки"
		if(EFFECT_ELECTRO)
			. += "Электромагнитные энергии"
		if(EFFECT_PARTICLE)
			. += "Высокочастотные частицы"
		if(EFFECT_ORGANIC)
			. += "Органически реактивные экзотические частицы"
		if(EFFECT_BLUESPACE)
			. += "Межпространственная/bluespace? фазировка"
		if(EFFECT_SYNTH)
			. += "Атомный синтез"
		else
			. += "Низкий уровень выбросов энергии"

	. += "</b> был/ли обнаружен/ны <b>"

	switch(effect)
		if(EFFECT_TOUCH)
			. += "как вкрапления в основание и оболочку."
		if(EFFECT_AURA)
			. += "как излучение в окружающем энергетическом поле."
		if(EFFECT_PULSE)
			. += "как излучение с периодическими всплесками."
		else
			. += "как волны испускаемые неизвестным образом"

	. += "</b>"

	switch(trigger)
		if(TRIGGER_TOUCH, TRIGGER_WATER, TRIGGER_ACID, TRIGGER_VOLATILE, TRIGGER_TOXIN)
			. += " Activation index involves <b>physical interaction</b> with artifact surface."
		if(TRIGGER_FORCE, TRIGGER_ENERGY, TRIGGER_HEAT, TRIGGER_COLD)
			. += " Activation index involves <b>energetic interaction</b> with artifact surface."
		if(TRIGGER_PHORON, TRIGGER_OXY, TRIGGER_CO2, TRIGGER_NITRO)
			. += " Activation index involves <b>precise local atmospheric conditions</b>."
		else
			. += " Unable to determine any data about activation trigger."

//returns 0..1, with 1 being no protection and 0 being fully protected
/proc/GetAnomalySusceptibility(var/mob/living/carbon/human/H)
	if(!istype(H))
		return 1
	if(istype(get_area(H),/area/crew_quarters/sleep)) return 0 //VOREStation Edit - Dorms are protected from anomalies
	var/protected = 0

	//anomaly suits give best protection, but excavation suits are almost as good
	if(istype(H.back,/obj/item/weapon/rig/hazmat))
		var/obj/item/weapon/rig/hazmat/rig = H.back
		if(rig.suit_is_deployed() && !rig.offline)
			protected += 1

	if(istype(H.wear_suit,/obj/item/clothing/suit/bio_suit/anomaly))
		protected += 0.6
	else if(istype(H.wear_suit,/obj/item/clothing/suit/space/anomaly))
		protected += 0.5

	if(istype(H.head,/obj/item/clothing/head/bio_hood/anomaly))
		protected += 0.3
	else if(istype(H.head,/obj/item/clothing/head/helmet/space/anomaly))
		protected += 0.2

	//latex gloves and science goggles also give a bit of bonus protection
	if(istype(H.gloves,/obj/item/clothing/gloves/sterile))
		protected += 0.1

	if(istype(H.glasses,/obj/item/clothing/glasses/science))
		protected += 0.1

	return 1 - protected
