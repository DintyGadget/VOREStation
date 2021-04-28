/obj/item/clothing/suit/storage/toggle/labcoat
	name = "Лабораторный халат"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов."
	icon_state = "labcoat"
	item_state_slots = list(slot_r_hand_str = "labcoat", slot_l_hand_str = "labcoat")
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|ARMS
	flags_inv = HIDEHOLSTER
	allowed = list(/obj/item/device/analyzer,/obj/item/stack/medical,/obj/item/weapon/dnainjector,/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,/obj/item/weapon/reagent_containers/hypospray,/obj/item/device/healthanalyzer,/obj/item/device/flashlight/pen,/obj/item/weapon/reagent_containers/glass/bottle,/obj/item/weapon/reagent_containers/glass/beaker,/obj/item/weapon/reagent_containers/pill,/obj/item/weapon/storage/pill_bottle,/obj/item/weapon/paper)
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 50, rad = 0)
	index = 1

/obj/item/clothing/suit/storage/toggle/labcoat/red
	name = "Красный лабораторный халат"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов. Этот красного цвета."
	icon_state = "red_labcoat"
	item_state_slots = list(slot_r_hand_str = "red_labcoat", slot_l_hand_str = "red_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/blue
	name = "Синий лабораторный халат"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов. Этот синего цвета."
	icon_state = "blue_labcoat"
	item_state_slots = list(slot_r_hand_str = "blue_labcoat", slot_l_hand_str = "blue_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/purple
	name = "Фиолетовый лабораторный халат"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов. Этот фиолетового цвета."
	icon_state = "purple_labcoat"
	item_state_slots = list(slot_r_hand_str = "purple_labcoat", slot_l_hand_str = "purple_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/orange
	name = "Оранжевый лабораторный халат"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов. Этот оранжевого цвета."
	icon_state = "orange_labcoat"
	item_state_slots = list(slot_r_hand_str = "orange_labcoat", slot_l_hand_str = "orange_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/green
	name = "Зелёный лабораторный халат"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов. Этот зелёного цвета."
	icon_state = "green_labcoat"
	item_state_slots = list(slot_r_hand_str = "green_labcoat", slot_l_hand_str = "green_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/yellow
	name = "Жёлтый лабораторный халат"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов. Этот жёлтого цвета."
	icon_state = "yellow_labcoat"
	item_state_slots = list(slot_r_hand_str = "yellow_labcoat", slot_l_hand_str = "yellow_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/pink
	name = "Розовый лабораторный халат"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов. Этот розового цвета."
	icon_state = "pink_labcoat"
	item_state_slots = list(slot_r_hand_str = "pink_labcoat", slot_l_hand_str = "pink_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/cmo
	name = "Лабораторный халат Главврача"
	desc = "Синее, чем обычный."
	icon_state = "labcoat_cmo"
	item_state_slots = list(slot_r_hand_str = "cmo_labcoat", slot_l_hand_str = "cmo_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/cmoalt
	name = "Лабораторный халат Главврача"
	desc = "Лабораторный халат с вышивками цветов Управления."
	icon_state = "labcoat_cmoalt"
	item_state_slots = list(slot_r_hand_str = "cmo_labcoat", slot_l_hand_str = "cmo_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/mad
	name = "Лабораторный халат Безумца"
	desc = "Придаёт Вам ауру ученого, способного долбануть кого-то и вышвырнуть в космос."
	icon_state = "labgreen"
	item_state_slots = list(slot_r_hand_str = "green_labcoat", slot_l_hand_str = "green_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/genetics
	name = "Лабораторный халат генетика"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов. Имеет синюю полосу на плече."
	icon_state = "labcoat_gen"
	item_state_slots = list(slot_r_hand_str = "genetics_labcoat", slot_l_hand_str = "genetics_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/chemist
	name = "Лабораторный халат химика"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов. Имеет оранжевую полосу на плече."
	icon_state = "labcoat_chem"
	item_state_slots = list(slot_r_hand_str = "chemist_labcoat", slot_l_hand_str = "chemist_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/virologist
	name = "Лабораторный халат вирусолога"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов. Предоставляет большую защиту от биологического воздействия, чем другие халаты. Имеет зелёную полосу на плече."
	icon_state = "labcoat_vir"
	item_state_slots = list(slot_r_hand_str = "virologist_labcoat", slot_l_hand_str = "virologist_labcoat")
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 60, rad = 0)

/obj/item/clothing/suit/storage/toggle/labcoat/science
	name = "Лабораторный халат учёного"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов. Имеет фиолетовую полосу на плече."
	icon_state = "labcoat_tox"
	item_state_slots = list(slot_r_hand_str = "science_labcoat", slot_l_hand_str = "science_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/emt
	name = "Лабораторный халат парамедика"
	desc = "Тёмно-синий лабораторный халат со светоотражающими полосами для врачей неотложной помощи."
	icon_state = "labcoat_emt"
	item_state_slots = list(slot_r_hand_str = "emt_labcoat", slot_l_hand_str = "emt_labcoat")

/obj/item/clothing/suit/storage/toggle/labcoat/blue_edge
	name = "Лабораторный халат с синими краями"
	desc = "Верхняя одежда, защищающая от воздействия пролитых химикатов. У этого синие края."
	icon_state = "blue_edge_labcoat"

/obj/item/clothing/suit/storage/toggle/labcoat/plaguedoctor
	name = "golden plague doctor suit"
	desc = "If it worked then, it works now. This classic design comes in gold."
	icon_state = "plaguedoctor2"
	index = 1
