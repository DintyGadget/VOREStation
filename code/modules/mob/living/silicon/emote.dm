/mob/living/silicon/emote(var/act, var/m_type = 1,var/message = null)
	var/param = null
	if(findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)

	if(findtext(act, "s", -1) && !findtext(act, "_", -2))//Removes ending s's unless they are prefixed with a '_'
		act = copytext(act, 1, length(act))

	switch(act)
		if("beep")
			var/M = null
			if(param)
				for (var/mob/A in view(null, null))
					if (param == A.name)
						M = A
						break
			if(!M)
				param = null

			if (param)
				message = "<b>[src]</b> пищит [param]."
			else
				message = "<b>[src]</b> пищит."
			playsound(src, 'sound/machines/twobeep.ogg', 50, 0)
			m_type = 1

		if("ping")
			var/M = null
			if(param)
				for (var/mob/A in view(null, null))
					if (param == A.name)
						M = A
						break
			if(!M)
				param = null

			if (param)
				message = "<b>[src]</b> пингует [param]."
			else
				message = "<b>[src]</b> пингует."
			playsound(src, 'sound/machines/ping.ogg', 50, 0)
			m_type = 1

		if("buzz")
			var/M = null
			if(param)
				for (var/mob/A in view(null, null))
					if (param == A.name)
						M = A
						break
			if(!M)
				param = null

			if (param)
				message = "<b>[src]</b> жужжит [param]."
			else
				message = "<b>[src]</b> жужжит."
			playsound(src, 'sound/machines/buzz-sigh.ogg', 50, 0)
			m_type = 1

		if("yes", "ye")
			var/M = null
			if(param)
				for (var/mob/A in view(null, null))
					if (param == A.name)
						M = A
						break
			if(!M)
				param = null

			if (param)
				message = "<b>[src]</b> издает утвердительный сигнал [param]."
			else
				message = "<b>[src]</b> издает утвердительный сигнал."
			playsound(src, 'sound/machines/synth_yes.ogg', 50, 0)
			m_type = 1

		if("dwoop")
			var/M = null
			if(param)
				for (var/mob/A in view(null, null))
					M = A
					break
			if(!M)
				param = null

			if (param)
				message = "<b>[src]</b> радостно щебечет [param]"
			else
				message = "<b>[src]</b> радостно щебечет."
			playsound(src, 'sound/machines/dwoop.ogg', 50, 0)
			m_type = 1

		if("no")
			var/M = null
			if(param)
				for (var/mob/A in view(null, null))
					if (param == A.name)
						M = A
						break
			if(!M)
				param = null

			if (param)
				message = "<b>[src]</b> издает отрицательный сигнал [param]."
			else
				message = "<b>[src]</b> издает отрицательный сигнал."
			playsound(src, 'sound/machines/synth_no.ogg', 50, 0)
			m_type = 1

	..(act, m_type, message)