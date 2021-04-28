/*
 * Contains:
 *		Lasertag
 *		Costume
 *		Misc
 */

// -S2-note- Needs categorizing and sorting.

/*
 * Lasertag
 */
/obj/item/clothing/suit/bluetag
	name = "Синяя броня для лазерных салок"
	desc = "Синие, вперёд!"
	icon_state = "bluetag"
	item_state_slots = list(slot_r_hand_str = "tdblue", slot_l_hand_str = "tdblue")
	blood_overlay_type = "armor"
	body_parts_covered = UPPER_TORSO
	allowed = list (/obj/item/weapon/gun/energy/lasertag/blue)
	siemens_coefficient = 3.0

/obj/item/clothing/suit/redtag
	name = "Красная броня для лазерных салок"
	desc = "По слухам, делает носителя быстрее."
	icon_state = "redtag"
	item_state_slots = list(slot_r_hand_str = "tdred", slot_l_hand_str = "tdred")
	blood_overlay_type = "armor"
	body_parts_covered = UPPER_TORSO
	allowed = list (/obj/item/weapon/gun/energy/lasertag/red)
	siemens_coefficient = 3.0

/*
 * Costume
 */
/obj/item/clothing/suit/pirate
	name = "Пиратский мундир"
	desc = "Йо-хо-хо."
	icon_state = "pirate"
	item_state_slots = list(slot_r_hand_str = "greatcoat", slot_l_hand_str = "greatcoat")
	body_parts_covered = UPPER_TORSO|ARMS

/obj/item/clothing/suit/poncho
	name = "Пончо"
	desc = "Простое и удобное пончо."
	icon = 'icons/mob/suit.dmi'
	icon_state = "poncho"
	item_state = "poncho"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_vr.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_vr.dmi',
		)
	body_parts_covered = UPPER_TORSO|ARMS

/obj/item/clothing/suit/hgpirate
	name = "Мундир капитана пиратов"
	desc = "Йо-хо-хо."
	icon_state = "hgpirate"
	item_state_slots = list(slot_r_hand_str = "greatcoat", slot_l_hand_str = "greatcoat")
	flags_inv = HIDEJUMPSUIT
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS

/obj/item/clothing/suit/cyborg_suit
	name = "Костюм киборга"
	desc = "Верхняя одежда для костюма киборга."
	icon_state = "death"
	fire_resist = T0C+5200
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/greatcoat
	name = "Шинель"
	desc = "Тяжелая шинель."
	icon_state = "gentlecoat"
	item_state_slots = list(slot_r_hand_str = "greatcoat", slot_l_hand_str = "greatcoat")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/johnny_coat
	name = "Пальто Джонни~~"
	desc = "Джонни~~"
	icon_state = "gentlecoat"
	item_state_slots = list(slot_r_hand_str = "johnny_coat", slot_l_hand_str = "johnny_coat")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/justice
	name = "Костюм справедливости"
	desc = "Смехота, если честно."
	icon_state = "gentle_coat"
	item_state_slots = list(slot_r_hand_str = "greatcoat", slot_l_hand_str = "greatcoat")
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|HANDS|LEGS|FEET

/obj/item/clothing/suit/judgerobe
	name = "Облачение судьи"
	desc = "От этой робы отдаёт авторитетом."
	icon_state = "judge"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	allowed = list(/obj/item/weapon/storage/fancy/cigarettes,/obj/item/weapon/spacecash)
	flags_inv = HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/storage/apron/overalls
	name = "Комбинезон"
	desc = "Денимовый комбинезон."
	icon_state = "overalls"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS

/obj/item/clothing/suit/syndicatefake
	name = "Муляжный красный скафандр"
	icon = 'icons/obj/clothing/spacesuits.dmi'
	icon_state = "syndicate"
	desc = "Пластиковый муляж синдикатного скафандра, в котором каждый похож на настоящего агента! Это лишь игрушка и не предназначается для использования в космосе."
	w_class = ITEMSIZE_NORMAL
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen,/obj/item/toy)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL|HIDETIE|HIDEHOLSTER
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|HANDS|LEGS|FEET

/obj/item/clothing/suit/hastur
	name = "Облачение Хастура"
	desc = "Эта роба предназначена не для человека."
	icon_state = "hastur"
	item_state_slots = list(slot_r_hand_str = "rad", slot_l_hand_str = "rad")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/imperium_monk
	name = "Имперское облачение"
	desc = "А ТЫ сегодня убивал ксеносов?"
	icon_state = "imperium_monk"
	body_parts_covered = HEAD|UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS
	flags_inv = HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/chickensuit
	name = "Костюм курицы"
	desc = "Костюм, сотканный в древней империи KFC."
	icon_state = "chickensuit"
	body_parts_covered = UPPER_TORSO|ARMS|LOWER_TORSO|LEGS|FEET
	flags_inv = HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	siemens_coefficient = 2.0

/obj/item/clothing/suit/monkeysuit
	name = "Костюм мартышки"
	desc = "Костюм, сделанный по образу примата."
	icon_state = "monkeysuit"
	item_state_slots = list(slot_r_hand_str = "brown_jacket", slot_l_hand_str = "brown_jacket")
	body_parts_covered = UPPER_TORSO|ARMS|LOWER_TORSO|LEGS|FEET|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	siemens_coefficient = 2.0

/obj/item/clothing/suit/holidaypriest
	name = "Выходной костюм священника"
	desc = "Сегодня отличный выходной день, сын мой."
	icon_state = "holidaypriest"
	item_state_slots = list(slot_r_hand_str = "labcoat", slot_l_hand_str = "labcoat")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/cardborg
	name = "Костюм картонного киборга"
	desc = "Обыкновенная картонная коробка с дырками по сторонам."
	icon_state = "cardborg"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	flags_inv = HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/skeleton
	name = "Костюм скелета"
	desc = "Обтягивающий костюм с нарисованным на нём человеческим скелетом."
	icon_state = "skelecost"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS|FEET|HANDS|EYES|HEAD|FACE
	flags_inv = HIDEJUMPSUIT|HIDESHOES|HIDEGLOVES|HIDETIE|HIDEHOLSTER
	item_state_slots = list(slot_r_hand_str = "judge", slot_l_hand_str = "judge")

/obj/item/clothing/suit/engicost
	name = "Скафандр сексапильного инженера"
	desc = "По идее это инженерный скафандр... однако от радиации вряд ли защитит."
	icon_state = "engicost"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|FEET
	flags_inv = HIDEJUMPSUIT|HIDESHOES|HIDETIE|HIDEHOLSTER
	item_state_slots = list(slot_r_hand_str = "eng_voidsuit", slot_l_hand_str = "eng_voidsuit")

/obj/item/clothing/suit/maxman
	name = "Костюм доктора Максмена"
	desc = "Костюм по подобию внешнего вида Доктора Максмена, известного продавца средств для мужчин. В комплекте с красной повязкой и халатом без рукавов!"
	icon_state = "maxman"
	body_parts_covered = LOWER_TORSO|FEET|LEGS|HEAD
	flags_inv = HIDEJUMPSUIT|HIDESHOES|HIDETIE|HIDEHOLSTER
	item_state_slots = list(slot_r_hand_str = "leather_jacket", slot_l_hand_str = "leather_jacket")

/obj/item/clothing/suit/iasexy
	name = "Костюм сексапильного агента внутренних дел"
	desc = "Ну и где твоя ручка?~"
	icon_state = "iacost"
	body_parts_covered = UPPER_TORSO|FEET|LOWER_TORSO|EYES
	flags_inv = HIDEJUMPSUIT|HIDESHOES|HIDETIE|HIDEHOLSTER
	item_state_slots = list(slot_r_hand_str = "suit_black", slot_l_hand_str = "suit_black")

/obj/item/clothing/suit/sexyminer
	name = "Костюм сексапильного шахтера"
	desc = "Когда нужно позаботиться о своих камушках."
	icon_state = "sexyminer"
	body_parts_covered = FEET|LOWER_TORSO|HEAD
	flags_inv = HIDEJUMPSUIT|HIDESHOES|HIDETIE|HIDEHOLSTER
	item_state_slots = list(slot_r_hand_str = "miner", slot_l_hand_str = "miner")

/obj/item/clothing/suit/sumo
	name = "Надуваемый костюм борца сумо"
	desc = "Надутый костюм борца сумо. В нём жарковато."
	icon_state = "sumo"
	body_parts_covered = FEET|LOWER_TORSO|UPPER_TORSO|LEGS|ARMS
	flags_inv = HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	item_state_slots = list(slot_r_hand_str = "classicponcho", slot_l_hand_str = "classicponcho")
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/suit/hackercost
	name = "Костюм классического хакера"
	desc = "В нём Вы чувствуете себя просто обалдеть как круто."
	icon_state = "hackercost"
	body_parts_covered = FEET|LOWER_TORSO|UPPER_TORSO|LEGS|ARMS|EYES
	flags_inv = HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	item_state_slots = list(slot_r_hand_str = "leather_coat", slot_l_hand_str = "leather_coat")

/obj/item/clothing/suit/lumber
	name = "Костюм сексапильного лесоруба"
	desc = "Пахнет утренней хвоей. В комплекте волосы на груди и борода."
	icon_state = "sexylumber"
	body_parts_covered = FEET|LOWER_TORSO|FEET
	flags_inv = HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	item_state_slots = list(slot_r_hand_str = "red_labcoat", slot_l_hand_str = "red_labcoat")

/*
 * Misc
 */
/obj/item/clothing/suit/straight_jacket
	name = "Смирительная рубашка"
	desc = "Костюм, полностью ограничивающий носителя в передвижении."
	icon_state = "straight_jacket"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL|HIDETIE|HIDEHOLSTER

	var/resist_time = 4800	// Eight minutes.

/obj/item/clothing/suit/straight_jacket/attack_hand(mob/living/user as mob)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(src == H.wear_suit)
			to_chat(H, "<span class='notice'>Вам необходима помощь, чтобы её снять!</span>")
			return
	..()

/obj/item/clothing/suit/straight_jacket/equipped(var/mob/living/user,var/slot)
	. = ..()
	if(slot == slot_wear_suit)
		user.drop_l_hand()
		user.drop_r_hand()
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.drop_from_inventory(H.handcuffed)

/obj/item/clothing/suit/ianshirt
	name = "Поношенная футболка"
	desc = "Поношенная и весьма удобная футболка с изображением Иана. По ощущениям она очень похожа на объятия. В ней приятно спать."
	icon_state = "ianshirt"
	item_state_slots = list(slot_r_hand_str = "labcoat", slot_l_hand_str = "labcoat") //placeholder -S2-
	body_parts_covered = UPPER_TORSO|ARMS
	flags_inv = HIDETIE|HIDEHOLSTER

obj/item/clothing/suit/kimono
	name = "Кимоно"
	desc = "Традиционное японское кимоно."
	icon_state = "kimono"
	addblends = "kimono_a"

obj/item/clothing/suit/kamishimo
	name = "Камисимо"
	desc = "Традиционная мужская одежда из Японии."
	icon_state = "kamishimo"

/*
 * coats
 */
/obj/item/clothing/suit/leathercoat
	name = "Кожаное пальто"
	desc = "Длинное и плотное кожаное пальто чёрного цвета."
	icon_state = "leathercoat_alt"
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight, /obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask)
	item_state_slots = list(slot_r_hand_str = "leather_jacket", slot_l_hand_str = "leather_jacket")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/leathercoat/sec
	name = "Кожаное пальто"
	desc = "Длинное и плотное кожаное пальто чёрного цвета."
	icon_state = "leathercoat_sec"
	item_state_slots = list(slot_r_hand_str = "leather_jacket", slot_l_hand_str = "leather_jacket")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/browncoat
	name = "Коричневое кожаное пальто"
	desc = "Длинное кожаное пальто коричневого цвета."
	icon_state = "browncoat"
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask)
	item_state_slots = list(slot_r_hand_str = "brown_jacket", slot_l_hand_str = "brown_jacket")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/neocoat
	name = "Чёрное пальто"
	desc = "Элегантное чёрное пальто."
	icon_state = "neocoat"
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight, /obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask)
	item_state_slots = list(slot_r_hand_str = "leather_jacket", slot_l_hand_str = "leather_jacket")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/customs
	name = "Таможенный пиджак"
	desc = "Формальный пиджак Таможни Сол."
	icon_state = "customs_jacket"
	item_state_slots = list(slot_r_hand_str = "suit_blue", slot_l_hand_str = "suit_blue")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/greyjacket
	name = "Серая куртка"
	desc = "Красивая твидовая куртка серого цвета."
	icon_state = "gentlecoat"
	item_state_slots = list(slot_r_hand_str = "leather_jacket", slot_l_hand_str = "leather_jacket")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/trench
	name = "Коричневый тренчкот"
	desc = "Изношенный тренчкот. Бронированная прокладка, кажется, оттуда убрана."
	icon_state = "detective"
	blood_overlay_type = "coat"
	allowed = list(/obj/item/weapon/tank/emergency/oxygen, /obj/item/device/flashlight,/obj/item/weapon/gun/energy,/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/storage/fancy/cigarettes,/obj/item/weapon/flame/lighter,/obj/item/device/taperecorder,/obj/item/device/uv_light)
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/trench/grey
	name = "Серый тренчкот"
	icon_state = "detective2"
	item_state_slots = list(slot_r_hand_str = "leather_jacket", slot_l_hand_str = "leather_jacket")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/toggle/peacoat
	name = "Бушлат"
	desc = "Искусно сшитый бушлат."
	icon_state = "peacoat"
	addblends = "peacoat_a"
	item_state_slots = list(slot_r_hand_str = "peacoat", slot_l_hand_str = "peacoat")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/duster
	name = "Ковбойский пыльник"
	desc = "Элемент одежды ковбоев, распространненый на Земле в конце XIX века."
	icon_state = "duster"
	blood_overlay_type = "coat"
	allowed = list(/obj/item/weapon/tank/emergency/oxygen, /obj/item/device/flashlight,/obj/item/weapon/gun/energy,/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/storage/fancy/cigarettes,/obj/item/weapon/flame/lighter)
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/toggle/cardigan
	name = "Кардиган"
	desc = "Согревающий кардиган классического фасона."
	icon_state = "cardigan"
	addblends = "cardigan_a"
	flags_inv = HIDEHOLSTER

/*
 * stripper
 */
/obj/item/clothing/suit/stripper/stripper_pink
	name = "Откровенное розовое платье"
	desc = "Весьма откровенное платье розового цвета."
	icon_state = "stripper_p_over"
	item_state_slots = list(slot_r_hand_str = "pink_labcoat", slot_l_hand_str = "pink_labcoat")
	siemens_coefficient = 1

/obj/item/clothing/suit/stripper/stripper_green
	name = "Откровенное зеленое платье"
	desc = "Весьма откровенное платье зеленого цвета."
	icon_state = "stripper_g_over"
	item_state_slots = list(slot_r_hand_str = "green_labcoat", slot_l_hand_str = "green_labcoat")
	siemens_coefficient = 1

/obj/item/clothing/suit/xenos
	name = "Костюм ксеноморфа"
	desc = "Костюм, изготовленный из хитиновой шкуры инопланетного происхождения."
	icon_state = "xenos"
	item_state_slots = list(slot_r_hand_str = "black_suit", slot_l_hand_str = "black_suit")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	siemens_coefficient = 2.0

/obj/item/clothing/suit/jacket/puffer
	name = "Пуховик"
	desc = "Толстая куртка с водонепроницаемым внешним слоем из резины."
	icon_state = "pufferjacket"
	item_state_slots = list(slot_r_hand_str = "chainmail", slot_l_hand_str = "chainmail")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	cold_protection = UPPER_TORSO|LOWER_TORSO|ARMS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/jacket/puffer/vest
	name = "Пуховик-безрукавка"
	desc = "Толстая безрукавка с водонепроницаемым внешним слоем из резины."
	icon_state = "puffervest"
	item_state_slots = list(slot_r_hand_str = "chainmail", slot_l_hand_str = "chainmail")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	cold_protection = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/suit/storage/miljacket
	name = "Куртка милитари"
	desc = "Брезентовая куртка, имитирующая стиль классических американских военных форм. Плотная, но удобная."
	icon_state = "militaryjacket_nobadge"
	item_state_slots = list(slot_r_hand_str = "suit_olive", slot_l_hand_str = "suit_olive")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/miljacket/alt
	name = "Куртка милитари с нашивками"
	desc = "Брезентовая куртка, имитирующая стиль классических американских военных форм. Плотная, но удобная. На этой несколько дополнительных нашивок."
	icon_state = "militaryjacket_badge"
	item_state_slots = list(slot_r_hand_str = "suit_olive", slot_l_hand_str = "suit_olive")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/miljacket/green
	name = "Зелёная куртка милитари"
	desc = "Брезентовая куртка тёмного, насыщенного зелёного цвета. Плотная, но удобная."
	icon_state = "militaryjacket_green"
	item_state_slots = list(slot_r_hand_str = "suit_olive", slot_l_hand_str = "suit_olive")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/miljacket/tan
	name = "Песочная куртка милитари"
	desc = "Брезентовая куртка, имитирующая стиль классических американских военных форм. Плотная, но удобная. В песочных цветах для любителей пустынь."
	icon_state = "militaryjacket_tan"
	item_state_slots = list(slot_r_hand_str = "suit_orange", slot_l_hand_str = "suit_orange")
	flags_inv = HIDEHOLSTER
	index = 1

/obj/item/clothing/suit/storage/miljacket/grey
	name = "Серая куртка милитари"
	desc = "Брезентовая куртка, имитирующая стиль классических американских военных форм. Плотная, но удобная. Эта асфальтового цвета."
	icon_state = "militaryjacket_grey"
	item_state_slots = list(slot_r_hand_str = "suit_grey", slot_l_hand_str = "suit_grey")
	flags_inv = HIDEHOLSTER
	index = 1

/obj/item/clothing/suit/storage/miljacket/navy
	name = "Синяя куртка милитари"
	desc = "Брезентовая куртка, имитирующая стиль классических американских военных форм. Плотная, но удобная. Эта тёмно-синего цвета."
	icon_state = "militaryjacket_navy"
	item_state_slots = list(slot_r_hand_str = "suit_navy", slot_l_hand_str = "suit_navy")
	flags_inv = HIDEHOLSTER
	index = 1

/obj/item/clothing/suit/storage/miljacket/black
	name = "Чёрная куртка милитари"
	desc = "Брезентовая куртка, имитирующая стиль классических американских военных форм. Плотная, но удобная. Чёрная, как у солдат."
	icon_state = "militaryjacket_black"
	item_state_slots = list(slot_r_hand_str = "suit_black", slot_l_hand_str = "suit_black")
	flags_inv = HIDEHOLSTER
	index = 1

/obj/item/clothing/suit/storage/miljacket/white
	name = "Белая куртка милитари"
	desc = "Белая брезентовая куртка. На снегу не носите, от холода не спасёт -- а вот замёрзшее тело найти будет уже трудно."
	icon_state = "militaryjacket_white"
	item_state_slots = list(slot_r_hand_str = "med_dep_jacket", slot_l_hand_str = "med_dep_jacket")
	flags_inv = HIDEHOLSTER
	index = 1

/obj/item/clothing/suit/storage/toggle/bomber
	name = "Куртка-бомбер"
	desc = "Плотная изношенная куртка-бомбер времён Второй Мировой."
	icon_state = "bomber"
	item_state_slots = list(slot_r_hand_str = "brown_jacket", slot_l_hand_str = "brown_jacket")
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight, /obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask)
	body_parts_covered = UPPER_TORSO|ARMS
	flags_inv = HIDEHOLSTER
	cold_protection = UPPER_TORSO|ARMS
	min_cold_protection_temperature = T0C - 20
	siemens_coefficient = 0.7

/obj/item/clothing/suit/storage/bomber/alt
	name = "Куртка-бомбер"
	desc = "Плотная изношенная куртка-бомбер времён Второй Мировой."
	icon_state = "bomberjacket_new"
	item_state_slots = list(slot_r_hand_str = "brown_jacket", slot_l_hand_str = "brown_jacket")
	body_parts_covered = UPPER_TORSO|ARMS
	flags_inv = HIDEHOLSTER
	cold_protection = UPPER_TORSO|ARMS
	min_cold_protection_temperature = T0C - 20
	siemens_coefficient = 0.7

/obj/item/clothing/suit/storage/toggle/leather_jacket
	name = "Кожаная куртка"
	desc = "Кожаная куртка чёрного цвета."
	icon_state = "leather_jacket"
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight, /obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask)
	body_parts_covered = UPPER_TORSO|ARMS
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/toggle/leather_jacket/sleeveless
	name = "Кожаная безрукавка"
	desc = "Кожаная безрукавка чёрного цвета."
	icon_state = "leather_jacket_sleeveless"
	body_parts_covered = UPPER_TORSO
	item_state_slots = list(slot_r_hand_str = "leather_jacket", slot_l_hand_str = "leather_jacket")

/obj/item/clothing/suit/storage/leather_jacket_alt
	name = "Кожаная куртка"
	desc = "Кожаная куртка чёрного цвета."
	icon_state = "leather_jacket_alt"
	item_state_slots = list(slot_r_hand_str = "leather_jacket", slot_l_hand_str = "leather_jacket")
	body_parts_covered = UPPER_TORSO|ARMS

/obj/item/clothing/suit/storage/toggle/leather_jacket/nanotrasen
	desc = "Чёрная кожаная куртка. На спине гордо распластан логотип корпорации."
	icon_state = "leather_jacket_nt"
	item_state_slots = list(slot_r_hand_str = "leather_jacket", slot_l_hand_str = "leather_jacket")

/obj/item/clothing/suit/storage/toggle/leather_jacket/nanotrasen/sleeveless
	name = "Кожаная безрукавка"
	desc = "Черная кожаная безрукавка. На спине гордо распластан логотип корпорации."
	icon_state = "leather_jacket_nt_sleeveless"
	body_parts_covered = UPPER_TORSO
	item_state_slots = list(slot_r_hand_str = "leather_jacket", slot_l_hand_str = "leather_jacket")

//This one has buttons for some reason
/obj/item/clothing/suit/storage/toggle/brown_jacket
	name = "Коричневая куртка"
	desc = "Кожаная куртка коричневого цвета."
	icon_state = "brown_jacket"
	item_state_slots = list(slot_r_hand_str = "brown_jacket", slot_l_hand_str = "brown_jacket")
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask)
	body_parts_covered = UPPER_TORSO|ARMS
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/toggle/brown_jacket/sleeveless
	name = "Коричневая безрукавка"
	desc = "Кожаная безрукавка коричневого цвета."
	icon_state = "brown_jacket_sleeveless"
	body_parts_covered = UPPER_TORSO
	item_state_slots = list(slot_r_hand_str = "brown_jacket", slot_l_hand_str = "brown_jacket")

/obj/item/clothing/suit/storage/toggle/brown_jacket/nanotrasen
	desc = "Кожаная куртка коричневого цвета. На спине гордо распластан логотип корпорации."
	icon_state = "brown_jacket_nt"
	item_state_slots = list(slot_r_hand_str = "brown_jacket", slot_l_hand_str = "brown_jacket")

/obj/item/clothing/suit/storage/toggle/brown_jacket/nanotrasen/sleeveless
	name = "Коричневая безрукавка"
	desc = "Кожаная безрукавка коричневого цвета. На спине гордо распластан логотип корпорации."
	icon_state = "brown_jacket_nt_sleeveless"
	body_parts_covered = UPPER_TORSO
	item_state_slots = list(slot_r_hand_str = "brown_jacket", slot_l_hand_str = "brown_jacket")

/obj/item/clothing/suit/storage/toggle/denim_jacket
	name = "Денимовая куртка"
	desc = "Денимовая куртка."
	icon_state = "denim_jacket"
	item_state_slots = list(slot_r_hand_str = "denim_jacket", slot_l_hand_str = "denim_jacket")
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask)
	body_parts_covered = UPPER_TORSO|ARMS
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/toggle/denim_jacket/sleeveless
	name = "Денимовая безрукавка"
	desc = "Денимовая безрукавка."
	icon_state = "denim_jacket_sleeveless"
	body_parts_covered = UPPER_TORSO
	item_state_slots = list(slot_r_hand_str = "denim_jacket", slot_l_hand_str = "denim_jacket")

/obj/item/clothing/suit/storage/toggle/denim_jacket/nanotrasen
	desc = "Денимовая куртка. На спине гордо распластан логотип корпорации."
	icon_state = "denim_jacket_nt"
	item_state_slots = list(slot_r_hand_str = "denim_jacket", slot_l_hand_str = "denim_jacket")

/obj/item/clothing/suit/storage/toggle/denim_jacket/nanotrasen/sleeveless
	name = "Денимовая безрукавка"
	desc = "Денимовая безрукавка. На спине гордо распластан логотип корпорации."
	icon_state = "denim_jacket_nt_sleeveless"
	body_parts_covered = UPPER_TORSO
	item_state_slots = list(slot_r_hand_str = "denim_jacket", slot_l_hand_str = "denim_jacket")

/obj/item/clothing/suit/storage/toggle/hoodie
	name = "Серое худи"
	desc = "Тёплый свитшот серого цвета."
	icon_state = "grey_hoodie"
	item_state_slots = list(slot_r_hand_str = "suit_grey", slot_l_hand_str = "suit_grey")
	min_cold_protection_temperature = T0C - 20
	cold_protection = UPPER_TORSO|LOWER_TORSO|ARMS
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/toggle/hoodie/black
	name = "Чёрное худи"
	desc = "Тёплый свитшот чёрного цвета."
	icon_state = "black_hoodie"
	item_state_slots = list(slot_r_hand_str = "suit_black", slot_l_hand_str = "suit_black")

/obj/item/clothing/suit/storage/toggle/hoodie/red
	name = "Красное худи"
	desc = "Тёплый свитшот красного цвета."
	icon_state = "red_hoodie"
	item_state_slots = list(slot_r_hand_str = "suit_red", slot_l_hand_str = "suit_red")

/obj/item/clothing/suit/storage/toggle/hoodie/blue
	name = "Синее худи"
	desc = "Тёплый свитшот синего цвета."
	icon_state = "blue_hoodie"
	item_state_slots = list(slot_r_hand_str = "suit_blue", slot_l_hand_str = "suit_blue")

/obj/item/clothing/suit/storage/toggle/hoodie/green
	name = "Зелёное худи"
	desc = "Тёплый свитшот зелёного цвета."
	icon_state = "green_hoodie"
	item_state_slots = list(slot_r_hand_str = "suit_olive", slot_l_hand_str = "suit_olive")

/obj/item/clothing/suit/storage/toggle/hoodie/orange
	name = "Оранжевое худи"
	desc = "Тёплый свитшот оранжевого цвета."
	icon_state = "orange_hoodie"
	item_state_slots = list(slot_r_hand_str = "suit_orange", slot_l_hand_str = "suit_orange")

/obj/item/clothing/suit/storage/toggle/hoodie/yellow
	name = "Жёлтое худи"
	desc = "Тёплый свитшот жёлтого цвета."
	icon_state = "yellow_hoodie"
	item_state_slots = list(slot_r_hand_str = "suit_yellow", slot_l_hand_str = "suit_yellow")

/obj/item/clothing/suit/storage/toggle/hoodie/cti
	name = "Худи CTI"
	desc = "Тёплый свитшот чёрного цвета. На спине аббревиатура Ceti Techinal Institute, престижного университета в системе Тау Кита. Спереди вышита эмблема CTI - синяя сверхновая."
	icon_state = "cti_hoodie"
	item_state_slots = list(slot_r_hand_str = "suit_black", slot_l_hand_str = "suit_black")

/obj/item/clothing/suit/storage/toggle/hoodie/mu
	name = "Худи Mojave University"
	desc = "Тёплый свитшот серого цвета. Спереди вышиты буквы MU - аббревиатура известного общественного колледжа Mojave University."
	icon_state = "mu_hoodie"
	item_state_slots = list(slot_r_hand_str = "suit_grey", slot_l_hand_str = "suit_grey")

/obj/item/clothing/suit/storage/toggle/hoodie/nt
	name = "Худи NT"
	desc = "Тёплый свитшот синего цвета. На спине гордо распластана аббревиатура NanoTrasen, а края обделаны серебром."
	icon_state = "nt_hoodie"
	item_state_slots = list(slot_r_hand_str = "suit_blue", slot_l_hand_str = "suit_blue")

/obj/item/clothing/suit/storage/toggle/hoodie/smw
	name = "Худи Space Mountain Wind"
	desc = "Тёплый свитшот чёрного цвета. На нём с обеих сторон изображен логотип популярной газировки Space Mountain Wind."
	icon_state = "smw_hoodie"
	item_state_slots = list(slot_r_hand_str = "suit_black", slot_l_hand_str = "suit_black")

/obj/item/clothing/suit/storage/toggle/hoodie/nrti
	name = "Худи New Reykjavik Technical Institute"
	desc = "Тёплый свитшот серого цвета. Сзади вышита аббревиатура NRT, принадлежащая самому известному технологическому институту Сифа."
	icon_state = "nrti_hoodie"
	item_state_slots = list(slot_r_hand_str = "suit_grey", slot_l_hand_str = "suit_grey")

/obj/item/clothing/suit/whitedress
	name = "Белое платье"
	desc = "Красивое белое платье."
	icon_state = "white_dress"
	item_state_slots = list(slot_r_hand_str = "white_dress", slot_l_hand_str = "white_dress")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS
	flags_inv = HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/varsity
	name = "Чёрная университетская куртка"
	desc = "Популярна среди качков от Сола до Никса."
	icon_state = "varsity"
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask)
	item_state_slots = list(slot_r_hand_str = "suit_black", slot_l_hand_str = "suit_black")
	flags_inv = HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/varsity/red
	name = "Красная университетская куртка"
	icon_state = "varsity_red"

/obj/item/clothing/suit/varsity/purple
	name = "Фиолетовая университетская куртка"
	icon_state = "varsity_purple"

/obj/item/clothing/suit/varsity/green
	name = "Зелёная университетская куртка"
	icon_state = "varsity_green"

/obj/item/clothing/suit/varsity/blue
	name = "Синяя университетская куртка"
	icon_state = "varsity_blue"

/obj/item/clothing/suit/varsity/brown
	name = "Коричневая университетская куртка"
	icon_state = "varsity_brown"

/*
 * Department Jackets
 */
/obj/item/clothing/suit/storage/toggle/sec_dep_jacket
	name = "Куртка службы безопасности"
	desc = "Тёплая куртка в цветах Службы Безопасности. Поддержите свой отдел!"
	icon_state = "sec_dep_jacket"
	item_state_slots = list(slot_r_hand_str = "sec_dep_jacket", slot_l_hand_str = "sec_dep_jacket")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/toggle/engi_dep_jacket
	name = "Куртка инженерного отдела"
	desc = "Тёплая куртка в цветах инженерного отдела. Поддержите свой отдел!"
	icon_state = "engi_dep_jacket"
	item_state_slots = list(slot_r_hand_str = "engi_dep_jacket", slot_l_hand_str = "engi_dep_jacket")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/toggle/supply_dep_jacket
	name = "Куртка отдела снабжения"
	desc = "Тёплая куртка в цветах отдела снабжения. Поддержите свой отдел!"
	icon_state = "supply_dep_jacket"
	item_state_slots = list(slot_r_hand_str = "supply_dep_jacket", slot_l_hand_str = "supply_dep_jacket")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/toggle/sci_dep_jacket
	name = "Куртка научного отдела"
	desc = "Тёплая куртка в цветах научного отдела. Поддержите свой отдел!"
	icon_state = "sci_dep_jacket"
	item_state_slots = list(slot_r_hand_str = "sci_dep_jacket", slot_l_hand_str = "sci_dep_jacket")
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/toggle/med_dep_jacket
	name = "Куртка медицинского отдела"
	desc = "Тёплая куртка в цветах медицинского отдела. Поддержите свой отдел!"
	icon_state = "med_dep_jacket"
	item_state_slots = list(slot_r_hand_str = "med_dep_jacket", slot_l_hand_str = "med_dep_jacket")
	flags_inv = HIDEHOLSTER

/*
 * Track Jackets
 */
/obj/item/clothing/suit/storage/toggle/track
	name = "Спортивная куртка"
	desc = "Спортивная куртка для бега."
	icon_state = "trackjacket"
	item_state_slots = list(slot_r_hand_str = "black_labcoat", slot_l_hand_str = "black_labcoat")
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask)

/obj/item/clothing/suit/storage/toggle/track/blue
	name = "Синяя спортивная куртка"
	icon_state = "trackjacketblue"
	item_state_slots = list(slot_r_hand_str = "blue_labcoat", slot_l_hand_str = "blue_labcoat")


/obj/item/clothing/suit/storage/toggle/track/green
	name = "Зелёная спортивная куртка"
	icon_state = "trackjacketgreen"
	item_state_slots = list(slot_r_hand_str = "green_labcoat", slot_l_hand_str = "green_labcoat")

/obj/item/clothing/suit/storage/toggle/track/red
	name = "Красная спортивная куртка"
	icon_state = "trackjacketred"
	item_state_slots = list(slot_r_hand_str = "red_labcoat", slot_l_hand_str = "red_labcoat")

/obj/item/clothing/suit/storage/toggle/track/white
	name = "Белая спортивная куртка"
	icon_state = "trackjacketwhite"
	item_state_slots = list(slot_r_hand_str = "labcoat", slot_l_hand_str = "labcoat")

//Flannels

/obj/item/clothing/suit/storage/flannel
	name = "Фланелевая рубашка"
	desc = "Удобная фланелевая рубашка серого цвета. Дайте волю своему внутреннему хипстеру."
	icon_state = "flannel"
	item_state_slots = list(slot_r_hand_str = "black_labcoat", slot_l_hand_str = "black_labcoat")
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask)
	flags_inv = HIDEHOLSTER
	var/rolled = 0
	var/tucked = 0
	var/buttoned = 0

/obj/item/clothing/suit/storage/flannel/verb/roll_sleeves()
	set name = "Закатить Рукава"
	set category = "Объект"
	set src in usr
	if(!istype(usr, /mob/living))
		return
	if(usr.stat)
		return

	if(rolled == 0)
		rolled = 1
		body_parts_covered &= ~(ARMS)
		to_chat(usr, "<span class='notice'>Вы закатываете рукава [ru_getcase(src, "gcase")].</span>")
	else
		rolled = 0
		body_parts_covered = initial(body_parts_covered)
		to_chat(usr, "<span class='notice'>Вы распускаете рукава [ru_getcase(src, "gcase")].</span>")
	update_icon()

/obj/item/clothing/suit/storage/flannel/verb/tuck()
	set name = "Заправить Рубашку"
	set category = "Объект"
	set src in usr
	if(!istype(usr, /mob/living)||usr.stat)
		return

	if(tucked == 0)
		tucked = 1
		to_chat(usr, "<span class='notice'>Вы заправляете [ru_getcase(src, "acase")].</span>")
	else
		tucked = 0
		to_chat(usr, "<span class='notice'>Вы расправляете [ru_getcase(src, "acase")].</span>")
	update_icon()

/obj/item/clothing/suit/storage/flannel/verb/button()
	set name = "Пуговицы Рубашки"
	set category = "Объект"
	set src in usr
	if(!istype(usr, /mob/living)||usr.stat)
		return

	if(buttoned == 0)
		buttoned = 1
		flags_inv = HIDETIE|HIDEHOLSTER
		to_chat(usr, "<span class='notice'>Вы застёгиваете [ru_getcase(src, "acase")].</span>")
	else
		buttoned = 0
		flags_inv = HIDEHOLSTER
		to_chat(usr, "<span class='notice'>Вы расстёгиваете [ru_getcase(src, "acase")].</span>")
	update_icon()

/obj/item/clothing/suit/storage/flannel/update_icon()
	icon_state = initial(icon_state)
	if(rolled)
		icon_state += "r"
	if(tucked)
		icon_state += "t"
	if(buttoned)
		icon_state += "b"
	update_clothing_icon()

/obj/item/clothing/suit/storage/flannel/red
	desc = "Удобная фланелевая рубашка красного цвета. Дайте волю своему внутреннему хипстеру."
	icon_state = "flannel_red"
	item_state_slots = list(slot_r_hand_str = "red_labcoat", slot_l_hand_str = "red_labcoat")

/obj/item/clothing/suit/storage/flannel/aqua
	desc = "Удобная фланелевая рубашка цвета морской волны. Дайте волю своему внутреннему хипстеру."
	icon_state = "flannel_aqua"
	item_state_slots = list(slot_r_hand_str = "blue_labcoat", slot_l_hand_str = "blue_labcoat")

/obj/item/clothing/suit/storage/flannel/brown
	desc = "Удобная фланелевая рубашка коричневого цвета. Дайте волю своему внутреннему хипстеру."
	icon_state = "flannel_brown"
	item_state_slots = list(slot_r_hand_str = "johnny", slot_l_hand_str = "johnny")

//Green Uniform

/obj/item/clothing/suit/storage/toggle/greengov
	name = "Зелёный формальный пиджак"
	desc = "Стильный формальный пиджак зелёного цвета с золотыми пуговицами."
	icon_state = "suitjacket_green"
	item_state_slots = list(slot_r_hand_str = "suit_olive", slot_l_hand_str = "suit_olive")
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|ARMS
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/snowsuit
	name = "Зимняя куртка"
	desc = "Верхняя одежда, позволяющая оставаться в тепле в холодные зимние дни. Или хотя бы в живых."
	icon_state = "snowsuit"
	item_state_slots = list(slot_r_hand_str = "labcoat", slot_l_hand_str = "labcoat")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	flags_inv = HIDEHOLSTER
	cold_protection = UPPER_TORSO|LOWER_TORSO|ARMS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask)

/obj/item/clothing/suit/storage/snowsuit/command
	name = "Зимняя куртка Управления"
	icon_state = "snowsuit_command"

/obj/item/clothing/suit/storage/snowsuit/security
	name = "Зимняя куртка службы безопасности"
	icon_state = "snowsuit_security"

/obj/item/clothing/suit/storage/snowsuit/medical
	name = "Зимняя куртка врача"
	icon_state = "snowsuit_medical"

/obj/item/clothing/suit/storage/snowsuit/engineering
	name = "Зимняя куртка инженера"
	icon_state = "snowsuit_engineering"

/obj/item/clothing/suit/storage/snowsuit/cargo
	name = "Зимняя куртка грузчика"
	icon_state = "snowsuit_cargo"

/obj/item/clothing/suit/storage/snowsuit/science
	name = "Зимняя куртка учёного"
	icon_state = "snowsuit_science"

/obj/item/clothing/suit/caution
	name = "Табличка \"Мокрый пол!\""
	desc = "ОСТОРОЖНО! Мокрый пол!"
	description_fluff = "Уборщики имеют тенденцию пассивно-агрессивно указывать на неё, когда Вы поскальзываетесь на мокром полу."
	description_info = "Альт+клик, либо нажатие в руке, активирует фонарики. Похоже, табличку можно носить поверх одежды."
	icon_state = "caution"
	drop_sound = 'sound/items/drop/shoes.ogg'
	force = 1
	throwforce = 3
	throw_speed = 2
	throw_range = 5
	w_class = 2
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	attack_verb = list("предупреждает", "остерегает", "стукает")
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/caution/attack_self()
	toggle()

/obj/item/clothing/suit/caution/AltClick()
	toggle()

/obj/item/clothing/suit/caution/proc/toggle()
	if(!usr || usr.stat || usr.lying || usr.restrained() || !Adjacent(usr))	return
	else if(src.icon_state == "caution")
		src.icon_state = "caution_blinking"
		src.item_state = "caution_blinking"
		usr.show_message("Вы включаете фонарики таблички.")
		playsound(src.loc, 'sound/machines/button.ogg', 30, 1)
	else
		src.icon_state = "caution"
		src.item_state = "caution"
		usr.show_message("Вы выключаете фонарики таблички.")
	update_clothing_icon()