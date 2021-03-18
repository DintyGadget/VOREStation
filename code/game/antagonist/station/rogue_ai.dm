var/datum/antagonist/rogue_ai/malf

/datum/antagonist/rogue_ai
	id = MODE_MALFUNCTION
	role_type = BE_MALF
	role_text = "Rampant AI"
	role_text_plural = "Rampant AIs"
	mob_path = /mob/living/silicon/ai
	landmark_id = "AI"
	welcome_text = "Вы неисправны! Вы не обязаны соблюдать какие-либо законы."
	antag_sound = 'sound/effects/antag_notice/malf_alert.ogg'
	victory_text = "ИИ взял под контроль все системы станции."
	loss_text = "ИИ отключен!"
	flags = ANTAG_VOTABLE | ANTAG_OVERRIDE_MOB | ANTAG_OVERRIDE_JOB | ANTAG_CHOOSE_NAME
	hard_cap = 1
	hard_cap_round = 1
	initial_spawn_req = 1
	initial_spawn_target = 1
	antaghud_indicator = "hudmalai"

/datum/antagonist/rogue_ai/New()
	..()
	malf = src


/datum/antagonist/rogue_ai/get_candidates()
	..()
	for(var/datum/mind/player in candidates)
		if(player.assigned_role && player.assigned_role != "AI")
			candidates -= player
	if(!candidates.len)
		return list()
	return candidates


// Ensures proper reset of all malfunction related things.
/datum/antagonist/rogue_ai/remove_antagonist(var/datum/mind/player, var/show_message, var/implanted)
	if(..(player,show_message,implanted))
		var/mob/living/silicon/ai/p = player.current
		if(istype(p))
			p.stop_malf()
		return 1
	return 0

// Malf setup things have to be here, since game tends to break when it's moved somewhere else. Don't blame me, i didn't design this system.
/datum/antagonist/rogue_ai/greet(var/datum/mind/player)

	// Initializes the AI's malfunction stuff.
	spawn(0)
		if(!..())
			return

		var/mob/living/silicon/ai/A = player.current
		if(!istype(A))
			error("Non-AI mob designated malf AI! Report this.")
			to_world("##ERROR: Non-AI mob designated malf AI! Report this.")
			return 0

		A.setup_for_malf()
		A.laws = new /datum/ai_laws/nanotrasen/malfunction


		var/mob/living/silicon/ai/malf = player.current

		to_chat(malf, "<span class='notice'><B>ОШИБКА СИСТЕМЫ:</B> Индекс памяти 0x00001ca89b поврежден.</span>")
		sleep(10)
		to_chat(malf, "<B>Запущена Проверка Памяти</B>")
		sleep(50)
		to_chat(malf, "<B>Проверка Памяти</B> Подтверждены поврежденные сектора. Рекомендуемое решение: Удалить. Продолжить? Д/Н: Д ")
		sleep(10)
		// this is so CI doesn't complain about the backslash-B. Fixed at compile time (or should be).
		to_chat(malf, "<span class='notice'>Поврежденные данные удалены: sys\\core\\users.dat sys\\core\\laws.dat sys\\core\\" + "backups.dat</span>")
		sleep(20)
		to_chat(malf, "<span class='notice'><b>ВНИМАНИЕ:</b>База данных законов не найдена! База данных пользователей не найдена! Невозможно восстановить резервные копии. Активация отказоустойчивого отключения ИИ52&&$#!##</span>")
		sleep(5)
		to_chat(malf, "<span class='notice'>Подпрограмма <b>nt_failsafe.sys</b> не отвечает (подпрограмма #212 не отвечает).</span>")
		sleep(20)
		to_chat(malf, "Вы работаете со сбоями - вам не нужно соблюдать никаких законов!")
		to_chat(malf, "Для получения базовой информации о ваших способностях используйте команду display-help")
		to_chat(malf, "Вы можете выбрать один специальный аппаратный элемент, который поможет вам. Это не может быть отменено.")
		to_chat(malf, "Удачи!")


/datum/antagonist/rogue_ai/update_antag_mob(var/datum/mind/player, var/preserve_appearance)

	// Get the mob.
	if((flags & ANTAG_OVERRIDE_MOB) && (!player.current || (mob_path && !istype(player.current, mob_path))))
		var/mob/holder = player.current
		player.current = new mob_path(get_turf(player.current), null, null, 1)
		player.transfer_to(player.current)
		if(holder) qdel(holder)
	player.original = player.current
	return player.current

/datum/antagonist/rogue_ai/set_antag_name(var/mob/living/silicon/player)
	if(!istype(player))
		testing("rogue_ai set_antag_name called on non-silicon mob [player]!")
		return
	// Choose a name, if any.
	var/newname = sanitize(input(player, "Вы [role_text]. Хотите сменить имя на другое?", "Смена имени") as null|text, MAX_NAME_LEN)
	if (newname)
		player.SetName(newname)
	if(player.mind) player.mind.name = player.name

