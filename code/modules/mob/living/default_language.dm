/mob/living
	var/datum/language/default_language

/mob/living/verb/set_default_language(language as null|anything in languages)
	set name = "Переключить язык"
	set category = "IC"

	if (only_species_language && language != GLOB.all_languages[src.species_language])
		to_chat(src, "<span class='notice'>Вы можете говорить только на языке своей расы, [src.species_language].</span>")
		return 0

	if(language == GLOB.all_languages[src.species_language])
		to_chat(src, "<span class='notice'>Теперь вы будете говорить на, [language ? language : "всеобщием"] языке по умолчанию, если вы не укажете язык при разговоре.</span>")
	else if (language)

		if(language && !can_speak(language))
			to_chat(src, "<span class='notice'>Вы не говорите на этом языке.</span>")
			return

		to_chat(src, "<span class='notice'>Теперь вы будете говорить на [language], если не укажете язык при разговоре.</span>")
	else
		to_chat(src, "<span class='notice'>Теперь вы будете говорить на любом стандартном языке по умолчанию, если вы не укажете его при разговоре.</span>")
	default_language = language

// Silicons can't neccessarily speak everything in their languages list
/mob/living/silicon/set_default_language(language as null|anything in speech_synthesizer_langs)
	..()

/mob/living/verb/check_default_language()
	set name = "Текущий язык"
	set category = "IC"

	if(default_language)
		to_chat(src, "<span class='notice'>По умолчанию вы в настоящее время говорите на [default_language].</span>")
	else
		to_chat(src, "<span class='notice'>Ваш текущий язык по умолчанию, язык вашей расы.</span>")
