
/datum/gear/pipe
	display_name = "Трубка курительная"
	path = /obj/item/clothing/mask/smokable/pipe

/datum/gear/pipe/New()
	..()
	var/list/pipes = list()
	for(var/pipe_style in typesof(/obj/item/clothing/mask/smokable/pipe))
		var/obj/item/clothing/mask/smokable/pipe/pipe = pipe_style
		pipes[initial(pipe.name)] = pipe
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(pipes))

/datum/gear/matchbook
	display_name = "Коробок спичек"
	path = /obj/item/weapon/storage/box/matches

/datum/gear/lighter
	display_name = "Зажигалка, дешёвая"
	path = /obj/item/weapon/flame/lighter

/datum/gear/lighter/zippo
	display_name = "Зажигалка, зиппо (выбор)"
	path = /obj/item/weapon/flame/lighter/zippo

/datum/gear/lighter/zippo/New()
	..()
	var/list/zippos = list()
	for(var/zippo in typesof(/obj/item/weapon/flame/lighter/zippo))
		if(zippo in typesof(/obj/item/weapon/flame/lighter/zippo/fluff))	//VOREStation addition
			continue														//VOREStation addition
		var/obj/item/weapon/flame/lighter/zippo/zippo_type = zippo
		zippos[initial(zippo_type.name)] = zippo_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(zippos))

/datum/gear/ashtray
	display_name = "Пепельница, пластик"
	path = /obj/item/weapon/material/ashtray/plastic

/datum/gear/cigar
	display_name = "Сигара"
	path = /obj/item/clothing/mask/smokable/cigarette/cigar

/datum/gear/cigarettes
	display_name = "Сигареты (выбор)"
	path = /obj/item/weapon/storage/fancy/cigarettes

/datum/gear/cigarettes/New()
	..()
	var/list/cigarettes = list()
	for(var/cigarette in (typesof(/obj/item/weapon/storage/fancy/cigarettes) - typesof(/obj/item/weapon/storage/fancy/cigarettes/killthroat)))
		var/obj/item/weapon/storage/fancy/cigarettes/cigarette_brand = cigarette
		cigarettes[initial(cigarette_brand.name)] = cigarette_brand
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(cigarettes))
