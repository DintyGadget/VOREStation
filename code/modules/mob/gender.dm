
/var/list/gender_datums = list()

/hook/startup/proc/populate_gender_datum_list()
	for(var/type in typesof(/datum/gender))
		var/datum/gender/G = new type
		gender_datums[G.key] = G
	return 1

/datum/gender
	var/key  = "plural"

	var/He   = "Они"
	var/he   = "они"
	var/His  = "Их"
	var/his  = "их"
	var/him  = "их"
	var/has  = "have"
	var/is   = "are"
	var/does = "do"
	var/himself = "себя"
	var/s = ""
	var/hes = "они"

// XenosStation Edit: There's more pronouns in Russian so we're introducing those too
	var/ru_g_ncase = "они"
	var/ru_g_gcase = "их"
	var/ru_g_gcase_b = "их"
	var/ru_g_dcase = "им"
	var/ru_g_dcase_b = "ним"
	var/ru_g_acase = "их"
	var/ru_g_acase_b = "них"
	var/ru_g_icase = "ими"
	var/ru_g_icase_b = "ними"
	var/ru_g_pcase = "них"
// End of XenosStation Edit

/datum/gender/male
	key  = "male"

	He   = "Он"
	he   = "он"
	His  = "Его"
	his  = "его"
	him  = "его"
	has  = "has"
	is   = "is"
	does = "does"
	himself = "себя"
	s = ""
	hes = "он"

// XenosStation Edit
	ru_g_ncase = "он"
	ru_g_gcase = "его"
	ru_g_gcase_b = "него"
	ru_g_dcase = "ему"
	ru_g_dcase_b = "нему"
	ru_g_acase = "его"
	ru_g_acase_b = "него"
	ru_g_icase = "им"
	ru_g_icase_b = "ним"
	ru_g_pcase = "нём"
// End of XenosStation Edit

/datum/gender/female
	key  = "female"

	He   = "Она"
	he   = "она"
	His  = "Её"
	his  = "её"
	him  = "её"
	has  = "has"
	is   = "is"
	does = "does"
	himself = "себя"
	s = ""
	hes = "она"

// XenosStation Edit
	ru_g_ncase = "она"
	ru_g_gcase = "её"
	ru_g_gcase_b = "неё"
	ru_g_dcase = "ей"
	ru_g_dcase_b = "ней"
	ru_g_acase = "её"
	ru_g_acase_b = "неё"
	ru_g_icase = "ей"
	ru_g_icase_b = "ней"
	ru_g_pcase = "ней"
// End of XenosStation Edit

/datum/gender/neuter
	key = "neuter"

	He   = "Оно"
	he   = "он"
	His  = "его"
	his  = "его"
	him  = "его"
	has  = "has"
	is   = "is"
	does = "does"
	himself = "себя"
	s = ""
	hes = "оно"

// XenosStation Edit
	ru_g_ncase = "оно"
	ru_g_gcase = "его"
	ru_g_gcase_b = "него"
	ru_g_dcase = "ему"
	ru_g_dcase_b = "нему"
	ru_g_acase = "его"
	ru_g_acase_b = "него"
	ru_g_icase = "им"
	ru_g_icase_b = "ним"
	ru_g_pcase = "нём"
// End of XenosStation Edit
