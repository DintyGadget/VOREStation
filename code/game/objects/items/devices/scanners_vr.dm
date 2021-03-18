var/global/mob/living/carbon/human/dummy/mannequin/sleevemate_mob

//SleeveMate!
/obj/item/device/sleevemate
	name = "\improper SleeveMate 3700"
	desc = "Портативный инструмент для управления конвертами для выполнения одноразовых резервных копий и управления состояниями разума."
	icon = 'icons/obj/device_alt.dmi'
	icon_state = "sleevemate"
	item_state = "healthanalyzer"
	slot_flags = SLOT_BELT
	throwforce = 3
	w_class = ITEMSIZE_SMALL
	throw_speed = 5
	throw_range = 10
	matter = list(DEFAULT_WALL_MATERIAL = 200)
	origin_tech = list(TECH_MAGNET = 2, TECH_BIO = 2)

	var/datum/mind/stored_mind

	var/ooc_notes = null //For holding prefs



//These don't perform any checks and need to be wrapped by checks
/obj/item/device/sleevemate/proc/clear_mind()
	stored_mind = null
	ooc_notes = null
	update_icon()

/obj/item/device/sleevemate/proc/get_mind(mob/living/M)
	ASSERT(M.mind)
	ooc_notes = M.ooc_notes
	stored_mind = M.mind
	M.ghostize()
	stored_mind.current = null
	update_icon()

/obj/item/device/sleevemate/proc/put_mind(mob/living/M)
	stored_mind.active = TRUE
	stored_mind.transfer_to(M)
	M.ooc_notes = ooc_notes
	clear_mind()



/obj/item/device/sleevemate/attack(mob/living/M, mob/living/user)
	// Gather potential subtargets
	var/list/choices = list(M)
	if(istype(M))
		for(var/belly in M.vore_organs)
			var/obj/belly/B = belly
			for(var/mob/living/carbon/human/H in B) // I do want an istype
				choices += H
	// Subtargets
	if(choices.len > 1)
		var/mob/living/new_M = input(user, "Неоднозначная цель. Пожалуйста, подтвердите цель:", "Target Validation", M) as null|anything in choices
		if(!new_M || !M.Adjacent(user))
			return
		M = new_M

	if(ishuman(M))
		scan_mob(M, user)
	else
		to_chat(user,"<span class='warning'>Несовместимый предмет для работы!</span>")

/obj/item/device/sleevemate/attack_self(mob/living/user)
	if(!stored_mind)
		to_chat(user,"<span class='warning'>В [src] нет сохраненного разума..</span>")
		return

	var/choice = alert(user,"Что вы хотите сделать?","Сохранено: [stored_mind.name]","Удалить","Резерв","Отмена")
	if(!stored_mind || user.get_active_hand() != src)
		return
	switch(choice)
		if("Удалить")
			to_chat(user,"<span class='notice'>Внутренняя копия [stored_mind.name] удалена.</span>")
			clear_mind()
		if("Резерв")
			to_chat(user,"<span class='notice'>Внутренняя копия [stored_mind.name] зарезервирована в базу данных.</span>")
			SStranscore.m_backup(stored_mind,null,one_time = TRUE)
		if("Отмена")
			return

/obj/item/device/sleevemate/proc/scan_mob(mob/living/carbon/human/H, mob/living/user)
	var/output = "<meta charset=\"utf-8\">"

	output += "<br><br><span class='notice'><b>Результаты сканирования [src.name]</b></span><br>"

	//Mind name
	output += "<b>Sleeved Mind:</b> "
	if(H.mind)
		output += "[H.mind.name]<br>"
	else
		output += "<span class='warning'>Неизвестно/Нет</span><br>"

	//Mind status
	output += "<b>Состояние разума:</b> "
	if(H.client)
		output += "Здоров<br>"
	else
		output += "Расстройство космического сна<br>"

	//Body status
	output += "<b>Sleeve Status:</b> "
	switch(H.stat)
		if(CONSCIOUS)
			output += "Жив<br>"
		if(UNCONSCIOUS)
			output += "Без сознания<br>"
		if(DEAD)
			output += "<span class='warning'>СМЕРТЬ</span><br>"
		else
			output += "<span class='warning'>Неизвестно</span><br>"

	//Mind/body comparison
	output += "<b>Sleeve Pair:</b> "
	if(!H.ckey)
		output += "<span class='warning'>В этом теле нет разума </span> [stored_mind != null ? "\[<a href='?src=\ref[src];target=\ref[H];mindupload=1'>Загрузить</a>\]" : null]<br>"
	else if(H.mind && ckey(H.mind.key) != H.ckey)
		output += "<span class='warning'>Может быть не правильное тело</span><br>"
	else if(H.mind && ckey(H.mind.key) == H.ckey)
		output += "Кажется, что это правильный разум в теле<br>"
	else
		output += "Невозможно провести сравнение<br>"

	//Actions
	output += "<br><b>-- Возможные действия --</b><br>"
	output += "<b>Mind-Scan (один раз): </b>\[<a href='?src=\ref[src];target=\ref[H];mindscan=1'>Выполнить</a>\]<br>"
	output += "<b>Body-Scan (один раз): </b>\[<a href='?src=\ref[src];target=\ref[H];bodyscan=1'>Выполнить</a>\]<br>"

	//Saving a mind
	output += "<b>Store Full Mind: </b>"
	if(stored_mind)
		output += "<span class='notice'>Уже сохранено</span> ([stored_mind.name])<br>"
	else if(H.mind)
		output += "\[<a href='?src=\ref[src];target=\ref[H];mindsteal=1'>Выполнить</a>\]<br>"
	else
		output += "<span class='warning'>Невозможно</span><br>"

	//Soulcatcher transfer
	if(H.nif)
		var/datum/nifsoft/soulcatcher/SC = H.nif.imp_check(NIF_SOULCATCHER)
		if(SC)
			output += "<br>"
			output += "<b>Soulcatcher detected ([SC.brainmobs.len] minds)</b><br>"
			for(var/mob/living/carbon/brain/caught_soul/mind in SC.brainmobs)
				output += "<i>[mind.name]: </i> [mind.transient == FALSE ? "\[<a href='?src=\ref[src];target=\ref[H];mindrelease=[mind.name]'>Load</a>\]" : "<span class='warning'>Incompatible</span>"]<br>"

			if(stored_mind)
				output += "<b>Store in Soulcatcher: </b>\[<a href='?src=\ref[src];target=\ref[H];mindput=1'>Выполнить</a>\]<br>"

	to_chat(user,output)

/obj/item/device/sleevemate/Topic(href, href_list)
	usr.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)

	//Sanity checking/href-hacking checking
	if(usr.get_active_hand() != src)
		to_chat(usr,"<span class='warning'>You're not holding \the [src].</span>")
		return

	var/target_ref = href_list["target"]
	var/mob/living/target = locate(target_ref) in mob_list
	if(!target)
		to_chat(usr,"<span class='warning'>Невозможно воздействовать на эту цель.</span>")
		return

	if(!usr.Adjacent(target))
		to_chat(usr,"<span class='warning'>Вы слишком далеко от этой цели.</span>")
		return

	//The actual options
	if(href_list["mindscan"])
		if(!target.mind || target.mind.name in prevent_respawns)
			to_chat(usr,"<span class='warning'>Цель кажется полностью мертвой.</span>")
			return

		var/nif
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			nif = H.nif
			persist_nif_data(H)

		usr.visible_message("[usr] begins scanning [target]'s mind.","<span class='notice'>You begin scanning [target]'s mind.</span>")
		if(do_after(usr,8 SECONDS,target))
			SStranscore.m_backup(target.mind,nif,one_time = TRUE)
			to_chat(usr,"<span class='notice'>Mind backed up!</span>")
		else
			to_chat(usr,"<span class='warning'>You must remain close to your target!</span>")

		return

	if(href_list["bodyscan"])
		if(!ishuman(target))
			to_chat(usr,"<span class='warning'>Target is not of an acceeptable body type.</span>")
			return

		var/mob/living/carbon/human/H = target

		usr.visible_message("[usr] begins scanning [target]'s body.","<span class='notice'>You begin scanning [target]'s body.</span>")
		if(do_after(usr,8 SECONDS,target))
			var/datum/transhuman/body_record/BR = new()
			BR.init_from_mob(H, TRUE, TRUE)
			to_chat(usr,"<span class='notice'>Body scanned!</span>")
		else
			to_chat(usr,"<span class='warning'>You must remain close to your target!</span>")

		return

	if(href_list["mindsteal"])
		if(!target.mind || target.mind.name in prevent_respawns)
			to_chat(usr,"<span class='warning'>Target seems totally braindead.</span>")
			return

		if(stored_mind)
			to_chat(usr,"<span class='warning'>There is already someone's mind stored inside</span>")
			return

		var/choice = alert(usr,"This will remove the target's mind from their body (and from the game as long as they're in the sleevemate). You can put them into a (mindless) body, a NIF, or back them up for normal resleeving, but you should probably have a plan in advance so you don't leave them unable to interact for too long. Continue?","Confirmation","Continue","Cancel")
		if(choice == "Continue" && usr.get_active_hand() == src && usr.Adjacent(target))

			usr.visible_message("<span class='warning'>[usr] begins downloading [target]'s mind!</span>","<span class='notice'>You begin downloading [target]'s mind!</span>")
			if(do_after(usr,35 SECONDS,target)) //This is powerful, yo.
				if(!stored_mind && target.mind)
					get_mind(target)
					to_chat(usr,"<span class='notice'>Mind downloaded!</span>")

		return

	if(href_list["mindput"])
		if(!stored_mind)
			to_chat(usr,"<span class='warning'>\The [src] no longer has a stored mind.</span>")
			return

		var/mob/living/carbon/human/H = target

		if(!istype(target))
			return //href hacking only

		if(!H.nif)
			return //Lost it? or href hacking

		var/datum/nifsoft/soulcatcher/SC = H.nif.imp_check(NIF_SOULCATCHER)
		if(!SC)
			return //Uninstalled it?

		//Lazzzyyy.
		if(!sleevemate_mob)
			sleevemate_mob = new()

		put_mind(sleevemate_mob)
		SC.catch_mob(sleevemate_mob)
		to_chat(usr,"<span class='notice'>Mind transferred into Soulcatcher!</span>")

	if(href_list["mindupload"])
		if(!stored_mind)
			to_chat(usr,"<span class='warning'>\The [src] no longer has a stored mind.</span>")
			return

		if(!istype(target))
			return

		if(istype(target, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = target
			if(H.resleeve_lock && stored_mind.loaded_from_ckey != H.resleeve_lock)
				to_chat(usr,"<span class='warning'>\[H] is protected from impersonation!</span>")
				return

		usr.visible_message("<span class='warning'>[usr] begins uploading someone's mind into [target]!</span>","<span class='notice'>You begin uploading a mind into [target]!</span>")
		if(do_after(usr,35 SECONDS,target))
			if(!stored_mind)
				to_chat(usr,"<span class='warning'>\The [src] no longer has a stored mind.</span>")
				return
			put_mind(target)
			to_chat(usr,"<span class='notice'>Mind transferred into [target]!</span>")

	if(href_list["mindrelease"])
		if(stored_mind)
			to_chat(usr,"<span class='warning'>There is already someone's mind stored inside</span>")
			return
		var/mob/living/carbon/human/H = target
		var/datum/nifsoft/soulcatcher/SC = H.nif.imp_check(NIF_SOULCATCHER)
		if(!SC)
			return
		for(var/mob/living/carbon/brain/caught_soul/soul in SC.brainmobs)
			if(soul.name == href_list["mindrelease"])
				get_mind(soul)
				qdel(soul)
				to_chat(usr,"<span class='notice'>Mind downloaded!</span>")
				return
		to_chat(usr,"<span class='notice'>Unable to find that mind in Soulcatcher!</span>")

/obj/item/device/sleevemate/update_icon()
	if(stored_mind)
		icon_state = "[initial(icon_state)]_on"
	else
		icon_state = initial(icon_state)
