// Ignition, but confined to the modifier system.
// This makes it more predictable and thus, easier to balance.
/datum/modifier/fire
	name = "on fire"
	desc = "Вы находитесь в огне! Вам будет причинен вред, пока огонь не погаснет или вы не потушите его водой."
	mob_overlay_state = "on_fire"

	on_created_text = "<span class='danger'>Вы загорелись!</span>"
	on_expired_text = "<span class='warning'>Огонь начинает угасать.</span>"
	stacks = MODIFIER_STACK_ALLOWED // Multiple instances will hurt a lot.
	var/damage_per_tick = 5

/datum/modifier/fire/intense
	mob_overlay_state = "on_fire_intense"
	damage_per_tick = 10

/datum/modifier/fire/tick()
	holder.inflict_heat_damage(damage_per_tick)

/datum/modifier/fire/weak
	damage_per_tick = 1

/*
 * Modifier used by projectiles, like the flamethrower, that rely heavily on fire_stacks to persist.
 */

/datum/modifier/fire/stack_managed/tick()
	..()

	if(!holder.fire_stacks || holder.fire_stacks < 0)
		if(prob(10))
			expire()

	else if(holder.fire_stacks > 0)
		holder.fire_stacks -= 0.5

/datum/modifier/fire/stack_managed/intense
	mob_overlay_state = "on_fire_intense"
	damage_per_tick = 10

/datum/modifier/fire/stack_managed/weak
	damage_per_tick = 1
