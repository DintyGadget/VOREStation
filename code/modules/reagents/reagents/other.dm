/* Paint and crayons */

/datum/reagent/crayon_dust
	name = "Мелковая пыль"
	id = "crayon_dust"
	description = "Сильно окрашенный порошок, полученный при измельчении мелками."
	taste_description = "порошковый воск"
	reagent_state = LIQUID
	color = "#888888"
	overdose = 5

/datum/reagent/crayon_dust/red
	name = "Красная мелковая пыль"
	id = "crayon_dust_red"
	color = "#FE191A"

/datum/reagent/crayon_dust/orange
	name = "Оранжевая мелковая пыль"
	id = "crayon_dust_orange"
	color = "#FFBE4F"

/datum/reagent/crayon_dust/yellow
	name = "Желтая мелковая пыль"
	id = "crayon_dust_yellow"
	color = "#FDFE7D"

/datum/reagent/crayon_dust/green
	name = "Зеленая мелковая пыль"
	id = "crayon_dust_green"
	color = "#18A31A"

/datum/reagent/crayon_dust/blue
	name = "Синяя мелковая пыль"
	id = "crayon_dust_blue"
	color = "#247CFF"

/datum/reagent/crayon_dust/purple
	name = "Пурпурная мелковая пыль"
	id = "crayon_dust_purple"
	color = "#CC0099"

/datum/reagent/crayon_dust/grey //Mime
	name = "Серая мелковая пыль"
	id = "crayon_dust_grey"
	color = "#808080"

/datum/reagent/crayon_dust/brown //Rainbow
	name = "Коричневая мелковая пыль"
	id = "crayon_dust_brown"
	color = "#846F35"

/datum/reagent/marker_ink
	name = "Маркерные чернила"
	id = "marker_ink"
	description = "Ярко окрашенные чернила, используемые в маркерах."
	taste_description = "чрезвычайно горький"
	reagent_state = LIQUID
	color = "#888888"
	overdose = 5

/datum/reagent/marker_ink/black
	name = "Черные маркерные чернила"
	id = "marker_ink_black"
	color = "#000000"

/datum/reagent/marker_ink/red
	name = "Красные маркерные чернила"
	id = "marker_ink_red"
	color = "#FE191A"

/datum/reagent/marker_ink/orange
	name = "Оранженвые маркерные чернила"
	id = "marker_ink_orange"
	color = "#FFBE4F"

/datum/reagent/marker_ink/yellow
	name = "Желтые маркерные чернила"
	id = "marker_ink_yellow"
	color = "#FDFE7D"

/datum/reagent/marker_ink/green
	name = "Зеленые маркерные чернила"
	id = "marker_ink_green"
	color = "#18A31A"

/datum/reagent/marker_ink/blue
	name = "Синие маркерные чернила"
	id = "marker_ink_blue"
	color = "#247CFF"

/datum/reagent/marker_ink/purple
	name = "Фиолетовые маркерные чернила"
	id = "marker_ink_purple"
	color = "#CC0099"

/datum/reagent/marker_ink/grey //Mime
	name = "Серые маркерные чернила"
	id = "marker_ink_grey"
	color = "#808080"

/datum/reagent/marker_ink/brown //Rainbow
	name = "Коричневые маркерные чернила"
	id = "marker_ink_brown"
	color = "#846F35"

/datum/reagent/paint
	name = "Краска"
	id = "paint"
	description = "Эта краска приклеится практически к любому объекту."
	taste_description = "мелок"
	reagent_state = LIQUID
	color = "#808080"
	overdose = REAGENTS_OVERDOSE * 0.5
	color_weight = 20

/datum/reagent/paint/touch_turf(var/turf/T)
	if(istype(T) && !istype(T, /turf/space))
		T.color = color

/datum/reagent/paint/touch_obj(var/obj/O)
	if(istype(O))
		O.color = color

/datum/reagent/paint/touch_mob(var/mob/M)
	if(istype(M) && !istype(M, /mob/observer)) //painting ghosts: not allowed
		M.color = color //maybe someday change this to paint only clothes and exposed body parts for human mobs.

/datum/reagent/paint/get_data()
	return color

/datum/reagent/paint/initialize_data(var/newdata)
	color = newdata
	return

/datum/reagent/paint/mix_data(var/newdata, var/newamount)
	var/list/colors = list(0, 0, 0, 0)
	var/tot_w = 0

	var/hex1 = uppertext(color)
	var/hex2 = uppertext(newdata)
	if(length(hex1) == 7)
		hex1 += "FF"
	if(length(hex2) == 7)
		hex2 += "FF"
	if(length(hex1) != 9 || length(hex2) != 9)
		return
	colors[1] += hex2num(copytext(hex1, 2, 4)) * volume
	colors[2] += hex2num(copytext(hex1, 4, 6)) * volume
	colors[3] += hex2num(copytext(hex1, 6, 8)) * volume
	colors[4] += hex2num(copytext(hex1, 8, 10)) * volume
	tot_w += volume
	colors[1] += hex2num(copytext(hex2, 2, 4)) * newamount
	colors[2] += hex2num(copytext(hex2, 4, 6)) * newamount
	colors[3] += hex2num(copytext(hex2, 6, 8)) * newamount
	colors[4] += hex2num(copytext(hex2, 8, 10)) * newamount
	tot_w += newamount

	color = rgb(colors[1] / tot_w, colors[2] / tot_w, colors[3] / tot_w, colors[4] / tot_w)
	return

/* Things that didn't fit anywhere else */

/datum/reagent/adminordrazine //An OP chemical for admins
	name = "Админордразин"
	id = "adminordrazine"
	description = "Это магия. Нам не нужно это объяснять."
	taste_description = "админ"
	reagent_state = LIQUID
	color = "#C8A5DC"
	affects_dead = 1 //This can even heal dead people.
	metabolism = 0.1
	mrate_static = TRUE //Just in case

	glass_name = "liquid gold"
	glass_desc = "Это магия. Нам не нужно это объяснять."

/datum/reagent/adminordrazine/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	affect_blood(M, alien, removed)

/datum/reagent/adminordrazine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.setCloneLoss(0)
	M.setOxyLoss(0)
	M.radiation = 0
	M.heal_organ_damage(20,20)
	M.adjustToxLoss(-20)
	M.hallucination = 0
	M.setBrainLoss(0)
	M.disabilities = 0
	M.sdisabilities = 0
	M.eye_blurry = 0
	M.SetBlinded(0)
	M.SetWeakened(0)
	M.SetStunned(0)
	M.SetParalysis(0)
	M.silent = 0
	M.dizziness = 0
	M.drowsyness = 0
	M.stuttering = 0
	M.SetConfused(0)
	M.SetSleeping(0)
	M.jitteriness = 0
	M.radiation = 0
	M.ExtinguishMob()
	M.fire_stacks = 0
	if(M.bodytemperature > 310)
		M.bodytemperature = max(310, M.bodytemperature - (40 * TEMPERATURE_DAMAGE_COEFFICIENT))
	else if(M.bodytemperature < 311)
		M.bodytemperature = min(310, M.bodytemperature + (40 * TEMPERATURE_DAMAGE_COEFFICIENT))
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/wound_heal = 5
		for(var/obj/item/organ/external/O in H.bad_external_organs)
			if(O.status & ORGAN_BROKEN)
				O.mend_fracture()		//Only works if the bone won't rebreak, as usual
			for(var/datum/wound/W in O.wounds)
				if(W.bleeding())
					W.damage = max(W.damage - wound_heal, 0)
					if(W.damage <= 0)
						O.wounds -= W
				if(W.internal)
					W.damage = max(W.damage - wound_heal, 0)
					if(W.damage <= 0)
						O.wounds -= W

/datum/reagent/gold
	name = "Золото"
	id = "gold"
	description = "Золото - это плотный, мягкий, блестящий металл, самый ковкий и пластичный из известных."
	taste_description = "металл"
	reagent_state = SOLID
	color = "#F7C430"

/datum/reagent/silver
	name = "Серебро"
	id = "silver"
	description = "Мягкий, белый, блестящий переходный металл, он имеет самую высокую электропроводность среди всех элементов и самую высокую теплопроводность среди всех металлов."
	taste_description = "металл"
	reagent_state = SOLID
	color = "#D0D0D0"

/datum/reagent/platinum
	name = "Платина"
	id = "platinum"
	description = "Платина - это плотный, ковкий, пластичный, крайне инертный, драгоценный переходный металл серо-белого цвета. Он очень устойчив к коррозии."
	taste_description = "металл"
	reagent_state = SOLID
	color = "#777777"

/datum/reagent/uranium
	name = "Уран"
	id = "uranium"
	description = "Серебристо-белый металлический химический элемент из ряда актинидов, слаборадиоактивный."
	taste_description = "металл"
	reagent_state = SOLID
	color = "#B8B8C0"

/datum/reagent/uranium/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	affect_ingest(M, alien, removed)

/datum/reagent/uranium/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.apply_effect(5 * removed, IRRADIATE, 0)

/datum/reagent/uranium/touch_turf(var/turf/T)
	if(volume >= 3)
		if(!istype(T, /turf/space))
			var/obj/effect/decal/cleanable/greenglow/glow = locate(/obj/effect/decal/cleanable/greenglow, T)
			if(!glow)
				new /obj/effect/decal/cleanable/greenglow(T)
			return

/datum/reagent/hydrogen/deuterium
	name = "Дейтерий"
	id = "deuterium"
	description = "Изотоп водорода. Он имеет один дополнительный нейтрон и разделяет все химические характеристики с водородом."

/datum/reagent/hydrogen/tritium
	name = "Тритий"
	id = "tritium"
	description = "Радиоактивный изотоп водорода. Он имеет два дополнительных нейтрона и разделяет все остальные химические характеристики с водородом."

/datum/reagent/lithium/lithium6
	name = "Литий-6"
	id = "lithium6"
	description = "Изотоп лития. Он имеет 3 нейтрона, но имеет все химические характеристики обычного лития."

/datum/reagent/helium/helium3
	name = "Гелий-3"
	id = "helium3"
	description = "Изотоп гелия. Он имеет только один нейтрон, но имеет все химические характеристики обычного гелия."
	taste_mult = 0
	reagent_state = GAS
	color = "#808080"

/datum/reagent/boron/boron11
	name = "Бор-11"
	id = "boron11"
	description = "Изотоп бора. В нем 6 нейтронов."
	taste_description = "металлический" // Apparently noone on the internet knows what boron tastes like. Or at least they won't share

/datum/reagent/supermatter
	name = "Суперматерия"
	id = "supermatter"
	description = "Огромная сила кристалла суперматериалы в жидкой форме. Вы не совсем уверены, как это возможно, но, вероятно, лучше всего обращаться с этим осторожно."
	taste_description = "ириска" // 0. The supermatter is tasty, tasty taffy.

// Same as if you boop it wrong. It touches you, you die
/datum/reagent/supermatter/affect_touch(mob/living/carbon/M, alien, removed)
	. = ..()
	M.ash()

/datum/reagent/supermatter/affect_ingest(mob/living/carbon/M, alien, removed)
	. = ..()
	M.ash()

/datum/reagent/supermatter/affect_blood(mob/living/carbon/M, alien, removed)
	. = ..()
	M.ash()


/datum/reagent/adrenaline
	name = "Адреналин"
	id = "adrenaline"
	description = "Адреналин - это гормон, используемый в качестве лекарственного средства для лечения остановки сердца и других сердечных нарушений ритма, приводящих к снижению или отсутствию сердечного выброса."
	taste_description = "горечь"
	reagent_state = LIQUID
	color = "#C8A5DC"
	mrate_static = TRUE

/datum/reagent/adrenaline/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.SetParalysis(0)
	M.SetWeakened(0)
	M.adjustToxLoss(rand(3))

/datum/reagent/water/holywater
	name = "Святая вода"
	id = "holywater"
	description = "Смесь пепла, обсидиана и воды, этот раствор изменит некоторые части рационального мышления мозга."
	taste_description = "вода"
	color = "#E0E8EF"
	mrate_static = TRUE

	glass_name = "holy water"
	glass_desc = "Смесь пепла, обсидиана и воды, этот раствор изменит некоторые части рационального мышления мозга."

/datum/reagent/water/holywater/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	..()
	if(ishuman(M)) // Any location
		if(M.mind && cult.is_antagonist(M.mind) && prob(10))
			cult.remove_antagonist(M.mind)

/datum/reagent/water/holywater/touch_turf(var/turf/T)
	if(volume >= 5)
		T.holy = 1
	return

/datum/reagent/ammonia
	name = "Аммиак"
	id = "ammonia"
	description = "Едкое вещество, обычно используемое в удобрениях или бытовых чистящих средствах."
	taste_description = "язва"
	taste_mult = 2
	reagent_state = GAS
	color = "#404030"

/datum/reagent/diethylamine
	name = "Диэтиламин"
	id = "diethylamine"
	description = "Вторичный амин, умеренно коррозионный."
	taste_description = "железо"
	reagent_state = LIQUID
	color = "#604030"

/datum/reagent/fluorosurfactant // Foam precursor
	name = "Фторсодержащее поверхностно-активное вещество"
	id = "fluorosurfactant"
	description = "Перфторированная сульфоновая кислота, образующая пену при смешивании с водой."
	taste_description = "металл"
	reagent_state = LIQUID
	color = "#9E6B38"

/datum/reagent/foaming_agent // Metal foaming agent. This is lithium hydride. Add other recipes (e.g. LiH + H2O -> LiOH + H2) eventually.
	name = "Пенообразователь"
	id = "foaming_agent"
	description = "Средство, образующее металлическую пену при смешивании с легким металлом и сильной кислотой."
	taste_description = "металл"
	reagent_state = SOLID
	color = "#664B63"

/datum/reagent/thermite
	name = "Термит"
	id = "thermite"
	description = "Термит вызывает алюминотермическую реакцию, известную как термитная реакция. Может использоваться для плавления стен."
	taste_description = "сладкий на вкус металл"
	reagent_state = SOLID
	color = "#673910"
	touch_met = 50

/datum/reagent/thermite/touch_turf(var/turf/T)
	if(volume >= 5)
		if(istype(T, /turf/simulated/wall))
			var/turf/simulated/wall/W = T
			W.thermite = 1
			W.overlays += image('icons/effects/effects.dmi',icon_state = "#673910")
			remove_self(5)
	return

/datum/reagent/thermite/touch_mob(var/mob/living/L, var/amount)
	if(istype(L))
		L.adjust_fire_stacks(amount / 5)

/datum/reagent/thermite/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.adjustFireLoss(3 * removed)

/datum/reagent/space_cleaner
	name = "Space cleaner"
	id = "cleaner"
	description = "Состав, используемый для чистки вещей. Теперь на 50% больше гипохлорита натрия!"
	taste_description = "кислинка"
	reagent_state = LIQUID
	color = "#A5F0EE"
	touch_met = 50

/datum/reagent/space_cleaner/touch_mob(var/mob/M)
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.clean_blood()

/datum/reagent/space_cleaner/touch_obj(var/obj/O)
	O.clean_blood()

/datum/reagent/space_cleaner/touch_turf(var/turf/T)
	if(volume >= 1)
		if(istype(T, /turf/simulated))
			var/turf/simulated/S = T
			S.dirt = 0
		T.clean_blood()

		for(var/mob/living/simple_mob/slime/M in T)
			M.adjustToxLoss(rand(5, 10))

/datum/reagent/space_cleaner/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.r_hand)
		M.r_hand.clean_blood()
	if(M.l_hand)
		M.l_hand.clean_blood()
	if(M.wear_mask)
		if(M.wear_mask.clean_blood())
			M.update_inv_wear_mask(0)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(alien == IS_SLIME)
			M.adjustToxLoss(rand(5, 10))
		if(H.head)
			if(H.head.clean_blood())
				H.update_inv_head(0)
		if(H.wear_suit)
			if(H.wear_suit.clean_blood())
				H.update_inv_wear_suit(0)
		else if(H.w_uniform)
			if(H.w_uniform.clean_blood())
				H.update_inv_w_uniform(0)
		if(H.shoes)
			if(H.shoes.clean_blood())
				H.update_inv_shoes(0)
		else
			H.clean_blood(1)
			return
	M.clean_blood()

/datum/reagent/space_cleaner/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_SLIME)
		M.adjustToxLoss(6 * removed)
	else
		M.adjustToxLoss(3 * removed)
		if(prob(5))
			M.vomit()

/datum/reagent/space_cleaner/touch_mob(var/mob/living/L, var/amount)
	if(istype(L, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = L
		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/mask/smokable))
				var/obj/item/clothing/mask/smokable/S = H.wear_mask
				if(S.lit)
					S.quench() // No smoking in my medbay!
					H.visible_message("<span class='notice'>[H]\'s [S.name] is put out.</span>")

/datum/reagent/lube // TODO: spraying on borgs speeds them up
	name = "Космическая смазка"
	id = "lube"
	description = "Смазка - это вещество, помещенное между двумя движущимися поверхностями, чтобы уменьшить трение и износ между ними. хихиканье."
	taste_description = "слизь"
	reagent_state = LIQUID
	color = "#009CA8"

/datum/reagent/lube/touch_turf(var/turf/simulated/T)
	if(!istype(T))
		return
	if(volume >= 1)
		T.wet_floor(2)

/datum/reagent/silicate
	name = "Силикат"
	id = "silicate"
	description = "Состав, который можно использовать для усиления стекла."
	taste_description = "пластик"
	reagent_state = LIQUID
	color = "#C7FFFF"

/datum/reagent/silicate/touch_obj(var/obj/O)
	if(istype(O, /obj/structure/window))
		var/obj/structure/window/W = O
		W.apply_silicate(volume)
		remove_self(volume)
	return

/datum/reagent/glycerol
	name = "Глицерин"
	id = "glycerol"
	description = "Глицерин - это простое соединение полиола. Глицерин имеет сладкий вкус и малотоксичен."
	taste_description = "сладость"
	reagent_state = LIQUID
	color = "#808080"

/datum/reagent/nitroglycerin
	name = "Нитроглицерин"
	id = "nitroglycerin"
	description = "Нитроглицерин - тяжелая, бесцветная, маслянистая, взрывоопасная жидкость, получаемая нитрованием глицерина."
	taste_description = "масло"
	reagent_state = LIQUID
	color = "#808080"

/datum/reagent/coolant
	name = "Хладоген"
	id = "coolant"
	description = "Промышленное охлаждающее вещество."
	taste_description = "кислинка"
	taste_mult = 1.1
	reagent_state = LIQUID
	color = "#C8A5DC"

	affects_robots = TRUE

/datum/reagent/coolant/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.isSynthetic() && ishuman(M))
		var/mob/living/carbon/human/H = M

		var/datum/reagent/blood/coolant = H.get_blood(H.vessel)

		if(coolant)
			H.vessel.add_reagent("blood", removed, coolant.data)

		else
			H.vessel.add_reagent("blood", removed)
			H.fixblood()

	else
		..()

/datum/reagent/ultraglue
	name = "Ультра клей"
	id = "glue"
	description = "Чрезвычайно мощный связующий агент."
	taste_description = "класс специального образования"
	color = "#FFFFCC"

/datum/reagent/woodpulp
	name = "Древесная масса"
	id = "woodpulp"
	description = "Масса древесных волокон."
	taste_description = "дерево"
	reagent_state = LIQUID
	color = "#B97A57"

/datum/reagent/luminol
	name = "Люминол"
	id = "luminol"
	description = "Соединение, взаимодействующее с кровью на молекулярном уровне."
	taste_description = "металл"
	reagent_state = LIQUID
	color = "#F2F3F4"

/datum/reagent/luminol/touch_obj(var/obj/O)
	O.reveal_blood()

/datum/reagent/luminol/touch_mob(var/mob/living/L)
	L.reveal_blood()

/datum/reagent/nutriment/biomass
	name = "Биомасса"
	id = "biomass"
	description = "Суспензия соединений, содержащая основные требования для жизни."
	taste_description = "соленое мясо"
	reagent_state = LIQUID
	color = "#DF9FBF"

/datum/reagent/mineralfluid
	name = "Жидкость, богатая минералами"
	id = "mineralizedfluid"
	description = "Теплая, богатая минералами жидкость."
	taste_description = "соль"
	reagent_state = LIQUID
	color = "#ff205255"

// The opposite to healing nanites, exists to make unidentified hypos implied to have nanites not be 100% safe.
/datum/reagent/defective_nanites
	name = "Дефектные наниты"
	id = "defective_nanites"
	description = "Миниатюрные медицинские роботы, которые работают со сбоями и причиняют телесные повреждения. К счастью, они не могут самовоспроизводиться."
	taste_description = "металл"
	reagent_state = SOLID
	color = "#333333"
	metabolism = REM * 3 // Broken nanomachines go a bit slower.
	scannable = 1

/datum/reagent/defective_nanites/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.take_organ_damage(2 * removed, 2 * removed)
	M.adjustOxyLoss(4 * removed)
	M.adjustToxLoss(2 * removed)
	M.adjustCloneLoss(2 * removed)

/datum/reagent/fishbait
	name = "Рыбная приманка"
	id = "fishbait"
	description = "Натуральная суспензия, которая особенно нравится рыбе."
	taste_description = "земля"
	reagent_state = LIQUID
	color = "#62764E"