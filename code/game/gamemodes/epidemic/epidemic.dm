/datum/game_mode/epidemic
	name = "Epidemic"
	config_tag = "epidemic"
	required_players = 1
	required_players_secret = 15
	round_description = "По станции распространяется смертельная эпидемия. Найдите лекарство как можно быстрее и держитесь подальше от всех, кто говорит хриплым голосом!"

	var/cruiser_arrival
	var/virus_name = ""
	var/stage = 0
	var/doctors = 0


///////////////////////////////////////////////////////////////////////////////
//Gets the round setup, cancelling if there's not enough players at the start//
///////////////////////////////////////////////////////////////////////////////
/datum/game_mode/epidemic/pre_setup()
	doctors = 0
	for(var/mob/new_player/player in world)
		if(player.mind.assigned_role in list("Chief Medical Officer","Medical Doctor"))
			doctors++
			break

	if(doctors < 1)
		return 0

	return 1

/datum/game_mode/epidemic/proc/cruiser_seconds()
	return (cruiser_arrival - world.time) / 10

////////////////////// INTERCEPT ////////////////////////
/// OVERWRITE THE INTERCEPT WITH A QUARANTINE WARNING ///
/////////////////////////////////////////////////////////

/datum/game_mode/epidemic/send_intercept()
	var/intercepttext = "<meta charset=\"utf-8\"><FONT size = 3 color='red'><B>КОНФИДЕНЦИАЛЬНЫЙ ОТЧЕТ</B></FONT><HR>"
	virus_name = "X-[rand(1,99)]&trade;"
	intercepttext += "<B>Внимание: Патоген [virus_name] обнаружен на [station_name()].</B><BR><BR>"
	intercepttext += "<B>Код карантина на [station_name()] требуется объявить немедленно.</B><BR>"
	intercepttext += "<B>Класс [rand(2,5)] крейсер отправлен. Время прибытия: [round(cruiser_seconds() / 60)] минут.</B><BR>"
	intercepttext += "<BR><B><FONT size = 2 color='blue'>Инструкция</FONT></B><BR>"
	intercepttext += "<B>* УСТРАНИТЕ УГРОЗУ С КРАЙНИМ ПРЕДУБЕЖДЕНИЕМ. [virus_name] ОЧЕНЬ ЗАРАЗЕН. ЗАРАЖЕННЫЕ ЧЛЕНЫ ЭКИПАЖА ДОЛЖНЫ БЫТЬ НЕМЕДЛЕННО ПОМЕЩЕНЫ В КАРАНТИН.</B><BR>"
	intercepttext += "<B>* [station_name()] находится на КАРАНТИНЕ. Любые суда, вылетающие из [station_name ()], будут выслежены и уничтожены.</B><BR>"
	intercepttext += "<B>* Существование [virus_name] строго конфиденциально. Чтобы предотвратить панику, только высокопоставленные сотрудники имеют право знать о ее существовании. Члены экипажа, незаконно получившие информацию о [virus_name], должны быть нейтрализованы.</B><BR>"
	intercepttext += "<B>* Лекарство должно быть исследовано немедленно, но интеллектуальная собственность нанотразена должна уважаться. Чтобы знание [virus_name] не попало в чужие руки, весь медицинский персонал, работающий с патогеном, должен быть усилен имплантатом лояльности нанотразена.</B><BR>"


	//New message handling won't hurt if someone enables epidemic
	post_comm_message("Cent. Com. КОНФИДЕНЦИАЛЬНЫЙ ОТЧЕТ", intercepttext)

	world << sound('sound/AI/commandreport.ogg')

	// add an extra law to the AI to make sure it cooperates with the heads
	var/extra_law = "Экипаж, уполномоченный знать о существовании патогена [virus_name], - это: Руководители командования. Не позволяйте постороннему персоналу получить информацию о [virus_name]. Помощь уполномоченному персоналу в карантине и нейтрализации вспышки. Этот закон превосходит все остальные."
	for(var/mob/living/silicon/ai/M in world)
		M.add_ion_law(extra_law)
		to_chat(M, "<span class='danger'>[extra_law]</span>")

/datum/game_mode/epidemic/proc/announce_to_kill_crew()
	var/intercepttext = "<FONT size = 3 color='red'><B>КОНФИДЕНЦИАЛЬНЫЙ ОТЧЕТ</B></FONT><HR>"
	intercepttext += "<FONT size = 2;color='red'><B>ПАТОГЕН [virus_name] ВСЕ ЕЩЕ ПРИСУТСТВУЕТ НА [station_name()]. В СООТВЕТСТВИИ С ЗАКОНАМИ НАНОТРАЗЕНА О МЕЖЗВЕЗДНОЙ БЕЗОПАСНОСТИ БЫЛИ САНКЦИОНИРОВАНЫ ЧРЕЗВЫЧАЙНЫЕ МЕРЫ БЕЗОПАСНОСТИ. ВСЕ ЗАРАЖЕННЫЕ ЧЛЕНЫ ЭКИПАЖА НА [station_name()] ОНИ ДОЛЖНЫ БЫТЬ НЕЙТРАЛИЗОВАНЫ И УТИЛИЗИРОВАНЫ ТАКИМ ОБРАЗОМ, ЧТОБЫ УНИЧТОЖИТЬ ВСЕ СЛЕДЫ ПАТОГЕНА. НЕСОБЛЮДЕНИЕ ЭТОГО ТРЕБОВАНИЯ ПРИВЕДЕТ К НЕМЕДЛЕННОМУ УНИЧТОЖЕНИЮ [station_name].</B></FONT><BR>"
	intercepttext += "<B>CRUISER WILL ARRIVE IN [round(cruiser_seconds()/60)] MINUTES</B><BR>"

	post_comm_message("Cent. Com. КОНФИДЕНЦИАЛЬНЫЙ ОТЧЕТ", intercepttext)
	world << sound('sound/AI/commandreport.ogg')


/datum/game_mode/epidemic/post_setup()
	// make sure viral outbreak events don't happen on this mode
	EventTypes.Remove(/datum/event/viralinfection)

	// scan the crew for possible infectees
	var/list/crew = list()
	for(var/mob/living/carbon/human/H in world) if(H.client)
		// heads should not be infected
		if(H.mind.assigned_role in command_positions) continue
		crew += H

	if(crew.len < 2)
		to_world("<span class='danger'>Для этого режима не хватает игроков!</span>")
		to_world("<span class='danger'>Перезагрузка мира за 5 секунд.</span>")

		if(blackbox)
			blackbox.save_all_data_to_sql()
		sleep(50)
		world.Reboot()

	var/datum/disease2/disease/lethal = new
	lethal.makerandom(3)
	lethal.infectionchance = 5

	// the more doctors, the more will be infected
	var/lethal_amount = doctors * 2

	// keep track of initial infectees
	var/list/infectees = list()

	for(var/i = 0, i < lethal_amount, i++)
		var/mob/living/carbon/human/H = pick(crew)
		if(lethal.uniqueID in H.virus2)
			i--
			continue
		H.virus2["[lethal.uniqueID]"] = lethal.getcopy()
		infectees += H

	var/mob/living/carbon/human/patient_zero = pick(infectees)
	var/datum/disease2/disease/V = patient_zero.virus2["[lethal.uniqueID]"]
	V.stage = 3

	cruiser_arrival = world.time + (10 * 90 * 60)
	stage = 1

	spawn (rand(waittime_l, waittime_h))
		send_intercept()


	..()


/datum/game_mode/epidemic/process()
	if(stage == 1 && cruiser_seconds() < 60 * 30)
		announce_to_kill_crew()
		stage = 2
	else if(stage == 2 && cruiser_seconds() <= 60 * 5)
		command_alert("Приближающийся крейсер обнаружен на встречном курсе. Сканирование показало, что корабль вооружен и готов к стрельбе. Расчетное время прибытия: 5 минут.", "[station_name()] Early Warning System")
		stage = 3
	else if(stage == 3 && cruiser_seconds() <= 0)
		crew_lose()
		stage = 4

	checkwin_counter++
	if(checkwin_counter >= 20)
		if(!finished)
			ticker.mode.check_win()
		checkwin_counter = 0
	return 0

//////////////////////////////////////
//Checks if the revs have won or not//
//////////////////////////////////////
/datum/game_mode/epidemic/check_win()
	var/alive = 0
	var/sick = 0
	for(var/mob/living/carbon/human/H in world)
		if(H.key && H.stat != 2) alive++
		if(H.virus2.len && H.stat != 2) sick++

	if(alive == 0)
		finished = 2
	if(sick == 0)
		finished = 1
	return

///////////////////////////////
//Checks if the round is over//
///////////////////////////////
/datum/game_mode/epidemic/check_finished()
	if(finished != 0)
		return 1
	else
		return 0

///////////////////////////////////////////
///Handle crew failure(station explodes)///
///////////////////////////////////////////
/datum/game_mode/epidemic/proc/crew_lose()
	ticker.mode:explosion_in_progress = 1
	for(var/mob/M in world)
		if(M.client)
			M << 'sound/machines/Alarm.ogg'
	to_world("<span class='notice'><b>Обнаружена приближающаяся ракета.. Удар в 10..</b></span>")
	for (var/i=9 to 1 step -1)
		sleep(10)
		to_world("<span class='notice'><b>[i]..</b></span>")
	sleep(10)
	enter_allowed = 0
	if(ticker)
		ticker.station_explosion_cinematic(0,null)
		if(ticker.mode)
			ticker.mode:station_was_nuked = 1
			ticker.mode:explosion_in_progress = 0
	finished = 2
	return


//////////////////////////////////////////////////////////////////////
//Announces the end of the game with all relavent information stated//
//////////////////////////////////////////////////////////////////////
/datum/game_mode/epidemic/declare_completion()
	if(finished == 1)
		feedback_set_details("round_end_result","win - epidemic cured")
		to_world("<font size = 3><span class='danger'> Вспышка вируса была локализована! Экипаж побеждает!</span></font>")
	else if(finished == 2)
		feedback_set_details("round_end_result","loss - rev heads killed")
		to_world("<font size = 3><span class='danger'> Экипаж погиб от эпидемии!</span></font>")
	..()
	return 1
