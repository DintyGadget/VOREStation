// Body weight limits on a character.
#define WEIGHT_MIN 70
#define WEIGHT_MAX 500
#define WEIGHT_CHANGE_MIN 0
#define WEIGHT_CHANGE_MAX 100

// Define a place to save in character setup
/datum/preferences
	var/size_multiplier = RESIZE_NORMAL
	// Body weight stuff.
	var/weight_vr = 137		// bodyweight of character (pounds, because I'm not doing the math again -Spades)
	var/weight_gain = 100	// Weight gain rate.
	var/weight_loss = 50	// Weight loss rate.
	var/fuzzy = 0			// Preference toggle for sharp/fuzzy icon. Default sharp.

// Definition of the stuff for Sizing
/datum/category_item/player_setup_item/vore/size
	name = "Size"
	sort_order = 2

/datum/category_item/player_setup_item/vore/size/load_character(var/savefile/S)
	S["size_multiplier"]	>> pref.size_multiplier
	S["weight_vr"]			>> pref.weight_vr
	S["weight_gain"]		>> pref.weight_gain
	S["weight_loss"]		>> pref.weight_loss
	S["fuzzy"]				>> pref.fuzzy

/datum/category_item/player_setup_item/vore/size/save_character(var/savefile/S)
	S["size_multiplier"]	<< pref.size_multiplier
	S["weight_vr"]			<< pref.weight_vr
	S["weight_gain"]		<< pref.weight_gain
	S["weight_loss"]		<< pref.weight_loss
	S["fuzzy"]				<< pref.fuzzy

/datum/category_item/player_setup_item/vore/size/sanitize_character()
	pref.weight_vr			= sanitize_integer(pref.weight_vr, WEIGHT_MIN, WEIGHT_MAX, initial(pref.weight_vr))
	pref.weight_gain		= sanitize_integer(pref.weight_gain, WEIGHT_CHANGE_MIN, WEIGHT_CHANGE_MAX, initial(pref.weight_gain))
	pref.weight_loss		= sanitize_integer(pref.weight_loss, WEIGHT_CHANGE_MIN, WEIGHT_CHANGE_MAX, initial(pref.weight_loss))
	pref.fuzzy				= sanitize_integer(pref.fuzzy, 0, 1, initial(pref.fuzzy))
	if(pref.size_multiplier == null || pref.size_multiplier < RESIZE_TINY || pref.size_multiplier > RESIZE_HUGE)
		pref.size_multiplier = initial(pref.size_multiplier)

/datum/category_item/player_setup_item/vore/size/copy_to_mob(var/mob/living/carbon/human/character)
	character.weight			= pref.weight_vr
	character.weight_gain		= pref.weight_gain
	character.weight_loss		= pref.weight_loss
	character.fuzzy				= pref.fuzzy
	character.resize(pref.size_multiplier, animate = FALSE)

/datum/category_item/player_setup_item/vore/size/content(var/mob/user)
	. += "<br>"
	. += "<b>Размер:</b> <a href='?src=\ref[src];size_multiplier=1'>[round(pref.size_multiplier*100)]%</a><br>"
	. += "<b>Масштабирование:</b> <a [pref.fuzzy ? "" : ""] href='?src=\ref[src];toggle_fuzzy=1'><b>[pref.fuzzy ? "Нечеткое" : "Резкое"]</b></a><br>"
	. += "<br>"
	. += "<b>Относительный вес:</b>  <a href='?src=\ref[src];weight=1'>[pref.weight_vr]</a><br>"
	. += "<b>Скорость увеличения веса:</b> <a href='?src=\ref[src];weight_gain=1'>[pref.weight_gain]</a><br>"
	. += "<b>Скорость потери веса:</b> <a href='?src=\ref[src];weight_loss=1'>[pref.weight_loss]</a><br>"

/datum/category_item/player_setup_item/vore/size/OnTopic(var/href, var/list/href_list, var/mob/user)
	if(href_list["size_multiplier"])
		var/new_size = input(user, "Выберите размер Вашего персонажа в пределах от 50% до 200%", "Установка Размера") as num|null
		if (!ISINRANGE(new_size,25,200))
			pref.size_multiplier = 1
			to_chat(user, "<span class='notice'>Недопустимый размер.</span>")
			return TOPIC_REFRESH_UPDATE_PREVIEW
		else if(new_size)
			pref.size_multiplier = (new_size/100)
			return TOPIC_REFRESH_UPDATE_PREVIEW

	else if(href_list["toggle_fuzzy"])
		pref.fuzzy = pref.fuzzy ? 0 : 1;
		return TOPIC_REFRESH_UPDATE_PREVIEW

	else if(href_list["weight"])
		var/new_weight = input(user, "Выберите относительную массу тела Вашего персонажа.\n\
			Это измерение должно быть установлено относительно тела обычного человека ростом 175 см, а не фактического размера вашего персонажа.\n\
			Если Вы установите свой вес на 500, потому что Вы нага или у Вас металлические имплантанты, и начнёте жаловаться на то, что не можете ходить, клянусь богом,\n\
			я найду Вас и вмажу Вам за то, что не прочитали инструкцию!\n\
			([WEIGHT_MIN]-[WEIGHT_MAX])", "Изменение Персонажа") as num|null
		if(new_weight)
			var/unit_of_measurement = alert(user, "Это в фунтах или килограммах?", "Подтверждение", "Фунты", "Килограммы")
			if(unit_of_measurement == "Фунты")
				new_weight = round(text2num(new_weight),4)
			if(unit_of_measurement == "Килограммы")
				new_weight = round(2.20462*text2num(new_weight),4)
			pref.weight_vr = sanitize_integer(new_weight, WEIGHT_MIN, WEIGHT_MAX, pref.weight_vr)
			return TOPIC_REFRESH

	else if(href_list["weight_gain"])
		var/weight_gain_rate = input(user, "Выберите скорость набора веса Вашим персонажем \
			от 100% (реалистично) до 0% (не набирается).\n\
			(для отключения, выставьте 0.01, округлится до 0)\
			([WEIGHT_CHANGE_MIN]-[WEIGHT_CHANGE_MAX])", "Изменение Персонажаe") as num|null
		if(weight_gain_rate)
			pref.weight_gain = round(text2num(weight_gain_rate),1)
			return TOPIC_REFRESH

	else if(href_list["weight_loss"])
		var/weight_loss_rate = input(user, "Выберите скорость потери веса Вами персонажем \
			от 100% (реалистично) до 0% (нет потери).\n\
			(для отключения, выставьте 0.01,округлится до 0)\
			([WEIGHT_CHANGE_MIN]-[WEIGHT_CHANGE_MAX])", "Изменение Персонажа") as num|null
		if(weight_loss_rate)
			pref.weight_loss = round(text2num(weight_loss_rate),1)
			return TOPIC_REFRESH

	return ..();
