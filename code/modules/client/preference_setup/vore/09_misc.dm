/datum/category_item/player_setup_item/vore/misc
	name = "Misc Settings"
	sort_order = 9

/datum/category_item/player_setup_item/vore/misc/load_character(var/savefile/S)
	S["show_in_directory"]		>> pref.show_in_directory
	S["directory_tag"]			>> pref.directory_tag
	S["directory_erptag"]			>> pref.directory_erptag
	S["directory_ad"]			>> pref.directory_ad
	S["sensorpref"]				>> pref.sensorpref

/datum/category_item/player_setup_item/vore/misc/save_character(var/savefile/S)
	S["show_in_directory"]		<< pref.show_in_directory
	S["directory_tag"]			<< pref.directory_tag
	S["directory_erptag"]			<< pref.directory_erptag
	S["directory_ad"]			<< pref.directory_ad
	S["sensorpref"]				<< pref.sensorpref

/datum/category_item/player_setup_item/vore/misc/copy_to_mob(var/mob/living/carbon/human/character)
	if(pref.sensorpref > 5 || pref.sensorpref < 1)
		pref.sensorpref = 5
	character.sensorpref = pref.sensorpref

/datum/category_item/player_setup_item/vore/misc/sanitize_character()
	pref.show_in_directory		= sanitize_integer(pref.show_in_directory, 0, 1, initial(pref.show_in_directory))
	pref.directory_tag			= sanitize_inlist(pref.directory_tag, GLOB.char_directory_tags, initial(pref.directory_tag))
	pref.directory_erptag			= sanitize_inlist(pref.directory_erptag, GLOB.char_directory_erptags, initial(pref.directory_erptag))
	pref.sensorpref				= sanitize_integer(pref.sensorpref, 1, sensorpreflist.len, initial(pref.sensorpref))

/datum/category_item/player_setup_item/vore/misc/content(var/mob/user)
	. += "<br>"
	. += "<b>Отображать в Директории Персонажей:</b> <a [pref.show_in_directory ? "class='linkOn'" : ""] href='?src=\ref[src];toggle_show_in_directory=1'><b>[pref.show_in_directory ? "Да" : "Нет"]</b></a><br>"
	. += "<b>Предпочитаемая настройка датчиков:</b> <a [pref.sensorpref ? "" : ""] href='?src=\ref[src];toggle_sensor_setting=1'><b>[sensorpreflist[pref.sensorpref]]</b></a><br>"

/datum/category_item/player_setup_item/vore/misc/OnTopic(var/href, var/list/href_list, var/mob/user)
	if(href_list["toggle_show_in_directory"])
		pref.show_in_directory = pref.show_in_directory ? 0 : 1;
		return TOPIC_REFRESH
	else if(href_list["toggle_sensor_setting"])
		var/new_sensorpref = input(user, "Выберите предпочитаемую настройку датчиков персонажа", "Настройка Персонажа", sensorpreflist[pref.sensorpref]) as null|anything in sensorpreflist
		if (!isnull(new_sensorpref) && CanUseTopic(user))
			pref.sensorpref = sensorpreflist.Find(new_sensorpref)
			return TOPIC_REFRESH
	return ..();
