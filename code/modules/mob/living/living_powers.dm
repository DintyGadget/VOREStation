/mob/living/proc/reveal(var/silent, var/message = "<span class='warning'>You have been revealed! You are no longer hidden.</span>")
	if(status_flags & HIDING)
		status_flags &= ~HIDING
		reset_plane_and_layer()
		if(!silent && message)
			to_chat(src, message)

/mob/living/proc/hide()
	set name = "Спрятаться"
	set desc = "Allows to hide beneath tables or certain items. Toggled on or off."
	set category = "Abilities"

	if(stat == DEAD || paralysis || weakened || stunned || restrained() || buckled || LAZYLEN(grabbed_by) || has_buckled_mobs()) //VORE EDIT: Check for has_buckled_mobs() (taur riding)
		return

	if(status_flags & HIDING)
		reveal("<span class='notice'>Вы перестали прятаться.</span>")
	else
		status_flags |= HIDING
		layer = HIDING_LAYER //Just above cables with their 2.44
		plane = OBJ_PLANE
		to_chat(src,"<span class='notice'>Вы сейчас прячетесь.</span>")

/mob/living/proc/toggle_selfsurgery()
	set name = "Разрешить операцию на себе"
	set desc = "Включает \"меры безопасности\" при самостоятельной операции, позволяя вам это сделать."
	set category = "Object"

	allow_self_surgery = !allow_self_surgery

	to_chat(usr, "<span class='notice'>Вы [allow_self_surgery ? "можете" : "не можете"] прооперировать себя самостоятельно.</span>")
	log_admin("DEBUG \[[world.timeofday]\]: [src.ckey ? "[src.name]:([src.ckey])" : "[src.name]"] has [allow_self_surgery ? "Enabled" : "Disabled"] self surgery.")
