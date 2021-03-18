
/client/verb/who_advanced()
	set name = "Кто Играет"
	set category = "OOC"

	var/msg = "<meta charset=\"utf-8\"><b>Игроки на сервере:</b>\n"

	var/list/Lines = list()

	if(holder)
		for(var/client/C in GLOB.clients)
			var/entry = "<meta charset=\"utf-8\"><tr><td>[C.key]"
			if(C.holder && C.holder.fakekey)
				entry += " <i>(as [C.holder.fakekey])</i>"

			entry += "</td><td>"

			if(C.mob.real_name)
				switch(C.mob.stat)
					if(UNCONSCIOUS)
						entry += "<span class='darkgray'><b>Без сознания</b></span>" // these are literally all spans so I can apply .inverted to them because black on dark grey isn't legible

					if(DEAD)
						if(isobserver(C.mob))
							var/mob/observer/dead/O = C.mob
							if(O.started_as_observer)
								entry += "<span class='gray'>Наблюдает</span>"
							else
								entry += "<span class='black'><b>Мёртв</b></span>"

					else
						entry += "<span class='green'>Играет</span>"

				entry += " as [C.mob.real_name]"

			else if(isnewplayer(C.mob))
				entry += "<span class='blue'><b>В лобби</b></span>"

			entry += "</td><td>"

			var/age
			if(isnum(C.player_age))
				age = C.player_age
			else
				age = 0

			if(age <= 1)
				age = "<span class='red'><b>[age]</b></span>"
			else if(age < 10)
				age = "<span class='orange'><b>[age]</b></span>"

			entry += "Age: [age]"
			entry += "</td><td>"

			if(is_special_character(C.mob))
				if(C.mob?.mind?.special_role)
					entry += "<b><span class='red'>[C.mob.mind.special_role]</span></b>"
				else
					entry += "<b><span class='red'>Антагонист</span></b>"

			entry += "</td><td>"

			if(C.is_afk())
				var/seconds = C.last_activity_seconds()
				entry += " (АФК - "
				entry += "[round(seconds / 60)] минут, "
				entry += "[seconds % 60] секунд)"

			entry += "</td><td>"
			entry += " (<A HREF='?_src_=holder;adminmoreinfo=\ref[C.mob]'>?</A>)"
			entry += "</td></tr>"

			Lines += entry
	else
		for(var/client/C in GLOB.clients)
			var/entry = "\t"
			if(C.holder && C.holder.fakekey)
				entry += "[C.holder.fakekey]"
			else
				entry += "[C.key]"
			var/mob/observer/dead/O = C.mob
			if(isobserver(O))
				entry += " - <span class='gray'>Наблюдает</span><br>"
			else if(istype(O,/mob/new_player))
				entry += " - <span class='blue'>В лобби</span><br>"
			else
				entry += " - <span class='green'>Играет</span><br>"

			Lines += entry

	msg += "<table>"
	for(var/line in sortList(Lines))
		msg += "[line]"
	msg += "</table>"
	msg += "<b>Всего игроков: [length(Lines)]</b>"
	msg = "<span class='filter_info'>" + msg + "</span>"
	to_chat(src, msg)
