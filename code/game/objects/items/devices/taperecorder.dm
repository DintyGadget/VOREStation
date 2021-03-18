/obj/item/device/taperecorder
	name = "диктофон"
	desc = "Прибор для записи на кассеты и их воспроизведения. Имеет встроенный автоматический переводчик."
	icon_state = "taperecorder_empty"
	item_state = "analyzer"
	w_class = ITEMSIZE_SMALL

	matter = list(DEFAULT_WALL_MATERIAL = 60,"glass" = 30)

	var/emagged = 0.0
	var/recording = 0.0
	var/playing = 0.0
	var/playsleepseconds = 0.0
	var/obj/item/device/tape/mytape = /obj/item/device/tape/random
	var/canprint = 1
	slot_flags = SLOT_BELT
	throwforce = 2
	throw_speed = 4
	throw_range = 20

/obj/item/device/taperecorder/New()
	..()
	if(ispath(mytape))
		mytape = new mytape(src)
		update_icon()
	listening_objects += src

/obj/item/device/taperecorder/empty
	mytape = null

/obj/item/device/taperecorder/Destroy()
	listening_objects -= src
	if(mytape)
		qdel(mytape)
		mytape = null
	return ..()


/obj/item/device/taperecorder/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/device/tape))
		if(mytape)
			to_chat(user, "<span class='notice'>Внутри уже есть кассета.</span>")
			return
		if(!user.unEquip(I))
			return
		I.forceMove(src)
		mytape = I
		to_chat(user, "<span class='notice'>Вы вставляете кассету в [src].</span>")
		update_icon()
		return
	..()


/obj/item/device/taperecorder/fire_act()
	if(mytape)
		mytape.ruin() //Fires destroy the tape
	return ..()


/obj/item/device/taperecorder/attack_hand(mob/user)
	if(user.get_inactive_hand() == src)
		if(mytape)
			eject()
			return
	..()


/obj/item/device/taperecorder/verb/eject()
	set name = "Достать Кассету"
	set category = "Object"

	if(usr.incapacitated())
		return
	if(!mytape)
		to_chat(usr, "<span class='notice'>В диктофоне нет кассеты.</span>")
		return
	if(emagged)
		to_chat(usr, "<span class='notice'>В диктофоне заело кассету.</span>")
		return

	if(playing || recording)
		stop()
	to_chat(usr, "<span class='notice'>Вы достаёте [mytape] из диктофона.</span>")
	usr.put_in_hands(mytape)
	mytape = null
	update_icon()


/obj/item/device/taperecorder/hear_talk(mob/M, list/message_pieces, verb)
	var/msg = multilingual_to_message(message_pieces, requires_machine_understands = TRUE, with_capitalization = TRUE)
	if(mytape && recording)
		mytape.record_speech("[M.name] [verb], \"[msg]\"")


/obj/item/device/taperecorder/see_emote(mob/M as mob, text, var/emote_type)
	if(emote_type != 2) //only hearable emotes
		return
	if(mytape && recording)
		mytape.record_speech("[strip_html_properly(text)]")


/obj/item/device/taperecorder/show_message(msg, type, alt, alt_type)
	var/recordedtext
	if (msg && type == 2) //must be hearable
		recordedtext = msg
	else if (alt && alt_type == 2)
		recordedtext = alt
	else
		return
	if(mytape && recording)
		mytape.record_noise("[strip_html_properly(recordedtext)]")

/obj/item/device/taperecorder/emag_act(var/remaining_charges, var/mob/user)
	if(emagged == 0)
		emagged = 1
		recording = 0
		to_chat(user, "<span class='warning'>ПЗЗЗТФФППП</span>")
		update_icon()
		return 1
	else
		to_chat(user, "<span class='warning'>[src] уже емаггнут!</span>")

/obj/item/device/taperecorder/proc/explode()
	var/turf/T = get_turf(loc)
	if(ismob(loc))
		var/mob/M = loc
		to_chat(M, "<span class='danger'>[src] взрывается!</span>")
	if(T)
		T.hotspot_expose(700,125)
		explosion(T, -1, -1, 0, 4)
	qdel(src)
	return

/obj/item/device/taperecorder/verb/record()
	set name = "Начать Запись"
	set category = "Object"

	if(usr.incapacitated())
		return
	if(!mytape)
		to_chat(usr, "<span class='notice'>Внутри нет кассеты!</span>")
		return
	if(mytape.ruined)
		to_chat(usr, "<span class='warning'>Диктофон издает звук царапанья.</span>")
		return
	if(recording)
		to_chat(usr, "<span class='notice'>Вы уже записываете!</span>")
		return
	if(playing)
		to_chat(usr, "<span class='notice'>Вы не можете записывать и проигрывать одновременно!</span>")
		return
	if(emagged)
		to_chat(usr, "<span class='warning'>Диктофон издает звук царапанья.</span>")
		return
	if(mytape.used_capacity < mytape.max_capacity)
		to_chat(usr, "<span class='notice'>Запись начата.</span>")
		recording = 1
		update_icon()

		mytape.record_speech("Запись начата.")

		//count seconds until full, or recording is stopped
		while(mytape && recording && mytape.used_capacity < mytape.max_capacity)
			sleep(10)
			mytape.used_capacity++
			if(mytape.used_capacity >= mytape.max_capacity)
				if(ismob(loc))
					var/mob/M = loc
					to_chat(M, "<span class='notice'>Кассета заполнена.</span>")
				stop_recording()


		update_icon()
		return
	else
		to_chat(usr, "<span class='notice'>Кассета заполнена.</span>")


/obj/item/device/taperecorder/proc/stop_recording()
	//Sanity checks skipped, should not be called unless actually recording
	recording = 0
	update_icon()
	mytape.record_speech("Запись остановлена.")
	if(ismob(loc))
		var/mob/M = loc
		to_chat(M, "<span class='notice'>Запись остановлена.</span>")


/obj/item/device/taperecorder/verb/stop()
	set name = "Остановить Запись"
	set category = "Object"

	if(usr.incapacitated())
		return
	if(recording)
		stop_recording()
		return
	else if(playing)
		playing = 0
		update_icon()
		to_chat(usr, "<span class='notice'>Воспроизведение остановлено.</span>")
		return
	else
		to_chat(usr, "<span class='notice'>Какую запись?</span>")


/obj/item/device/taperecorder/verb/wipe_tape()
	set name = "Стереть Кассету"
	set category = "Object"

	if(usr.incapacitated())
		return
	if(emagged)
		to_chat(usr, "<span class='warning'>Диктофон издает звук царапанья.</span>")
		return
	if(mytape.ruined)
		to_chat(usr, "<span class='warning'>Диктофон издает звук царапанья.</span>")
		return
	if(recording || playing)
		to_chat(usr, "<span class='notice'>Вы не можете стереть кассету во время записи или проигрывания!</span>")
		return
	else
		if(mytape.storedinfo)	mytape.storedinfo.Cut()
		if(mytape.timestamp)	mytape.timestamp.Cut()
		mytape.used_capacity = 0
		to_chat(usr, "<span class='notice'>YВы стираете содержимое кассеты.</span>")
		return


/obj/item/device/taperecorder/verb/playback_memory()
	set name = "Воспроизвести Кассету"
	set category = "Object"

	if(usr.incapacitated())
		return
	if(!mytape)
		to_chat(usr, "<span class='notice'>Внутри нет кассеты!</span>")
		return
	if(mytape.ruined)
		to_chat(usr, "<span class='warning'>Диктофон издает звук царапанья.</span>")
		return
	if(recording)
		to_chat(usr, "<span class='notice'>Вы не можете записывать и проигрывать одновременно!</span>")
		return
	if(playing)
		to_chat(usr, "<span class='notice'>Воспроизведение уже идёт!</span>")
		return
	playing = 1
	update_icon()
	to_chat(usr, "<span class='notice'>Воспроизведение начато.</span>")
	for(var/i=1 , i < mytape.max_capacity , i++)
		if(!mytape || !playing)
			break
		if(mytape.storedinfo.len < i)
			break

		var/turf/T = get_turf(src)
		var/playedmessage = mytape.storedinfo[i]
		if (findtextEx(playedmessage,"*",1,2)) //remove marker for action sounds
			playedmessage = copytext_char(playedmessage,2)
		T.audible_message("<font color=Maroon><B>Диктофон</B>: [playedmessage]</font>")

		if(mytape.storedinfo.len < i+1)
			playsleepseconds = 1
			sleep(10)
			T = get_turf(src)
			T.audible_message("<font color=Maroon><B>Диктофон</B>: Конец записи.</font>")
			break
		else
			playsleepseconds = mytape.timestamp[i+1] - mytape.timestamp[i]

		if(playsleepseconds > 14)
			sleep(10)
			T = get_turf(src)
			T.audible_message("<font color=Maroon><B>Диктофон</B>: Пропускаем [playsleepseconds] секунд молчания.</font>")
			playsleepseconds = 1
		sleep(10 * playsleepseconds)


	playing = 0
	update_icon()

	if(emagged)
		var/turf/T = get_turf(src)
		T.audible_message("<font color=Maroon><B>Диктофон</B>: Этот диктофон самоуничтожится через... Пять.</font>")
		sleep(10)
		T = get_turf(src)
		T.audible_message("<font color=Maroon><B>Диктофон</B>: Четыре.</font>")
		sleep(10)
		T = get_turf(src)
		T.audible_message("<font color=Maroon><B>Диктофон</B>: Три.</font>")
		sleep(10)
		T = get_turf(src)
		T.audible_message("<font color=Maroon><B>Диктофон</B>: Два.</font>")
		sleep(10)
		T = get_turf(src)
		T.audible_message("<font color=Maroon><B>Диктофон</B>: Один.</font>")
		sleep(10)
		explode()


/obj/item/device/taperecorder/verb/print_transcript()
	set name = "Распечатать Транскрипт"
	set category = "Object"

	if(usr.incapacitated())
		return
	if(!mytape)
		to_chat(usr, "<span class='notice'>Внутри нет кассеты!</span>")
		return
	if(mytape.ruined)
		to_chat(usr, "<span class='warning'>Диктофон издает звук царапанья.</span>")
		return
	if(emagged)
		to_chat(usr, "<span class='warning'>Диктофон издает звук царапанья.</span>")
		return
	if(!canprint)
		to_chat(usr, "<span class='notice'>Диктофон не может печатать так быстро!</span>")
		return
	if(recording || playing)
		to_chat(usr, "<span class='notice'>Вы не можете распечатать транскрипт во время записи или воспроизведения!</span>")
		return

	to_chat(usr, "<span class='notice'>Транскрипт распечатан.</span>")
	var/obj/item/weapon/paper/P = new /obj/item/weapon/paper(get_turf(src))
	var/t1 = "<B>Transcript:</B><BR><BR>"
	for(var/i=1,mytape.storedinfo.len >= i,i++)
		var/printedmessage = mytape.storedinfo[i]
		if (findtextEx(printedmessage,"*",1,2)) //replace action sounds
			printedmessage = "\[[time2text(mytape.timestamp[i]*10,"mm:ss")]\] (Неузнаваемый звук)"
		t1 += "[printedmessage]<BR>"
	P.info = t1
	P.name = "Транскрипт"
	canprint = 0
	sleep(300)
	canprint = 1


/obj/item/device/taperecorder/attack_self(mob/user)
	if(recording || playing)
		stop()
	else
		record()


/obj/item/device/taperecorder/update_icon()
	if(!mytape)
		icon_state = "taperecorder_empty"
	else if(recording)
		icon_state = "taperecorder_recording"
	else if(playing)
		icon_state = "taperecorder_playing"
	else
		icon_state = "taperecorder_idle"



/obj/item/device/tape
	name = "кассета"
	desc = "Магнитная кассета, на которую возможно записать десять минут содержимого."
	icon_state = "tape_white"
	item_state = "analyzer"
	w_class = ITEMSIZE_TINY
	matter = list(DEFAULT_WALL_MATERIAL=20, "glass"=5)
	force = 1
	throwforce = 0
	var/max_capacity = 1800
	var/used_capacity = 0
	var/list/storedinfo = new/list()
	var/list/timestamp = new/list()
	var/ruined = 0


/obj/item/device/tape/update_icon()
	overlays.Cut()
	if(ruined)
		overlays += "ribbonoverlay"


/obj/item/device/tape/fire_act()
	ruin()

/obj/item/device/tape/attack_self(mob/user)
	if(!ruined)
		to_chat(user, "<span class='notice'>Вы вытягиваете всю кассету!</span>")
		ruin()


/obj/item/device/tape/proc/ruin()
	ruined = 1
	update_icon()


/obj/item/device/tape/proc/fix()
	ruined = 0
	update_icon()


/obj/item/device/tape/proc/record_speech(text)
	timestamp += used_capacity
	storedinfo += "\[[time2text(used_capacity*10,"mm:ss")]\] [text]"


//shows up on the printed transcript as (Unrecognized sound)
/obj/item/device/tape/proc/record_noise(text)
	timestamp += used_capacity
	storedinfo += "*\[[time2text(used_capacity*10,"mm:ss")]\] [text]"


/obj/item/device/tape/attackby(obj/item/I, mob/user, params)
	if(ruined && I.is_screwdriver())
		to_chat(user, "<span class='notice'>Вы начинаете закручивать ленту кассеты обратно...</span>")
		playsound(src, I.usesound, 50, 1)
		if(do_after(user, 120 * I.toolspeed, target = src))
			to_chat(user, "<span class='notice'>Вы закрутили ленту обратно в кассету.</span>")
			fix()
		return
	else if(istype(I, /obj/item/weapon/pen))
		if(loc == user && !user.incapacitated())
			var/new_name = input(user, "Как бы Вы хотели подписать кассету?", "Подпись кассеты") as null|text
			if(isnull(new_name)) return
			new_name = sanitizeSafe(new_name)
			if(new_name)
				name = "кассета - '[new_name]'"
				to_chat(user, "<span class='notice'>Вы подписываете кассету: '[new_name]'.</span>")
			else
				name = "кассета"
				to_chat(user, "<span class='notice'>Вы зачеркиваете подпись на кассете.</span>")
		return
	..()


//Random colour tapes
/obj/item/device/tape/random/New()
	icon_state = "tape_[pick("white", "blue", "red", "yellow", "purple")]"