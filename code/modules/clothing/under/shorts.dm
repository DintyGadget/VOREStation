//these need item states -S2-
/obj/item/clothing/under/shorts
	name = "спортивные шорты"
	desc = "95% полиэстер, 5% спандекс!"
	icon_state = "redshorts" // Hackyfix for icon states until someone wants to come do a recolor later.
	gender = PLURAL
	body_parts_covered = LOWER_TORSO
	index = 1

/obj/item/clothing/under/shorts/red
	name = "красные спортивные шорты"
	icon_state = "redshorts"

/obj/item/clothing/under/shorts/green
	name = "зеленые спортивные шорты"
	icon_state = "greenshorts"

/obj/item/clothing/under/shorts/blue
	name = "синие спортивные шорты"
	icon_state = "blueshorts"

/obj/item/clothing/under/shorts/black
	name = "черные спортивные шорты"
	icon_state = "blackshorts"

/obj/item/clothing/under/shorts/grey
	name = "серые спортивные шорты"
	icon_state = "greyshorts"

/obj/item/clothing/under/shorts/white
	name = "белые шорты"
	icon_state = "whiteshorts"

/obj/item/clothing/under/shorts/white/female
	name = "короткие белые шорты"
	icon_state = "whiteshorts_f"

/obj/item/clothing/under/shorts/jeans
	name = "джинсовые шорты"
	desc = "Как джинсы, только короче!"
	icon_state = "jeans_shorts"

/obj/item/clothing/under/shorts/jeans/female
	name = "короткие джинсовые шорты"
	icon_state = "jeans_shorts_f"

/obj/item/clothing/under/shorts/jeans/classic
	name = "классические джинсовые шорты"
	icon_state = "jeansclassic_shorts"

/obj/item/clothing/under/shorts/jeans/classic/female
	name = "короткие классические джинсовые шорты"
	icon_state = "jeansclassic_shorts_f"

/obj/item/clothing/under/shorts/jeans/mustang
	name = "мустанговые шорты"
	icon_state = "jeansmustang_shorts"

/obj/item/clothing/under/shorts/jeans/mustang/female
	name = "короткие мустанговые шорты"
	icon_state = "jeansmustang_shorts_f"

/obj/item/clothing/under/shorts/jeans/youngfolks
	name = "молодежные шорты"
	icon_state = "jeansyoungfolks_shorts"

/obj/item/clothing/under/shorts/jeans/youngfolks/female
	name = "короткие молодежные шорты"
	icon_state = "jeansyoungfolks_shorts_f"

/obj/item/clothing/under/shorts/jeans/black
	name = "темные шорты"
	icon_state = "blackpants_shorts"

/obj/item/clothing/under/shorts/jeans/black/female
	name = "короткие темные шорты"
	icon_state = "black_shorts_f"

/obj/item/clothing/under/shorts/jeans/grey
	name = "серые шорты"
	icon_state = "greyshorts"

/obj/item/clothing/under/shorts/jeans/grey/female
	name = "короткие серые шорты"
	icon_state = "grey_shorts_f"

/obj/item/clothing/under/shorts/khaki
	name = "шорты цвета хаки"
	icon_state = "tanpants_shorts"

/obj/item/clothing/under/shorts/khaki/female
	name = "короткие шорты цвета хаки"
	icon_state = "khaki_shorts_f"

//Argh, skirts be below this line -> ------------------------------

/obj/item/clothing/under/skirt
	name = "короткая черная юбка"
	desc = "Юбка блестящего черного цвета."
	icon_state = "skirt_short_black"
	body_parts_covered = LOWER_TORSO
	rolled_sleeves = -1
	index = 1

/obj/item/clothing/under/skirt/khaki
	name = "короткая юбка цвета хаки"
	desc = "Юбка цвета хаки."
	icon_state = "skirt_khaki"

/obj/item/clothing/under/skirt/blue
	name = "короткая голубая юбка"
	desc = "Юбка блестящего голубого цвета."
	icon_state = "skirt_short_blue"

/obj/item/clothing/under/skirt/red
	name = "короткая красная юбка"
	desc = "Юбка блестящего красного цвета."
	icon_state = "skirt_short_red"

/obj/item/clothing/under/skirt/denim
	name = "короткая денимовая юбка"
	desc = "Юбка из денима."
	icon_state = "skirt_short_denim"

/obj/item/clothing/under/skirt/swept
	name = "короткая стянутая юбка"
	desc = "Юбка, стянутая вбок."
	icon_state = "skirt_swept"

/obj/item/clothing/under/skirt/loincloth
	name = "набедренная повязка"
	desc = "Кусок ткани, обматываемый вокруг талии."
	icon_state = "loincloth"

/obj/item/clothing/under/skirt/pleated
	name = "короткая плиссированная юбка"
	desc = "Обыкновенная плиссированная юбка. Прям как в школе."
	icon_state = "pleated"
	addblends = "pleated_a"

/obj/item/clothing/under/skirt/outfit
	name = "черная юбка"
	desc = "Юбка чёрного цвета, как стильно!"
	icon_state = "blackskirt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/skirt/outfit/plaid_blue
	name = "клетчатая синяя юбка"
	desc = "Опрятная синяя рубашка в комплекте с белой блузкой."
	icon_state = "plaid_blue"
	item_state_slots = list(slot_r_hand_str = "blue", slot_l_hand_str = "blue")

/obj/item/clothing/under/skirt/outfit/plaid_red
	name = "клетчатая красная юбка"
	desc = "Опрятная красная рубашка в комплекте с белой блузкой."
	icon_state = "plaid_red"
	item_state_slots = list(slot_r_hand_str = "red", slot_l_hand_str = "red")

/obj/item/clothing/under/skirt/outfit/plaid_purple
	name = "клетчатая фиолетовая юбка"
	desc = "Опрятная фиолетовая рубашка в комплекте с белой блузкой."
	icon_state = "plaid_purple"
	item_state_slots = list(slot_r_hand_str = "purple", slot_l_hand_str = "purple")

/obj/item/clothing/under/rank/cargo/skirt
	name = "юбка Квартирмейстера"
	desc = "Юбка, предназначенная для Квартирмейстера. Позволяет не испортить осанку, распихивая повсюду бумагу."
	icon_state = "qmf"
	item_state_slots = list(slot_r_hand_str = "qm", slot_l_hand_str = "qm")
	index = 1

/obj/item/clothing/under/rank/cargotech/skirt
	name = "юбка грузчика"
	desc = "Юююююбочки! Удобные!"
	icon_state = "cargof"
	item_state_slots = list(slot_r_hand_str = "cargo", slot_l_hand_str = "cargo")
	index = 1

/obj/item/clothing/under/rank/engineer/skirt
	desc = "Оранжевая юбка повышенной видимости, предназначенная для инженера. Обладает слабой защитой от радиации."
	name = "юбка инженера"
	icon_state = "enginef"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 10)
	item_state_slots = list(slot_r_hand_str = "engine", slot_l_hand_str = "engine")
	index = 1

/obj/item/clothing/under/rank/chief_engineer/skirt
	desc = "Оранжевая юбка повышенной видимости, предназначенная для безумцев, именнованных Главными Инженерами. Обладает слабой защитой от радиации."
	name = "chief engineer's jumpskirt"
	icon_state = "chieff"
	item_state_slots = list(slot_r_hand_str = "chiefengineer", slot_l_hand_str = "chiefengineer")
	index = 1

/obj/item/clothing/under/rank/atmospheric_technician/skirt
	desc = "Юбка, предназначенная для атмосферных техников."
	name = "юбка атмосферного техника"
	icon_state = "atmosf"
	item_state_slots = list(slot_r_hand_str = "atmos", slot_l_hand_str = "atmos")
	index = 1

/obj/item/clothing/under/rank/roboticist/skirt
	desc = "Черная юбка с упрочненными швами; отлично подходит для тяжелой работы."
	name = "roboticist's jumpskirt"
	icon_state = "roboticsf"
	item_state_slots = list(slot_r_hand_str = "robotics", slot_l_hand_str = "robotics")
	index = 1

/obj/item/clothing/under/rank/scientist/skirt
	name = "юбка ученого"
	icon_state = "sciencef"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)
	index = 1

/obj/item/clothing/under/rank/medical/skirt
	name = "юбка врача"
	icon_state = "medicalf"
	index = 1

/obj/item/clothing/under/rank/chemist/skirt
	name = "юбка химика"
	icon_state = "chemistryf"
	index = 1

/obj/item/clothing/under/rank/chief_medical_officer/skirt
	desc = "Юбка, предназначенная для тех, кто владеет достаточным опытом, чтобы именоваться Главврачом. Предоставляет слабую биологическую защиту."
	name = "юбка Главврача"
	icon_state = "cmof"
	index = 1

/obj/item/clothing/under/rank/geneticist/skirt
	name = "юбка генетика"
	icon_state = "geneticsf"
	index = 1

/obj/item/clothing/under/rank/virologist/skirt
	name = "юбка вирусолога"
	icon_state = "virologyf"
	index = 1

/obj/item/clothing/under/rank/security/skirt
	name = "юбка офицера службы безопасности"
	desc = "Стандартная женская униформа офицеров службы безопасности. Изготовлена из более прочного материала, чем обыкновенные юбки."
	icon_state = "securityf"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	index = 1

/obj/item/clothing/under/rank/warden/skirt
	desc = "Стандартная женская униформа надзирателя. Изготовлена из более прочного материала, чем обыкновенные юбки. На плечах верхней одежды написано \"Надзиратель\"."
	name = "warden's jumpskirt"
	icon_state = "wardenf"
	index = 1

/obj/item/clothing/under/rank/head_of_security/skirt
	desc = "Элегантная юбка для тех, кто заслужил находиться в должности Главы Службы Безопасности. Обладает бронёй для защиты носителя."
	name = "head of security's jumpskirt"
	icon_state = "hosf"
	index = 1