/obj/machinery/seed_extractor
	name = "seed extractor"
	desc = "Extracts and bags seeds from produce."
	icon = 'icons/obj/hydroponics_machines_vr.dmi' //VOREStation Edit
	icon_state = "sextractor"
	density = 1
	anchored = 1

obj/machinery/seed_extractor/attackby(var/obj/item/O as obj, var/mob/user as mob)

	// Fruits and vegetables.
	if(istype(O, /obj/item/weapon/reagent_containers/food/snacks/grown) || istype(O, /obj/item/weapon/grown))

		user.remove_from_mob(O)

		var/datum/seed/new_seed_type
		if(istype(O, /obj/item/weapon/grown))
			var/obj/item/weapon/grown/F = O
			new_seed_type = SSplants.seeds[F.plantname]
		else
			var/obj/item/weapon/reagent_containers/food/snacks/grown/F = O
			new_seed_type = SSplants.seeds[F.plantname]

		if(new_seed_type)
			to_chat(user, "<span class='notice'>Вы извлекаете семена из [O].</span>")
			var/produce = rand(1,4)
			for(var/i = 0;i<=produce;i++)
				var/obj/item/seeds/seeds = new(get_turf(src))
				seeds.seed_type = new_seed_type.name
				seeds.update_seed()
		else
			to_chat(user, "[O], похоже, не содержит семян, которые можно использовать.")

		qdel(O)

	//Grass.
	else if(istype(O, /obj/item/stack/tile/grass))
		var/obj/item/stack/tile/grass/S = O
		if(S.use(1))
			to_chat(user, "<span class='notice'>Вы извлекаете семена из плитки травы.</span>")
			new /obj/item/seeds/grassseed(loc)

	else if(istype(O, /obj/item/weapon/fossil/plant)) // Fossils
		var/obj/item/seeds/random/R = new(get_turf(src))
		to_chat(user, "[src] распыляет [O] и выплевывает [R].")
		qdel(O)

	else if(default_unfasten_wrench(user, O, 20))
		return

	return