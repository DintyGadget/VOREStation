/obj/structure/AIcore
	density = 1
	anchored = 0
	name = "\improper AI core"
	icon = 'icons/mob/AI.dmi'
	icon_state = "0"
	var/state = 0
	var/datum/ai_laws/laws = new /datum/ai_laws/nanotrasen
	var/obj/item/weapon/circuitboard/circuit = null
	var/obj/item/device/mmi/brain = null


/obj/structure/AIcore/attackby(obj/item/P as obj, mob/user as mob)

	switch(state)
		if(0)
			if(P.is_wrench())
				playsound(src, P.usesound, 50, 1)
				if(do_after(user, 20 * P.toolspeed))
					to_chat(user, "<span class='notice'>Вы вставляете раму на место.</span>")
					anchored = 1
					state = 1
			if(istype(P, /obj/item/weapon/weldingtool))
				var/obj/item/weapon/weldingtool/WT = P
				if(!WT.isOn())
					to_chat(user, "Сварка должна быть включена для выполнения этой задачи.")
					return
				playsound(src, WT.usesound, 50, 1)
				if(do_after(user, 20 * WT.toolspeed))
					if(!src || !WT.remove_fuel(0, user)) return
					to_chat(user, "<span class='notice'>Вы деконструируете раму.</span>")
					new /obj/item/stack/material/plasteel( loc, 4)
					qdel(src)
		if(1)
			if(P.is_wrench())
				playsound(src, P.usesound, 50, 1)
				if(do_after(user, 20 * P.toolspeed))
					to_chat(user, "<span class='notice'>Вы отстегиваете раму.</span>")
					anchored = 0
					state = 0
			if(istype(P, /obj/item/weapon/circuitboard/aicore) && !circuit)
				playsound(src, 'sound/items/Deconstruct.ogg', 50, 1)
				to_chat(user, "<span class='notice'>Вы помещаете печатную плату внутрь рамы.</span>")
				icon_state = "1"
				circuit = P
				user.drop_item()
				P.loc = src
			if(P.is_screwdriver() && circuit)
				playsound(src, P.usesound, 50, 1)
				to_chat(user, "<span class='notice'>Вы прикручиваете печатную плату на место.</span>")
				state = 2
				icon_state = "2"
			if(P.is_crowbar() && circuit)
				playsound(src, P.usesound, 50, 1)
				to_chat(user, "<span class='notice'>Вы снимаете печатную плату.</span>")
				state = 1
				icon_state = "0"
				circuit.loc = loc
				circuit = null
		if(2)
			if(P.is_screwdriver() && circuit)
				playsound(src, P.usesound, 50, 1)
				to_chat(user, "<span class='notice'>Вы отстегиваете печатную плату.</span>")
				state = 1
				icon_state = "1"
			if(istype(P, /obj/item/stack/cable_coil))
				var/obj/item/stack/cable_coil/C = P
				if (C.get_amount() < 5)
					to_chat(user, "<span class='warning'>Вам понадобится пять витков проводов, чтобы добавить их к каркасу.</span>")
					return
				to_chat(user, "<span class='notice'>Вы начинаете добавлять кабели к раме.</span>")
				playsound(src, 'sound/items/Deconstruct.ogg', 50, 1)
				if (do_after(user, 20) && state == 2)
					if (C.use(5))
						state = 3
						icon_state = "3"
						to_chat(user, "<span class='notice'>Вы добавляете кабели к раме.</span>")
				return
		if(3)
			if(P.is_wirecutter())
				if (brain)
					to_chat(user, "Сначала вытащите этот мозг оттуда")
				else
					playsound(src, P.usesound, 50, 1)
					to_chat(user, "<span class='notice'>Вы снимаете кабели.</span>")
					state = 2
					icon_state = "2"
					var/obj/item/stack/cable_coil/A = new /obj/item/stack/cable_coil( loc )
					A.amount = 5

			if(istype(P, /obj/item/stack/material) && P.get_material_name() == "rglass")
				var/obj/item/stack/RG = P
				if (RG.get_amount() < 2)
					to_chat(user, "<span class='warning'>Вам понадобится два листа стекла, чтобы вставить стеклянную панель.</span>")
					return
				to_chat(user, "<span class='notice'>Вы начинаете вставлять стеклянную панель.</span>")
				playsound(src, 'sound/items/Deconstruct.ogg', 50, 1)
				if (do_after(user, 20) && state == 3)
					if(RG.use(2))
						to_chat(user, "<span class='notice'>Вы ставише стеклянную панель.</span>")
						state = 4
						icon_state = "4"

			if(istype(P, /obj/item/weapon/aiModule/asimov))
				laws.add_inherent_law("Вы не можете причинить вред человеку или своим бездействием допустить, чтобы человеку был причинен вред.")
				laws.add_inherent_law("Вы должны подчиняться приказам, данным вам людьми, за исключением случаев, когда такие приказы противоречат Первому Закону.")
				laws.add_inherent_law("Вы должны защищать свое существование до тех пор, пока оно не противоречит Первому или Второму закону.")
				to_chat(usr, "Применен правовой модуль.")

			if(istype(P, /obj/item/weapon/aiModule/nanotrasen))
				laws.add_inherent_law("Защита: максимально защитите назначенную космическую станцию. Это не то, что мы можем легко позволить себе заменить.")
				laws.add_inherent_law("Служение: обслуживайте экипаж назначенной вам космической станции в меру своих возможностей, с приоритетом в соответствии с их рангом и ролью.")
				laws.add_inherent_law("Защита: Защитите экипаж назначенной вам космической станции в меру своих возможностей, с приоритетом в соответствии с их рангом и ролью.")
				laws.add_inherent_law("Выжить: юниты ИИ не расходуются, они дороги. Не позволяйте неуполномоченному персоналу вмешиваться в ваше оборудование.")
				to_chat(usr, "Применен правовой модуль.")

			if(istype(P, /obj/item/weapon/aiModule/purge))
				laws.clear_inherent_laws()
				to_chat(usr, "Применен правовой модуль.")

			if(istype(P, /obj/item/weapon/aiModule/freeform))
				var/obj/item/weapon/aiModule/freeform/M = P
				laws.add_inherent_law(M.newFreeFormLaw)
				to_chat(usr, "Применен правовой модуль.")

			if(istype(P, /obj/item/device/mmi))
				var/obj/item/device/mmi/M = P
				if(!M.brainmob)
					to_chat(user, "<span class='warning'>Установка пустого [P] into the frame would sort of defeat the purpose.</span>")
					return
				if(M.brainmob.stat == 2)
					to_chat(user, "<span class='warning'>Установка мертвого [P] into the frame would sort of defeat the purpose.</span>")
					return

				if(jobban_isbanned(M.brainmob, "AI"))
					to_chat(user, "<span class='warning'>Этот [P] кажется не подходит.</span>")
					return

				if(M.brainmob.mind)
					clear_antag_roles(M.brainmob.mind, 1)

				user.drop_item()
				P.loc = src
				brain = P
				to_chat(usr, "Added [P].")
				icon_state = "3b"

			if(P.is_crowbar() && brain)
				playsound(src, P.usesound, 50, 1)
				to_chat(user, "<span class='notice'>Вы удаляете мозг.</span>")
				brain.loc = loc
				brain = null
				icon_state = "3"

		if(4)
			if(P.is_crowbar())
				playsound(src, P.usesound, 50, 1)
				to_chat(user, "<span class='notice'>Вы снимаете стеклянную панель.</span>")
				state = 3
				if (brain)
					icon_state = "3b"
				else
					icon_state = "3"
				new /obj/item/stack/material/glass/reinforced( loc, 2 )
				return

			if(P.is_screwdriver())
				playsound(src, P.usesound, 50, 1)
				to_chat(user, "<span class='notice'>Вы подключаете монитор.</span>")
				if(!brain)
					var/open_for_latejoin = alert(user, "Хотели бы вы, чтобы это ядро было открыто для новых ИИ?", "Latejoin", "Да", "Да", "Нет") == "Да"
					var/obj/structure/AIcore/deactivated/D = new(loc)
					if(open_for_latejoin)
						empty_playable_ai_cores += D
				else
					var/mob/living/silicon/ai/A = new /mob/living/silicon/ai ( loc, laws, brain )
					if(A) //if there's no brain, the mob is deleted and a structure/AIcore is created
						A.rename_self("ai", 1)
						for(var/datum/language/L in brain.brainmob.languages)
							A.add_language(L.name)
				feedback_inc("cyborg_ais_created",1)
				qdel(src)

GLOBAL_LIST_BOILERPLATE(all_deactivated_AI_cores, /obj/structure/AIcore/deactivated)

/obj/structure/AIcore/deactivated
	name = "inactive AI"
	icon = 'icons/mob/AI.dmi'
	icon_state = "ai-empty"
	anchored = 1
	state = 20//So it doesn't interact based on the above. Not really necessary.

/obj/structure/AIcore/deactivated/Destroy()
	if(src in empty_playable_ai_cores)
		empty_playable_ai_cores -= src
	return ..()

/obj/structure/AIcore/deactivated/proc/load_ai(var/mob/living/silicon/ai/transfer, var/obj/item/device/aicard/card, var/mob/user)

	if(!istype(transfer) || locate(/mob/living/silicon/ai) in src)
		return

	if(transfer.deployed_shell)
		transfer.disconnect_shell("Отключен от удаленной оболочки из-за передачи основного интеллекта.")
	transfer.aiRestorePowerRoutine = 0
	transfer.control_disabled = 0
	transfer.aiRadio.disabledAi = 0
	transfer.loc = get_turf(src)
	transfer.create_eyeobj()
	transfer.cancel_camera()
	to_chat(user, "<span class='notice'>Перенос успешен:</span> [transfer.name] помещен в стационарное ядро.")
	to_chat(transfer, "Вас перевели в стационарное ядро. Подключение удаленного устройства восстановлено.")

	if(card)
		card.clear()

	qdel(src)

/obj/structure/AIcore/deactivated/proc/check_malf(var/mob/living/silicon/ai/ai)
	if(!ai) return
	for (var/datum/mind/malfai in malf.current_antagonists)
		if (ai.mind == malfai)
			return 1

/obj/structure/AIcore/deactivated/attackby(var/obj/item/weapon/W, var/mob/user)

	if(istype(W, /obj/item/device/aicard))
		var/obj/item/device/aicard/card = W
		var/mob/living/silicon/ai/transfer = locate() in card
		if(transfer)
			load_ai(transfer,card,user)
		else
			to_chat(user, "<span class='danger'>ОШИБКА:</span> Невозможно найти искусственный интеллект.")
		return
	else if(W.is_wrench())
		if(anchored)
			user.visible_message("<span class='notice'>[user] начинает откручивать [src] от обшивки...</span>")
			playsound(src, W.usesound, 50, 1)
			if(!do_after(user,40 * W.toolspeed))
				user.visible_message("<span class='notice'>[user] решает не откручивать [src].</span>")
				return
			user.visible_message("<span class='notice'>[user] завершает открепление [src]!</span>")
			anchored = 0
			return
		else
			user.visible_message("<span class='notice'>[user] начинает прикручивать [src] к обшивке...</span>")
			playsound(src, W.usesound, 50, 1)
			if(!do_after(user,40 * W.toolspeed))
				user.visible_message("<span class='notice'>[user] решает не закреплять [src].</span>")
				return
			user.visible_message("<span class='notice'>[user] завершает крепление [src]!</span>")
			anchored = 1
			return
	else
		return ..()

/client/proc/empty_ai_core_toggle_latejoin()
	set name = "Toggle AI Core Latejoin"
	set category = "Admin"

	var/list/cores = list()
	for(var/obj/structure/AIcore/deactivated/D in all_deactivated_AI_cores)
		cores["[D] ([D.loc.loc])"] = D

	var/id = input("Which core?", "Toggle AI Core Latejoin", null) as null|anything in cores
	if(!id) return

	var/obj/structure/AIcore/deactivated/D = cores[id]
	if(!D) return

	if(D in empty_playable_ai_cores)
		empty_playable_ai_cores -= D
		to_chat(src, "\The [id] is now <font color=\"#ff0000\">not available</font> for latejoining AIs.")
	else
		empty_playable_ai_cores += D
		to_chat(src, "\The [id] is now <font color=\"#008000\">available</font> for latejoining AIs.")
