/*
 * Backpack
 */

/obj/item/weapon/storage/backpack
	name = "Рюкзак"
	desc = "Он надевается на спину и используется для хранения предметов."
	icon = 'icons/obj/clothing/backpack.dmi'
	icon_state = "backpack"
	sprite_sheets = list(
		SPECIES_TESHARI = 'icons/mob/species/teshari/back.dmi'
		)
	w_class = ITEMSIZE_LARGE
	slot_flags = SLOT_BACK
	max_w_class = ITEMSIZE_LARGE
	max_storage_space = INVENTORY_STANDARD_SPACE
	var/flippable = 0
	var/side = 0 //0 = right, 1 = left
	drop_sound = 'sound/items/drop/backpack.ogg'
	pickup_sound = 'sound/items/pickup/backpack.ogg'


/obj/item/weapon/storage/backpack/equipped(var/mob/user, var/slot)
	if (slot == slot_back && src.use_sound)
		playsound(src, src.use_sound, 50, 1, -5)
	..(user, slot)

/*
/obj/item/weapon/storage/backpack/dropped(mob/user as mob)
	if (loc == user && src.use_sound)
		playsound(src, src.use_sound, 50, 1, -5)
	..(user)
*/

/*
 * Backpack Types
 */

/obj/item/weapon/storage/backpack/holding
	name = "Рюкзак-хранилище"
	desc = "Рюкзак, открывающий портативный карман в Блюспейсе."
	origin_tech = list(TECH_BLUESPACE = 4)
	icon_state = "holdingpack"
	max_w_class = ITEMSIZE_LARGE
	max_storage_space = ITEMSIZE_COST_NORMAL * 14 // 56
	storage_cost = INVENTORY_STANDARD_SPACE + 1

/obj/item/weapon/storage/backpack/holding/duffle
	name = "Вещмешок-хранилище"
	icon_state = "holdingduffle"

/obj/item/weapon/storage/backpack/holding/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/storage/backpack/holding))
		to_chat(user, "<span class='warning'>Блюспейсовые интерфейсы конфликтуют друг с другом и дают сбой.</span>")
		qdel(W)
		return
	. = ..()

//Please don't clutter the parent storage item with stupid hacks.
/obj/item/weapon/storage/backpack/holding/can_be_inserted(obj/item/W as obj, stop_messages = 0)
	if(istype(W, /obj/item/weapon/storage/backpack/holding))
		return 1
	return ..()

/obj/item/weapon/storage/backpack/santabag
	name = "Мешок с подарками Санты"
	desc = "Космический Санта доставляет в нём подарки послушным детям. Вау, огромный!"
	icon_state = "giftbag0"
	item_state_slots = list(slot_r_hand_str = "giftbag", slot_l_hand_str = "giftbag")
	w_class = ITEMSIZE_LARGE
	max_w_class = ITEMSIZE_NORMAL
	max_storage_space = ITEMSIZE_COST_NORMAL * 100 // can store a ton of shit!
	item_state_slots = null

/obj/item/weapon/storage/backpack/cultpack
	name = "Трофейная витрина"
	desc = "Полезная как для хранения экипировки, так и для гордой демонстрации своего безумия."
	icon_state = "cultpack"

/obj/item/weapon/storage/backpack/clown
	name = "Полный Хохотач"
	desc = "Этот рюкзак изготовлен Хонк! Кo."
	icon_state = "clownpack"

/obj/item/weapon/storage/backpack/medic
	name = "Медицинский рюкзак"
	desc = "Этот рюкзак предначен для использования в стерильной среде."
	icon_state = "medicalpack"

/obj/item/weapon/storage/backpack/security
	name = "Рюкзак службы безопасности"
	desc = "Очень надёжный рюкзак."
	icon_state = "securitypack"

/obj/item/weapon/storage/backpack/captain
	name = "Рюкзак Директора колонии"
	desc = "Особый рюкзак, изготавливаемый исключительно для руководителей."
	icon_state = "captainpack"

/obj/item/weapon/storage/backpack/industrial
	name = "Промышленный рюкзак"
	desc = "Прочный рюкзак, предназначенный для ежедневной рутинной работы на станции."
	icon_state = "engiepack"

/obj/item/weapon/storage/backpack/toxins
	name = "Лабораторный рюкзак"
	desc = "Лёгкий рюкзак, предназначенный для использования в лабораториях и прочих научных местах."
	icon_state = "toxpack"

/obj/item/weapon/storage/backpack/hydroponics
	name = "Травнический рюкзак"
	desc = "Зелёный рюкзак с большим количеством карманов для хранения как растений, так и инструментов."
	icon_state = "hydpack"

/obj/item/weapon/storage/backpack/genetics
	name = "Рюкзак генетика"
	desc = "Это рюкзак, обладающий кармашками для дискет и прочих инструментов."
	icon_state = "genpack"

/obj/item/weapon/storage/backpack/virology
	name = "Стерильный рюкзак"
	desc = "Это стерильный рюкзак, не поддающийся воздействию различных патогенов."
	icon_state = "viropack"

/obj/item/weapon/storage/backpack/chemistry
	name = "Химический рюкзак"
	desc = "Это оранжевый рюкзак, приспособленный для хранения мензурок, пузырьков и склянок."
	icon_state = "chempack"

/*
 * Duffle Types
 */

/obj/item/weapon/storage/backpack/dufflebag
	name = "Вещмешок"
	desc = "Крупный вещмешок для хранения принадлежностей."
	icon_state = "duffle"
	slowdown = 1
	max_storage_space = INVENTORY_DUFFLEBAG_SPACE

/obj/item/weapon/storage/backpack/dufflebag/syndie
	name = "Чёрный вещмешок"
	desc = "Крупный вещмешок для хранения дополнительных тактических припасов. Этот, кажется, из более лёгкого материала, чем обычно."
	icon_state = "duffle_syndie"
	slowdown = 0

/obj/item/weapon/storage/backpack/dufflebag/syndie/med
	name = "Медицинский вещмешок"
	desc = "Крупный вещмешок для хранения дополнительных медицинских припасов. Этот, кажется, из более лёгкого материала, чем обычно."
	icon_state = "duffle_syndiemed"

/obj/item/weapon/storage/backpack/dufflebag/syndie/ammo
	name = "Вещмешок для боеприпасов"
	desc = "Крупный вещмешок для хранения дополнительных тактических припасов и патронов. Этот, кажется, из более лёгкого материала, чем обычно."
	icon_state = "duffle_syndieammo"

/obj/item/weapon/storage/backpack/dufflebag/captain
	name = "Вещмешок Директора колонии"
	desc = "Крупный вещмешок для хранения директорских принадлежностей."
	icon_state = "duffle_captain"

/obj/item/weapon/storage/backpack/dufflebag/med
	name = "Медицинский вещмешок"
	desc = "Крупный вещмешок для хранения дополнительных медицинских припасов."
	icon_state = "duffle_med"

/obj/item/weapon/storage/backpack/dufflebag/emt
	name = "Вещмешок парамедика"
	desc = "Крупный вещмешок для хранения дополнительных медицинских припасов. На этом вещмешке есть светоотражательные полосы!"
	icon_state = "duffle_emt"

/obj/item/weapon/storage/backpack/dufflebag/sec
	name = "Вещмешок службы безопасности"
	desc = "Крупный вещмешок для хранения дополнительных припасов и патронов службы безопасности."
	icon_state = "duffle_sec"

/obj/item/weapon/storage/backpack/dufflebag/eng
	name = "Рабочий вещмешок"
	desc = "Крупный вещмешок для хранения дополнительных припасов и инструментов."
	icon_state = "duffle_eng"

/obj/item/weapon/storage/backpack/dufflebag/sci
	name = "Научный вещмешок"
	desc = "Крупный вещмешок для хранения всевозможных микросхем и мензурок."
	icon_state = "duffle_sci"

/*
 * Satchel Types
 */

/obj/item/weapon/storage/backpack/satchel
	name = "Кожаная сумка"
	desc = "Очень стильная сумка из качественной кожи."
	icon_state = "satchel"
	item_state_slots = list(slot_r_hand_str = "briefcase", slot_l_hand_str = "briefcase")

/obj/item/weapon/storage/backpack/satchel/withwallet
	starts_with = list(/obj/item/weapon/storage/wallet/random)

/obj/item/weapon/storage/backpack/satchel/norm
	name = "Сумка"
	desc = "Довольно модная сумка."
	icon_state = "satchel-norm"

/obj/item/weapon/storage/backpack/satchel/eng
	name = "Промышленная сумка"
	desc = "Надёжная сумка с кучей карманов."
	icon_state = "satchel-eng"
	item_state_slots = list(slot_r_hand_str = "engiepack", slot_l_hand_str = "engiepack")

/obj/item/weapon/storage/backpack/satchel/med
	name = "Медицинская сумка"
	desc = "Стерильная сумка, предназначенная для использования в медицинском отделе."
	icon_state = "satchel-med"
	item_state_slots = list(slot_r_hand_str = "medicalpack", slot_l_hand_str = "medicalpack")

/obj/item/weapon/storage/backpack/satchel/vir
	name = "Сумка вирусолога"
	desc = "Стерильная сумка в расцветке вирусолога."
	icon_state = "satchel-vir"
	item_state_slots = list(slot_r_hand_str = "viropack", slot_l_hand_str = "viropack")

/obj/item/weapon/storage/backpack/satchel/chem
	name = "Сумка химика"
	desc = "Стерильная сумка в расцветке химика."
	icon_state = "satchel-chem"
	item_state_slots = list(slot_r_hand_str = "chempack", slot_l_hand_str = "chempack")

/obj/item/weapon/storage/backpack/satchel/gen
	name = "Сумка генетика"
	desc = "Стерильная сумка в расцветке генетика."
	icon_state = "satchel-gen"
	item_state_slots = list(slot_r_hand_str = "genpack", slot_l_hand_str = "genpack")

/obj/item/weapon/storage/backpack/satchel/tox
	name = "Сумка учёного"
	desc = "Полезна для хранения различных материалов для исследований."
	icon_state = "satchel-tox"
	item_state_slots = list(slot_r_hand_str = "toxpack", slot_l_hand_str = "toxpack")

/obj/item/weapon/storage/backpack/satchel/sec
	name = "Сумка службы безопасности"
	desc = "Надёжная сумка для всех нужд службы безопаности."
	icon_state = "satchel-sec"
	item_state_slots = list(slot_r_hand_str = "securitypack", slot_l_hand_str = "securitypack")

/obj/item/weapon/storage/backpack/satchel/hyd
	name = "Сумка ботаника"
	desc = "Зелёная сумка для всего, что связано с растениями."
	icon_state = "satchel_hyd"

/obj/item/weapon/storage/backpack/satchel/cap
	name = "Сумка Директора колонии"
	desc = "Сумка, предназначенная исключительно для руководителя."
	icon_state = "satchel-cap"
	item_state_slots = list(slot_r_hand_str = "captainpack", slot_l_hand_str = "captainpack")

//ERT backpacks.
/obj/item/weapon/storage/backpack/ert
	name = "Рюкзак группы экстренного реагирования"
	desc = "Просторный рюкзак с множеством карманов, используемый членами группы экстренного аварийного реагирования."
	icon_state = "ert_commander"
	item_state_slots = list(slot_r_hand_str = "securitypack", slot_l_hand_str = "securitypack")

//Commander
/obj/item/weapon/storage/backpack/ert/commander
	name = "Рюкзак руководителя группы экстренного реагирования"
	desc = "Просторный рюкзак с множеством карманов, используемый руководителями группы экстренного аварийного реагирования."

//Security
/obj/item/weapon/storage/backpack/ert/security
	name = "Рюкзак службы безопасности экстренного реагирования"
	desc = "Просторный рюкзак с множеством карманов, используемый членами службы безопасности группы экстренного аварийного реагирования."
	icon_state = "ert_security"

//Engineering
/obj/item/weapon/storage/backpack/ert/engineer
	name = "Рюкзак инженера группы экстренного реагирования"
	desc = "Просторный рюкзак с множеством карманов, используемый инженерами группы экстренного аварийного реагирования."
	icon_state = "ert_engineering"

//Medical
/obj/item/weapon/storage/backpack/ert/medical
	name = "Рюкзак врача группы экстренного реагирования"
	desc = "Просторный рюкзак с множеством карманов, используемый врачами группы экстренного аварийного реагирования."
	icon_state = "ert_medical"

/*
 * Courier Bags
 */

/obj/item/weapon/storage/backpack/messenger
	name = "Курьерская сумка"
	desc = "Надёжный рюкзак, надеваемый на одно плечо."
	icon_state = "courierbag"
	item_state_slots = list(slot_r_hand_str = "backpack", slot_l_hand_str = "backpack")

/obj/item/weapon/storage/backpack/messenger/chem
	name = "Курьерская сумка химика"
	desc = "Стерильный рюкзак, надеваемый на одно плечо. Этот рюкзак в расцветке химика."
	icon_state = "courierbagchem"
	item_state_slots = list(slot_r_hand_str = "chempack", slot_l_hand_str = "chempack")

/obj/item/weapon/storage/backpack/messenger/med
	name = "Курьерская сумка врача"
	desc = "Стерильный рюкзак, надеваемый на одно плечо и предназначенный для использования в медицинском отделе."
	icon_state = "courierbagmed"
	item_state_slots = list(slot_r_hand_str = "medicalpack", slot_l_hand_str = "medicalpack")

/obj/item/weapon/storage/backpack/messenger/viro
	name = "Курьерская сумка вирусолога"
	desc = "Стерильный рюкзак, надеваемый на одно плечо. Этот рюкзак в расцветке вирусолога."
	icon_state = "courierbagviro"
	item_state_slots = list(slot_r_hand_str = "viropack", slot_l_hand_str = "viropack")

/obj/item/weapon/storage/backpack/messenger/tox
	name = "Курьерская сумка учёного"
	desc = "Рюкзак, надеваемый на одно плечо. Позволяет хранить различные материалы для исследований."
	icon_state = "courierbagtox"
	item_state_slots = list(slot_r_hand_str = "toxpack", slot_l_hand_str = "toxpack")

/obj/item/weapon/storage/backpack/messenger/com
	name = "Курьерская сумка Управления"
	desc = "Особый рюкзак, надеваемый на одно плечо. Этот изготовлен исключительно для руководителей."
	icon_state = "courierbagcom"
	item_state_slots = list(slot_r_hand_str = "captainpack", slot_l_hand_str = "captainpack")

/obj/item/weapon/storage/backpack/messenger/engi
	name = "Курьерская сумка инженера"
	icon_state = "courierbagengi"
	item_state_slots = list(slot_r_hand_str = "engiepack", slot_l_hand_str = "engiepack")

/obj/item/weapon/storage/backpack/messenger/hyd
	name = "Курьерская сумка ботаника"
	desc = "Рюкзак, надеваемый на одно плечо. Эта сумка предназначена для работы с растительностью."
	icon_state = "courierbaghyd"

/obj/item/weapon/storage/backpack/messenger/sec
	name = "Курьерская сумка службы безопасности"
	desc = "Тактический рюкзак, надеваемый на одно плечо. Эта сумка в расцветке службы безопасности."
	icon_state = "courierbagsec"
	item_state_slots = list(slot_r_hand_str = "securitypack", slot_l_hand_str = "securitypack")

/obj/item/weapon/storage/backpack/messenger/black
	icon_state = "courierbagblk"


//Purses
/obj/item/weapon/storage/backpack/purse
	name = "Сумочка"
	desc = "Небольшая модная сумочка, надеваемая через плечо."
	icon_state = "purse"
	item_state_slots = list(slot_r_hand_str = "lgpurse", slot_l_hand_str = "lgpurse")
	w_class = ITEMSIZE_LARGE
	max_w_class = ITEMSIZE_NORMAL
	max_storage_space = ITEMSIZE_COST_NORMAL * 5

//Parachutes
/obj/item/weapon/storage/backpack/parachute
	name = "Парашут"
	desc = "Особый рюкзак, позволяющий прыгать с невероятных высот. За счёт сложенного парашута в нём значительно меньше свободного места."
	icon_state = "parachute"
	item_state_slots = list(slot_r_hand_str = "backpack", slot_l_hand_str = "backpack")
	max_storage_space = ITEMSIZE_COST_NORMAL * 5

/obj/item/weapon/storage/backpack/parachute/examine(mob/user)
	. = ..()
	if(Adjacent(user))
		if(parachute)
			. += "Парашут сложен."
		else
			. += "Парашут разложен."

/obj/item/weapon/storage/backpack/parachute/handleParachute()
	parachute = FALSE	//If you parachute in, the parachute has probably been used.

/obj/item/weapon/storage/backpack/parachute/verb/pack_parachute()

	set name = "Сложить/Разложить Парашут"
	set category = "Object"
	set src in usr

	if(!istype(src.loc, /mob/living))
		return

	var/mob/living/carbon/human/H = usr

	if(!istype(H))
		return
	if(H.stat)
		return
	if(H.back == src)
		to_chat(H, "<span class='warning'>Вы как собрались работать с [ru_getcase(src, "icase")], если [ru_g_obj(src, "он", "", "а", "о", "и")] у Вас на спине?</span>")
		return

	if(!parachute)	//This packs the parachute
		H.visible_message("<span class='notice'>[H] [ru_g_mob(H, "начина", "ет", "ет", "ет", "ют")] упаковывать [ru_getcase(src, "acase")]!</span>", \
					"<span class='notice'>Вы начинаете упаковывать [ru_getcase(src, "acase")]!</span>", \
					"Вы слышите запихивание ткани.")
		if(do_after(H, 50))
			H.visible_message("<span class='notice'>[H] [ru_g_mob(H, "упаковал")] [ru_getcase(src, "acase")]!</span>", \
					"<span class='notice'>Вы упаковали [ru_getcase(src, "acase")]!</span>", \
					"Вы слышите запихивание ткани.")
			parachute = TRUE
		else
			H.visible_message("<span class='notice'>[H] [ru_g_mob(H, "передумал")] упаковывать [ru_getcase(src, "acase")]!</span>", \
					"<span class='notice'>Вы передумали упаковывать [ru_getcase(src, "acase")]!</span>")
			return
	else			//This unpacks the parachute
		H.visible_message("<span class='notice'>[H] [ru_g_mob(H, "начина", "ет", "ет", "ет", "ют")] распаковывать [ru_getcase(src, "acase")]!</span>", \
					"<span class='notice'>Вы начинаете распаковывать [ru_getcase(src, "acase")]!</span>", \
					"Вы слышите запихивание ткани.")
		if(do_after(H, 25))
			H.visible_message("<span class='notice'>[H] [ru_g_mob(H, "распаковал")] [ru_getcase(src, "acase")]!</span>", \
					"<span class='notice'>Вы распаковали [ru_getcase(src, "acase")]!</span>", \
					"Вы слышите запихивание ткани.")
			parachute = FALSE
		else
			H.visible_message("<span class='notice'>[H] [ru_g_mob(H, "передумал")] распаковывать [ru_getcase(src, "acase")]!</span>", \
					"<span class='notice'>Вы передумали распаковывать [ru_getcase(src, "acase")]!</span>")
	return

/obj/item/weapon/storage/backpack/satchel/ranger
	name = "Сумка рейнджера"
	desc = "Сумка Go Go ERT Рейнджеров, позволяющая хранить большое количество вещей. \
	Вопреки сериалу, это не фороновая сумка, в которой волшебным образом появляются нужные вещи."
	icon = 'icons/obj/clothing/ranger.dmi'
	icon_state = "ranger_satchel"