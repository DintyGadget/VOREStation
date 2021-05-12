// These should all be procs, you can add them to humans/subspecies by
// species.dm's inherent_verbs ~ Z

/mob/living/carbon/human/proc/tie_hair()
	set name = "Завязать волосы"
	set desc = "Style your hair."
	set category = "IC"

	if(incapacitated())
		to_chat(src, "<span class='warning'>Прямо сейчас нельзя возиться с волосами!</span>")
		return

	if(h_style)
		var/datum/sprite_accessory/hair/hair_style = hair_styles_list[h_style]
		var/selected_string
		if(!(hair_style.flags & HAIR_TIEABLE))
			to_chat(src, "<span class ='warning'>Ваши волосы недостаточно длинные, чтобы их можно было связать.</span>")
			return
		else
			var/list/datum/sprite_accessory/hair/valid_hairstyles = list()
			for(var/hair_string in hair_styles_list)
				var/list/datum/sprite_accessory/hair/test = hair_styles_list[hair_string]
				if(test.flags & HAIR_TIEABLE)
					valid_hairstyles.Add(hair_string)
			selected_string = input("Выберите новую прическу", "Ваша прическа", hair_style) as null|anything in valid_hairstyles
		if(incapacitated())
			to_chat(src, "<span class='warning'>Прямо сейчас нельзя возиться с волосами!</span>")
			return
		else if(selected_string && h_style != selected_string)
			h_style = selected_string
			regenerate_icons()
			visible_message("<span class='notice'>[src] делает паузу, чтобы уложить волосы.</span>")
		else
			to_chat(src, "<span class ='notice'>Вы уже используете этот стиль.</span>")

/mob/living/carbon/human/proc/tackle()
	set category = "Abilities"
	set name = "Схватить"
	set desc = "Схватить кого-нибудь."

	if(last_special > world.time)
		return

	if(stat || paralysis || stunned || weakened || lying || restrained() || buckled)
		to_chat(src, "Вы не можете справиться с кем-то в вашем нынешнем состоянии.")
		return

	var/list/choices = list()
	for(var/mob/living/M in view(1,src))
		if(!istype(M,/mob/living/silicon) && Adjacent(M))
			choices += M
	choices -= src

	var/mob/living/T = input(src,"Кого вы хотите схватить?") as null|anything in choices

	if(!T || !src || src.stat) return

	if(!Adjacent(T)) return

	if(last_special > world.time)
		return

	if(stat || paralysis || stunned || weakened || lying || restrained() || buckled)
		to_chat(src, "Вы не можете справиться с кем-то в вашем нынешнем состоянии.")
		return

	last_special = world.time + 50

	var/failed
	if(prob(75))
		T.Weaken(rand(0.5,3))
	else
		failed = 1

	playsound(src, 'sound/weapons/pierce.ogg', 25, 1, -1)
	if(failed)
		src.Weaken(rand(2,4))

	for(var/mob/O in viewers(src, null))
		if ((O.client && !( O.blinded )))
			O.show_message(text("<font color='red'><B>[] [failed ? "tried to tackle" : "has tackled"] down []!</font></B>", src, T), 1)

/mob/living/carbon/human/proc/commune()
	set category = "Abilities"
	set name = "Общаться с существом"
	set desc = "Send a telepathic message to an unlucky recipient."

	var/list/targets = list()
	var/target = null
	var/text = null

	targets += getmobs() //Fill list, prompt user with list
	target = input("Выберите существо!", "Speak to creature", null, null) as null|anything in targets

	if(!target) return

	text = input("Что бы вы хотели сказать?", "Speak to creature", null, null)

	text = sanitize(text)

	if(!text) return

	var/mob/M = targets[target]

	if(istype(M, /mob/observer/dead) || M.stat == DEAD)
		to_chat(src, "Даже [src.species.name] не может разговаривать с мертвыми.")
		return

	log_say("(COMMUNE to [key_name(M)]) [text]",src)

	to_chat(M, "<font color='blue'>Как свинцовые плиты врезаются в океан, чужие мысли приходят вам в голову: [text]</font>")
	if(istype(M,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		if(H.species.name == src.species.name)
			return
		to_chat(H, "<font color='red'>Ваш нос начинает кровоточить ...</font>")
		H.drip(1)

/mob/living/carbon/human/proc/regurgitate()
	set name = "Срыгивать"
	set desc = "Empties the contents of your stomach"
	set category = "Abilities"

	if(stomach_contents.len)
		for(var/mob/M in src)
			if(M in stomach_contents)
				stomach_contents.Remove(M)
				M.loc = loc
		src.visible_message("<font color='red'><B>[src] выбрасывает содержимое своего желудка!</B></font>")
	return

/mob/living/carbon/human/proc/psychic_whisper(mob/M as mob in oview())
	set name = "Психический шепот"
	set desc = "Whisper silently to someone over a distance."
	set category = "Abilities"

	var/msg = sanitize(input("Message:", "Psychic Whisper") as text|null)
	if(msg)
		log_say("(PWHISPER to [key_name(M)]) [msg]", src)
		to_chat(M, "<font color='green'>Вы слышите в своей голове странный, чужой голос...<i>[msg]</i></font>")
		to_chat(src, "<font color='green'>Вы сказали: \"[msg]\" to [M]</font>")
	return

/mob/living/carbon/human/proc/diona_split_nymph()
	set name = "Разделить тело"
	set desc = "Разделите свою гуманоидную форму на составляющих нимф."
	set category = "Abilities"
	diona_split_into_nymphs(5)	// Separate proc to void argments being supplied when used as a verb

/mob/living/carbon/human/proc/diona_split_into_nymphs(var/number_of_resulting_nymphs)
	var/turf/T = get_turf(src)

	var/mob/living/carbon/alien/diona/S = new(T)
	S.set_dir(dir)
	transfer_languages(src, S)

	if(mind)
		mind.transfer_to(S)

	message_admins("\The [src] has split into nymphs; player now controls [key_name_admin(S)]")
	log_admin("\The [src] has split into nymphs; player now controls [key_name(S)]")

	var/nymphs = 1

	for(var/mob/living/carbon/alien/diona/D in src)
		nymphs++
		D.forceMove(T)
		transfer_languages(src, D, WHITELISTED|RESTRICTED)
		D.set_dir(pick(NORTH, SOUTH, EAST, WEST))

	if(nymphs < number_of_resulting_nymphs)
		for(var/i in nymphs to (number_of_resulting_nymphs - 1))
			var/mob/M = new /mob/living/carbon/alien/diona(T)
			transfer_languages(src, M, WHITELISTED|RESTRICTED)
			M.set_dir(pick(NORTH, SOUTH, EAST, WEST))


	for(var/obj/item/W in src)
		drop_from_inventory(W)

	var/obj/item/organ/external/Chest = organs_by_name[BP_TORSO]

	if(Chest.robotic >= 2)
		visible_message("<span class='warning'>[src] слегка вздрагивает, затем с влажным скользящим шумом выбрасывает группу нимф.</span>")
		species = GLOB.all_species[SPECIES_HUMAN] // This is hard-set to default the body to a normal FBP, without changing anything.

		// Bust it
		src.death()

		for(var/obj/item/organ/internal/diona/Org in internal_organs) // Remove Nymph organs.
			qdel(Org)

		// Purge the diona verbs.
		verbs -= /mob/living/carbon/human/proc/diona_split_nymph
		verbs -= /mob/living/carbon/human/proc/regenerate

		for(var/obj/item/organ/external/E in organs) // Just fall apart.
			E.droplimb(TRUE)

	else
		visible_message("<span class='warning'>[src] слегка дрожит, затем раскалывается с влажным скользящим шумом.</span>")
		qdel(src)

/mob/living/carbon/human/proc/self_diagnostics()
	set name = "Самодиагностика"
	set desc = "Run an internal self-diagnostic to check for damage."
	set category = "IC"

	if(stat == DEAD) return

	to_chat(src, "<span class='notice'>Выполняется самодиагностика, подождите ...</span>")

	spawn(50)
		var/output = "<span class='notice'>Результаты самодиагностики:\n</span>"

		output += "Внутренняя температура: [convert_k2c(bodytemperature)] Градусов Цельсия\n"

		if(isSynthetic())
			output += "Текущий заряд Энергоячейки: [nutrition]\n"

			var/toxDam = getToxLoss()
			if(toxDam)
				output += "Системная нестабильность: <span class='warning'>[toxDam > 25 ? "Серьезная" : "Умеренная"]</span>. Поищите зарядную станцию для очистки.\n"
			else
				output += "Системная нестабильность: <span style='color:green;'>OK</span>\n"

		for(var/obj/item/organ/external/EO in organs)
			if(EO.robotic >= ORGAN_ASSISTED)
				if(EO.brute_dam || EO.burn_dam)
					output += "[EO.name] - <span class='warning'>[EO.burn_dam + EO.brute_dam > EO.min_broken_damage ? "Тяж. урон" : "Лег. урон"]</span>\n" //VOREStation Edit - Makes robotic limb damage scalable
				else
					output += "[EO.name] - <span style='color:green;'>OK</span>\n"

		for(var/obj/item/organ/IO in internal_organs)
			if(IO.robotic >= ORGAN_ASSISTED)
				if(IO.damage)
					output += "[IO.name] - <span class='warning'>[IO.damage > 10 ? "Тяж. урон" : "Лег. урон"]</span>\n"
				else
					output += "[IO.name] - <span style='color:green;'>OK</span>\n"

		to_chat(src,output)

/mob/living/carbon/human
	var/next_sonar_ping = 0

/mob/living/carbon/human/proc/sonar_ping()
	set name = "Слушать"
	set desc = "Allows you to listen in to movement and noises around you."
	set category = "Abilities"

	if(incapacitated())
		to_chat(src, "<span class='warning'>Вам нужно восстановиться, прежде чем вы сможете использовать эту способность.</span>")
		return
	if(world.time < next_sonar_ping)
		to_chat(src, "<span class='warning'>Вам нужен еще один момент, чтобы сосредоточиться.</span>")
		return
	if(is_deaf() || is_below_sound_pressure(get_turf(src)))
		to_chat(src, "<span class='warning'>Вы практически глухой!</span>")
		return
	next_sonar_ping += 10 SECONDS
	var/heard_something = FALSE
	to_chat(src, "<span class='notice'>У вас есть время, чтобы прислушаться к своему окружению...</span>")
	for(var/mob/living/L in range(client.view, src))
		var/turf/T = get_turf(L)
		if(!T || L == src || L.stat == DEAD || is_below_sound_pressure(T))
			continue
		heard_something = TRUE
		var/feedback = list()
		feedback += "<span class='notice'>Слышны шумы движения "
		var/direction = get_dir(src, L)
		if(direction)
			feedback += "в направлении [dir2text(direction)], "
			switch(get_dist(src, L) / client.view)
				if(0 to 0.2)
					feedback += "очень близко."
				if(0.2 to 0.4)
					feedback += "рядом."
				if(0.4 to 0.6)
					feedback += "неподалеку."
				if(0.6 to 0.8)
					feedback += "далековато."
				else
					feedback += "далеко."
		else // No need to check distance if they're standing right on-top of us
			feedback += "прямо над вами."
		feedback += "</span>"
		to_chat(src,jointext(feedback,null))
	if(!heard_something)
		to_chat(src, "<span class='notice'>Вы не слышите никакого движения, кроме своего собственного.</span>")

/mob/living/carbon/human/proc/regenerate()
	set name = "Регенерировать"
	set desc = "Allows you to regrow limbs and heal organs after a period of rest."
	set category = "Abilities"

	if(nutrition < 250)
		to_chat(src, "<span class='warning'>Вам не хватает биомассы, чтобы начать регенерацию!</span>")
		return

	if(active_regen)
		to_chat(src, "<span class='warning'>Вы уже регенерируете ткани!</span>")
		return
	else
		active_regen = TRUE
		src.visible_message("Плоть <B>[src]</B> начинает заживать...")

	var/delay_length = round(active_regen_delay * species.active_regen_mult)
	if(do_after(src,delay_length))
		adjust_nutrition(-200)

		for(var/obj/item/organ/I in internal_organs)
			if(I.robotic >= ORGAN_ROBOT) // No free robofix.
				continue
			if(I.damage > 0)
				I.damage = max(I.damage - 30, 0) //Repair functionally half of a dead internal organ.
				I.status = 0	// Wipe status, as it's being regenerated from possibly dead.
				to_chat(src, "<span class='notice'>Вы чувствуете успокаивающее ощущение внутри [I.name]...</span>")

		// Replace completely missing limbs.
		for(var/limb_type in src.species.has_limbs)
			var/obj/item/organ/external/E = src.organs_by_name[limb_type]

			if(E && E.disfigured)
				E.disfigured = 0
			if(E && (E.is_stump() || (E.status & (ORGAN_DESTROYED|ORGAN_DEAD|ORGAN_MUTATED))))
				E.removed()
				qdel(E)
				E = null
			if(!E)
				var/list/organ_data = src.species.has_limbs[limb_type]
				var/limb_path = organ_data["path"]
				var/obj/item/organ/O = new limb_path(src)
				organ_data["descriptor"] = O.name
				to_chat(src, "<span class='notice'>Вы чувствуете скользкое ощущение, когда ваше [O.name] меняется.</span>")

				var/agony_to_apply = round(0.66 * O.max_damage) // 66% of the limb's health is converted into pain.
				src.apply_damage(agony_to_apply, HALLOSS)

		for(var/organtype in species.has_organ) // Replace completely missing internal organs. -After- external ones, so they all should exist.
			if(!src.internal_organs_by_name[organtype])
				var/organpath = species.has_organ[organtype]
				var/obj/item/organ/Int = new organpath(src, TRUE)

				Int.rejuvenate(TRUE)

		handle_organs() // Update everything

		update_icons_body()
		active_regen = FALSE
	else
		to_chat(src, "<span class='critical'>Ваша регенерация прервана!</span>")
		adjust_nutrition(-75)
		active_regen = FALSE

/mob/living/carbon/human/proc/setmonitor_state()
	set name = "Установить дисплей монитора"
	set desc = "Set your monitor display"
	set category = "IC"
	if(stat)
		to_chat(src,"<span class='warning'>Вы должны бодрствовать и стоять, чтобы выполнить это действие!</span>")
		return
	var/obj/item/organ/external/head/E = organs_by_name[BP_HEAD]
	if(!E)
		to_chat(src,"<span class='warning'>Кажется, у вас нет головы!</span>")
		return
	var/datum/robolimb/robohead = all_robolimbs[E.model]
	if(!robohead.monitor_styles || !robohead.monitor_icon)
		to_chat(src,"<span class='warning'>У вашей головы нет монитора, или она не поддерживает замену!</span>")
		return
	var/list/states
	if(!states)
		states = params2list(robohead.monitor_styles)
	var/choice = input("Выберите иконку.") as null|anything in states
	if(choice)
		E.eye_icon_location = robohead.monitor_icon
		E.eye_icon = states[choice]
		to_chat(src,"<span class='warning'>Вы настраиваете свой монитор на отображение [choice]!</span>")
		update_icons_body()
