/decl/emote/audible/scream
	key = "scream"
	emote_message_1p = "Вы кричите!"
	emote_message_3p = "кричит!"
	emote_volume = 120

/decl/emote/audible/scream/get_emote_message_1p(var/atom/user, var/atom/target, var/extra_params)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		return "You [H.species.scream_verb_1p]!"
	. = ..()

/decl/emote/audible/cough/get_emote_message_3p(var/atom/user, var/atom/target, var/extra_params)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		return "[H.species.scream_verb_3p]!"
	. = ..()

/decl/emote/audible/scream/get_emote_sound(var/atom/user)
	if(ishuman(user) && !check_synthetic(user))
		var/mob/living/carbon/human/H = user
		if(H.get_gender() == FEMALE)
			if(length(H.species.female_scream_sound))
				return list(
					"sound" = H.species.female_scream_sound,
					"vol" = emote_volume
				)
		else
			if(length(H.species.male_scream_sound))
				return list(
					"sound" = H.species.male_scream_sound,
					"vol" = emote_volume
				)
	return ..()