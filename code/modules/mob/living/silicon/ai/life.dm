/mob/living/silicon/ai/Life()
	if (src.stat == DEAD)
		return
	else //I'm not removing that shitton of tabs, unneeded as they are. -- Urist
		//Being dead doesn't mean your temperature never changes
		var/turf/T = get_turf(src)

		if (src.stat != CONSCIOUS)
			src.cameraFollow = null
			src.reset_view(null)
			disconnect_shell("Отключение от удаленной оболочки из-за сбоя локальной системы.")

		src.updatehealth()

		if (!hardware_integrity() || !backup_capacitor())
			death()
			return

		// If our powersupply object was destroyed somehow, create new one.
		if(!psupply)
			create_powersupply()


		// Handle power damage (oxy)
		if(aiRestorePowerRoutine != 0 && !APU_power)
			// Lose power
			adjustOxyLoss(1)
		else
			// Gain Power
			aiRestorePowerRoutine = 0 // Necessary if AI activated it's APU AFTER losing primary power.
			adjustOxyLoss(-1)

		handle_stunned()	// Handle EMP-stun
		lying = 0			// Handle lying down

		malf_process()

		if(APU_power && (hardware_integrity() < 50))
			to_chat(src, "<span class='notice'><b>ОТКАЗ ГЕНЕРАТОРА APU! (Система повреждена)</b></span>")
			stop_apu(1)

		var/blind = 0
		var/area/loc = null
		if (istype(T, /turf))
			loc = T.loc
			if (istype(loc, /area))
				if (!loc.power_equip && !istype(src.loc,/obj/item) && !APU_power)
					blind = 1

		if (!blind)
			src.sight |= SEE_TURFS
			src.sight |= SEE_MOBS
			src.sight |= SEE_OBJS
			src.see_in_dark = 8
			src.see_invisible = SEE_INVISIBLE_LIVING

			if (aiRestorePowerRoutine==2)
				to_chat(src, "Оповещение отменено. Электроэнергия восстановлена без нашей помощи.")
				aiRestorePowerRoutine = 0
				clear_fullscreen("blind")
				updateicon()
				return
			else if (aiRestorePowerRoutine==3)
				to_chat(src, "Оповещение отменено. Электроэнергия восстановлена.")
				aiRestorePowerRoutine = 0
				clear_fullscreen("blind")
				updateicon()
				return
			else if (APU_power)
				aiRestorePowerRoutine = 0
				clear_fullscreen("blind")
				updateicon()
				return
		else
			var/area/current_area = get_area(src)

			if (lacks_power())
				if (aiRestorePowerRoutine==0)
					aiRestorePowerRoutine = 1

					//Blind the AI
					updateicon()
					overlay_fullscreen("blind", /obj/screen/fullscreen/blind)
					src.sight = src.sight&~SEE_TURFS
					src.sight = src.sight&~SEE_MOBS
					src.sight = src.sight&~SEE_OBJS
					src.see_in_dark = 0
					src.see_invisible = SEE_INVISIBLE_LIVING

					//Now to tell the AI why they're blind and dying slowly.

					to_chat(src, "Энергия закончилась!")
					disconnect_shell(message = "Отключен от удаленной оболочки из-за отключенного сетевого интерфейса.")

					spawn(20)
						to_chat(src, "Резервный аккумулятор онлайн. Сканеры, камера и радиоинтерфейс в автономном режиме. Начало поиска неисправностей.")
						end_multicam()
						sleep(50)
						if (loc.power_equip)
							if (!istype(T, /turf/space))
								to_chat(src, "Оповещение отменено. Электроэнергия восстановлена без нашей помощи.")
								aiRestorePowerRoutine = 0
								clear_fullscreen("blind")
								return
						to_chat(src, "Подтвержденная неисправность: отсутствует внешнее питание. Отключение основной системы управления для экономии энергии.")
						sleep(20)
						to_chat(src, "Система аварийного управления онлайн. Проверка подключения к электросети.")
						sleep(50)
						if (istype(T, /turf/space))
							to_chat(src, "Невозможно проверить! Нет подключения к источнику питания!")
							aiRestorePowerRoutine = 2
							return
						to_chat(src, "Подключение проверено. Ищем APC в электросети.")
						sleep(50)
						var/obj/machinery/power/apc/theAPC = null

						var/PRP
						for (PRP=1, PRP<=4, PRP++)
							for (var/obj/machinery/power/apc/APC in current_area)
								if (!(APC.stat & BROKEN))
									theAPC = APC
									break
							if (!theAPC)
								switch(PRP)
									if (1)
										to_chat(src, "Не удалось найти APC!")
									else
										to_chat(src, "Потеряна связь с APC!")
								src:aiRestorePowerRoutine = 2
								return
							if (loc.power_equip)
								if (!istype(T, /turf/space))
									to_chat(src, "Оповещение отменено. Электроэнергия восстановлена без нашей помощи.")
									aiRestorePowerRoutine = 0
									clear_fullscreen("blind") //This, too, is a fix to issue 603
									return
							switch(PRP)
								if (1)
									to_chat(src, "APC расположен. Оптимизация маршрута к APC, чтобы избежать ненужных потерь энергии.")
								if (2)
									to_chat(src, "Определен лучший маршрут. Взлом автономного порта питания APC.")
								if (3)
									to_chat(src, "Доступ к загрузке порта питания подтвержден. Загрузка программы управления в программное обеспечение порта питания APC.")
								if (4)
									to_chat(src, "Перевод завершен. Заставить APC выполнить программу.")
									sleep(50)
									to_chat(src, "Получение управляющей информации от APC.")
									sleep(2)
									theAPC.operating = 1
									theAPC.equipment = 3
									theAPC.update()
									aiRestorePowerRoutine = 3
									to_chat(src, "Вот ваши действующие законы:")
									show_laws()
									updateicon()
							sleep(50)
							theAPC = null

	process_queued_alarms()
	handle_regular_hud_updates()
	handle_vision()

/mob/living/silicon/ai/proc/lacks_power()
	if(APU_power)
		return 0
	var/turf/T = get_turf(src)
	var/area/A = get_area(src)
	return ((!A.power_equip) && A.requires_power == 1 || istype(T, /turf/space)) && !istype(src.loc,/obj/item)

/mob/living/silicon/ai/updatehealth()
	if(status_flags & GODMODE)
		health = 100
		set_stat(CONSCIOUS)
		setOxyLoss(0)
	else
		health = 100 - getFireLoss() - getBruteLoss() // Oxyloss is not part of health as it represents AIs backup power. AI is immune against ToxLoss as it is machine.

/mob/living/silicon/ai/rejuvenate()
	..()
	add_ai_verbs(src)

