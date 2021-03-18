/*
 *	Modifier applied to newly cloned people.
 */

// Gives rather nasty downsides for awhile, making them less robust.
/datum/modifier/cloning_sickness
	name = "cloning sickness"
	desc = "Вы чувствуете себя слабоватым, будучи клонированным не так давно."

	on_created_text = "<span class='warning'><font size='3'>Вы чувствуете себя очень слабым.</font></span>"
	on_expired_text = "<span class='notice'><font size='3'>Вы чувствуете, как ваша сила возвращается к вам.</font></span>"

	max_health_percent = 0.6				// -40% max health.
	incoming_damage_percent = 1.1			// 10% more incoming damage.
	outgoing_melee_damage_percent = 0.7		// 30% less melee damage.
	disable_duration_percent = 1.25			// Stuns last 25% longer.
	slowdown = 1							// Slower.
	evasion = -15							// 15% easier to hit.

// Tracks number of deaths, one modifier added per cloning
/datum/modifier/cloned
	name = "cloned"
	desc = "Вы умерли и были клонированы, и вы никогда не сможете этого забыть."

	flags = MODIFIER_GENETIC			// So it gets copied if they die and get cloned again.
	stacks = MODIFIER_STACK_ALLOWED		// Two deaths means two instances of this.

// Prevents cloning, actual effect is on the cloning machine
/datum/modifier/no_clone
	name = "Cloning Incompatability"
	desc = "По какой-то причине вас нельзя клонировать."

	//WIP, but these may never be seen anyway, so *shrug
	on_created_text = "<span class='warning'>Жизнь внезапно становится более драгоценной.</span>"
	on_expired_text = "<span class='notice'>Смерть наступила снова, как дешева.</span>"

	flags = MODIFIER_GENETIC


// Prevents borging (specifically the MMI part), actual effect is on the MMI.
/datum/modifier/no_borg
	name = "Cybernetic Incompatability"
	desc = "По какой-то причине ваш мозг несовместим с прямыми кибернетическими интерфейсами, такими как MMI."

	flags = MODIFIER_GENETIC

//////////////////////////////////////
//Species-Specific Cloning Modifiers//
/////////////////////////////////////

/datum/modifier/cloning_sickness/promethean
	name = "reformation sickness"
	desc = "Ваше ядро кажется повреждено, так как вы были преобразованы с использованием неподходящего оборудования."

	on_created_text = "<span class='warning'><font size='3'>Ваше ядро болит.</font></span>"
	on_expired_text = "<span class='notice'><font size='3'>Вы чувствуете, как сила вашего ядра возвращается в норму.</font></span>"

	incoming_damage_percent = 1 //Level the incoming damage from the parent modifier. They already take 200% burn.
	incoming_brute_damage_percent = 1.5 //150% incoming brute damage. Decreases the effectiveness of their 0.75 modifier.
	incoming_hal_damage_percent = 1.25 //125% incoming halloss.

	outgoing_melee_damage_percent = 0.5 //50% less outgoing melee damage.
	attack_speed_percent = 1.2 //20% slower attack speed.

//////////////////////
//Surgical Modifiers// As of writing, limited to the 'Frankenstein' modifier.
//////////////////////

/datum/modifier/franken_sickness
	name = "surgically attached brain"
	desc = "Вы чувствуете слабость, поскольку ваша центральная нервная система все еще нормализуется после восстановления."

	on_created_text = "<span class='warning'><font size='3'>Вы чувствуете себя ... как не себя, и у вас болит голова.</font></span>"
	on_expired_text = "<span class='notice'><font size='3'>Вы чувствуете, как к вам возвращается какая-то сила.</font></span>"

	max_health_percent = 0.9				// -10% max health.
	incoming_damage_percent = 1.1			// 10% more incoming damage.
	incoming_hal_damage_percent = 1.5		// 50% more halloss damage, stacking on the previous 1.1 widespread.
	outgoing_melee_damage_percent = 0.9		// 10% less melee damage.
	disable_duration_percent = 1.25			// Stuns last 25% longer.
	incoming_healing_percent = 0.9			// -10% to all healing
	slowdown = 0.5							// Slower, by a smidge.
	evasion = -5							// 5% easier to hit.
	accuracy_dispersion = 1					// Inaccurate trait level of tile dispersion.

	stacks = MODIFIER_STACK_ALLOWED //You have somehow had the surgery done twice. Your brain is very, very fucked, but I won't say no.

/datum/modifier/franken_sickness/can_apply(var/mob/living/L)
	if(!ishuman(L))
		return FALSE
	if(L.isSynthetic()) //Nonhumans and Machines cannot be Frankensteined, at this time.
		return FALSE

	return ..()

/datum/modifier/franken_sickness/tick()
	if(holder.stat != DEAD)
		if(istype(holder, /mob/living/carbon/human))
			var/mob/living/carbon/human/F = holder
			if(F.can_defib)
				F.can_defib = 0

/datum/modifier/franken_sickness/on_expire() //Not permanent, but its child is.
	holder.add_modifier(/datum/modifier/franken_recovery, 0)

/datum/modifier/franken_recovery //When Franken_Sickness expires, this will be permanently applied in its place.
	name = "neural recovery"
	desc = "Вы чувствуете себя не в своей тарелке, поскольку ваша центральная нервная система все еще нормализуется после восстановления."

	on_created_text = "<span class='warning'><font size='3'>Вы чувствуете... Что все расплывается.</font></span>"
	on_expired_text = "<span class='notice'><font size='3'>Вы чувствуете, как к вам возвращаются ваши чувства.</font></span>"

	incoming_hal_damage_percent = 1.5		// 50% more halloss damage.
	disable_duration_percent = 1.25			// Stuns last 25% longer.
	evasion = -5							// 5% easier to hit.
	accuracy_dispersion = 1					// Inaccurate trait level of tile dispersion.

	stacks = MODIFIER_STACK_ALLOWED

/datum/modifier/franken_recovery/can_apply(var/mob/living/L)
	if(!ishuman(L))
		return FALSE
	if(L.isSynthetic()) //Nonhumans and Machines cannot be Frankensteined, at this time.
		return FALSE

	return ..()
