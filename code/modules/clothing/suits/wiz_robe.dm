/obj/item/clothing/head/wizard
	name = "Шляпа волшебника"
	desc = "Причудливая шляпа, абсолютно точно принадлежащая настоящему волшебнику."
	icon_state = "wizard"
	//Not given any special protective value since the magic robes are full-body protection --NEO
	siemens_coefficient = 0.8
	body_parts_covered = 0
	wizard_garb = 1

/obj/item/clothing/head/wizard/red
	name = "Красная шляпа волшебника"
	desc = "Причудливая красная шляпа, абсолютно точно принадлежащая настоящему волшебнику."
	icon_state = "redwizard"
	siemens_coefficient = 0.8

/obj/item/clothing/head/wizard/fake
	name = "Шляпа волшебника"
	desc = "На ней вышито: МАГГГ. В комплекте классная борода."
	icon_state = "wizard-fake"
	body_parts_covered = HEAD|FACE

/obj/item/clothing/head/wizard/marisa
	name = "Шляпа ведьмы"
	desc = "Причудливый головной убор, от которого хочется метать огненные шары."
	icon_state = "marisa"
	siemens_coefficient = 0.8

/obj/item/clothing/head/wizard/magus
	name = "Шлем чародея-магистра"
	desc = "Таинственный шлем, гудящий от внеземной мощи."
	icon_state = "magus"
	siemens_coefficient = 0.8
	body_parts_covered = HEAD|FACE|EYES

/obj/item/clothing/head/wizard/amp
	name = "Экстрасенсорный усилитель"
	desc = "Экстрасенсорный усилитель в виде тернового венца. Выглядит как убогое слияние тиары и промышленного робота."
	icon_state = "amp"
	siemens_coefficient = 0.8

/obj/item/clothing/head/wizard/cap
	name = "Кепка джентльмена"
	desc = "Клетчатая плоская кепка серого цвета, сшитая самыми редкими нитями."
	icon_state = "gentcap"
	item_state_slots = list(slot_r_hand_str = "detective", slot_l_hand_str = "detective")
	siemens_coefficient = 0.8

/obj/item/clothing/suit/wizrobe
	name = "Мантия волшебника"
	desc = "Великолепная роба, украшенная самоцветами, от которой так и тянет силой."
	icon_state = "wizard"
	gas_transfer_coefficient = 0.01 // IT'S MAGICAL OKAY JEEZ +1 TO NOT DIE
	permeability_coefficient = 0.01
	armor = list(melee = 30, bullet = 20, laser = 20,energy = 20, bomb = 20, bio = 20, rad = 20)
	allowed = list(/obj/item/weapon/teleportation_scroll)
	flags_inv = HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	siemens_coefficient = 0.8
	wizard_garb = 1

/obj/item/clothing/suit/wizrobe/red
	name = "Красная мантия волшебника"
	desc = "Великолепная красная роба, украшенная самоцветами, от которой так и тянет силой."
	icon_state = "redwizard"

/obj/item/clothing/suit/wizrobe/marisa
	name = "Мантия ведьмы"
	desc = "Магия сводится к силе твоих заклятий!"
	icon_state = "marisa"

/obj/item/clothing/suit/wizrobe/magusblue
	name = "Мантия чародея-магистра"
	desc = "Зачарованные доспехи, от которых веет тёмными силами."
	icon_state = "magusblue"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|HANDS|LEGS|FEET

/obj/item/clothing/suit/wizrobe/magusred
	name = "Мантия чародея-магистра"
	desc = "Зачарованные доспехи, от которых веет тёмными силами."
	icon_state = "magusred"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|HANDS|LEGS|FEET

/obj/item/clothing/suit/wizrobe/psypurple
	name = "Фиолетовая мантия"
	desc = "Плотная мантия королевского фиолетового цвета вкупе с экстрасенсорными усилителями и странными бульбообразными линзами. Не стирать в машинке."
	icon_state = "psyamp"

/obj/item/clothing/suit/wizrobe/gentlecoat
	name = "Куртка джентльмена"
	desc = "Плотная твидовая куртка серого цвета. Для особого вида джентльменов."
	icon_state = "gentlecoat"
	item_state_slots = list(slot_r_hand_str = "greatcoat", slot_l_hand_str = "greatcoat")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	flags_inv = HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/wizrobe/fake
	name = "Мантия волшебника"
	desc = "Скудноватая синия мантия, имитирующая робы настоящих волшебников."
	icon_state = "wizard-fake"
	item_state_slots = list(slot_r_hand_str = "wizard", slot_l_hand_str = "wizard")
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 1.0

/obj/item/clothing/head/wizard/marisa/fake
	name = "Шляпа ведьмы"
	desc = "Причудливый головной убор, от которого хочется метать огненные шары."
	icon_state = "marisa"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 1.0

/obj/item/clothing/suit/wizrobe/marisa/fake
	name = "Мантия ведьмы"
	desc = "Магия сводится к силе твоих заклятий!"
	icon_state = "marisa"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 1.0