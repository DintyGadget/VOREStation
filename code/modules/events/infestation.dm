#define LOC_KITCHEN 0
#define LOC_ATMOS 1
#define LOC_CHAPEL 2
#define LOC_LIBRARY 3
#define LOC_HYDRO 4
#define LOC_VAULT 5
#define LOC_CONSTR 6
#define LOC_TECH 7
#define LOC_GARDEN 8

#define VERM_MICE 0
#define VERM_LIZARDS 1
#define VERM_SPIDERS 2

/datum/event/infestation
	announceWhen = 10
	endWhen = 11
	var/location
	var/locstring
	var/vermin
	var/vermstring

/datum/event/infestation/start()

	location = rand(0,8)
	var/list/turf/simulated/floor/turfs = list()
	var/spawn_area_type
	switch(location)
		if(LOC_KITCHEN)
			spawn_area_type = /area/crew_quarters/kitchen
			locstring = "кухне"
		if(LOC_ATMOS)
			spawn_area_type = /area/engineering/atmos
			locstring = "системе АТМОС"
		if(LOC_CHAPEL)
			spawn_area_type = /area/chapel/main
			locstring = "часовне"
		if(LOC_LIBRARY)
			spawn_area_type = /area/library
			locstring = "библиотеке"
		if(LOC_HYDRO)
			spawn_area_type = /area/hydroponics
			locstring = "гидропонике"
		if(LOC_VAULT)
			spawn_area_type = /area/security/nuke_storage
			locstring = "хранилище"
		if(LOC_CONSTR)
			spawn_area_type = /area/construction
			locstring = "зоне постройки"
		if(LOC_TECH)
			spawn_area_type = /area/storage/tech
			locstring = "хранилище техники"
		if(LOC_GARDEN)
			spawn_area_type = /area/hydroponics/garden
			locstring = "общем саду"

	for(var/areapath in typesof(spawn_area_type))
		var/area/A = locate(areapath)
		for(var/turf/simulated/floor/F in A.contents)
			//VOREStation Edit - Fixes event
			var/blocked = FALSE
			for(var/atom/movable/AM in F)
				if(AM.density)
					blocked = TRUE
			if(!blocked)
				turfs += F
			//VOREStation Edit - Fixes event

	var/list/spawn_types = list()
	var/max_number
	vermin = rand(0,2)
	switch(vermin)
		if(VERM_MICE)
			spawn_types = list(/mob/living/simple_mob/animal/passive/mouse/gray, /mob/living/simple_mob/animal/passive/mouse/brown, /mob/living/simple_mob/animal/passive/mouse/white)
			max_number = 12
			vermstring = "мыши"
		if(VERM_LIZARDS)
			spawn_types = list(/mob/living/simple_mob/animal/passive/lizard)
			max_number = 6
			vermstring = "ящерицы"
		if(VERM_SPIDERS)
			spawn_types = list(/obj/effect/spider/spiderling)
			max_number = 3
			vermstring = "пауки"

	spawn(0)
		var/num = rand(2,max_number)
		while(turfs.len > 0 && num > 0)
			var/turf/simulated/floor/T = pick(turfs)
			turfs.Remove(T)
			num--

			if(vermin == VERM_SPIDERS)
				var/obj/effect/spider/spiderling/S = new(T)
				S.amount_grown = -1
			else
				var/spawn_type = pick(spawn_types)
				new spawn_type(T)


/datum/event/infestation/announce()
	command_announcement.Announce("Биосканы показывают, что [vermstring] размножаются в [locstring]. Избавьтесь от них, прежде чем они нанесут ущерб станции.", "Заражение паразитами")

#undef LOC_KITCHEN
#undef LOC_ATMOS
#undef LOC_CHAPEL
#undef LOC_LIBRARY
#undef LOC_HYDRO
#undef LOC_VAULT
#undef LOC_TECH
#undef LOC_GARDEN

#undef VERM_MICE
#undef VERM_LIZARDS
#undef VERM_SPIDERS
