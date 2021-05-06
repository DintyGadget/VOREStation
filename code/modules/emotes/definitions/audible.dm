/decl/emote/audible
	key = "burp"
	emote_message_3p = "рыгает."
	message_type = AUDIBLE_MESSAGE

/decl/emote/audible/New()
	. = ..()
	// Snips the 'USER' from 3p emote messages for radio.
	if(!emote_message_radio && emote_message_3p)
		emote_message_radio = emote_message_3p
	if(!emote_message_radio_synthetic && emote_message_synthetic_3p)
		emote_message_radio_synthetic = emote_message_synthetic_3p

/decl/emote/audible/deathgasp_alien
	key = "deathgasp"
	emote_message_3p = "издает убывающий гортанный визг, зеленая кровь пузырится из пасти."

/decl/emote/audible/whimper
	key = "whimper"
	emote_message_3p = "хнычет."

/decl/emote/audible/gasp
	key = "gasp"
	emote_message_3p = "задыхается."
	conscious = FALSE
	emote_volume = 120

/decl/emote/audible/gasp/get_emote_sound(var/atom/user)
	if(ishuman(user) && !check_synthetic(user))
		var/mob/living/carbon/human/H = user
		if(H.get_gender() == FEMALE)
			if(length(H.species.female_gasp_sound))
				return list(
					"sound" = H.species.female_gasp_sound,
					"vol" = emote_volume
				)
		else
			if(length(H.species.male_gasp_sound))
				return list(
					"sound" = H.species.male_gasp_sound,
					"vol" = emote_volume
				)
	return ..()

/decl/emote/audible/scretch
	key = "scretch"
	emote_message_3p = "scretches."

/decl/emote/audible/choke
	key ="choke"
	emote_message_3p = "задыхается."
	conscious = FALSE

/decl/emote/audible/gnarl
	key = "gnarl"
	emote_message_3p = "корчится и показывает USER_THEIR зубы."

/decl/emote/audible/multichirp
	key = "mchirp"
	emote_message_3p = "чирикает припев нот!"
	emote_sound = 'sound/voice/multichirp.ogg'

/decl/emote/audible/alarm
	key = "alarm"
	emote_message_1p = "Вы бьете тревогу."
	emote_message_3p = "бьет тревогу."

/decl/emote/audible/alert
	key = "alert"
	emote_message_1p = "Вы испускаете тревожный звук."
	emote_message_3p = "испускает тревожный звук."

/decl/emote/audible/notice
	key = "notice"
	emote_message_1p = "Вы играете громким тоном."
	emote_message_3p = "играет громким тоном."

/decl/emote/audible/boop
	key = "boop"
	emote_message_1p = "You boop."
	emote_message_3p = "boops."

/decl/emote/audible/beep
	key = "beep"
	emote_message_3p = "Вы пищите"
	emote_message_3p = "пищит."
	emote_sound = 'sound/machines/twobeep.ogg'

/decl/emote/audible/sniff
	key = "sniff"
	emote_message_3p = "sniffs."

/decl/emote/audible/snore
	key = "snore"
	emote_message_3p = "храпит."
	conscious = FALSE
	emote_volume = 120

/decl/emote/audible/snore/get_emote_sound(var/atom/user)
	if(ishuman(user) && !check_synthetic(user))
		var/mob/living/carbon/human/H = user
		if(H.get_gender() == FEMALE)
			if(length(H.species.female_snore_sounds))
				return list(
					"sound" = H.species.female_snore_sounds,
					"vol" = emote_volume
				)
		else
			if(length(H.species.male_snore_sounds))
				return list(
					"sound" = H.species.male_snore_sounds,
					"vol" = emote_volume
				)
	return ..()

/decl/emote/audible/whimper
	key = "whimper"
	emote_message_3p = "хнычет."

/decl/emote/audible/yawn
	key = "yawn"
	emote_message_3p = "зевает."
	emote_volume = 120

/decl/emote/audible/yawn/get_emote_sound(var/atom/user)
	if(ishuman(user) && !check_synthetic(user))
		var/mob/living/carbon/human/H = user
		if(H.get_gender() == FEMALE)
			if(length(H.species.female_yawn_sounds))
				return list(
					"sound" = H.species.female_yawn_sounds,
					"vol" = emote_volume
				)
		else
			if(length(H.species.male_yawn_sounds))
				return list(
					"sound" = H.species.male_yawn_sounds,
					"vol" = emote_volume
				)
	return ..()

/decl/emote/audible/clap
	key = "clap"
	emote_message_3p = "хлопает."

/decl/emote/audible/chuckle
	key = "chuckle"
	emote_message_3p = "хихикает."

/decl/emote/audible/cry
	key = "cry"
	emote_message_3p = "плачет."
	emote_volume = 120

/decl/emote/audible/cry/get_emote_sound(var/atom/user)
	if(ishuman(user) && !check_synthetic(user))
		var/mob/living/carbon/human/H = user
		if(H.get_gender() == FEMALE)
			if(length(H.species.female_cry_sounds))
				return list(
					"sound" = H.species.female_cry_sounds,
					"vol" = emote_volume
				)
		else
			if(length(H.species.male_cry_sounds))
				return list(
					"sound" = H.species.male_cry_sounds,
					"vol" = emote_volume
				)
	return ..()

/decl/emote/audible/sigh
	key = "sigh"
	emote_message_3p = "вздыхает."
	emote_volume = 120

/decl/emote/audible/sigh/get_emote_sound(var/atom/user)
	if(ishuman(user) && !check_synthetic(user))
		var/mob/living/carbon/human/H = user
		if(H.get_gender() == FEMALE)
			if(length(H.species.female_sigh_sounds))
				return list(
					"sound" = H.species.female_sigh_sounds,
					"vol" = emote_volume
				)
		else
			if(length(H.species.male_sigh_sounds))
				return list(
					"sound" = H.species.male_sigh_sounds,
					"vol" = emote_volume
				)
	return ..()

/decl/emote/audible/laugh
	key = "laugh"
	emote_message_3p_target = "смеется над TARGET."
	emote_message_3p = "смеется."
	emote_volume = 120

/decl/emote/audible/laugh/get_emote_sound(var/atom/user)
	if(ishuman(user) && !check_synthetic(user))
		var/mob/living/carbon/human/H = user
		if(H.get_gender() == FEMALE)
			if(length(H.species.female_laugh_sounds))
				return list(
					"sound" = H.species.female_laugh_sounds,
					"vol" = emote_volume
				)
		else
			if(length(H.species.male_laugh_sounds))
				return list(
					"sound" = H.species.male_laugh_sounds,
					"vol" = emote_volume
				)
	return ..()

/decl/emote/audible/mumble
	key = "mumble"
	emote_message_3p = "mumbles!"

/decl/emote/audible/grumble
	key = "grumble"
	emote_message_3p = "grumbles!"

/decl/emote/audible/groan
	key = "groan"
	emote_message_3p = "groans!"
	conscious = FALSE

/decl/emote/audible/moan
	key = "moan"
	emote_message_3p = "стонет!"
	conscious = FALSE
	emote_volume = 120

/decl/emote/audible/moan/get_emote_sound(var/atom/user)
	if(ishuman(user) && !check_synthetic(user))
		var/mob/living/carbon/human/H = user
		if(H.get_gender() == FEMALE)
			if(length(H.species.female_moan_sounds))
				return list(
					"sound" = H.species.female_moan_sounds,
					"vol" = emote_volume
				)
		else
			if(length(H.species.male_moan_sounds))
				return list(
					"sound" = H.species.male_moan_sounds,
					"vol" = emote_volume
				)
	return ..()

/decl/emote/audible/giggle
	key = "giggle"
	emote_message_3p = "хихикает."
	emote_volume = 120

/decl/emote/audible/giggle/get_emote_sound(var/atom/user)
	if(ishuman(user) && !check_synthetic(user))
		var/mob/living/carbon/human/H = user
		if(H.get_gender() == FEMALE)
			if(length(H.species.female_giggle_sounds))
				return list(
					"sound" = H.species.female_giggle_sounds,
					"vol" = emote_volume
				)
		else
			if(length(H.species.male_giggle_sounds))
				return list(
					"sound" = H.species.male_giggle_sounds,
					"vol" = emote_volume
				)
	return ..()

/decl/emote/audible/grunt
	key = "grunt"
	emote_message_3p = "ворчит."

/decl/emote/audible/bug_hiss
	key ="hiss"
	emote_message_3p_target = "шипит на TARGET."
	emote_message_3p = "шипит."
	emote_sound = 'sound/voice/BugHiss.ogg'

/decl/emote/audible/bug_buzz
	key ="buzz"
	emote_message_3p = "жужжит крыльями."
	emote_sound = 'sound/voice/BugBuzz.ogg'

/decl/emote/audible/bug_chitter
	key ="chitter"
	emote_message_3p = "бубнит."
	emote_sound = 'sound/voice/Bug.ogg'

/decl/emote/audible/roar
	key = "roar"
	emote_message_3p = "ревет!"

/decl/emote/audible/bellow
	key = "bellow"
	emote_message_3p = "bellows!"

/decl/emote/audible/howl
	key = "howl"
	emote_message_3p = "воет!"

/decl/emote/audible/wheeze
	key = "wheeze"
	emote_message_3p = "хрипит."

/decl/emote/audible/hiss
	key = "hiss"
	emote_message_3p_target = "тихо шипит на TARGET."
	emote_message_3p = "тихо шипит."

/decl/emote/audible/chirp
	key = "chirp"
	emote_message_3p = "чирикает!"
	emote_sound = 'sound/misc/nymphchirp.ogg'

/decl/emote/audible/crack
	key = "crack"
	emote_message_3p = "хрустит USER_THEIR пальцами."
	emote_sound = 'sound/voice/knuckles.ogg'

/decl/emote/audible/squish
	key = "squish"
	emote_sound = 'sound/effects/slime_squish.ogg' //Credit to DrMinky (freesound.org) for the sound.
	emote_message_3p = "хлюпает."

/decl/emote/audible/warble
	key = "warble"
	emote_sound = 'sound/effects/warble.ogg' // Copyright CC BY 3.0 alienistcog (freesound.org) for the sound.
	emote_message_3p = "warbles."

/decl/emote/audible/vox_shriek
	key = "shriek"
	emote_message_3p = "SHRIEKS!"
	emote_sound = 'sound/voice/shriek1.ogg'

/decl/emote/audible/purr
	key = "purr"
	emote_message_3p = "мурлычет."
	emote_sound = 'sound/voice/cat_purr.ogg'

/decl/emote/audible/purrlong
	key = "purrl"
	emote_message_3p = "мурлычет."
	emote_sound = 'sound/voice/cat_purr_long.ogg'

/decl/emote/audible/teshsqueak
	key = "surprised"
	emote_message_1p = "Вы чирикаете от удивления!"
	emote_message_3p = "чирикает от удивления!"
	emote_message_1p_target = "Вы чирикаете от удивления на TARGET!"
	emote_message_3p_target = "чирикает от удивления на TARGET!"
	emote_sound = 'sound/voice/teshsqueak.ogg' // Copyright CC BY 3.0 InspectorJ (freesound.org) for the source audio.

/decl/emote/audible/teshchirp
	key = "chirp"
	emote_message_1p = "You chirp!"
	emote_message_3p = "chirps!"
	emote_message_1p_target = "You chirp at TARGET!"
	emote_message_3p_target = "chirps at TARGET!"
	emote_sound = 'sound/voice/teshchirp.ogg' // Copyright Sampling+ 1.0 Incarnidine (freesound.org) for the source audio.

/decl/emote/audible/teshtrill
	key = "trill"
	emote_message_1p = "You trill."
	emote_message_3p = "trills."
	emote_message_1p_target = "You trill at TARGET."
	emote_message_3p_target = "trills at TARGET."
	emote_sound = 'sound/voice/teshtrill.ogg' // Copyright CC BY-NC 3.0 Arnaud Coutancier (freesound.org) for the source audio.
