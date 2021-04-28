/*
 * Science
 */
/obj/item/clothing/under/rank/research_director
	desc = "Комбинезон, предназначенных для тех, кто владеет достаточными знаниями, чтобы носить титул Директора Исследований. Ткань предоставляет слабую защиту от биологическх заражений."
	name = "комбинезон Директора Исследований"
	icon_state = "director"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/research_director/rdalt
	desc = "Парадный костюм, окрашенного в цвета упорной и кропотливой работы. Ну и иногда и другие, но обычно упорной и кропотливой работы."
	name = "униформа Главного Исследователя"
	icon_state = "rdalt"
	item_state_slots = list(slot_r_hand_str = "director", slot_l_hand_str = "director")
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/research_director/dress_rd
	name = "парадная форма Директора Исследований"
	desc = "Женская одежда для Директора Исследований с чувством стиля. Особое волокно предоставляет слабую защиту от биологических заражений."
	icon_state = "dress_rd"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/scientist
	desc = "Изготовлен из особого волокна, которое предоставляет слабую защиту от биологических угроз. На него нанесена маркировка должности учёного."
	name = "комбинезон ученого"
	icon_state = "science"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)
	rolled_sleeves = 0

/obj/item/clothing/under/rank/scientist/turtleneck
	name = "водолазка ученого"
	desc = "Стильная водолазка из удобного взрывоустойчивого волокна."
	icon_state = "turtle_sci"
	item_state_slots = list(slot_r_hand_str = "purple", slot_l_hand_str = "purple")
	rolled_down = -1
	rolled_sleeves = -1

/obj/item/clothing/under/rank/chemist
	desc = "Изготовлен из особого волокна, которое предоставляет слабую защиту от биологических угроз. На него нанесена маркировка должности химика."
	name = "комбинезон химика"
	icon_state = "chemistry"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	rolled_sleeves = 0

/*
 * Medical
 */
/obj/item/clothing/under/rank/chief_medical_officer
	desc = "Комбинезон, предназначенный для тех, кто обладает достаточным опытом, чтобы именоваться Главврачом. Предоставляет слабую защиту от биологических угроз."
	name = "комбинезон Главврача"
	icon_state = "cmo"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	rolled_sleeves = 0

/obj/item/clothing/under/rank/geneticist
	desc = "Изготовлен из особого волокна, которое предоставляет слабую защиту от биологических угроз. На него нанесена маркировка должности генетика."
	name = "комбинезон генетика"
	icon_state = "genetics"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	rolled_sleeves = 0

/obj/item/clothing/under/rank/virologist
	desc = "Изготовлен из особого волокна, которое предоставляет слабую защиту от биологических угроз. На него нанесена маркировка должности вирусолога."
	name = "комбинезон вирусолога"
	icon_state = "virology"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	rolled_sleeves = 0

/obj/item/clothing/under/rank/nursesuit
	desc = "Комбинезон, распространенный среди медсестр в медицинском отделе."
	name = "костюм медсестры"
	icon_state = "nursesuit"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	rolled_sleeves = -1

/obj/item/clothing/under/rank/nurse
	desc = "Платье, распространенное среди медсестр в медицинском отделе."
	name = "платье медсестры"
	icon_state = "nurse"
	item_state_slots = list(slot_r_hand_str = "nursesuit", slot_l_hand_str = "nursesuit")
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	rolled_sleeves = -1

/obj/item/clothing/under/rank/orderly
	desc = "Белый костюм медицинского работника."
	name = "униформа медицинского работника"
	icon_state = "orderly"
	item_state_slots = list(slot_r_hand_str = "nursesuit", slot_l_hand_str = "nursesuit")
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	rolled_sleeves = 0

/obj/item/clothing/under/rank/medical
	desc = "Изготовлен из особого волокна, которое предоставляет слабую защиту от биологических угроз. На него нанесён крест, означающий обученность медицинского работника."
	name = "комбинезон врача"
	icon_state = "medical"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	rolled_sleeves = 0

/obj/item/clothing/under/rank/medical/turtleneck
	name = "водолазка врача"
	desc = "Стильная водолазка из особых защитных волокон. Смотрится хорошо, спасает жизни, что ещё нужно для счастья?"
	icon_state = "turtle_med"
	rolled_down = -1
	rolled_sleeves = -1

/obj/item/clothing/under/rank/medical/paramedic
	name = "комбинезон врача с короткими рукавами"
	desc = "Изготовлен из особого волокна, которое предоставляет слабую защиту от биологических угроз. На него нанесён крест, означающий обученность медицинского работника."
	icon_state = "medical_short"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS
	rolled_sleeves = -1

/obj/item/clothing/under/rank/medical/scrubs
	name = "голубая клиническая униформа"
	desc = "Изготовлена из особого волокна, которое предоставляет слабую защиту от биологических угроз. Эта униформа голубого цвета."
	icon_state = "scrubsblue"
	item_state_slots = list(slot_r_hand_str = "blue", slot_l_hand_str = "blue")

/obj/item/clothing/under/rank/medical/scrubs/green
	name = "зеленая клиническая униформа"
	desc = "Изготовлена из особого волокна, которое предоставляет слабую защиту от биологических угроз. Эта униформа тёмно-зеленого цвета."
	icon_state = "scrubsgreen"
	item_state_slots = list(slot_r_hand_str = "green", slot_l_hand_str = "green")

/obj/item/clothing/under/rank/medical/scrubs/purple
	name = "фиолетовая клиническая униформа"
	desc = "Изготовлена из особого волокна, которое предоставляет слабую защиту от биологических угроз. Эта униформа фиолетового цвета."
	icon_state = "scrubspurple"
	item_state_slots = list(slot_r_hand_str = "purple", slot_l_hand_str = "purple")

/obj/item/clothing/under/rank/medical/scrubs/black
	name = "черная клиническая униформа"
	desc = "Изготовлена из особого волокна, которое предоставляет слабую защиту от биологических угроз. Эта униформа черного цвета."
	icon_state = "scrubsblack"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")

/obj/item/clothing/under/rank/medical/scrubs/navyblue
	name = "синяя клиническая униформа"
	desc = "Изготовлена из особого волокна, которое предоставляет слабую защиту от биологических угроз. Эта униформа синего цвета."
	icon_state = "scrubsnavyblue"
	item_state_slots = list(slot_r_hand_str = "blue", slot_l_hand_str = "blue")

/obj/item/clothing/under/rank/medical/scrubs/white
	name = "scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards"
	icon_state = "scrubs"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")

/obj/item/clothing/under/rank/psych
	desc = "Обыкновенный белый комбинезон. На него нанесена бирюзовая маркировка должности психиатра."
	name = "комбинезон психиатра"
	icon_state = "psych"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")

/obj/item/clothing/under/rank/psych/turtleneck
	desc = "Бирюзовая водолазка и пара тёмно-синих брюк, принадлежащие психологу."
	name = "водолазка психолога"
	icon_state = "psychturtle"
	item_state_slots = list(slot_r_hand_str = "psyche", slot_l_hand_str = "psyche")
	rolled_sleeves = 0

/*
 * Medsci, unused (i think) stuff
 */
/obj/item/clothing/under/rank/geneticist_new
	desc = "Изготовлен из особого волокна, которое предоставляет слабую защиту от биологических угроз."
	name = "комбинезон генетика"
	icon_state = "genetics_new"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	rolled_sleeves = 0

/obj/item/clothing/under/rank/chemist_new
	desc = "Изготовлен из особого волокна, которое предоставляет слабую защиту от биологических угроз."
	name = "комбинезон химика"
	icon_state = "chemist_new"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	rolled_sleeves = 0

/obj/item/clothing/under/rank/scientist_new
	desc = "Изготовлен из особого волокна, которое предоставляет слабую защиту от биологических угроз и небольших взрывов."
	name = "комбинезон ученого"
	icon_state = "scientist_new"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)
	rolled_sleeves = 0

/obj/item/clothing/under/rank/virologist_new
	desc = "Изготовлен из особого волокна, которое предоставляет слабую защиту от биологических угроз."
	name = "комбинезон вирусолога"
	icon_state = "virologist_new"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	rolled_sleeves = 0
