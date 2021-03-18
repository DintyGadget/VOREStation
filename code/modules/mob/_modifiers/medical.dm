
/*
 * Modifiers applied by Medical sources.
 */

/datum/modifier/bloodpump
	name = "external blood pumping"
	desc = "Ваша кровь течет благодаря чудесной силе науки."

	on_created_text = "<span class='notice'>Вы чувствуете себя живым.</span>"
	on_expired_text = "<span class='notice'>Вы чувствуете себя .. менее живым.</span>"
	stacks = MODIFIER_STACK_EXTEND

	pulse_set_level = PULSE_NORM

/datum/modifier/bloodpump/check_if_valid()
	..()
	if(holder.stat == DEAD)
		src.expire()

/datum/modifier/bloodpump_corpse
	name = "forced blood pumping"
	desc = "Ваша кровь течет благодаря чудесной силе науки."

	on_created_text = "<span class='notice'>Вы чувствуете себя живым.</span>"
	on_expired_text = "<span class='notice'>Вы чувствуете себя .. менее живым.</span>"
	stacks = MODIFIER_STACK_EXTEND

	pulse_set_level = PULSE_SLOW

/datum/modifier/bloodpump/corpse/check_if_valid()
	..()
	if(holder.stat != DEAD)
		src.expire()

/*
 * Modifiers caused by chemicals or organs specifically.
 */

/datum/modifier/cryogelled
	name = "cryogelled"
	desc = "Ваше тело начинает мерзнуть."
	mob_overlay_state = "chilled"

	on_created_text = "<span class='danger'>Вы чувствуете, что вот-вот замерзнете! Трудно двигаться.</span>"
	on_expired_text = "<span class='warning'>Теперь вы чувствуете себя немного теплее и подвижнее.</span>"
	stacks = MODIFIER_STACK_ALLOWED

	slowdown = 0.1
	evasion = -5
	attack_speed_percent = 1.1
	disable_duration_percent = 1.05

/datum/modifier/clone_stabilizer
	name = "clone stabilized"
	desc = "Регенерация вашего тела сильно ограничена."

	on_created_text = "<span class='danger'>Вас тошнит.</span>"
	on_expired_text = "<span class='warning'>Вы чувствуете себя здоровее.</span>"
	stacks = MODIFIER_STACK_EXTEND

	incoming_healing_percent = 0.1
