// Medbot Info

#define MEDBOT_PANIC_NONE	0
#define MEDBOT_PANIC_LOW	15
#define MEDBOT_PANIC_MED	35
#define MEDBOT_PANIC_HIGH	55
#define MEDBOT_PANIC_FUCK	70
#define MEDBOT_PANIC_ENDING	90
#define MEDBOT_PANIC_END	100

#define MEDBOT_MIN_INJECTION 5
#define MEDBOT_MAX_INJECTION 15
#define MEDBOT_MIN_HEAL 0.1
#define MEDBOT_MAX_HEAL 75

/mob/living/bot/medbot
	name = "Medibot"
	desc = "A little medical robot. He looks somewhat underwhelmed."
	icon_state = "medibot0"
	req_one_access = list(access_robotics, access_medical)
	botcard_access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics)

	var/skin = null //Set to "tox", "ointment" or "o2" for the other two firstaid kits.

	//AI vars
	var/last_newpatient_speak = 0
	var/vocal = 1

	//Healing vars
	var/obj/item/weapon/reagent_containers/glass/reagent_glass = null //Can be set to draw from this for reagents.
	var/injection_amount = 15 //How much reagent do we inject at a time?
	var/heal_threshold = 10 //Start healing when they have this much damage in a category
	var/use_beaker = 0 //Use reagents in beaker instead of default treatment agents.
	var/treatment_brute = "tricordrazine"
	var/treatment_oxy = "tricordrazine"
	var/treatment_fire = "tricordrazine"
	var/treatment_tox = "tricordrazine"
	var/treatment_virus = "spaceacillin"
	var/treatment_emag = "toxin"
	var/declare_treatment = 0 //When attempting to treat a patient, should it notify everyone wearing medhuds?

	// Are we tipped over?
	var/is_tipped = FALSE
	//How panicked we are about being tipped over (why would you do this?)
	var/tipped_status = MEDBOT_PANIC_NONE
	//The name we got when we were tipped
	var/tipper_name
	//The last time we were tipped/righted and said a voice line, to avoid spam
	var/last_tipping_action_voice = 0

/mob/living/bot/medbot/mysterious
	name = "\improper Mysterious Medibot"
	desc = "International Medibot of mystery."
	skin = "bezerk"
	treatment_brute		= "bicaridine"
	treatment_fire		= "dermaline"
	treatment_oxy		= "dexalin"
	treatment_tox		= "anti_toxin"

/mob/living/bot/medbot/handleIdle()
	if(is_tipped) // Don't handle idle things if we're incapacitated!
		return

	if(vocal && prob(1))
		var/message_options = list(
			"Радар, надень маску!" = 'sound/voice/medbot/mradar.ogg',
			"Во всем есть подвох, и это лучшее, что есть на свете." = 'sound/voice/medbot/mcatch.ogg',
			"Я всегда знал что, должен был стать пластическим хирургом." = 'sound/voice/medbot/msurgeon.ogg',
			"Что это за МедОтсек? Все дохнут как мухи." = 'sound/voice/medbot/mflies.ogg',
			"Деликатес!" = 'sound/voice/medbot/mdelicious.ogg'
			)
		var/message = pick(message_options)
		say(message)
		playsound(src, message_options[message], 50, 0)

/mob/living/bot/medbot/handleAdjacentTarget()
	if(is_tipped) // Don't handle targets if we're incapacitated!
		return

	UnarmedAttack(target)

/mob/living/bot/medbot/handlePanic()	// Speed modification based on alert level.
	. = 0
	switch(get_security_level())
		if("green")
			. = 0

		if("yellow")
			. = 0

		if("violet")
			. = 1

		if("orange")
			. = 0

		if("blue")
			. = 1

		if("red")
			. = 2

		if("delta")
			. = 2

	return .

/mob/living/bot/medbot/lookForTargets()
	if(is_tipped) // Don't look for targets if we're incapacitated!
		return

	for(var/mob/living/carbon/human/H in view(7, src)) // Time to find a patient!
		if(confirmTarget(H))
			target = H
			if(last_newpatient_speak + 30 SECONDS < world.time)
				if(vocal)
					var/message_options = list(
						"Эй, [H.name]! Держись, Я иду." = 'sound/voice/medbot/mcoming.ogg',
						"Подожди [H.name]! Я иду на помощь!" = 'sound/voice/medbot/mhelp.ogg',
						"[H.name], кажется вы ранены!" = 'sound/voice/medbot/minjured.ogg'
						)
					var/message = pick(message_options)
					say(message)
					playsound(src, message_options[message], 50, 0)
				custom_emote(1, "points at [H.name].")
				last_newpatient_speak = world.time
			break

/mob/living/bot/medbot/UnarmedAttack(var/mob/living/carbon/human/H)
	if(!..())
		return

	if(!on)
		return

	if(!istype(H))
		return

	if(busy)
		return

	var/t = confirmTarget(H)
	if(!t)
		return

	visible_message("<span class='warning'>[src] пытается ввести [H]!</span>")
	if(declare_treatment)
		var/area/location = get_area(src)
		global_announcer.autosay("[src] лечит <b>[H]</b> in <b>[location]</b>", "[src]", "Medical")
	busy = 1
	update_icons()
	if(do_mob(src, H, 30))
		if(t == 1)
			reagent_glass.reagents.trans_to_mob(H, injection_amount, CHEM_BLOOD)
		else
			H.reagents.add_reagent(t, injection_amount)
		visible_message("<span class='warning'>[src] вводит [H] шприцем!</span>")

	if(H.stat == DEAD) // This is down here because this proc won't be called again due to losing a target because of parent AI loop.
		target = null
		if(vocal)
			var/death_messages = list(
				"Нет! Останься со мной!" = 'sound/voice/medbot/mno.ogg',
				"Живи, черт возьми! ЖИВИ!" = 'sound/voice/medbot/mlive.ogg',
				"Я ... я никогда раньше не терял пациента. Я имею в виду, не сегодня." = 'sound/voice/medbot/mlost.ogg'
				)
			var/message = pick(death_messages)
			say(message)
			playsound(src, death_messages[message], 50, 0)

	// This is down here for the same reason as above.
	else
		t = confirmTarget(H)
		if(!t)
			target = null
			if(vocal)
				var/possible_messages = list(
					"Все залатано!" = 'sound/voice/medbot/mpatchedup.ogg',
					"Советую есть по яблочку в день." = 'sound/voice/medbot/mapple.ogg',
					"Поправляйся!" = 'sound/voice/medbot/mfeelbetter.ogg'
					)
				var/message = pick(possible_messages)
				say(message)
				playsound(src, possible_messages[message], 50, 0)

	busy = 0
	update_icons()

/mob/living/bot/medbot/update_icons()
	overlays.Cut()
	if(skin)
		overlays += image('icons/obj/aibots.dmi', "medskin_[skin]")
	if(busy)
		icon_state = "medibots"
	else
		icon_state = "medibot[on]"

/mob/living/bot/medbot/attack_hand(mob/living/carbon/human/H)
	if(H.a_intent == I_DISARM && !is_tipped)
		H.visible_message("<span class='danger'>[H] начинает опрокидывать [src].</span>", "<span class='warning'>Вы начинаете опрокидывать [src] ...</span>")

		if(world.time > last_tipping_action_voice + 15 SECONDS)
			last_tipping_action_voice = world.time // message for tipping happens when we start interacting, message for righting comes after finishing
			var/list/messagevoice = list("Эй, подожди..." = 'sound/voice/medbot/hey_wait.ogg',"Пожалуйста, не..." = 'sound/voice/medbot/please_dont.ogg',"Я тебе доверял..." = 'sound/voice/medbot/i_trusted_you.ogg', "Нееет..." = 'sound/voice/medbot/nooo.ogg', "Вот блядь-" = 'sound/voice/medbot/oh_fuck.ogg')
			var/message = pick(messagevoice)
			say(message)
			playsound(src, messagevoice[message], 70, FALSE)

		if(do_after(H, 3 SECONDS, target=src))
			tip_over(H)

	else if(H.a_intent == I_HELP && is_tipped)
		H.visible_message("<span class='notice'>[H] начинает исправлять [src].</span>", "<span class='notice'>Вы начинаете исправлять [src]...</span>")
		if(do_after(H, 3 SECONDS, target=src))
			set_right(H)
	else
		tgui_interact(H)

/mob/living/bot/medbot/tgui_data(mob/user, datum/tgui/ui, datum/tgui_state/state)
	var/list/data = ..()
	data["on"] = on
	data["open"] = open
	data["beaker"] = FALSE
	if(reagent_glass)
		data["beaker"] = TRUE
		data["beaker_total"] = reagent_glass.reagents.total_volume
		data["beaker_max"] = reagent_glass.reagents.maximum_volume
	data["locked"] = locked
	data["heal_threshold"] = null
	data["heal_threshold_max"] = MEDBOT_MAX_HEAL
	data["injection_amount_min"] = MEDBOT_MIN_INJECTION
	data["injection_amount"] = null
	data["injection_amount_max"] = MEDBOT_MAX_INJECTION
	data["use_beaker"] = null
	data["declare_treatment"] = null
	data["vocal"] = null
	if(!locked || issilicon(user))
		data["heal_threshold"] = heal_threshold
		data["injection_amount"] = injection_amount
		data["use_beaker"] = use_beaker
		data["declare_treatment"] = declare_treatment
		data["vocal"] = vocal
	return data

/mob/living/bot/medbot/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Medbot", name)
		ui.open()

/mob/living/bot/medbot/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/weapon/reagent_containers/glass))
		if(locked)
			to_chat(user, "<span class='notice'>Вы не можете вставить емкость, потому что панель заблокирована.</span>")
			return
		if(!isnull(reagent_glass))
			to_chat(user, "<span class='notice'>Емкость уже установлена.</span>")
			return

		user.drop_item()
		O.loc = src
		reagent_glass = O
		to_chat(user, "<span class='notice'>Вы вставляете [O].</span>")
		return
	else
		..()

/mob/living/bot/medbot/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	usr.set_machine(src)
	add_fingerprint(usr)

	. = TRUE
	switch(action)
		if("power")
			if(!access_scanner.allowed(usr))
				return FALSE
			if(on)
				turn_off()
			else
				turn_on()

	if(locked && !issilicon(usr))
		return TRUE

	switch(action)
		if("adj_threshold")
			heal_threshold = clamp(text2num(params["val"]), MEDBOT_MIN_HEAL, MEDBOT_MAX_HEAL)
			. = TRUE

		if("adj_inject")
			injection_amount = clamp(text2num(params["val"]), MEDBOT_MIN_INJECTION, MEDBOT_MAX_INJECTION)
			. = TRUE

		if("use_beaker")
			use_beaker = !use_beaker
			. = TRUE

		if("eject")
			if(reagent_glass)
				reagent_glass.forceMove(get_turf(src))
				reagent_glass = null
			. = TRUE

		if("togglevoice")
			vocal = !vocal
			. = TRUE

		if("declaretreatment")
			declare_treatment = !declare_treatment
			. = TRUE

/mob/living/bot/medbot/emag_act(var/remaining_uses, var/mob/user)
	. = ..()
	if(!emagged)
		if(user)
			to_chat(user, "<span class='warning'>Вы замыкаете цепи синтеза реагентов [src].</span>")
		visible_message("<span class='warning'>[src] странно гудит!</span>")
		flick("medibot_spark", src)
		target = null
		busy = 0
		emagged = 1
		on = 1
		update_icons()
		. = 1
	ignore_list |= user

/mob/living/bot/medbot/explode()
	on = 0
	visible_message("<span class='danger'>[src] разлетается на части!</span>")
	var/turf/Tsec = get_turf(src)

	new /obj/item/weapon/storage/firstaid(Tsec)
	new /obj/item/device/assembly/prox_sensor(Tsec)
	new /obj/item/device/healthanalyzer(Tsec)
	if (prob(50))
		new /obj/item/robot_parts/l_arm(Tsec)

	if(reagent_glass)
		reagent_glass.loc = Tsec
		reagent_glass = null

	if(emagged && prob(25))
		playsound(src, 'sound/voice/medbot/minsult.ogg', 50, 0)

	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	qdel(src)
	return

/mob/living/bot/medbot/handleRegular()
	. = ..()

	if(is_tipped)
		handle_panic()
		return

/mob/living/bot/medbot/proc/tip_over(mob/user)
	playsound(src, 'sound/machines/warning-buzzer.ogg', 50)
	user.visible_message("<span class='danger'>[user] опрокидывает [src]!</span>", "<span class='danger'>Вы опрокидываете [src]!</span>")
	is_tipped = TRUE
	tipper_name = user.name
	var/matrix/mat = transform
	transform = mat.Turn(180)

/mob/living/bot/medbot/proc/set_right(mob/user)
	var/list/messagevoice
	if(user)
		user.visible_message("<span class='notice'>[user] sets [src] right-side up!</span>", "<span class='green'>You set [src] right-side up!</span>")
		if(user.name == tipper_name)
			messagevoice = list("Я прощаю вас." = 'sound/voice/medbot/forgive.ogg')
		else
			messagevoice = list("Спасибо!" = 'sound/voice/medbot/thank_you.ogg', "You are a good person." = 'sound/voice/medbot/youre_good.ogg')
	else
		visible_message("<span class='notice'>[src] manages to [pick("writhe", "wriggle", "wiggle")] enough to right itself.</span>")
		messagevoice = list("Пошел нахуй." = 'sound/voice/medbot/fuck_you.ogg', "О вашем поведении сообщили, хорошего дня." = 'sound/voice/medbot/reported.ogg')

	tipper_name = null
	if(world.time > last_tipping_action_voice + 15 SECONDS)
		last_tipping_action_voice = world.time
		var/message = pick(messagevoice)
		say(message)
		playsound(src, messagevoice[message], 70)
	tipped_status = MEDBOT_PANIC_NONE
	is_tipped = FALSE
	transform = matrix()

// if someone tipped us over, check whether we should ask for help or just right ourselves eventually
/mob/living/bot/medbot/proc/handle_panic()
	tipped_status++
	var/list/messagevoice
	switch(tipped_status)
		if(MEDBOT_PANIC_LOW)
			messagevoice = list("Мне нужна помощь." = 'sound/voice/medbot/i_require_asst.ogg')
		if(MEDBOT_PANIC_MED)
			messagevoice = list("Пожалуйста, поставьте меня на место" = 'sound/voice/medbot/please_put_me_back.ogg')
		if(MEDBOT_PANIC_HIGH)
			messagevoice = list("Пожалуйста, мне страшно!" = 'sound/voice/medbot/please_im_scared.ogg')
		if(MEDBOT_PANIC_FUCK)
			messagevoice = list("Мне это не нравится, мне нужна помощь!" = 'sound/voice/medbot/dont_like.ogg', "Это больно, моя боль настоящая!" = 'sound/voice/medbot/pain_is_real.ogg')
		if(MEDBOT_PANIC_ENDING)
			messagevoice = list("Это конец?" = 'sound/voice/medbot/is_this_the_end.ogg', "Неееет!" = 'sound/voice/medbot/nooo.ogg')
		if(MEDBOT_PANIC_END)
			global_announcer.autosay("ПСИХИЧЕСКОЕ ПРЕДУПРЕЖДЕНИЕ: член экипажа [tipper_name] записал демонстрацию антиобщественных действий, а именно пытку ботов в [get_area(src)]. Проведите психологическую оценку.", "[src]", "Medical")
			set_right() // strong independent medbot

	// if(prob(tipped_status)) // Commented out pending introduction of jitter stuff from /tg/
		// do_jitter_animation(tipped_status * 0.1)

	if(messagevoice)
		var/message = pick(messagevoice)
		say(message)
		playsound(src, messagevoice[message], 70)
	else if(prob(tipped_status * 0.2))
		playsound(src, 'sound/machines/warning-buzzer.ogg', 30, extrarange=-2)

/mob/living/bot/medbot/examine(mob/user)
	. = ..()
	if(tipped_status == MEDBOT_PANIC_NONE)
		return

	switch(tipped_status)
		if(MEDBOT_PANIC_NONE to MEDBOT_PANIC_LOW)
			. += "Кажется, что он перевернулся и спокойно ждет, чтобы кто-то его исправил."
		if(MEDBOT_PANIC_LOW to MEDBOT_PANIC_MED)
			. += "Он опрокидывается и просит помощи."
		if(MEDBOT_PANIC_MED to MEDBOT_PANIC_HIGH)
			. += "Он опрокидывается и выглядит обеспокоенными." // now we humanize the medbot as a they, not an it
		if(MEDBOT_PANIC_HIGH to MEDBOT_PANIC_FUCK)
			. += "<span class='warning'>Он опрокинут и явно запаниковал!</span>"
		if(MEDBOT_PANIC_FUCK to INFINITY)
			. += "<span class='warning'><b>Он в ужасе от того, что его опрокинули!</b></span>"

/mob/living/bot/medbot/confirmTarget(var/mob/living/carbon/human/H)
	if(!..())
		return 0

	if(H.isSynthetic()) // Don't treat FBPs
		return 0

	if(H.stat == DEAD) // He's dead, Jim
		return 0

	if(H.suiciding)
		return 0

	if(emagged)
		return treatment_emag

	// If they're injured, we're using a beaker, and they don't have on of the chems in the beaker
	if(reagent_glass && use_beaker && ((H.getBruteLoss() >= heal_threshold) || (H.getToxLoss() >= heal_threshold) || (H.getToxLoss() >= heal_threshold) || (H.getOxyLoss() >= (heal_threshold + 15))))
		for(var/datum/reagent/R in reagent_glass.reagents.reagent_list)
			if(!H.reagents.has_reagent(R))
				return 1
			continue

	if((H.getBruteLoss() >= heal_threshold) && (!H.reagents.has_reagent(treatment_brute)))
		return treatment_brute //If they're already medicated don't bother!

	if((H.getOxyLoss() >= (15 + heal_threshold)) && (!H.reagents.has_reagent(treatment_oxy)))
		return treatment_oxy

	if((H.getFireLoss() >= heal_threshold) && (!H.reagents.has_reagent(treatment_fire)))
		return treatment_fire

	if((H.getToxLoss() >= heal_threshold) && (!H.reagents.has_reagent(treatment_tox)))
		return treatment_tox

/* Construction */

/obj/item/weapon/storage/firstaid/attackby(var/obj/item/robot_parts/S, mob/user as mob)
	if ((!istype(S, /obj/item/robot_parts/l_arm)) && (!istype(S, /obj/item/robot_parts/r_arm)))
		..()
		return

	if(contents.len >= 1)
		to_chat(user, "<span class='notice'>Сначала вам нужно опустошить [src].</span>")
		return

	var/obj/item/weapon/firstaid_arm_assembly/A = new /obj/item/weapon/firstaid_arm_assembly
	if(istype(src, /obj/item/weapon/storage/firstaid/fire))
		A.skin = "ointment"
	else if(istype(src, /obj/item/weapon/storage/firstaid/toxin))
		A.skin = "tox"
	else if(istype(src, /obj/item/weapon/storage/firstaid/o2))
		A.skin = "o2"

	qdel(S)
	user.put_in_hands(A)
	to_chat(user, "<span class='notice'>Вы добавляете руку робота в аптечку.</span>")
	user.drop_from_inventory(src)
	qdel(src)

/obj/item/weapon/storage/firstaid/attackby(var/obj/item/organ/external/S, mob/user as mob)
	if (!istype(S, /obj/item/organ/external/arm) || S.robotic != ORGAN_ROBOT)
		..()
		return

	if(contents.len >= 1)
		to_chat(user, "<span class='notice'>Сначала вам нужно опустошить [src].</span>")
		return

	var/obj/item/weapon/firstaid_arm_assembly/A = new /obj/item/weapon/firstaid_arm_assembly
	if(istype(src, /obj/item/weapon/storage/firstaid/fire))
		A.skin = "ointment"
	else if(istype(src, /obj/item/weapon/storage/firstaid/toxin))
		A.skin = "tox"
	else if(istype(src, /obj/item/weapon/storage/firstaid/o2))
		A.skin = "o2"

	qdel(S)
	user.put_in_hands(A)
	to_chat(user, "<span class='notice'>Вы добавляете руку робота в аптечку.</span>")
	user.drop_from_inventory(src)
	qdel(src)

/obj/item/weapon/firstaid_arm_assembly
	name = "first aid/robot arm assembly"
	desc = "Аптечка, к которой постоянно прикреплена рука робота."
	icon = 'icons/obj/aibots.dmi'
	icon_state = "firstaid_arm"
	var/build_step = 0
	var/created_name = "Medibot" //To preserve the name if it's a unique medbot I guess
	var/skin = null //Same as medbot, set to tox or ointment for the respective kits.
	w_class = ITEMSIZE_NORMAL

/obj/item/weapon/firstaid_arm_assembly/Initialize()
	. = ..()
	if(skin)
		overlays += image('icons/obj/aibots.dmi', "kit_skin_[src.skin]")

/obj/item/weapon/firstaid_arm_assembly/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(istype(W, /obj/item/weapon/pen))
		var/t = sanitizeSafe(input(user, "Введите новое имя", name, created_name), MAX_NAME_LEN)
		if(!t)
			return
		if(!in_range(src, usr) && loc != usr)
			return
		created_name = t
	else
		switch(build_step)
			if(0)
				if(istype(W, /obj/item/device/healthanalyzer))
					user.drop_item()
					qdel(W)
					build_step++
					to_chat(user, "<span class='notice'>Вы добавляете датчик здоровья в [src].</span>")
					name = "First aid/robot arm/health analyzer assembly"
					overlays += image('icons/obj/aibots.dmi', "na_scanner")

			if(1)
				if(isprox(W))
					user.drop_item()
					qdel(W)
					to_chat(user, "<span class='notice'>Вы завершили Medibot! Бип-буп.</span>")
					var/turf/T = get_turf(src)
					var/mob/living/bot/medbot/S = new /mob/living/bot/medbot(T)
					S.skin = skin
					S.name = created_name
					user.drop_from_inventory(src)
					qdel(src)

// Undefine these.
#undef MEDBOT_PANIC_NONE
#undef MEDBOT_PANIC_LOW
#undef MEDBOT_PANIC_MED
#undef MEDBOT_PANIC_HIGH
#undef MEDBOT_PANIC_FUCK
#undef MEDBOT_PANIC_ENDING
#undef MEDBOT_PANIC_END
