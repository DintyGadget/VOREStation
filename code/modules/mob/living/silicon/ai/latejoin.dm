var/global/list/empty_playable_ai_cores = list()

/hook/roundstart/proc/spawn_empty_ai()
	for(var/obj/effect/landmark/start/S in landmarks_list)
		if(S.name != "AI")
			continue
		if(locate(/mob/living) in S.loc)
			continue
		empty_playable_ai_cores += new /obj/structure/AIcore/deactivated(get_turf(S))

	return 1

/mob/living/silicon/ai/verb/store_core()
	set name = "Освободить ядро ИИ"
	set category = "OOC"
	set desc = "Войдите в хранилище ИИ. Это функционально эквивалентно крио или роботизированному хранилищу, освобождая место для работы."

	if(ticker && ticker.mode && ticker.mode.name == "AI malfunction")
		to_chat(usr, "<span class='danger'>Вы не можете использовать этот глагол являясь антагонистом. Если вам нужно уйти, пожалуйста, напишите adminhelp.</span>")
		return

	// Guard against misclicks, this isn't the sort of thing we want happening accidentally
	if(alert("ВНИМАНИЕ: это действие немедленно опустошит ваше ядро и призрак, навсегда удалив вашего персонажа из раунда (аналогично крио и роботизированному хранилищу). Вы полностью уверены, что хотите это сделать?",
					"Store Core", "Нет", "Нет", "Да") != "Да")
		return

	// We warned you.
	empty_playable_ai_cores += new /obj/structure/AIcore/deactivated(loc)
	global_announcer.autosay("[src] перемещен в хранилище ИИ.", "Artificial Intelligence Oversight")

	//Handle job slot/tater cleanup.
	set_respawn_timer()
	clear_client()