var/global/universe_has_ended = 0


/datum/universal_state/supermatter_cascade
 	name = "Supermatter Cascade"
 	desc = "Unknown harmonance affecting universal substructure, converting nearby matter to supermatter."

 	decay_rate = 5 // 5% chance of a turf decaying on lighting update/airflow (there's no actual tick for turfs)

/datum/universal_state/supermatter_cascade/OnShuttleCall(var/mob/user)
	if(user)
		to_chat(user, "<span class='sinister'>Все, что вы слышите на этой частоте, - это статический и панический крик. Сегодня шаттла не будет.</span>")
	return 0

/datum/universal_state/supermatter_cascade/OnTurfChange(var/turf/T)
	var/turf/space/S = T
	if(istype(S))
		S.color = "#0066FF"
	else
		S.color = initial(S.color)

/datum/universal_state/supermatter_cascade/DecayTurf(var/turf/T)
	if(istype(T,/turf/simulated/wall))
		var/turf/simulated/wall/W=T
		W.melt()
		return
	if(istype(T,/turf/simulated/floor))
		var/turf/simulated/floor/F=T
		// Burnt?
		if(!F.burnt)
			F.burn_tile()
		else
			if(!istype(F,/turf/simulated/floor/plating))
				F.break_tile_to_plating()
		return

// Apply changes when entering state
/datum/universal_state/supermatter_cascade/OnEnter()
	set background = 1
	to_world("<span class='sinister' style='font-size:22pt'>Вы ослеплены яркой вспышкой энергии.</span>")

	world << sound('sound/effects/cascade.ogg')

	for(var/mob/M in player_list)
		M.flash_eyes()

	if(emergency_shuttle.can_recall())
		priority_announcement.Announce("Аварийный шаттл вернулся из-за искажения синего пространства.")
		emergency_shuttle.recall()

	AreaSet()
	MiscSet()
	APCSet()
	OverlayAndAmbientSet()

	// Disable Nar-Sie.
	cult.allow_narsie = 0

	PlayerSet()

	new /obj/singularity/narsie/large/exit(pick(endgame_exits))
	spawn(rand(30,60) SECONDS)
		var/txt = {"
Произошел электромагнитный импульс по всей галактике.  Все наши системы сильно повреждены, и многие сотрудники погибли или умирают. Мы видим все больше признаков того, что сама Вселенная начинает распадаться.

[station_name()], вы - единственный объект рядом с разломом в космическом пространстве, рядом с вашим исследовательским форпостом. Настоящим вы получаете указание войти в разлом, используя все необходимые средства, вполне возможно, в качестве последнего живого представителя вашего вида.

У вас есть пять минут до коллапса вселенной. Удч\[\[###!!!-

АВТОМАТИЧЕСКОЕ ОПОВЕЩЕНИЕ: Связь с [command_name()] потеряна.

Требования к доступу к консолям Asteroid Shuttles отменены.
"}
		priority_announcement.Announce(txt,"SUPERMATTER CASCADE DETECTED")

		for(var/obj/machinery/computer/shuttle_control/C in machines)
			if(istype(C, /obj/machinery/computer/shuttle_control/research) || istype(C, /obj/machinery/computer/shuttle_control/mining))
				C.req_access = list()
				C.req_one_access = list()

		spawn(5 MINUTES)
			ticker.station_explosion_cinematic(0,null) // TODO: Custom cinematic
			universe_has_ended = 1
		return

/datum/universal_state/supermatter_cascade/proc/AreaSet()
	for(var/area/A in world)
		if(!istype(A,/area) || istype(A, /area/space) || istype(A,/area/beach))
			continue

		A.updateicon()

/datum/universal_state/supermatter_cascade/OverlayAndAmbientSet()
	spawn(0)
		for(var/datum/lighting_corner/L in world)
			if(L.z in using_map.admin_levels)
				L.update_lumcount(1,1,1)
			else
				L.update_lumcount(0.0, 0.4, 1)

		for(var/turf/space/T in world)
			OnTurfChange(T)

/datum/universal_state/supermatter_cascade/proc/MiscSet()
	for (var/obj/machinery/firealarm/alm in machines)
		if (!(alm.stat & BROKEN))
			alm.ex_act(2)

/datum/universal_state/supermatter_cascade/proc/APCSet()
	for (var/obj/machinery/power/apc/APC in GLOB.apcs)
		if (!(APC.stat & BROKEN) && !APC.is_critical)
			APC.chargemode = 0
			if(APC.cell)
				APC.cell.charge = 0
			APC.emagged = 1
			APC.queue_icon_update()

/datum/universal_state/supermatter_cascade/proc/PlayerSet()
	for(var/datum/mind/M in player_list)
		if(!istype(M.current,/mob/living))
			continue
		if(M.current.stat!=2)
			M.current.Weaken(10)
			M.current.flash_eyes()

		clear_antag_roles(M)
