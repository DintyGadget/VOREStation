/mob/living/silicon/ai/examine(mob/user)
	. = ..()

	if (src.stat == DEAD)
		. += "<span class='deadsay'>Похоже, [src] отключен.</span>"
	else
		if (src.getBruteLoss())
			if (src.getBruteLoss() < 30)
				. += "<span class='warning'>Выглядит слегка помято.</span>"
			else
				. += "<span class='warning'><B>Выглядит сильно помято!</B></span>"
		if (src.getFireLoss())
			if (src.getFireLoss() < 30)
				. += "<span class='warning'>Выглядит слегка обугленно.</span>"
			else
				. += "<span class='warning'><B>Корпус расплавлен и покороблен!</B></span>"
		if (src.getOxyLoss() && (aiRestorePowerRoutine != 0 && !APU_power))
			if (src.getOxyLoss() > 175)
				. += "<span class='warning'><B>Кажется, [src] работает от резервного питания. На его дисплее мигает предупреждение \"РЕЗЕРВНОЕ ПИТАНИЕ - КРИТИЧЕСКОЕ\".</B></span>"
			else if(src.getOxyLoss() > 100)
				. += "<span class='warning'><B>Кажется, [src] работает от резервного питания. На его дисплее мигает предупреждение \"РЕЗЕРВНОЕ ПИТАНИЕ - НИЗКОЕ\".</B></span>"
			else
				. += "<span class='warning'>Кажется, [src] работает от резервного питания.</span>"

		if (src.stat == UNCONSCIOUS)
			. += "<span class='warning'>Не отвечает и отображает текст: \"RUNTIME: Sensory Overload, stack 26/3\".</span>"

		if(deployed_shell)
			. += "Индикатор беспроводной сети мигает."

	. += "*---------*"

	if(hardware && (hardware.owner == src))
		. += hardware.get_examine_desc()

	user.showLaws(src)

/mob/proc/showLaws(var/mob/living/silicon/S)
	return

/mob/observer/dead/showLaws(var/mob/living/silicon/S)
	if(antagHUD || is_admin(src))
		S.laws.show_laws(src)
