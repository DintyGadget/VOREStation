/obj/machinery/artifact_analyser
	name = "Anomaly Analyser"
	desc = "Изучает выбросы аномальных материалов, чтобы определить их применение."
	icon = 'icons/obj/virology_vr.dmi' //VOREStation Edit
	icon_state = "isolator"
	anchored = 1
	density = 1
	var/scan_in_progress = 0
	var/scan_num = 0
	var/obj/scanned_obj
	var/obj/machinery/artifact_scanpad/owned_scanner = null
	var/scan_completion_time = 0
	var/scan_duration = 50
	var/obj/scanned_object
	var/report_num = 0

/obj/machinery/artifact_analyser/Initialize()
	. = ..()
	reconnect_scanner()

/obj/machinery/artifact_analyser/proc/reconnect_scanner()
	//connect to a nearby scanner pad
	owned_scanner = locate(/obj/machinery/artifact_scanpad) in get_step(src, dir)
	if(!owned_scanner)
		owned_scanner = locate(/obj/machinery/artifact_scanpad) in orange(1, src)

/obj/machinery/artifact_analyser/attack_hand(mob/user)
	add_fingerprint(user)
	if(stat & (NOPOWER|BROKEN) || get_dist(src, user) > 1)
		return
	tgui_interact(user)

/obj/machinery/artifact_analyser/tgui_interact(mob/user, datum/tgui/ui)
	if(!owned_scanner)
		reconnect_scanner()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "XenoarchArtifactAnalyzer", name)
		ui.open()

/obj/machinery/artifact_analyser/tgui_data(mob/user, datum/tgui/ui, datum/tgui_state/state)
	var/list/data = ..()

	data["owned_scanner"] = owned_scanner
	data["scan_in_progress"] = scan_in_progress

	return data

/obj/machinery/artifact_analyser/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	add_fingerprint(usr)

	switch(action)
		if("scan")
			if(scan_in_progress)
				scan_in_progress = FALSE
				atom_say("Сканирование остановлено.")
				return TRUE
			if(!owned_scanner)
				reconnect_scanner()
			if(owned_scanner)
				var/artifact_in_use = 0
				for(var/obj/O in owned_scanner.loc)
					if(O == owned_scanner)
						continue
					if(O.invisibility)
						continue
					if(istype(O, /obj/machinery/artifact))
						var/obj/machinery/artifact/A = O
						if(A.being_used)
							artifact_in_use = 1
						else
							A.anchored = 1
							A.being_used = 1

					if(artifact_in_use)
						atom_say("Невозможно сканировать. Слишком много помех.")
					else
						scanned_object = O
						scan_in_progress = 1
						scan_completion_time = world.time + scan_duration
						atom_say("Сканирование началось.")
					break
				if(!scanned_object)
					atom_say("Невозможно изолировать цель сканирования.")
			return TRUE

/obj/machinery/artifact_analyser/process()
	if(scan_in_progress && world.time > scan_completion_time)
		scan_in_progress = 0
		updateDialog()

		var/results = ""
		if(!owned_scanner)
			reconnect_scanner()
		if(!owned_scanner)
			results = "Ошибка связи со сканером."
		else if(!scanned_object || scanned_object.loc != owned_scanner.loc)
			results = "Невозможно найти отсканированный объект. Убедитесь, что он не был перемещен в процессе."
		else
			results = get_scan_info(scanned_object)

		atom_say("Сканирование завершено.")
		var/obj/item/weapon/paper/P = new(src.loc)
		P.name = "[src] report #[++report_num]"
		P.info = "<b>[src] analysis report #[report_num]</b><br>"
		P.info += "<br>"
		P.info += "[bicon(scanned_object)] [results]"
		P.stamped = list(/obj/item/weapon/stamp)
		P.overlays = list("paper_stamped")

		if(scanned_object && istype(scanned_object, /obj/machinery/artifact))
			var/obj/machinery/artifact/A = scanned_object
			A.anchored = 0
			A.being_used = 0
			scanned_object = null

//hardcoded responses, oh well
/obj/machinery/artifact_analyser/proc/get_scan_info(var/obj/scanned_obj)
	switch(scanned_obj.type)
		if(/obj/machinery/auto_cloner)
			return "Подставка для автоматического клонирования - похоже, полагается на искусственную экосистему, образованную полуорганическими наномашинами и содержащейся в ней жидкостью.<br>Жидкость похожа на остаток протоплазмы, поддерживающий условия развития одноклеточного организма.<br>Конструкция изготовлена из титанового сплава."
		if(/obj/machinery/power/supermatter)
			return "Сверхплотный сгусток форона - кажется, сформированный или высеченный, структура состоит из вещества, примерно в 20 раз более плотного, чем обычный очищенный форон."
		if(/obj/structure/constructshell)
			return "Племенной идол - субъект напоминает статую/эмблему, построенные суеверными цивилизациями до деформации в честь своих богов. Материал представляет собой композит камня/пластмассы-бетона."
		if(/obj/machinery/giga_drill)
			return "Автоматическая буровая установка - конструкция из сплава титана с карбидом, с режущей кромкой и буровыми канавками из сплава алмаза и форона."
		if(/obj/structure/cult/pylon)
			return "Пилон племени - субъект напоминает статую/эмблему, построенные цивилизациями культов карго в честь энергетических систем послевоенных цивилизаций."
		if(/obj/machinery/replicator)
			return "Автоматизированная строительная единица - субъект, кажется, может синтезировать различные объекты из материала, некоторые из которых имеют простую внутреннюю схему. Метод неизвестен."
		if(/obj/structure/crystal)
			return "Кристаллообразование - псевдоорганическая кристаллическая матрица, вряд ли образовавшаяся естественным путем. Не существует известной технологии для синтеза этой точной композиции."
		if(/obj/machinery/artifact)
			var/obj/machinery/artifact/A = scanned_obj
			var/out = "Аномальное инопланетное устройство - изготовлено из неизвестного сплава.<br><br>"

			if(A.my_effect)
				out += A.my_effect.getDescription()

			if(A.secondary_effect && A.secondary_effect.activated)
				out += "<br><br>Внутреннее сканирование указывает на текущую вторичную активность, работающую независимо от основных систем.<br><br>"
				out += A.secondary_effect.getDescription()

			return out
		else
			return "[scanned_obj.name] - обыденное приложение."
