/proc/intonation(text)
	if (copytext_char(text,-1) == "!")
		text = "<b>[text]</b>"
	return text

/obj
	var/rugender = "unset"
	var/ncase = "ncase"
	var/gcase = "gcase"
	var/dcase = "dcase"
	var/acase = "acase"
	var/icase = "icase"
	var/pcase = "pcase"

/proc/ru_countreagents(var/input, single_text = "единица", few_text = "единицы", many_text = "единиц")
	var/a = input % 100
	var/b = input % 10
	if (a > 10 && a < 20)
		return "[input] [many_text]"
	if (b > 1 && b < 5)
		return "[input] [few_text]"
	if (b == 1)
		return "[input] [single_text]"
	return "[input] [many_text]"

/proc/ru_countitems(var/list/input, single_text = "единица", few_text = "единицы", many_text = "единиц")
	var/a = input.len % 100
	var/b = input.len % 10
	if (a > 10 && a < 20)
		return "[input.len] [many_text]"
	if (b > 1 && b < 5)
		return "[input.len] [few_text]"
	if (b == 1)
		return "[input.len] [single_text]"
	return "[input.len] [many_text]"

/proc/ru_getcase(var/obj/obj, case = "case")
	if(case == "ncase" && obj.rugender != "unset") return obj.ncase
	if(case == "gcase" && obj.rugender != "unset") return obj.gcase
	if(case == "dcase" && obj.rugender != "unset") return obj.dcase
	if(case == "acase" && obj.rugender != "unset") return obj.acase
	if(case == "icase" && obj.rugender != "unset") return obj.icase
	if(case == "pcase" && obj.rugender != "unset") return obj.pcase
	return obj.name

//Gives the mob verbs an ending
/proc/ru_g_mob(var/mob/user, base_verb = "", he_end = "", she_end = "а", it_end = "о", they_end = "и")
	var/datum/gender/user_gender = gender_datums[user.get_visible_gender()]
	switch(user_gender.ru_g_ncase)
		if("он") return "[base_verb][he_end]"
		if("она") return "[base_verb][she_end]"
		if("оно") return "[base_verb][it_end]"
		if("они") return "[base_verb][they_end]"
		else return "[base_verb][he_end]"

// Gives the object verb an ending
/proc/ru_g_obj(var/obj/obj, base_verb = "", male_pronoun = "", female_pronoun = "а", neuter_pronoun = "о", plural_pronoun = "ы")
	switch(obj.rugender)
		if("male") return "[base_verb][male_pronoun]"
		if("female") return "[base_verb][female_pronoun]"
		if("neuter") return "[base_verb][neuter_pronoun]"
		if("plural") return "[base_verb][plural_pronoun]"
		else return "[base_verb][male_pronoun]"
