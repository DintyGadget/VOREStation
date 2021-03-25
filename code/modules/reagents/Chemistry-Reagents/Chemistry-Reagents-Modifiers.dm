/*
 * Modifier-applying chemicals.
 */

/datum/reagent/modapplying
	name = "грубый сок"
	id = "berserkmed"
	description = "Жидкость, способная вызывать длительное состояние повышенной агрессии и стойкости."
	taste_description = "металл"
	reagent_state = LIQUID
	color = "#ff5555"
	metabolism = REM

	var/modifier_to_add = /datum/modifier/berserk
	var/modifier_duration = 3 SECONDS	// How long, per unit dose, will this last?
										// 2 SECONDS is the resolution of life code, and the modifier will expire before chemical processing tries to re-add it

/datum/reagent/modapplying/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.add_modifier(modifier_to_add, modifier_duration, suppress_failure = TRUE)

/datum/reagent/modapplying/cryofluid
	name = "криогенная суспензия"
	id = "cryoslurry"
	description = "Невероятно странная жидкость, которая быстро поглощает тепловую энергию из материалов, с которыми соприкасается."
	taste_description = "сибирский ад"
	color = "#4CDBDB"
	metabolism = REM * 0.5

	modifier_to_add = /datum/modifier/cryogelled
	modifier_duration = 3 SECONDS

/datum/reagent/modapplying/cryofluid/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	..(M, alien, removed)
	M.bodytemperature -= removed * 20

/datum/reagent/modapplying/cryofluid/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	affect_blood(M, alien, removed * 2.5)

/datum/reagent/modapplying/cryofluid/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	affect_blood(M, alien, removed * 0.6)

/datum/reagent/modapplying/cryofluid/touch_mob(var/mob/M, var/amount)
	if(isliving(M))
		var/mob/living/L = M
		for(var/I = 1 to rand(1, round(amount + 1)))
			L.add_modifier(modifier_to_add, amount * rand(modifier_duration / 2, modifier_duration * 2))
	return

/datum/reagent/modapplying/cryofluid/touch_turf(var/turf/T, var/amount)
	if(istype(T, /turf/simulated/floor/water) && prob(amount))
		T.visible_message("<span class='danger'>[T] громко потрескивает, когда криогенная жидкость выкипает, оставляя после себя твердый слой льда.</span>")
		T.ChangeTurf(/turf/simulated/floor/outdoors/ice, 1, 1, TRUE)
	else
		if(istype(T, /turf/simulated))
			var/turf/simulated/S = T
			S.freeze_floor()
	return

/datum/reagent/modapplying/vatstabilizer
	name = "ингибитор роста клонов"
	id = "vatstabilizer"
	description = "Соединение, производимое NanoTrasen с использованием секретной смеси форона и токсинов, чтобы остановить безудержный рост клона за пределами запланированных состояний."
	taste_description = "кислый клей"
	color = "#060501"
	metabolism = REM * 0.2

	modifier_to_add = /datum/modifier/clone_stabilizer
	modifier_duration = 30 SECONDS
