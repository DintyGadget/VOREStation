/datum/reagent/aluminum
	name = "Алюминий"
	id = "aluminum"
	description = "Серебристо-белый и пластичный член группы химических элементов бора."
	taste_description = "metal"
	taste_mult = 1.1
	reagent_state = SOLID
	color = "#A8A8A8"

/datum/reagent/calcium
	name = "Кальций"
	id = "calcium"
	description = "Химический элемент, строительный блок костей."
	taste_description = "metallic chalk" // Apparently, calcium tastes like calcium.
	taste_mult = 1.3
	reagent_state = SOLID
	color = "#e9e6e4"

//VOREStation Edit
/datum/reagent/calcium/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(ishuman(M) && rand(1,10000) == 1)
		var/mob/living/carbon/human/H = M
		for(var/obj/item/organ/external/O in H.bad_external_organs)
			if(O.status & ORGAN_BROKEN)
				O.mend_fracture()
				H.custom_pain("Вы ощущаете мучительную силу кальция, исцеляющего ваши кости!",60)
				H.AdjustWeakened(1)
				break // Only mend one bone, whichever comes first in the list
//VOREStation Edit End

/datum/reagent/carbon
	name = "Углерод"
	id = "carbon"
	description = "Химический элемент, строительный блок жизни."
	taste_description = "sour chalk"
	taste_mult = 1.5
	reagent_state = SOLID
	color = "#1C1300"
	ingest_met = REM * 5

/datum/reagent/carbon/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	if(M.ingested && M.ingested.reagent_list.len > 1) // Need to have at least 2 reagents - cabon and something to remove
		var/effect = 1 / (M.ingested.reagent_list.len - 1)
		for(var/datum/reagent/R in M.ingested.reagent_list)
			if(R == src)
				continue
			M.ingested.remove_reagent(R.id, removed * effect)

/datum/reagent/carbon/touch_turf(var/turf/T)
	if(!istype(T, /turf/space))
		var/obj/effect/decal/cleanable/dirt/dirtoverlay = locate(/obj/effect/decal/cleanable/dirt, T)
		if (!dirtoverlay)
			dirtoverlay = new/obj/effect/decal/cleanable/dirt(T)
			dirtoverlay.alpha = volume * 30
		else
			dirtoverlay.alpha = min(dirtoverlay.alpha + volume * 30, 255)

/datum/reagent/chlorine
	name = "Хлор"
	id = "chlorine"
	description = "Химический элемент с характерным запахом."
	taste_description = "pool water"
	reagent_state = GAS
	color = "#808080"

/datum/reagent/chlorine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.take_organ_damage(1*REM, 0)

/datum/reagent/chlorine/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	M.take_organ_damage(1*REM, 0)

/datum/reagent/copper
	name = "Медь"
	id = "copper"
	description = "Очень пластичный металл."
	taste_description = "pennies"
	color = "#6E3B08"

/datum/reagent/copper/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_SKRELL)
		M.add_chemical_effect(CE_BLOODRESTORE, 8 * removed)

/datum/reagent/ethanol
	name = "Этанол" //Parent class for all alcoholic reagents.
	id = "ethanol"
	description = "Хорошо известный алкоголь с самыми разнообразными приложениями."
	taste_description = "pure alcohol"
	reagent_state = LIQUID
	color = "#404030"

	ingest_met = REM * 2

	var/nutriment_factor = 0
	var/strength = 10 // This is, essentially, units between stages - the lower, the stronger. Less fine tuning, more clarity.
	var/toxicity = 1

	var/druggy = 0
	var/adj_temp = 0
	var/targ_temp = 310
	var/halluci = 0

	glass_name = "ethanol"
	glass_desc = "Хорошо известный алкоголь с самыми разнообразными приложениями."
	allergen_factor = 0.5	//simulates mixed drinks containing less of the allergen, as they have only a single actual reagent unlike food

/datum/reagent/ethanol/touch_mob(var/mob/living/L, var/amount)
	if(istype(L))
		L.adjust_fire_stacks(amount / 15)

/datum/reagent/ethanol/affect_blood(var/mob/living/carbon/M, var/alien, var/removed) //This used to do just toxin. That's boring. Let's make this FUN.
	if(issmall(M)) removed *= 2
	var/strength_mod = 3 * M.species.alcohol_mod //Alcohol is 3x stronger when injected into the veins.
	if(alien == IS_SKRELL)
		strength_mod *= 5
	if(alien == IS_TAJARA)
		strength_mod *= 1.25
	if(alien == IS_UNATHI)
		strength_mod *= 0.75
	if(alien == IS_DIONA)
		strength_mod = 0
	if(alien == IS_SLIME)
		strength_mod *= 2 // VOREStation Edit - M.adjustToxLoss(removed)

	M.add_chemical_effect(CE_ALCOHOL, 1)
	var/effective_dose = dose * strength_mod * (1 + volume/60) //drinking a LOT will make you go down faster

	if(effective_dose >= strength) // Early warning
		M.make_dizzy(18) // It is decreased at the speed of 3 per tick
	if(effective_dose >= strength * 2) // Slurring
		M.slurring = max(M.slurring, 90)
	if(effective_dose >= strength * 3) // Confusion - walking in random directions
		M.Confuse(60)
	if(effective_dose >= strength * 4) // Blurry vision
		M.eye_blurry = max(M.eye_blurry, 30)
	if(effective_dose >= strength * 5) // Drowsyness - periodically falling asleep
		M.drowsyness = max(M.drowsyness, 60)
	if(effective_dose >= strength * 6) // Toxic dose
		M.add_chemical_effect(CE_ALCOHOL_TOXIC, toxicity*3)
	if(effective_dose >= strength * 7) // Pass out
		M.Paralyse(60)
		M.Sleeping(90)

	if(druggy != 0)
		M.druggy = max(M.druggy, druggy*3)

	if(adj_temp > 0 && M.bodytemperature < targ_temp) // 310 is the normal bodytemp. 310.055
		M.bodytemperature = min(targ_temp, M.bodytemperature + (adj_temp * TEMPERATURE_DAMAGE_COEFFICIENT))
	if(adj_temp < 0 && M.bodytemperature > targ_temp)
		M.bodytemperature = min(targ_temp, M.bodytemperature - (adj_temp * TEMPERATURE_DAMAGE_COEFFICIENT))

	if(halluci)
		M.hallucination = max(M.hallucination, halluci*3)

/datum/reagent/ethanol/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(issmall(M)) removed *= 2
	if(!(M.species.allergens & allergen_type))	//assuming it doesn't cause a horrible reaction, we get the nutrition effects
		M.adjust_nutrition(nutriment_factor * removed)
	var/strength_mod = 1 * M.species.alcohol_mod
	if(alien == IS_SKRELL)
		strength_mod *= 5
	if(alien == IS_TAJARA)
		strength_mod *= 1.25
	if(alien == IS_UNATHI)
		strength_mod *= 0.75
	if(alien == IS_DIONA)
		strength_mod = 0
	if(alien == IS_SLIME)
		strength_mod *= 2 // VOREStation Edit - M.adjustToxLoss(removed * 2)

	M.add_chemical_effect(CE_ALCOHOL, 1)

	if(dose * strength_mod >= strength) // Early warning
		M.make_dizzy(6) // It is decreased at the speed of 3 per tick
	if(dose * strength_mod >= strength * 2) // Slurring
		M.slurring = max(M.slurring, 30)
	if(dose * strength_mod >= strength * 3) // Confusion - walking in random directions
		M.Confuse(20)
	if(dose * strength_mod >= strength * 4) // Blurry vision
		M.eye_blurry = max(M.eye_blurry, 10)
	if(dose * strength_mod >= strength * 5) // Drowsyness - periodically falling asleep
		M.drowsyness = max(M.drowsyness, 20)
	if(dose * strength_mod >= strength * 6) // Toxic dose
		M.add_chemical_effect(CE_ALCOHOL_TOXIC, toxicity)
	if(dose * strength_mod >= strength * 7) // Pass out
		M.Paralyse(20)
		M.Sleeping(30)

	if(druggy != 0)
		M.druggy = max(M.druggy, druggy)

	if(adj_temp > 0 && M.bodytemperature < targ_temp) // 310 is the normal bodytemp. 310.055
		M.bodytemperature = min(targ_temp, M.bodytemperature + (adj_temp * TEMPERATURE_DAMAGE_COEFFICIENT))
	if(adj_temp < 0 && M.bodytemperature > targ_temp)
		M.bodytemperature = min(targ_temp, M.bodytemperature - (adj_temp * TEMPERATURE_DAMAGE_COEFFICIENT))

	if(halluci)
		M.hallucination = max(M.hallucination, halluci)

/datum/reagent/ethanol/touch_obj(var/obj/O)
	if(istype(O, /obj/item/weapon/paper))
		var/obj/item/weapon/paper/paperaffected = O
		paperaffected.clearpaper()
		to_chat(usr, "Раствор растворяет чернила на бумаге.")
		return
	if(istype(O, /obj/item/weapon/book))
		if(volume < 5)
			return
		if(istype(O, /obj/item/weapon/book/tome))
			to_chat(usr, "<span class='notice'>Раствор ничего не дает. Что бы это ни было, это не обычные чернила.</span>")
			return
		var/obj/item/weapon/book/affectedbook = O
		affectedbook.dat = null
		to_chat(usr, "<span class='notice'>Раствор растворяет чернила на книге.</span>")
	return

/datum/reagent/fluorine
	name = "Фтор"
	id = "fluorine"
	description = "Высокореактивный химический элемент."
	taste_description = "acid"
	reagent_state = GAS
	color = "#808080"

/datum/reagent/fluorine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.adjustToxLoss(removed)

/datum/reagent/fluorine/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	M.adjustToxLoss(removed)

/datum/reagent/hydrogen
	name = "Водород"
	id = "hydrogen"
	description = "Бесцветный, без запаха, неметаллический, безвкусный, очень горючий двухатомный газ."
	taste_mult = 0 //no taste
	reagent_state = GAS
	color = "#808080"

/datum/reagent/iron
	name = "Железо"
	id = "iron"
	description = "Чистое железо-это металл."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#353535"

/datum/reagent/iron/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien != IS_DIONA && alien != IS_SKRELL)
		M.add_chemical_effect(CE_BLOODRESTORE, 8 * removed)

/datum/reagent/lithium
	name = "Литий"
	id = "lithium"
	description = "Химический элемент, используемый в качестве антидепрессанта."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#808080"

/datum/reagent/lithium/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien != IS_DIONA)
		if(M.canmove && !M.restrained() && istype(M.loc, /turf/space))
			step(M, pick(cardinal))
		if(prob(5))
			M.emote(pick("twitch", "drool", "moan"))

/datum/reagent/mercury
	name = "Ртуть"
	id = "mercury"
	description = "Химический элемент."
	taste_mult = 0 //mercury apparently is tasteless. IDK
	reagent_state = LIQUID
	color = "#484848"

/datum/reagent/mercury/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien != IS_DIONA)
		if(M.canmove && !M.restrained() && istype(M.loc, /turf/space))
			step(M, pick(cardinal))
		if(prob(5))
			M.emote(pick("twitch", "drool", "moan"))
		M.adjustBrainLoss(0.5 * removed)

/datum/reagent/nitrogen
	name = "Азот"
	id = "nitrogen"
	description = "Бесцветный, без запаха, безвкусный газ."
	taste_mult = 0 //no taste
	reagent_state = GAS
	color = "#808080"

/datum/reagent/oxygen
	name = "Кислород"
	id = "oxygen"
	description = "Бесцветный газ без запаха."
	taste_mult = 0
	reagent_state = GAS
	color = "#808080"

/datum/reagent/oxygen/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_VOX)
		M.adjustToxLoss(removed * 3)

/datum/reagent/phosphorus
	name = "Фосфор"
	id = "phosphorus"
	description = "Химический элемент, основа биологических энергоносителей."
	taste_description = "vinegar"
	reagent_state = SOLID
	color = "#832828"

/datum/reagent/potassium
	name = "Калий"
	id = "potassium"
	description = "Мягкое, легкоплавкое твердое вещество, которое можно легко разрезать ножом. Бурно реагирует с водой."
	taste_description = "sweetness" //potassium is bitter in higher doses but sweet in lower ones.
	reagent_state = SOLID
	color = "#A0A0A0"

/datum/reagent/radium
	name = "Радий"
	id = "radium"
	description = "Радий-щелочноземельный металл. Он чрезвычайно радиоактивен."
	taste_mult = 0	//Apparently radium is tasteless
	reagent_state = SOLID
	color = "#C7C7C7"

/datum/reagent/radium/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(issmall(M)) removed *= 2
	M.apply_effect(10 * removed, IRRADIATE, 0) // Radium may increase your chances to cure a disease
	if(M.virus2.len)
		for(var/ID in M.virus2)
			var/datum/disease2/disease/V = M.virus2[ID]
			if(prob(5))
				M.antibodies |= V.antigen
				if(prob(50))
					M.apply_effect(50, IRRADIATE, check_protection = 0) // curing it that way may kill you instead
					var/absorbed = 0
					var/obj/item/organ/internal/diona/nutrients/rad_organ = locate() in M.internal_organs
					if(rad_organ && !rad_organ.is_broken())
						absorbed = 1
					if(!absorbed)
						M.adjustToxLoss(100)

/datum/reagent/radium/touch_turf(var/turf/T)
	if(volume >= 3)
		if(!istype(T, /turf/space))
			var/obj/effect/decal/cleanable/greenglow/glow = locate(/obj/effect/decal/cleanable/greenglow, T)
			if(!glow)
				new /obj/effect/decal/cleanable/greenglow(T)
			return

/datum/reagent/acid
	name = "Серная кислота"
	id = "sacid"
	description = "Очень агрессивная минеральная кислота с молекулярной формулой H2SO4."
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#DB5008"
	metabolism = REM * 2
	touch_met = 50 // It's acid!
	var/power = 5
	var/meltdose = 10 // How much is needed to melt

/datum/reagent/acid/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(issmall(M)) removed *= 2
	M.take_organ_damage(0, removed * power * 2)

/datum/reagent/acid/affect_touch(var/mob/living/carbon/M, var/alien, var/removed) // This is the most interesting
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.head)
			if(H.head.unacidable)
				to_chat(H, "<span class='danger'>Ваша [H.head] защищает вас от кислоты.</span>")
				remove_self(volume)
				return
			else if(removed > meltdose)
				to_chat(H, "<span class='danger'>Ваша [H.head] тает!</span>")
				qdel(H.head)
				H.update_inv_head(1)
				H.update_hair(1)
				removed -= meltdose
		if(removed <= 0)
			return

		if(H.wear_mask)
			if(H.wear_mask.unacidable)
				to_chat(H, "<span class='danger'>Ваша [H.wear_mask] защищает вас от кислоты.</span>")
				remove_self(volume)
				return
			else if(removed > meltdose)
				to_chat(H, "<span class='danger'>Ваша [H.wear_mask] тает!</span>")
				qdel(H.wear_mask)
				H.update_inv_wear_mask(1)
				H.update_hair(1)
				removed -= meltdose
		if(removed <= 0)
			return

		if(H.glasses)
			if(H.glasses.unacidable)
				to_chat(H, "<span class='danger'>Ваши [H.glasses] частично защищают вас от кислоты!</span>")
				removed /= 2
			else if(removed > meltdose)
				to_chat(H, "<span class='danger'>Ваши [H.glasses] тают!</span>")
				qdel(H.glasses)
				H.update_inv_glasses(1)
				removed -= meltdose / 2
		if(removed <= 0)
			return

	if(volume < meltdose) // Not enough to melt anything
		M.take_organ_damage(0, removed * power * 0.2) //burn damage, since it causes chemical burns. Acid doesn't make bones shatter, like brute trauma would.
		return
	if(!M.unacidable && removed > 0)
		if(istype(M, /mob/living/carbon/human) && volume >= meltdose)
			var/mob/living/carbon/human/H = M
			var/obj/item/organ/external/affecting = H.get_organ(BP_HEAD)
			if(affecting)
				if(affecting.take_damage(0, removed * power * 0.1))
					H.UpdateDamageIcon()
				if(prob(100 * removed / meltdose)) // Applies disfigurement
					if (affecting.organ_can_feel_pain())
						H.emote("scream")
					H.status_flags |= DISFIGURED
		else
			M.take_organ_damage(0, removed * power * 0.1) // Balance. The damage is instant, so it's weaker. 10 units -> 5 damage, double for pacid. 120 units beaker could deal 60, but a) it's burn, which is not as dangerous, b) it's a one-use weapon, c) missing with it will splash it over the ground and d) clothes give some protection, so not everything will hit

/datum/reagent/acid/touch_obj(var/obj/O)
	if(O.unacidable)
		return
	if((istype(O, /obj/item) || istype(O, /obj/effect/plant)) && (volume > meltdose))
		var/obj/effect/decal/cleanable/molten_item/I = new/obj/effect/decal/cleanable/molten_item(O.loc)
		I.desc = "Похоже, это было [O] некоторое время назад."
		for(var/mob/M in viewers(5, O))
			to_chat(M, "<span class='warning'>[O] тает.</span>")
		qdel(O)
		remove_self(meltdose) // 10 units of acid will not melt EVERYTHING on the tile

/datum/reagent/silicon
	name = "Кремний"
	id = "silicon"
	description = "Четырехвалентный металлоид, кремний менее реакционноспособен, чем его химический аналог углерод."
	taste_mult = 0
	reagent_state = SOLID
	color = "#A8A8A8"

/datum/reagent/sodium
	name = "Натрий"
	id = "sodium"
	description = "Химический элемент, легко реагирует с водой."
	taste_description = "salty metal"
	reagent_state = SOLID
	color = "#808080"

/datum/reagent/sugar
	name = "Сахар"
	id = "sugar"
	description = "Органическое соединение, широко известное как столовый сахар и иногда называемое сахарозой. Этот белый кристаллический порошок без запаха имеет приятный сладкий вкус."
	taste_description = "sugar"
	taste_mult = 1.8
	reagent_state = SOLID
	color = "#FFFFFF"

	glass_name = "sugar"
	glass_desc = "Органическое соединение, широко известное как столовый сахар и иногда называемое сахарозой. Этот белый кристаллический порошок без запаха имеет приятный сладкий вкус."
	glass_icon = DRINK_ICON_NOISY

/datum/reagent/sugar/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.adjust_nutrition(removed * 3)

	var/effective_dose = dose
	if(issmall(M))
		effective_dose *= 2

	if(alien == IS_UNATHI)
		if(effective_dose < 2)
			if(effective_dose == metabolism * 2 || prob(5))
				M.emote("yawn")
		else if(effective_dose < 5)
			M.eye_blurry = max(M.eye_blurry, 10)
		else if(effective_dose < 20)
			if(prob(50))
				M.Weaken(2)
			M.drowsyness = max(M.drowsyness, 20)
		else
			M.Sleeping(20)
			M.drowsyness = max(M.drowsyness, 60)

/datum/reagent/sulfur
	name = "Сера"
	id = "sulfur"
	description = "Химический элемент с резким запахом."
	taste_description = "old eggs"
	reagent_state = SOLID
	color = "#BF8C00"

/datum/reagent/tungsten
	name = "Вольфрам"
	id = "tungsten"
	description = "Химический элемент и сильный окислитель."
	taste_description = "metal"
	taste_mult = 0 //no taste
	reagent_state = SOLID
	color = "#DCDCDC"
