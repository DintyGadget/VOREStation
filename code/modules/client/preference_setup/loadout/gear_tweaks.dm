#define LOADOUT_BAN_STRING "Custom loadout"

/datum/gear_tweak/proc/get_contents(var/metadata)
	return

/datum/gear_tweak/proc/get_metadata(var/user, var/metadata)
	return

/datum/gear_tweak/proc/get_default()
	return

/datum/gear_tweak/proc/tweak_gear_data(var/metadata, var/datum/gear_data)
	return

/datum/gear_tweak/proc/tweak_item(var/obj/item/I, var/metadata)
	return

/*
* Color adjustment
*/

/datum/gear_tweak/color
	var/list/valid_colors

/datum/gear_tweak/color/New(var/list/valid_colors)
	src.valid_colors = valid_colors
	..()

/datum/gear_tweak/color/get_contents(var/metadata)
	return "Цвет: <font color='[metadata]'>&#9899;</font>"

/datum/gear_tweak/color/get_default()
	return valid_colors ? valid_colors[1] : COLOR_GRAY

/datum/gear_tweak/color/get_metadata(var/user, var/metadata, var/title = "Предпочтения")
	if(valid_colors)
		return input(user, "Выберите цвет.", title, metadata) as null|anything in valid_colors
	return input(user, "Выберите цвет.", title, metadata) as color|null

/datum/gear_tweak/color/tweak_item(var/obj/item/I, var/metadata)
	if(valid_colors && !(metadata in valid_colors))
		return
	I.color = metadata

/*
* Path adjustment
*/

/datum/gear_tweak/path
	var/list/valid_paths

/datum/gear_tweak/path/New(var/list/valid_paths)
	src.valid_paths = valid_paths
	..()

/datum/gear_tweak/path/get_contents(var/metadata)
	return "Вид: [metadata]"

/datum/gear_tweak/path/get_default()
	return valid_paths[1]

/datum/gear_tweak/path/get_metadata(var/user, var/metadata)
	return input(user, "Выберите вид.", "Предпочтения", metadata) as null|anything in valid_paths

/datum/gear_tweak/path/tweak_gear_data(var/metadata, var/datum/gear_data/gear_data)
	if(!(metadata in valid_paths))
		return
	gear_data.path = valid_paths[metadata]

/*
* Content adjustment
*/

/datum/gear_tweak/contents
	var/list/valid_contents

/datum/gear_tweak/contents/New()
	valid_contents = args.Copy()
	..()

/datum/gear_tweak/contents/get_contents(var/metadata)
	return "Содержимое: [english_list(metadata, and_text = ", ")]"

/datum/gear_tweak/contents/get_default()
	. = list()
	for(var/i = 1 to valid_contents.len)
		. += "Случайно"

/datum/gear_tweak/contents/get_metadata(var/user, var/list/metadata)
	. = list()
	for(var/i = metadata.len to valid_contents.len)
		metadata += "Случайно"
	for(var/i = 1 to valid_contents.len)
		var/entry = input(user, "Выберите содержимое.", "Предпочтения", metadata[i]) as null|anything in (valid_contents[i] + list("Случайно", "Нет"))
		if(entry)
			. += entry
		else
			return metadata

/datum/gear_tweak/contents/tweak_item(var/obj/item/I, var/list/metadata)
	if(metadata.len != valid_contents.len)
		return
	for(var/i = 1 to valid_contents.len)
		var/path
		var/list/contents = valid_contents[i]
		if(metadata[i] == "Случайно")
			path = pick(contents)
			path = contents[path]
		else if(metadata[i] == "Нет")
			continue
		else
			path = 	contents[metadata[i]]
		new path(I)

/*
* Ragent adjustment
*/

/datum/gear_tweak/reagents
	var/list/valid_reagents

/datum/gear_tweak/reagents/New(var/list/reagents)
	valid_reagents = reagents.Copy()
	..()

/datum/gear_tweak/reagents/get_contents(var/metadata)
	return "Содержимое: [metadata]"

/datum/gear_tweak/reagents/get_default()
	return "Случайно"

/datum/gear_tweak/reagents/get_metadata(var/user, var/list/metadata)
	. = input(user, "Выберите содержимое.", "Предпочтения", metadata) as null|anything in (valid_reagents + list("Случайно", "Нет"))
	if(!.)
		return metadata

/datum/gear_tweak/reagents/tweak_item(var/obj/item/I, var/list/metadata)
	if(metadata == "Нет")
		return
	if(metadata == "Случайно")
		. = valid_reagents[pick(valid_reagents)]
	else
		. = valid_reagents[metadata]
	I.reagents.add_reagent(., I.reagents.get_free_space())

//Custom name and desciption code
//note to devs downstream: where 'gear_tweaks = list(gear_tweak_free_color_choice)' was used before for color selection
//in the loadout, now 'gear_tweaks += gear_tweak_free_color_choice' will need to be used, otherwise the item will not
// be able to be given a custom name or description
/*
Custom Name
*/

var/datum/gear_tweak/custom_name/gear_tweak_free_name = new()

/datum/gear_tweak/custom_name
	var/list/valid_custom_names

/datum/gear_tweak/custom_name/New(var/list/valid_custom_names)
	src.valid_custom_names = valid_custom_names
	..()

/datum/gear_tweak/custom_name/get_contents(var/metadata)
	return "Название: [metadata]"

/datum/gear_tweak/custom_name/get_default()
	return ""

/datum/gear_tweak/custom_name/get_metadata(var/user, var/metadata)
	if(jobban_isbanned(user, LOADOUT_BAN_STRING))
		to_chat(user, SPAN_WARNING("Вам запрещено использовать собственные описания и названия предметов."))
		return
	if(valid_custom_names)
		return input(user, "Введите название предмета.", "Предпочтения", metadata) as null|anything in valid_custom_names
	return sanitize(input(user, "Введите название предмета. Оставьте пустым для названия по умолчанию.", "Название предмета", metadata) as text|null, MAX_LNAME_LEN, extra = 0)

/datum/gear_tweak/custom_name/tweak_item(var/obj/item/I, var/metadata)
	if(!metadata)
		return I.name
	I.name = metadata

/*
Custom Description
*/
var/datum/gear_tweak/custom_desc/gear_tweak_free_desc = new()

/datum/gear_tweak/custom_desc
	var/list/valid_custom_desc

/datum/gear_tweak/custom_desc/New(var/list/valid_custom_desc)
	src.valid_custom_desc = valid_custom_desc
	..()

/datum/gear_tweak/custom_desc/get_contents(var/metadata)
	return "Описание: [metadata]"

/datum/gear_tweak/custom_desc/get_default()
	return ""

/datum/gear_tweak/custom_desc/get_metadata(var/user, var/metadata)
	if(jobban_isbanned(user, LOADOUT_BAN_STRING))
		to_chat(user, SPAN_WARNING("Вам запрещено использовать собственные описания и названия предметов."))
		return
	if(valid_custom_desc)
		return input(user, "Введите описание предмета.", "Предпочтения", metadata) as null|anything in valid_custom_desc
	return sanitize(input(user, "Введите описание предмета. Оставьте пустым для описания по умолчанию.", "Описание предмета", metadata) as message|null, extra = 0)

/datum/gear_tweak/custom_desc/tweak_item(var/obj/item/I, var/metadata)
	if(!metadata)
		return I.desc
	I.desc = metadata

//end of custom description

/datum/gear_tweak/tablet
	var/list/ValidProcessors = list(/obj/item/weapon/computer_hardware/processor_unit/small)
	var/list/ValidBatteries = list(/obj/item/weapon/computer_hardware/battery_module/nano, /obj/item/weapon/computer_hardware/battery_module/micro, /obj/item/weapon/computer_hardware/battery_module)
	var/list/ValidHardDrives = list(/obj/item/weapon/computer_hardware/hard_drive/micro, /obj/item/weapon/computer_hardware/hard_drive/small, /obj/item/weapon/computer_hardware/hard_drive)
	var/list/ValidNetworkCards = list(/obj/item/weapon/computer_hardware/network_card, /obj/item/weapon/computer_hardware/network_card/advanced)
	var/list/ValidNanoPrinters = list(null, /obj/item/weapon/computer_hardware/nano_printer)
	var/list/ValidCardSlots = list(null, /obj/item/weapon/computer_hardware/card_slot)
	var/list/ValidTeslaLinks = list(null, /obj/item/weapon/computer_hardware/tesla_link)

/datum/gear_tweak/tablet/get_contents(var/list/metadata)
	var/list/names = list()
	var/obj/O = ValidProcessors[metadata[1]]
	if(O)
		names += initial(O.name)
	O = ValidBatteries[metadata[2]]
	if(O)
		names += initial(O.name)
	O = ValidHardDrives[metadata[3]]
	if(O)
		names += initial(O.name)
	O = ValidNetworkCards[metadata[4]]
	if(O)
		names += initial(O.name)
	O = ValidNanoPrinters[metadata[5]]
	if(O)
		names += initial(O.name)
	O = ValidCardSlots[metadata[6]]
	if(O)
		names += initial(O.name)
	O = ValidTeslaLinks[metadata[7]]
	if(O)
		names += initial(O.name)
	return "[english_list(names, and_text = ", ")]"

/datum/gear_tweak/tablet/get_metadata(var/user, var/metadata)
	. = list()

	var/list/names = list()
	var/counter = 1
	for(var/i in ValidProcessors)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	var/entry = input(user, "Выберите процессор.", "Предпочтения") in names
	. += names[entry]

	names = list()
	counter = 1
	for(var/i in ValidBatteries)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	entry = input(user, "Выберите батарейку.", "Предпочтения") in names
	. += names[entry]

	names = list()
	counter = 1
	for(var/i in ValidHardDrives)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	entry = input(user, "Выберите жесткий диск.", "Предпочтения") in names
	. += names[entry]

	names = list()
	counter = 1
	for(var/i in ValidNetworkCards)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	entry = input(user, "Выберите сетевую карту.", "Предпочтения") in names
	. += names[entry]

	names = list()
	counter = 1
	for(var/i in ValidNanoPrinters)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	entry = input(user, "Выберите нанопринтер.", "Предпочтения") in names
	. += names[entry]

	names = list()
	counter = 1
	for(var/i in ValidCardSlots)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	entry = input(user, "Выберите слот карты.", "Предпочтения") in names
	. += names[entry]

	names = list()
	counter = 1
	for(var/i in ValidTeslaLinks)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	entry = input(user, "Выберите точку связи тесла.", "Предпочтения") in names
	. += names[entry]

/datum/gear_tweak/tablet/get_default()
	return list(1, 1, 1, 1, 1, 1, 1)

/datum/gear_tweak/tablet/tweak_item(var/obj/item/modular_computer/tablet/I, var/list/metadata)
	if(ValidProcessors[metadata[1]])
		var/t = ValidProcessors[metadata[1]]
		I.processor_unit = new t(I)
	if(ValidBatteries[metadata[2]])
		var/t = ValidBatteries[metadata[2]]
		I.battery_module = new t(I)
		I.battery_module.charge_to_full()
	if(ValidHardDrives[metadata[3]])
		var/t = ValidHardDrives[metadata[3]]
		I.hard_drive = new t(I)
	if(ValidNetworkCards[metadata[4]])
		var/t = ValidNetworkCards[metadata[4]]
		I.network_card = new t(I)
	if(ValidNanoPrinters[metadata[5]])
		var/t = ValidNanoPrinters[metadata[5]]
		I.nano_printer = new t(I)
	if(ValidCardSlots[metadata[6]])
		var/t = ValidCardSlots[metadata[6]]
		I.card_slot = new t(I)
	if(ValidTeslaLinks[metadata[7]])
		var/t = ValidTeslaLinks[metadata[7]]
		I.tesla_link = new t(I)
	I.update_verbs()

/datum/gear_tweak/laptop
	var/list/ValidProcessors = list(/obj/item/weapon/computer_hardware/processor_unit/small, /obj/item/weapon/computer_hardware/processor_unit)
	var/list/ValidBatteries = list(/obj/item/weapon/computer_hardware/battery_module, /obj/item/weapon/computer_hardware/battery_module/advanced, /obj/item/weapon/computer_hardware/battery_module/super)
	var/list/ValidHardDrives = list(/obj/item/weapon/computer_hardware/hard_drive, /obj/item/weapon/computer_hardware/hard_drive/advanced, /obj/item/weapon/computer_hardware/hard_drive/super)
	var/list/ValidNetworkCards = list(/obj/item/weapon/computer_hardware/network_card, /obj/item/weapon/computer_hardware/network_card/advanced)
	var/list/ValidNanoPrinters = list(null, /obj/item/weapon/computer_hardware/nano_printer)
	var/list/ValidCardSlots = list(null, /obj/item/weapon/computer_hardware/card_slot)
	var/list/ValidTeslaLinks = list(null, /obj/item/weapon/computer_hardware/tesla_link)

/datum/gear_tweak/laptop/get_contents(var/list/metadata)
	var/list/names = list()
	var/obj/O = ValidProcessors[metadata[1]]
	if(O)
		names += initial(O.name)
	O = ValidBatteries[metadata[2]]
	if(O)
		names += initial(O.name)
	O = ValidHardDrives[metadata[3]]
	if(O)
		names += initial(O.name)
	O = ValidNetworkCards[metadata[4]]
	if(O)
		names += initial(O.name)
	O = ValidNanoPrinters[metadata[5]]
	if(O)
		names += initial(O.name)
	O = ValidCardSlots[metadata[6]]
	if(O)
		names += initial(O.name)
	O = ValidTeslaLinks[metadata[7]]
	if(O)
		names += initial(O.name)
	return "[english_list(names, and_text = ", ")]"

/datum/gear_tweak/laptop/get_metadata(var/user, var/metadata)
	. = list()

	var/list/names = list()
	var/counter = 1
	for(var/i in ValidProcessors)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	var/entry = input(user, "Выберите процессор.", "Предпочтения") in names
	. += names[entry]

	names = list()
	counter = 1
	for(var/i in ValidBatteries)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	entry = input(user, "Выберите батарейку.", "Предпочтения") in names
	. += names[entry]

	names = list()
	counter = 1
	for(var/i in ValidHardDrives)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	entry = input(user, "Выберите жесткий диск.", "Предпочтения") in names
	. += names[entry]

	names = list()
	counter = 1
	for(var/i in ValidNetworkCards)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	entry = input(user, "Выберите сетевую карту.", "Предпочтения") in names
	. += names[entry]

	names = list()
	counter = 1
	for(var/i in ValidNanoPrinters)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	entry = input(user, "Выберите нанопринтер.", "Предпочтения") in names
	. += names[entry]

	names = list()
	counter = 1
	for(var/i in ValidCardSlots)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	entry = input(user, "Выберите слот карты.", "Предпочтения") in names
	. += names[entry]

	names = list()
	counter = 1
	for(var/i in ValidTeslaLinks)
		if(i)
			var/obj/O = i
			names[initial(O.name)] = counter++
		else
			names["None"] = counter++

	entry = input(user, "Выберите точку связи тесла.", "Предпочтения") in names
	. += names[entry]

/datum/gear_tweak/laptop/get_default()
	return list(1, 1, 1, 1, 1, 1, 1)

/datum/gear_tweak/laptop/tweak_item(var/obj/item/modular_computer/laptop/preset/I, var/list/metadata)
	if(ValidProcessors[metadata[1]])
		var/t = ValidProcessors[metadata[1]]
		I.processor_unit = new t(I)
	if(ValidBatteries[metadata[2]])
		var/t = ValidBatteries[metadata[2]]
		I.battery_module = new t(I)
		I.battery_module.charge_to_full()
	if(ValidHardDrives[metadata[3]])
		var/t = ValidHardDrives[metadata[3]]
		I.hard_drive = new t(I)
	if(ValidNetworkCards[metadata[4]])
		var/t = ValidNetworkCards[metadata[4]]
		I.network_card = new t(I)
	if(ValidNanoPrinters[metadata[5]])
		var/t = ValidNanoPrinters[metadata[5]]
		I.nano_printer = new t(I)
	if(ValidCardSlots[metadata[6]])
		var/t = ValidCardSlots[metadata[6]]
		I.card_slot = new t(I)
	if(ValidTeslaLinks[metadata[7]])
		var/t = ValidTeslaLinks[metadata[7]]
		I.tesla_link = new t(I)
	I.update_verbs()

/datum/gear_tweak/implant_location
	var/static/list/bodypart_names_to_tokens = list(
		"head" =       BP_HEAD,
		"upper body" = BP_TORSO,
		"lower body" = BP_GROIN,
		"left hand" =  BP_L_HAND,
		"left arm" =   BP_L_ARM,
		"right hand" = BP_R_HAND,
		"right arm" =  BP_R_ARM,
		"left foot" =  BP_L_FOOT,
		"left leg" =   BP_L_LEG,
		"right foot" = BP_R_FOOT,
		"right leg" =  BP_R_LEG
	)
	var/static/list/bodypart_tokens_to_names = list(
		BP_HEAD =       "head",
		BP_TORSO =      "upper body",
		BP_GROIN =      "lower body",
		BP_LEFT_HAND =  "left hand",
		BP_LEFT_ARM =   "left arm",
		BP_RIGHT_HAND = "right hand",
		BP_RIGHT_ARM =  "right arm",
		BP_LEFT_FOOT =  "left foot",
		BP_LEFT_LEG =   "left leg",
		BP_RIGHT_FOOT = "right foot",
		BP_RIGHT_LEG =  "right leg"
	)

/datum/gear_tweak/implant_location/get_default()
	return bodypart_names_to_tokens[1]

/datum/gear_tweak/implant_location/tweak_item(var/obj/item/weapon/implant/I, var/metadata)
	if(istype(I))
		I.initialize_loc = bodypart_names_to_tokens[metadata] || BP_TORSO

/datum/gear_tweak/implant_location/get_contents(var/metadata)
	return "Location: [metadata]"

/datum/gear_tweak/implant_location/get_metadata(var/user, var/metadata)
	return (input(user, "Select a bodypart for the implant to be implanted inside.", "Implant Location", metadata || "upper body") as null|anything in bodypart_names_to_tokens) || bodypart_tokens_to_names[BP_TORSO]

#undef LOADOUT_BAN_STRING