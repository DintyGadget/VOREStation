/* First aid storage
 * Contains:
 *		First Aid Kits
 * 		Pill Bottles
 */

/*
 * First Aid Kits
 */
/obj/item/weapon/storage/firstaid
	name = "аптечка первой помощи"
	desc = "Это аптечка для тех, кто серьезно болтает."
	icon = 'icons/obj/storage.dmi'
	icon_state = "firstaid"
	throw_speed = 2
	throw_range = 8
	max_storage_space = ITEMSIZE_COST_SMALL * 7 // 14
	var/list/icon_variety
	drop_sound = 'sound/items/drop/cardboardbox.ogg'
	pickup_sound = 'sound/items/pickup/cardboardbox.ogg'

/obj/item/weapon/storage/firstaid/Initialize()
	. = ..()
	if(icon_variety)
		icon_state = pick(icon_variety)
		icon_variety = null

/obj/item/weapon/storage/firstaid/fire
	name = "аптечка первой помощи (пожар)"
	desc = "Это набор для оказания неотложной медицинской помощи на случай, когда лаборатория по изучению токсинов <i>самопроизвольно</i> возгорается."
	icon_state = "ointment"
	item_state_slots = list(slot_r_hand_str = "firstaid-ointment", slot_l_hand_str = "firstaid-ointment")
	//icon_variety = list("ointment","firefirstaid") //VOREStation Removal
	starts_with = list(
		/obj/item/device/healthanalyzer,
		/obj/item/weapon/reagent_containers/hypospray/autoinjector,
		/obj/item/stack/medical/ointment,
		/obj/item/stack/medical/ointment,
		/obj/item/weapon/reagent_containers/pill/kelotane,
		/obj/item/weapon/reagent_containers/pill/kelotane,
		/obj/item/weapon/reagent_containers/pill/kelotane
	)

/obj/item/weapon/storage/firstaid/regular
	icon_state = "firstaid"
	starts_with = list(
		/obj/item/stack/medical/bruise_pack,
		/obj/item/stack/medical/bruise_pack,
		/obj/item/stack/medical/bruise_pack,
		/obj/item/stack/medical/ointment,
		/obj/item/stack/medical/ointment,
		/obj/item/device/healthanalyzer,
		/obj/item/weapon/reagent_containers/hypospray/autoinjector
	)

/obj/item/weapon/storage/firstaid/toxin
	name = "аптечка первой помощи (яды)" //IRL the term used would be poison first aid kit.
	desc = "Используется для лечения, когда в организме много токсинов."
	icon_state = "antitoxin"
	item_state_slots = list(slot_r_hand_str = "firstaid-toxin", slot_l_hand_str = "firstaid-toxin")
	//icon_variety = list("antitoxin","antitoxfirstaid","antitoxfirstaid2","antitoxfirstaid3") //VOREStation Removal
	starts_with = list(
		/obj/item/weapon/reagent_containers/syringe/antitoxin,
		/obj/item/weapon/reagent_containers/syringe/antitoxin,
		/obj/item/weapon/reagent_containers/syringe/antitoxin,
		/obj/item/weapon/reagent_containers/pill/antitox,
		/obj/item/weapon/reagent_containers/pill/antitox,
		/obj/item/weapon/reagent_containers/pill/antitox,
		/obj/item/device/healthanalyzer
	)

/obj/item/weapon/storage/firstaid/o2
	name = "аптечка первой помощи (кислород)"
	desc = "Коробка с кислородными вкусностями."
	icon_state = "o2"
	item_state_slots = list(slot_r_hand_str = "firstaid-o2", slot_l_hand_str = "firstaid-o2")
	starts_with = list(
		/obj/item/weapon/reagent_containers/pill/dexalin,
		/obj/item/weapon/reagent_containers/pill/dexalin,
		/obj/item/weapon/reagent_containers/pill/dexalin,
		/obj/item/weapon/reagent_containers/pill/dexalin,
		/obj/item/weapon/reagent_containers/hypospray/autoinjector,
		/obj/item/weapon/reagent_containers/syringe/inaprovaline,
		/obj/item/device/healthanalyzer
	)

/obj/item/weapon/storage/firstaid/adv
	name = "продвинутая аптечка первой помощи"
	desc = "Содержит передовые методы лечения, для for <b>серьезных</b> проблем."
	icon_state = "advfirstaid"
	item_state_slots = list(slot_r_hand_str = "firstaid-advanced", slot_l_hand_str = "firstaid-advanced")
	starts_with = list(
		/obj/item/weapon/reagent_containers/hypospray/autoinjector,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/stack/medical/advanced/ointment,
		/obj/item/stack/medical/advanced/ointment,
		/obj/item/stack/medical/splint
	)

/obj/item/weapon/storage/firstaid/combat
	name = "боевая аптечка"
	desc = "Содержит передовые медицинские препараты."
	icon_state = "bezerk"
	item_state_slots = list(slot_r_hand_str = "firstaid-advanced", slot_l_hand_str = "firstaid-advanced")
	starts_with = list(
		/obj/item/weapon/storage/pill_bottle/bicaridine,
		/obj/item/weapon/storage/pill_bottle/dermaline,
		/obj/item/weapon/storage/pill_bottle/dexalin_plus,
		/obj/item/weapon/storage/pill_bottle/dylovene,
		/obj/item/weapon/storage/pill_bottle/tramadol,
		/obj/item/weapon/storage/pill_bottle/spaceacillin,
		/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/clotting,
		/obj/item/stack/medical/splint,
		/obj/item/device/healthanalyzer/advanced
	)

/obj/item/weapon/storage/firstaid/surgery
	name = "хирургический комплект"
	desc = "Содержит инструменты для хирургии. Имеет точную подгонку поролона для безопасной транспортировки и автоматически стерилизует содержимое между использованием."
	icon = 'icons/obj/storage.dmi' // VOREStation edit
	icon_state = "surgerykit"
	item_state = "firstaid-surgery"
	max_w_class = ITEMSIZE_NORMAL

	can_hold = list(
		/obj/item/weapon/surgical/bonesetter,
		/obj/item/weapon/surgical/cautery,
		/obj/item/weapon/surgical/circular_saw,
		/obj/item/weapon/surgical/hemostat,
		/obj/item/weapon/surgical/retractor,
		/obj/item/weapon/surgical/scalpel,
		/obj/item/weapon/surgical/surgicaldrill,
		/obj/item/weapon/surgical/bonegel,
		/obj/item/weapon/surgical/FixOVein,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/stack/nanopaste,
		/obj/item/device/healthanalyzer/advanced,
		/obj/item/weapon/autopsy_scanner
		)

	starts_with = list(
		/obj/item/weapon/surgical/bonesetter,
		/obj/item/weapon/surgical/cautery,
		/obj/item/weapon/surgical/circular_saw,
		/obj/item/weapon/surgical/hemostat,
		/obj/item/weapon/surgical/retractor,
		/obj/item/weapon/surgical/scalpel,
		/obj/item/weapon/surgical/surgicaldrill,
		/obj/item/weapon/surgical/bonegel,
		/obj/item/weapon/surgical/FixOVein,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/device/healthanalyzer/advanced,
		/obj/item/weapon/autopsy_scanner
		)

/obj/item/weapon/storage/firstaid/clotting
	name = "набор для свертывания"
	desc = "Содержит химические вещества, останавливающие кровотечение."
	max_storage_space = ITEMSIZE_COST_SMALL * 7
	starts_with = list(/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/clotting = 8)

/obj/item/weapon/storage/firstaid/bonemed
	name = "комплект для ремонта костей"
	desc = "Содержит химические вещества для лечения сломанных костей."
	max_storage_space = ITEMSIZE_COST_SMALL * 7
	starts_with = list(/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/bonemed = 8)

/*
 * Pill Bottles
 */
/obj/item/weapon/storage/pill_bottle
	name = "баночка таблеток"
	desc = "Это герметичный контейнер для хранения лекарств."
	icon_state = "pill_canister"
	icon = 'icons/obj/chemical.dmi'
	drop_sound = 'sound/items/drop/pillbottle.ogg'
	pickup_sound = 'sound/items/pickup/pillbottle.ogg'
	item_state_slots = list(slot_r_hand_str = "contsolid", slot_l_hand_str = "contsolid")
	w_class = ITEMSIZE_SMALL
	can_hold = list(/obj/item/weapon/reagent_containers/pill,/obj/item/weapon/dice,/obj/item/weapon/paper)
	allow_quick_gather = 1
	allow_quick_empty = 1
	use_to_pickup = 1
	use_sound = 'sound/items/storage/pillbottle.ogg'
	max_storage_space = ITEMSIZE_COST_TINY * 14
	max_w_class = ITEMSIZE_TINY
	var/wrapper_color
	var/label

	var/label_text = ""
	var/base_name = " "
	var/base_desc = " "

/obj/item/weapon/storage/pill_bottle/Initialize()
	. = ..()
	base_name = name
	base_desc = desc
	update_icon()

/obj/item/weapon/storage/pill_bottle/update_icon()
	overlays.Cut()
	if(wrapper_color)
		var/image/I = image(icon, "pillbottle_wrap")
		I.color = wrapper_color
		overlays += I

/obj/item/weapon/storage/pill_bottle/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/pen) || istype(W, /obj/item/device/flashlight/pen))
		var/tmp_label = sanitizeSafe(input(user, "Введите название для [name]", "Label", label_text), MAX_NAME_LEN)
		if(length(tmp_label) > 50)
			to_chat(user, "<span class='notice'>Ярлык может содержать не более 50 символов.</span>")
		else if(length(tmp_label) > 10)
			to_chat(user, "<span class='notice'>Вы устанавливаете этикетку.</span>")
			label_text = tmp_label
			update_name_label()
		else
			to_chat(user, "<span class='notice'>Вы устанавливаете этикетку \"[tmp_label]\".</span>")
			label_text = tmp_label
			update_name_label()
	else
		..()

/obj/item/weapon/storage/pill_bottle/proc/update_name_label()
	if(!label_text)
		name = base_name
		desc = base_desc
		return
	else if(length(label_text) > 10)
		var/short_label_text = copytext_char(label_text, 1, 11)
		name = "[base_name] ([short_label_text]...)"
	else
		name = "[base_name] ([label_text])"
	desc = "[base_desc] помечено как \"[label_text]\"."

/obj/item/weapon/storage/pill_bottle/antitox
	name = "таблетки (Диловин)"
	desc = "Содержит таблетки, используемые для борьбы с токсинами."
	starts_with = list(/obj/item/weapon/reagent_containers/pill/antitox = 7)
	wrapper_color = COLOR_GREEN

/obj/item/weapon/storage/pill_bottle/bicaridine
	name = "таблетки (Бикаридин)"
	desc = "Содержит таблетки, используемые для стабилизации тяжелораненых."
	starts_with = list(/obj/item/weapon/reagent_containers/pill/bicaridine = 7)
	wrapper_color = COLOR_MAROON

/obj/item/weapon/storage/pill_bottle/dexalin_plus
	name = "таблетки (Дексалин Плюс)"
	desc = "Содержит таблетки, используемые для лечения крайних случаев кислородного голодания."
	starts_with = list(/obj/item/weapon/reagent_containers/pill/dexalin_plus = 7)
	wrapper_color = "#3366cc"

/obj/item/weapon/storage/pill_bottle/dermaline
	name = "таблетки (Дермалин)"
	desc = "Содержит таблетки, применяемые для лечения ожоговых ран."
	starts_with = list(/obj/item/weapon/reagent_containers/pill/dermaline = 7)
	wrapper_color = "#e8d131"

/obj/item/weapon/storage/pill_bottle/dylovene
	name = "таблетки (Диловин)"
	desc = "Содержит таблетки, используемые для лечения токсичных веществ в крови."
	starts_with = list(/obj/item/weapon/reagent_containers/pill/dylovene = 7)
	wrapper_color = COLOR_GREEN

/obj/item/weapon/storage/pill_bottle/inaprovaline
	name = "таблетки (Инапровалин)"
	desc = "Содержит таблетки, используемые для стабилизации состояния пациентов."
	starts_with = list(/obj/item/weapon/reagent_containers/pill/inaprovaline = 7)
	wrapper_color = COLOR_PALE_BLUE_GRAY

/obj/item/weapon/storage/pill_bottle/kelotane
	name = "таблетки (Келотан)"
	desc = "Содержит таблетки, применяемые для лечения ожогов."
	starts_with = list(/obj/item/weapon/reagent_containers/pill/kelotane = 7)
	wrapper_color = "#ec8b2f"

/obj/item/weapon/storage/pill_bottle/spaceacillin
	name = "таблетки (Spaceacillin)"
	desc = "Тета-лактамный антибиотик. Эффективен против многих болезней, которые могут встретиться в космосе."
	starts_with = list(/obj/item/weapon/reagent_containers/pill/spaceacillin = 7)
	wrapper_color = COLOR_PALE_GREEN_GRAY

/obj/item/weapon/storage/pill_bottle/tramadol
	name = "таблетки (Трамадол)"
	desc = "Содержит таблетки, применяемые для снятия боли."
	starts_with = list(/obj/item/weapon/reagent_containers/pill/tramadol = 7)
	wrapper_color = COLOR_PURPLE_GRAY

/obj/item/weapon/storage/pill_bottle/citalopram
	name = "таблетки (Циталопрам)"
	desc = "Содержит таблетки для стабилизации настроения пациента."
	starts_with = list(/obj/item/weapon/reagent_containers/pill/citalopram = 7)
	wrapper_color = COLOR_GRAY

/obj/item/weapon/storage/pill_bottle/carbon
	name = "таблетки (Углерод)"
	desc = "Содержит таблетки, которые нейтрализуют химические вещества в желудке."
	starts_with = list(/obj/item/weapon/reagent_containers/pill/carbon = 7)

/obj/item/weapon/storage/pill_bottle/iron
	name = "таблетки (Железо)"
	desc = "Содержит таблетки, способствующие регенерации крови."
	starts_with = list(/obj/item/weapon/reagent_containers/pill/iron = 7)
