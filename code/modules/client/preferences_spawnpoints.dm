var/list/spawntypes = list()

/proc/populate_spawn_points()
	spawntypes = list()
	for(var/type in typesof(/datum/spawnpoint)-/datum/spawnpoint)
		var/datum/spawnpoint/S = new type()
		spawntypes[S.display_name] = S

/datum/spawnpoint
	var/msg          //Message to display on the arrivals computer.
	var/list/turfs   //List of turfs to spawn on.
	var/display_name //Name used in preference setup.
	var/list/restrict_job = null
	var/list/disallow_job = null
	var/announce_channel = "Общий"
	var/allowed_mob_types = JOB_SILICON|JOB_CARBON

	proc/check_job_spawning(job)
		if(restrict_job && !(job in restrict_job))
			return 0

		if(disallow_job && (job in disallow_job))
			return 0

		var/datum/job/J = SSjob.get_job(job)
		if(!J) // Couldn't find, admin shenanigans? Allow it
			return 1

		if(J.offmap_spawn && !(job in restrict_job))
			return 0

		if(!(J.mob_type & allowed_mob_types))
			return 0

		return 1

/datum/spawnpoint/proc/get_spawn_position()
	return get_turf(pick(turfs))

/datum/spawnpoint/arrivals
	display_name = "Arrivals Shuttle"
	msg = "прибывает на станцию на шаттле"

/datum/spawnpoint/arrivals/New()
	..()
	turfs = latejoin

/datum/spawnpoint/gateway
	display_name = "Gateway"
	msg = "завершает переход через внестанционный телепорт"

/datum/spawnpoint/gateway/New()
	..()
	turfs = latejoin_gateway
/* VOREStation Edit
/datum/spawnpoint/elevator
	display_name = "Elevator"
	msg = "has arrived from the residential district"

/datum/spawnpoint/elevator/New()
	..()
	turfs = latejoin_elevator
*/
/datum/spawnpoint/cryo
	display_name = "Cryogenic Storage"
	msg = "завершает криогенную разморозку"
	allowed_mob_types = JOB_CARBON

/datum/spawnpoint/cryo/New()
	..()
	turfs = latejoin_cryo

/datum/spawnpoint/cyborg
	display_name = "Cyborg Storage"
	msg = "активируется в хранилище"
	allowed_mob_types = JOB_SILICON

/datum/spawnpoint/cyborg/New()
	..()
	turfs = latejoin_cyborg