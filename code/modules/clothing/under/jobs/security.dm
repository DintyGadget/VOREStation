/*
 * Contains:
 *		Security
 *		Detective
 *		Head of Security
 */

/*
 * Security
 */
/obj/item/clothing/under/rank/warden
	desc = "Изготовлен из более прочного материала, чем обыкновенные комбинезоны,и предоставляет больше защиты. На плечах написано \"Надзиратель\"."
	name = "комбинезон надзирателя"
	icon_state = "warden"
	item_state_slots = list(slot_r_hand_str = "red", slot_l_hand_str = "red")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/security
	name = "комбинезон офицера службы безопасности"
	desc = "Изготовлен из более прочного материала, чем обыкновенные комбинезоны,и предоставляет больше защиты."
	icon_state = "security"
	item_state_slots = list(slot_r_hand_str = "red", slot_l_hand_str = "red")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/security/turtleneck
	name = "водолазка службы безопасности"
	desc = "Стильная водолазка надёжного наноплетения. Кто сказал, что закон не может выглядеть стильно."
	icon_state = "turtle_sec"
	rolled_down = -1
	rolled_sleeves = -1

/obj/item/clothing/under/rank/dispatch
	name = "униформа диспетчера"
	desc = "Рубашка в комплекте с брюками цвета хаки, на которые нашита эмблема службы безопасности."
	icon_state = "dispatch"
	item_state_slots = list(slot_r_hand_str = "detective", slot_l_hand_str = "detective")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/security2
	name = "униформа офицера службы безопасности"
	desc = "Изготовлена из более прочного материала и предоставляет больше защиты, чем обыкновенная одежда."
	icon_state = "redshirt2"
	item_state_slots = list(slot_r_hand_str = "red", slot_l_hand_str = "red")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/security/corp
	icon_state = "sec_corporate"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	rolled_sleeves = 0

/obj/item/clothing/under/rank/warden/corp
	icon_state = "warden_corporate"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	rolled_sleeves = 0

/obj/item/clothing/under/tactical
	name = "тактический комбинезон"
	desc = "Изготовлена из более прочного материала, чем обыкновенный комбинезон, и предоставляет больше защиты."
	icon_state = "swatunder"
	item_state_slots = list(slot_r_hand_str = "green", slot_l_hand_str = "green")
	armor = list(melee = 10, bullet = 5, laser = 5,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = -1

/*
 * Detective
 */
/obj/item/clothing/under/det
	name = "костюм детектива"
	desc = "Мятая парадная рубашка в паре с поношенными серыми брюками."
	icon_state = "detective"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0
	starting_accessories = list(/obj/item/clothing/accessory/tie/blue_clip)

/*
/obj/item/clothing/under/det/verb/rollup()
	set name = "Roll Suit Sleeves"
	set category = "Object"
	set src in usr
	var/unrolled = item_state_slots[slot_w_uniform_str] == initial(worn_state)
	item_state_slots[slot_w_uniform_str] = unrolled ? "[worn_state]_r" : initial(worn_state)
	var/mob/living/carbon/human/H = loc
	H.update_inv_w_uniform(1)
	to_chat(H, "<span class='notice'>You roll the sleeves of your shirt [unrolled ? "up" : "down"]</span>")
*/
/obj/item/clothing/under/det/grey
	icon_state = "detective2"
	desc = "Весьма официальная на вид бежевая рубашка в паре с только что поглаженными чёрными брюками."
	starting_accessories = list(/obj/item/clothing/accessory/tie/red_long)

/obj/item/clothing/under/det/black
	icon_state = "detective3"
	item_state_slots = list(slot_r_hand_str = "sl_suit", slot_l_hand_str = "sl_suit")
	desc = "Безупречная белая парадная рубашка вместе с парой тёмно-серых брюк, красным галстуком и жилетом угольного цвета."
	starting_accessories = list(/obj/item/clothing/accessory/tie/red_long, /obj/item/clothing/accessory/vest)

/obj/item/clothing/under/det/corporate
	name = "комбинезон детектива"
	icon_state = "det_corporate"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	desc = "Более современная униформа для криминалистов корпорации."

/obj/item/clothing/under/det/waistcoat
	icon_state = "жилетка детектива"
	desc = "Мятая парадная рубашка в паре с поношенными серыми брюками, вместе с синим полосатым галстуком и жилеткой."
	starting_accessories = list(/obj/item/clothing/accessory/tie/blue_clip, /obj/item/clothing/accessory/wcoat)

/obj/item/clothing/under/det/grey/waistcoat
	icon_state = "detective2"
	desc = "Весьма официальная на вид бежевая рубашка вместе с только что поглаженными чёрными брюкам, а также красным полосатыми галстуком и жилеткой."
	starting_accessories = list(/obj/item/clothing/accessory/tie/red_long, /obj/item/clothing/accessory/wcoat)

/obj/item/clothing/under/det/skirt
	name = "юбка детектива"
	icon_state = "detective_skirt"
	desc = "Серьёзная на вид белая блузка в паре с формальной чёрной юбкой."
	item_state_slots = list(slot_r_hand_str = "sl_suit", slot_l_hand_str = "sl_suit")

/*
 * Head of Security
 */
/obj/item/clothing/under/rank/head_of_security
	desc = "Комбинезон, предназначенный для тех, кто заслужил звание Главы Службы Безопасности. Обладает бронёй для защиты носителя."
	name = "комбинезон Главы Службы Безопасности"
	icon_state = "hos"
	item_state_slots = list(slot_r_hand_str = "red", slot_l_hand_str = "red")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/head_of_security/corp
	icon_state = "hos_corporate"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	rolled_sleeves = 0

//Jensen cosplay gear
/obj/item/clothing/under/rank/head_of_security/jensen
	desc = "Стильнее и не придумаеешь."
	name = "комбинезон Главы Службы Безопасности"
	icon_state = "jensen"
	rolled_sleeves = -1

/*
 * Navy uniforms
 */
/obj/item/clothing/under/rank/security/navyblue
	name = "униформа офицера службы безопасности"
	desc = "Последний писк моды среди офицеров безопасности."
	icon_state = "officerblueclothes"
	item_state_slots = list(slot_r_hand_str = "ba_suit", slot_l_hand_str = "ba_suit")
	rolled_sleeves = 0

/obj/item/clothing/under/rank/head_of_security/navyblue
	desc = "Нашивка на униформе говорит о своей принадлежности Главе Службы Безопасности."
	name = "униформа Главы Службы Безопасности"
	icon_state = "hosblueclothes"
	item_state_slots = list(slot_r_hand_str = "ba_suit", slot_l_hand_str = "ba_suit")
	rolled_sleeves = 0

/obj/item/clothing/under/rank/warden/navyblue
	desc = "Нашивка на униформе говорит о своей принадлежности надзирателю."
	name = "униформа надзирателя"
	icon_state = "wardenblueclothes"
	item_state_slots = list(slot_r_hand_str = "ba_suit", slot_l_hand_str = "ba_suit")
	rolled_sleeves = 0
