//Augmented Eyesight: Gives you thermal vision. Also, higher DNA cost because of how powerful it is.

/datum/power/changeling/augmented_eyesight
	name = "Augmented Eyesight"
	desc = "Создает тепловые рецепторы в наших глазах и резко увеличивает светочувствительность."
	helptext = "Дает нам тепловое зрение. Его можно включить или выключить. Пока мы активны, мы станем более уязвимыми для устройств на базе света."
	ability_icon_state = "ling_augmented_eyesight"
	genomecost = 2
	verbpath = /mob/proc/changeling_augmented_eyesight

/mob/proc/changeling_augmented_eyesight()
	set category = "Changeling"
	set name = "Расширенное зрение (5)"
	set desc = "We evolve our eyes to sense the infrared."

	var/datum/changeling/changeling = changeling_power(5,0,100,CONSCIOUS)
	if(!changeling)
		return 0

	var/mob/living/carbon/human/C = src

	changeling.thermal_sight = !changeling.thermal_sight

	var/active = changeling.thermal_sight

	if(active)
		src.mind.changeling.chem_charges -= 5
		to_chat(C, "<span class='notice'>Мы чувствуем, как наши глаза подергиваются, и миру открывается скрытый слой.</span>")
		C.add_modifier(/datum/modifier/changeling/thermal_sight, 0, src)
//		C.permanent_sight_flags |= SEE_MOBS
//		C.dna.species.invis_sight = SEE_INVISIBLE_MINIMUM
	else
		to_chat(C, "<span class='notice'>Наше видение тускнеет.</span>")
		C.remove_modifiers_of_type(/datum/modifier/changeling/thermal_sight)
//		C.permanent_sight_flags &= ~SEE_MOBS
//		C.dna.species.invis_sight = initial(user.dna.species.invis_sight)
	return 1
