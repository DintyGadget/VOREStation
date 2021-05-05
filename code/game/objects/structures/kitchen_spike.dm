//////Kitchen Spike

/obj/structure/kitchenspike
	name = "мясные крюки"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "spike"
	desc = "Крюки для сбора мяса с животных."
	density = 1
	anchored = 1
	var/meat = 0
	var/occupied
	var/meat_type
	var/victim_name = "corpse"

/obj/structure/kitchenspike/attackby(obj/item/weapon/grab/G as obj, mob/user as mob)
	if(!istype(G, /obj/item/weapon/grab) || !ismob(G.affecting))
		return
	if(occupied)
		to_chat(user, "<span class = 'danger'>На крюках уже что-то есть, сначала закончите собирать его мясо!</span>")
	else
		if(spike(G.affecting))
			//var/datum/gender/T = gender_datums[G.affecting.get_visible_gender()]
			visible_message("<span class = 'danger'>[user] силой насаживает [G.affecting] на крюк, мгновенно убивая жертву!</span>")
			var/mob/M = G.affecting
			M.forceMove(src)
			qdel(G)
			qdel(M)
		else
			to_chat(user, "<span class='danger'>Это слишком большое для крюка, попробуйте что-нибудь поменьше!</span>")

/obj/structure/kitchenspike/proc/spike(var/mob/living/victim)
	if(!istype(victim))
		return

	if(istype(victim, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = victim
		if(istype(H.species, /datum/species/monkey))
			meat_type = H.species.meat_type
			icon_state = "spikebloody"
		else
			return 0
	else if(istype(victim, /mob/living/carbon/alien))
		meat_type = /obj/item/weapon/reagent_containers/food/snacks/xenomeat
		icon_state = "spikebloodygreen"
	else
		return 0

	victim_name = victim.name
	occupied = 1
	meat = 5
	return 1

/obj/structure/kitchenspike/attack_hand(mob/user as mob)
	if(..() || !occupied)
		return
	meat--
	new meat_type(get_turf(src))
	if(meat > 1)
		to_chat(user, "Вы отрезаете кусок мяса от тела [victim_name].")
	else if(meat == 1)
		to_chat(user, "Вы убираете последний кусок мяса с [victim_name]!")
		icon_state = "spike"
		occupied = 0
