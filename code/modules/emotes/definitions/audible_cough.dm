/decl/emote/audible/cough
	key = "cough"
	emote_message_1p = "Вы кашляете!"
	emote_message_1p_target = "Вы кашляете на TARGET!"
	emote_message_3p = "кашляет!"
	emote_message_3p_target = "кашляет на TARGET!"
	emote_message_synthetic_1p_target = "Вы кашляете в сторону TARGET."
	emote_message_synthetic_1p = "Вы испускаете роботизированный кашель."
	emote_message_synthetic_3p_target = "издает роботизированный кашель в сторону TARGET."
	emote_message_synthetic_3p = "издает роботизированный кашель."
	emote_volume = 120
	emote_volume_synthetic = 50

	conscious = FALSE
	emote_sound_synthetic = list(
		FEMALE = list(
			'sound/effects/mob_effects/f_machine_cougha.ogg',
			'sound/effects/mob_effects/f_machine_coughb.ogg'
		),
		MALE = list(
			'sound/effects/mob_effects/m_machine_cougha.ogg',
			'sound/effects/mob_effects/m_machine_coughb.ogg',
			'sound/effects/mob_effects/m_machine_coughc.ogg'
		),
		NEUTER = list(
			'sound/effects/mob_effects/m_machine_cougha.ogg',
			'sound/effects/mob_effects/m_machine_coughb.ogg',
			'sound/effects/mob_effects/m_machine_coughc.ogg'
		),
		PLURAL = list(
			'sound/effects/mob_effects/m_machine_cougha.ogg',
			'sound/effects/mob_effects/m_machine_coughb.ogg',
			'sound/effects/mob_effects/m_machine_coughc.ogg'
		)
	)

/decl/emote/audible/cough/get_emote_sound(var/atom/user)
	if(ishuman(user) && !check_synthetic(user))
		var/mob/living/carbon/human/H = user
		if(H.get_gender() == FEMALE)
			if(length(H.species.female_cough_sounds))
				return list(
					"sound" = H.species.female_cough_sounds,
					"vol" = emote_volume
				)
		else
			if(length(H.species.male_cough_sounds))
				return list(
					"sound" = H.species.male_cough_sounds,
					"vol" = emote_volume
				)
	return ..()
