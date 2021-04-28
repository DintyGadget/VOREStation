/obj/item/clothing/under/pj/red
	name = "красная пижама"
	desc = "Пижама для сна."
	icon_state = "red_pyjamas"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")

/obj/item/clothing/under/pj/blue
	name = "синяя пижама"
	desc = "Пижама для сна."
	icon_state = "blue_pyjamas"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")

/obj/item/clothing/under/captain_fly
	name = "униформа разбойника"
	desc = "Для мужчины, котому абсолютно всё равно."
	icon_state = "captain_fly"
	item_state_slots = list(slot_r_hand_str = "red", slot_l_hand_str = "red")

/obj/item/clothing/under/scratch
	name = "белый костюм"
	desc = "Отличный костюм для отличного хозяина вечеринки."
	icon_state = "scratch"

/obj/item/clothing/under/scratch/skirt
	name = "белый костюм с юбкой"
	icon_state = "scratch_skirt"
	item_state_slots = list(slot_r_hand_str = "scratch", slot_l_hand_str = "scratch")

/obj/item/clothing/under/sl_suit
	desc = "Скудноватый на вид костюм."
	name = "амишевый костюм"
	icon_state = "sl_suit"
	rolled_sleeves = 0

/obj/item/clothing/under/waiter
	name = "униформа официанта"
	desc = "Солидная униформа с особым кармашком для чаевых."
	icon_state = "waiter"
	rolled_sleeves = 0

/obj/item/clothing/under/customs
	name = "таможенная униформа"
	desc = "Стандартная таможенная униформа Сол. На ней множество вышивок."
	icon_state = "cu_suit"

/obj/item/clothing/under/customs/khaki
	icon_state = "cu_suit_kh"

/obj/item/clothing/under/rank/mailman
	name = "комбинезон почтальона"
	desc = "<i>'Спецдоставка!'</i>"
	icon_state = "mailman"
	item_state_slots = list(slot_r_hand_str = "blue", slot_l_hand_str = "blue")
	rolled_sleeves = 0

/obj/item/clothing/under/sexyclown
	name = "сексапильный костюм клоуна"
	desc = "Так и хочется Вас хонкнуть!"
	icon_state = "sexyclown"
	item_state_slots = list(slot_r_hand_str = "clown", slot_l_hand_str = "clown")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	rolled_sleeves = -1 //Please never

/obj/item/clothing/under/rank/vice
	name = "комбинезон вице-офицера"
	desc = "Униформа мальчика на побегушках."
	icon_state = "vice"
	item_state_slots = list(slot_r_hand_str = "grey", slot_l_hand_str = "grey")

//This set of uniforms looks fairly fancy and is generally used for high-ranking NT personnel from what I've seen, so lets give them appropriate ranks.
/obj/item/clothing/under/rank/centcom
	desc = "Золотые кромки поверх чёрных тканей. Эта униформа демонстрирует звание Капитана."
	name = "парадная униформа Офицера ЦК"
	icon_state = "officer"
	item_state_slots = list(slot_r_hand_str = "lawyer_black", slot_l_hand_str = "lawyer_black")
	displays_id = 0

/obj/item/clothing/under/rank/centcom_officer
	desc = "Золотые кромки поверх чёрных тканей. Эта униформа демонстрирует звание Адмирала."
	name = "парадная униформа Офицера ЦК"
	icon_state = "officer"
	item_state_slots = list(slot_r_hand_str = "lawyer_black", slot_l_hand_str = "lawyer_black")
	displays_id = 0

/obj/item/clothing/under/rank/centcom_captain
	desc = "Золотые кромки поверх чёрных тканей. Эта униформа демонстрирует звание Исполнительного Адмирала."
	name = "парадная униформа Офицера ЦК"
	icon_state = "centcom"
	item_state_slots = list(slot_r_hand_str = "lawyer_black", slot_l_hand_str = "lawyer_black")
	displays_id = 0

/obj/item/clothing/under/ert
	name = "тактическая форма ГЭР"
	desc = "Чёрная униформа с короткими рукавами вместе с серыми камуфляжными штанами."
	icon_state = "ert_uniform"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")

/obj/item/clothing/under/gov
	desc = "Формальная униформа для важных дел. Воротник <i>тщательно</i> закрахмален."
	name = "формальная зеленая униформа"
	icon_state = "greensuit"
	item_state_slots = list(slot_r_hand_str = "centcom", slot_l_hand_str = "centcom")
	rolled_sleeves = 0
	starting_accessories = list(/obj/item/clothing/accessory/tie/darkgreen)

/obj/item/clothing/under/gov/skirt
	name = "формальная зеленая юбка"
	desc = "Формальная униформа для важных дел. Верхняя пуговица вшита полностью."
	icon_state = "greensuit_skirt"

/obj/item/clothing/under/space
	name = "кобинезон NASA"
	desc = "Изготовлен из герметичных материалов и имеет на себе логотип NASA."
	icon_state = "black"
	w_class = ITEMSIZE_LARGE//bulky item
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.02
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS //Needs gloves and shoes with cold protection to be fully protected.
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	rolled_sleeves = 0

/obj/item/clothing/under/acj
	name = "административный кибернетический костюм"
	icon_state = "syndicate"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	desc = "Кибернетически усовершенствованный кобинезон для исполнения административных обязанностей."
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	armor = list(melee = 100, bullet = 100, laser = 100,energy = 100, bomb = 100, bio = 100, rad = 100)
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0

/obj/item/clothing/under/owl
	name = "костюм филина"
	desc = "Комбинезон с крыльями. И с реалистичными перьями!"
	icon_state = "owl"

/obj/item/clothing/under/johnny
	name = "кобинезон Джонни~~"
	desc = "Джонни~~"
	icon_state = "johnny"

/obj/item/clothing/under/color/rainbow
	name = "радужный комбинезон"
	desc = "Комбинезон всех цветов радуги."
	icon_state = "rainbow"

/obj/item/clothing/under/psysuit
	name = "темное термобелье"
	desc = "Плотное слоистое термобелье темного цвета, обвитое проводами. Будто переносная электрическая буря."
	icon_state = "psysuit"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/under/gentlesuit
	name = "костюм джентльмена"
	desc = "Шёлковая рубашка чёрного цвета в комплекте с серыми брюками."
	icon_state = "gentlesuit"
	item_state_slots = list(slot_r_hand_str = "grey", slot_l_hand_str = "grey")
	rolled_sleeves = 0
	starting_accessories = list(/obj/item/clothing/accessory/tie/white, /obj/item/clothing/accessory/wcoat/gentleman)

/obj/item/clothing/under/gentlesuit/skirt
	name = "костюм леди"
	desc = "Шёлковая блузка чёрного цвета в комплекте с серой юбкой."
	icon_state = "gentlesuit_skirt"

/obj/item/clothing/under/gimmick/rank/captain/suit
	name = "костюм Директора Колонии"
	desc = "Зеленый костюм с желтым галстуком. Пиковый авторитет."
	icon_state = "green_suit"
	item_state_slots = list(slot_r_hand_str = "centcom", slot_l_hand_str = "centcom")

/obj/item/clothing/under/gimmick/rank/captain/suit/skirt
	name = "юбка Директора Колонии"
	icon_state = "green_suit_skirt"

/obj/item/clothing/under/gimmick/rank/head_of_personnel/suit
	name = "костюм Главы Персонала"
	desc = "Бирюзовый костюм с желтым галстуком. Показушно, однако стильно."
	icon_state = "teal_suit"
	item_state_slots = list(slot_r_hand_str = "green", slot_l_hand_str = "green")

/obj/item/clothing/under/gimmick/rank/head_of_personnel/suit/skirt
	name = "юбка Главы Персонала"
	icon_state = "teal_suit_skirt"

/obj/item/clothing/under/suit_jacket
	name = "черный костюм"
	desc = "Чёрный костюм с красным галстуком. Очень официально."
	icon_state = "black_suit"
	item_state_slots = list(slot_r_hand_str = "lawyer_black", slot_l_hand_str = "lawyer_black")

/obj/item/clothing/under/suit_jacket/really_black
	name = "костюм руководителя"
	desc = "Чёрный костюм с красным галстуком, предназначенный для самых крупных шишек."
	icon_state = "really_black_suit"
	item_state_slots = list(slot_r_hand_str = "lawyer_black", slot_l_hand_str = "lawyer_black")

/obj/item/clothing/under/suit_jacket/really_black/skirt
	name = "костюм руководителя с юбкой"
	desc = "Чёрный костюм с красным галстуком, предназначенный для самых крупных шишек."
	icon_state = "really_black_suit_skirt"

/obj/item/clothing/under/suit_jacket/female
	name = "женский костюм руководителя"
	desc = "Женский костюм с брюками, предназначенный для самых крупных шишек."
	icon_state = "black_suit_fem"
	item_state_slots = list(slot_r_hand_str = "lawyer_black", slot_l_hand_str = "lawyer_black")

/obj/item/clothing/under/suit_jacket/female/skirt
	name = "костюм руководителя с юбкой"
	desc = "Женский костюм с юбкой, предназначенный для самых крупных шишек."
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	icon_state = "black_suit_fem"
	item_state = "black_formal_skirt"

/obj/item/clothing/under/suit_jacket/red
	name = "красный костюм"
	desc = "Красный костюм с синим галстуком. Вполне официально."
	icon_state = "red_suit"
	item_state_slots = list(slot_r_hand_str = "lawyer_red", slot_l_hand_str = "lawyer_red")

/obj/item/clothing/under/suit_jacket/red/skirt
	name = "красный костюм с юбкой"
	desc = "Красный костюм с синим галстуком. Вполне официально."
	icon_state = "red_suit_skirt"

/obj/item/clothing/under/schoolgirl
	name = "униформа школьницы"
	desc = "Прям как в японских мультиках!"
	icon_state = "schoolgirl"
	item_state_slots = list(slot_r_hand_str = "blue", slot_l_hand_str = "blue")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/overalls
	name = "кобинезон работяги"
	desc = "Надежный комбинезон для исполнения обязанностей."
	icon_state = "overalls"
	item_state_slots = list(slot_r_hand_str = "cargo", slot_l_hand_str = "cargo")

/obj/item/clothing/under/overalls/sleek
	name = "стильный комбинезон"
	desc = "Современный кобинезон, упрочненный кожзамом."
	icon_state = "overalls_sleek"

/obj/item/clothing/under/pirate
	name = "костюм пирата"
	desc = "Йо-хо-хо."
	icon_state = "pirate"
	item_state_slots = list(slot_r_hand_str = "sl_suit", slot_l_hand_str = "sl_suit")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS

/obj/item/clothing/under/soviet
	name = "советская униформа"
	desc = "За Россию-матушку!"
	icon_state = "soviet"
	item_state_slots = list(slot_r_hand_str = "grey", slot_l_hand_str = "grey")

/obj/item/clothing/under/redcoat
	name = "алый мундир"
	desc = "На вид староватый."
	icon_state = "redcoat"
	item_state_slots = list(slot_r_hand_str = "red", slot_l_hand_str = "red")

/obj/item/clothing/under/kilt
	name = "килт"
	desc = "В комплект входят ботинки."
	icon_state = "kilt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|FEET
	rolled_sleeves = 0

/obj/item/clothing/under/sexymime
	name = "сексапильный костюм мима"
	desc = "На такую красоту даже смотреть не хочется."
	icon_state = "sexymime"
	item_state_slots = list(slot_r_hand_str = "mime", slot_l_hand_str = "mime")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	rolled_sleeves = -1 //Please never

/obj/item/clothing/under/gladiator
	name = "облачение гладиатора"
	desc = "Хлеба и зрелищ."
	icon_state = "gladiator"
	item_state_slots = list(slot_r_hand_str = "yellow", slot_l_hand_str = "yellow")
	body_parts_covered = LOWER_TORSO

/obj/item/clothing/under/moderncoat
	name = "обернутое пальто"
	desc = "Последний писк моды."
	icon_state = "moderncoat"
	item_state_slots = list(slot_r_hand_str = "red", slot_l_hand_str = "red")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS

/obj/item/clothing/under/ascetic
	name = "аскетичный комбинезон"
	desc = "Популярен среди как свежевыращенных клонов, так и культистов новой эпохи."
	icon_state = "ascetic"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")

/obj/item/clothing/under/robe
	name = "черная роба"
	desc = "Черная роба, так и отдаёт культизмом."
	icon_state = "robe"

/obj/item/clothing/under/whiterobe
	name = "белая роба"
	desc = "Белая роба, так и отдаёт культизмом."
	icon_state = "whiterobe"

/obj/item/clothing/under/goldrobe
	name = "черно-золотая роба"
	desc = "Черно-золотая роба, так и отдаёт культизмом, однако смотрится стильно."
	icon_state = "goldrobe"

/obj/item/clothing/under/whitegoldrobe
	name = "бело-золотая роба"
	desc = "Бело-золотая роба, так и отдаёт культизмом, однако смотрится стильно."
	icon_state = "whitegoldrobe"

/*
 * dress
 */
/obj/item/clothing/under/dress
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/dress/blacktango
	name = "черное платье для танго"
	desc = "Блещет южноамериканским пламенем."
	icon_state = "black_tango"

/obj/item/clothing/under/dress/blacktango/alt
	name = "черное платье для танго"
	desc = "Блещет южноамериканским пламенем."
	icon_state = "black_tango_alt"
	item_state_slots = list(slot_r_hand_str = "black_tango", slot_l_hand_str = "black_tango")

/obj/item/clothing/under/dress/stripeddress
	name = "полосатое платье"
	desc = "Мода в космосе."
	icon_state = "striped_dress"

/obj/item/clothing/under/dress/sailordress
	name = "платье морячки"
	desc = "Наряд для женщины за штурвалом."
	icon_state = "sailor_dress"

/obj/item/clothing/under/dress/redeveninggown
	name = "красное вечернее платье"
	desc = "Шикарное платье для барных певиц."
	icon_state = "red_evening_gown"

/obj/item/clothing/under/dress/maid
	name = "наряд горничной"
	desc = "Сделано в Китае."
	icon_state = "maid"
	index = 1

/obj/item/clothing/under/dress/maid/janitor
	name = "наряд горничной"
	desc = "Обыкновенный наряд для домохозяйки."
	icon_state = "janimaid"

/obj/item/clothing/under/dress/maid/sexy
	name = "сексапильный наряд горничной"
	desc = "Это ж смелость надо иметь, чтобы ходить и возбуждать всех таким костюмом!"
	icon_state = "sexymaid"

/obj/item/clothing/under/dress/dress_fire
	name = "огненное платье"
	desc = "Небольшое чёрное платье с огненным принтом синего цвета."
	icon_state = "dress_fire"

/obj/item/clothing/under/dress/dress_green
	name = "зеленое платье"
	desc = "Простое, плотно прилегающее платье зелёного цвета."
	icon_state = "dress_green"

/obj/item/clothing/under/dress/dress_orange
	name = "оранжевое платье"
	desc = "Стильное оранжевое платье для тех, кто не стесняется своих ножек."
	icon_state = "dress_orange"

/obj/item/clothing/under/dress/dress_pink
	name = "розовое платье"
	desc = "Простое, плотно прилегающее платье розового цвета."
	icon_state = "dress_pink"

/obj/item/clothing/under/dress/dress_yellow
	name = "желтое платье"
	desc = "Небольшое романтичное платье жёлтого цвета."
	icon_state = "dress_yellow"

/obj/item/clothing/under/dress/dress_saloon
	name = "платье девушки из кабака"
	desc = "Облачение в духе старых вестернов для девушек, которые не против выпить."
	icon_state = "dress_saloon"
	item_state_slots = list(slot_r_hand_str = "dress_white", slot_l_hand_str = "dress_white")

/obj/item/clothing/under/dress/dress_cap
	name = "платье Директора Колонии"
	desc = "Женская одежда для Директора Колонии с чувством стиля."
	icon_state = "dress_cap"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/dress/dress_hop
	name = "платье Главы Персонала"
	desc = "Женская одежда для Главы Персонала с чувством стиля."
	icon_state = "dress_hop"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/dress/dress_hr
	name = "униформа директора отдела кадров"
	desc = "Элегантная униформа для доставучего директора отдела кадров."
	icon_state = "huresource"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/dress/black_corset
	name = "черный корсет"
	desc = "Черный корсет и юбка для роскошных пятниц."
	icon_state = "black_corset"

/obj/item/clothing/under/dress/flower_dress
	name = "цветочное платье"
	desc = "Прекрасное платье с цветочной юбочкой."
	icon_state = "flower_dress"

/obj/item/clothing/under/dress/red_swept_dress
	name = "красное стянутое платье"
	desc = "Красное платье, стянутое вбок."
	icon_state = "red_swept_dress"

/obj/item/clothing/under/dress/flamenco
	name = "платье для фламенко"
	desc = "Мексиканское платье для фламенко."
	icon_state = "flamenco"

/obj/item/clothing/under/dress/westernbustle
	name = "тюрнюр"
	desc = "Тюрнюр с Земли эпохи 1800-ых."
	icon_state = "westernbustle"

/obj/item/clothing/under/dress/sari
	name = "красное сари"
	desc = "Яркое традиционное платье из Индии."
	icon_state = "sari_red"
	item_state_slots = list(slot_r_hand_str = "darkreddress", slot_l_hand_str = "darkreddress")

/obj/item/clothing/under/dress/sari/green
	name = "зеленое сари"
	icon_state = "sari_green"
	item_state_slots = list(slot_r_hand_str = "dress_green", slot_l_hand_str = "dress_green")

/obj/item/clothing/under/dress/lilacdress
	name = "сиреневое платье"
	desc = "Простое чёрное платье, украшенное искусственной сиренью."
	icon_state = "lilacdress"

/obj/item/clothing/under/dress/white
	name = "белое свадебное платье"
	desc = "Роскошное белое платье с голубой подкладкой."
	icon_state = "whitedress1"
	flags_inv = HIDESHOES

/obj/item/clothing/under/dress/white2
	name = "длинное платье"
	desc = "Длинное платье."
	icon_state = "whitedress2"
	addblends = "whitedress2_a"
	flags_inv = HIDESHOES

/obj/item/clothing/under/dress/white3
	name = "короткое платье"
	desc = "Обыкновенное короткое платье."
	icon_state = "whitedress3"
	addblends = "whitedress3_a"

/obj/item/clothing/under/dress/white4
	name = "длинное широкое платье"
	desc = "Длинное платье платье, которое становится шире к низу."
	icon_state = "whitedress4"
	addblends = "whitedress4_a"
	flags_inv = HIDESHOES

/obj/item/clothing/under/dress/darkred
	name = "роскошное красное платье"
	desc = "Короткое красное платье с чёрным ремнём. Стильно."
	icon_state = "darkreddress"

/obj/item/clothing/under/dress/polka
	name = "платье в горошек"
	desc = "Платье сливочного цвета в красный горошек."
	icon_state = "polka"

/obj/item/clothing/under/dress/twistfront
	name = "скрученный топ"
	desc = "Чёрная юбка со скрученным красным топом. Стильно!"
	icon_state = "twistfront"

/obj/item/clothing/under/dress/cropdress
	name = "укороченный топ"
	desc = "Красная юбка и укороченный топ с длинными рукавами и пуговицами."
	icon_state = "cropdress"

/obj/item/clothing/under/dress/vneck
	name = "платье с V-образным вырезом"
	desc = "Чёрное платье с V-образным вырезом, прикрывающее шею и грудь сеточкой."
	icon_state = "vneckdress"

/obj/item/clothing/under/dress/bluedress
	name = "синее платье"
	desc = "Обыкновенное синее платье с белым ремешком."
	icon_state = "bluedress"

/obj/item/clothing/under/dress/wench
	name = "платье распутницы"
	desc = "Белое платье в стиле барных служанок из вестернов. Пикантно!"
	icon_state = "wench"

/obj/item/clothing/under/dress/littleblackdress
	name = "черное платьице"
	desc = "Небольшое чёрное платьице с красной ленточкой и аксессуаром в виде цветка."
	icon_state = "littleblackdress"

/obj/item/clothing/under/dress/pinktutu
	name = "розовая пачка"
	desc = "Чёрный корсаж с розовой юбкой из тюля, идеально подходит балеринам."
	icon_state = "pinktutu"

/obj/item/clothing/under/dress/festivedress
	name = "праздничное платье"
	desc = "Красно-белое платье в духе зимних праздников. Праздник к нам приходит!"
	icon_state = "festivedress"

/obj/item/clothing/under/dress/revealingdress
	name = "откровенное платье"
	desc = "Откровенное чёрно-синее платье. Такое вообще можно на работу?"
	icon_state = "revealingdress"
	index = 1

/obj/item/clothing/under/dress/gothic
	name = "готическое платье"
	desc = "Чёрное платье с сеточками в духе олдскульных готов."
	icon_state = "gothic"
	index = 1

/obj/item/clothing/under/dress/formalred
	name = "официальное красное платье"
	desc = "Формальное красное платье для роскошных дам."
	icon_state = "formalred"
	flags_inv = HIDESHOES
	index = 1

/obj/item/clothing/under/dress/pentagram
	name = "платье с пентаграммой"
	desc = "Чёрное платье с ремешками в форме пентаграммы на груди."
	icon_state = "pentagram"
	index = 1

obj/item/clothing/under/dress/yellowswoop
	name = "желтое стянутое платье"
	desc = "Жёлтое платье, стянутое вбок."
	icon_state = "yellowswoop"
	index = 1

/obj/item/clothing/under/dress/countess
	name = "countess dress"
	desc = "A red and black dress fit for a countess."
	icon_state = "countess"
	index = 1

/*
 * wedding stuff
 */
/obj/item/clothing/under/wedding
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS

/obj/item/clothing/under/wedding/bride_orange
	name = "оранжевое свадебное платье"
	desc = "Большое и пышное платье оранжевого цвета."
	icon_state = "bride_orange"
	flags_inv = HIDESHOES

/obj/item/clothing/under/wedding/bride_purple
	name = "фиолетовое свадебное платье"
	desc = "Большое и пышное платье фиолетового цвета."
	icon_state = "bride_purple"
	flags_inv = HIDESHOES

/obj/item/clothing/under/wedding/bride_blue
	name = "синее свадебное платье"
	desc = "Большое и пышное платье синего цвета."
	icon_state = "bride_blue"
	flags_inv = HIDESHOES

/obj/item/clothing/under/wedding/bride_red
	name = "красное свадебное платье"
	desc = "Большое и пышное платье красного цвета."
	icon_state = "bride_red"
	flags_inv = HIDESHOES

/obj/item/clothing/under/wedding/bride_white
	name = "шелковое свадебное платье"
	desc = "Большое и пышное платье из шёлка."
	icon_state = "bride_white"
	flags_inv = HIDESHOES
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/wedding/floofdress
	name = "пышное платье"
	desc = "Красивое пышное платье для официальных церемоний. Разных цветов!"
	icon_state = "floofdress"
	flags_inv = HIDESHOES
	index = 1

/obj/item/clothing/under/wedding/whitegown
	name = "белое платье"
	desc = "Элегантное белое платье с сеточками."
	icon_state = "whitegown"
	index = 1

/*
Uniforms and such
*/

/obj/item/clothing/under/sundress
	name = "цветочный сарафан"
	desc = "В таком хочется бегать по полю ромашек."
	icon_state = "sundress"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/sundress_white
	name = "белый сарафан"
	desc = "Белый сарафан, украшенный фиолетовыми цветами."
	icon_state = "sundress_white"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/dress/sundress_pink
	name = "розовый сарафан"
	desc = "Милый сарафан розового цвета."
	icon_state = "pinksun"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	index = 1

/obj/item/clothing/under/dress/sundress_white
	name = "белый сарафан"
	desc = "Коротенький белый сарафан."
	icon_state = "whitesun"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	index = 1

/obj/item/clothing/under/dress/sundress_pinkbow
	name = "розовый сарафан с бантиком"
	desc = "Милый розовый сарафан с бантиком."
	icon_state = "bowsun"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	index = 1

/obj/item/clothing/under/dress/sundress_blue
	name = "длинный голубой сарафан"
	desc = "Длинный сарафан голубого цвета с белой подкладкой."
	icon_state = "bluesun"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS
	index = 1

/obj/item/clothing/under/dress/sundress_pinkshort
	name = "короткий розовый сарафан"
	desc = "Очень короткий розовый сарафанчик."
	icon_state = "shortpink"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	index = 1

/obj/item/clothing/under/dress/twopiece
	name = "двойное платье"
	desc = "Красивое платье из двух сшитых частей."
	icon_state = "twopiece"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	index = 1

/obj/item/clothing/under/dress/gothic2
	name = "готическое платье"
	desc = "Элегантное готическое платье."
	icon_state = "gothic2"
	index = 1

/obj/item/clothing/under/captainformal
	name = "формальный наряд Директора Колонии"
	desc = "Официальный наряд Директора Колонии для особых случаев."
	icon_state = "captain_formal"
	item_state_slots = list(slot_r_hand_str = "lawyer_blue", slot_l_hand_str = "lawyer_blue")

/obj/item/clothing/under/hosformalmale
	name = "формальный наряд Главы Службы Безопасности"
	desc = "Мужской наряд Главы Службы Безопасности для особых случаев."
	icon_state = "hos_formal_male"
	item_state_slots = list(slot_r_hand_str = "lawyer_red", slot_l_hand_str = "lawyer_red")

/obj/item/clothing/under/hosformalfem
	name = "формальный наряд Главы Службы Безопасности"
	desc = "Женский наряд Главы Службы Безопасности для особых случаев."
	icon_state = "hos_formal_fem"
	item_state_slots = list(slot_r_hand_str = "lawyer_red", slot_l_hand_str = "lawyer_red")

/obj/item/clothing/under/assistantformal
	name = "формальный наряд ассистента"
	desc = "Официальный наряд ассистента. Для чего он нужен ассистентам - пока ещё не понятно."
	icon_state = "assistant_formal"
	item_state_slots = list(slot_r_hand_str = "lawyer_black", slot_l_hand_str = "lawyer_black")

/obj/item/clothing/under/suit_jacket/charcoal
	name = "угольный костюм "
	desc = "Костюм угольного цвета с красным галстуком. Как профессионально."
	icon_state = "charcoal_suit"
	item_state_slots = list(slot_r_hand_str = "lawyer_black", slot_l_hand_str = "lawyer_black")
	starting_accessories = list(/obj/item/clothing/accessory/tie/navy, /obj/item/clothing/accessory/jacket/charcoal)

/obj/item/clothing/under/suit_jacket/charcoal/skirt
	name = "угольная юбка"
	icon_state = "charcoal_suit_skirt"

/obj/item/clothing/under/suit_jacket/navy
	name = "синий костюм"
	desc = "Синий костюм с красным галстуком для элиты станции."
	icon_state = "navy_suit"
	item_state_slots = list(slot_r_hand_str = "lawyer_blue", slot_l_hand_str = "lawyer_blue")
	starting_accessories = list(/obj/item/clothing/accessory/tie/red, /obj/item/clothing/accessory/jacket/navy)

/obj/item/clothing/under/suit_jacket/navy/skirt
	name = "синяя юбка"
	icon_state = "navy_suit_skirt"

/obj/item/clothing/under/suit_jacket/burgundy
	name = "бордовый костюм"
	desc = "Бордовый костюм с черным галстуком. Весьма официально."
	icon_state = "burgundy_suit"
	item_state_slots = list(slot_r_hand_str = "lawyer_red", slot_l_hand_str = "lawyer_red")
	starting_accessories = list(/obj/item/clothing/accessory/tie/black, /obj/item/clothing/accessory/jacket/burgundy)

/obj/item/clothing/under/suit_jacket/burgundy/skirt
	name = "бордовая юбка"
	icon_state = "burgundy_suit_skirt"

/obj/item/clothing/under/suit_jacket/checkered
	name = "клетчатый костюм"
	desc = "Какой красивый костюм. Было бы грустно, если бы с ним что-то произошло, не правда ли?"
	icon_state = "checkered_suit"
	item_state_slots = list(slot_r_hand_str = "lawyer_black", slot_l_hand_str = "lawyer_black")
	starting_accessories = list(/obj/item/clothing/accessory/tie/black, /obj/item/clothing/accessory/jacket/checkered)

/obj/item/clothing/under/suit_jacket/checkered/skirt
	name = "клетчатая юбка"
	icon_state = "checkered_suit_skirt"

/obj/item/clothing/under/suit_jacket/tan
	name = "бежевый костюм"
	desc = "Бежевый костюм. Придаёт умный, но расслабленный вид."
	icon_state = "tan_suit"
	item_state_slots = list(slot_r_hand_str = "tan_suit", slot_l_hand_str = "tan_suit")
	starting_accessories = list(/obj/item/clothing/accessory/tie/yellow, /obj/item/clothing/accessory/jacket)

/obj/item/clothing/under/suit_jacket/tan/skirt
	name = "бежевая юбка"
	icon_state = "tan_suit_skirt"

/obj/item/clothing/under/serviceoveralls
	name = "костюм работяги"
	desc = "Образцовый костюм работяги. Была бы ещё работа."
	icon_state = "mechanic"
	item_state_slots = list(slot_r_hand_str = "cargo", slot_l_hand_str = "cargo")
	rolled_sleeves = 0

/obj/item/clothing/under/cheongsam
	name = "белый ципао"
	desc = "Ципао белого цвета."
	icon_state = "cheongsam-white"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS

/obj/item/clothing/under/cheongsam/red
	name = "красный ципао"
	desc = "Ципао красного цвета."
	icon_state = "cheongsam-red"

/obj/item/clothing/under/cheongsam/blue
	name = "синий ципао"
	desc = "Ципао синего цвета."
	icon_state = "cheongsam-blue"

/obj/item/clothing/under/cheongsam/black
	name = "черный ципао"
	desc = "Ципао чёрного цвета."
	icon_state = "cheongsam-black"

/obj/item/clothing/under/cheongsam/darkred
	name = "темно-красный ципа"
	desc = "Ципао тёмно-красного цвета."
	icon_state = "cheongsam-darkred"

/obj/item/clothing/under/cheongsam/green
	name = "зеленый ципао"
	desc = "Ципао зеленого цвета."
	icon_state = "cheongsam-green"

/obj/item/clothing/under/cheongsam/purple
	name = "фиолетовый ципао"
	desc = "Ципао фиолетового цвета."
	icon_state = "cheongsam-purple"

/obj/item/clothing/under/cheongsam/darkblue
	name = "темно-синий ципао"
	desc = "Ципао тёмно-синего цвета."
	icon_state = "cheongsam-darkblue"

/obj/item/clothing/under/blazer
	name = "синий блейзер"
	desc = "В меру вызывающий костюм из красных вельветовых брюк, синего блейзера и галстука."
	icon_state = "blue_blazer"
	item_state_slots = list(slot_r_hand_str = "lawyer_blue", slot_l_hand_str = "lawyer_blue")

/obj/item/clothing/under/blazer/skirt
	name = "женский синий блейзер"
	desc = "В меру вызывающий костюм из красной юбки и синего блейзера."
	icon_state = "blue_blazer_skirt"

/obj/item/clothing/under/croptop
	name = "топик"
	desc = "Укороченная рубашка с логотипом NT."
	icon_state = "croptop"
	item_state_slots = list(slot_r_hand_str = "grey", slot_l_hand_str = "grey")

/obj/item/clothing/under/croptop/red
	name = "красный топик"
	desc = "Красная укороченная рубашка."
	icon_state = "croptop_red"
	item_state_slots = list(slot_r_hand_str = "red", slot_l_hand_str = "red")

/obj/item/clothing/under/croptop/grey
	name = "серый топик"
	desc = "Серая укороченная рубашка."
	icon_state = "croptop_grey"
	item_state_slots = list(slot_r_hand_str = "grey", slot_l_hand_str = "grey")

/obj/item/clothing/under/cuttop
	name = "серый топ с вырезом"
	desc = "Серая рубашечка с вырезом."
	icon_state = "cuttop"
	item_state_slots = list(slot_r_hand_str = "grey", slot_l_hand_str = "grey")

/obj/item/clothing/under/cuttop/red
	name = "красный топ с вырезом"
	desc = "Красная рубашечка с вырезом."
	icon_state = "cuttop_red"
	item_state_slots = list(slot_r_hand_str = "red", slot_l_hand_str = "red")

/obj/item/clothing/under/harness
	name = "упряжь для снаряжения"
	desc = "Как... минималистично."
	icon_state = "gear_harness"
	body_parts_covered = 0

/obj/item/clothing/under/haltertop
	name = "халтер"
	desc = "Джинсовые шорты с чёрным халтером. Самое то надеть в пятницу!"
	icon_state = "haltertop"

/obj/item/clothing/under/rippedpunk
	name = "оборванные джинсы"
	desc = "Чёрные оборванные джинсы с сетью в качестве топа. Как по-панковски."
	icon_state = "rippedpunk"
	index = 1

/obj/item/clothing/under/greenasym
	name = "зеленый асимметричный комбинезон"
	desc = "Зеленая футуристическая униформа с асимметричными брюками. Стильно, модно, молодёжно!"
	icon_state = "greenasym"
	index = 1

/obj/item/clothing/under/cyberpunkharness
	name = "упряжь в стиле киберпанк"
	desc = "Штаны и упряжь в стиле киберпанк - самое то для дистопии."
	icon_state = "cyberhell"
	index = 1

/obj/item/clothing/under/blackngold
	name = "черно-золотое платье"
	desc = "Чёрно-золотое платье. У Вас такое впечатление, что его носят для проведения религиозных обрядов."
	icon_state = "blackngold"
	index = 1

/obj/item/clothing/under/sheerblue
	name = "открытое голубое платье"
	desc = "Довольно откровенное голубое платье. Лучше всего смотрится с чем-то ещё!"
	icon_state = "sheerblue"
	index = 1

/obj/item/clothing/under/disheveled
	name = "растрепанный костюм"
	desc = "Сойдёт за хорошую формальную униформу. Если Вы в край слепы, конечно."
	icon_state = "disheveled"
	index = 1

/obj/item/clothing/under/flower_skirt
	name = "flower skirt"
	desc = "A flowery skirt that comes in a variety of colors."
	icon_state = "flowerskirt"
	index = 1

/*
 * swimsuit
 */
/obj/item/clothing/under/swimsuit/
	siemens_coefficient = 1
	body_parts_covered = 0

/obj/item/clothing/under/swimsuit/black
	name = "черный купальник"
	desc = "Старомодный купальник чёрного цвета."
	icon_state = "swim_black"

/obj/item/clothing/under/swimsuit/blue
	name = "синий купальник"
	desc = "Старомодный купальник синего цвета."
	icon_state = "swim_blue"

/obj/item/clothing/under/swimsuit/purple
	name = "фиолетовый купальник"
	desc = "Старомодный купальник фиолетового цвета."
	icon_state = "swim_purp"

/obj/item/clothing/under/swimsuit/green
	name = "зеленый купальник"
	desc = "Старомодный купальник зелёного цвета."
	icon_state = "swim_green"

/obj/item/clothing/under/swimsuit/red
	name = "красный купальник"
	desc = "Старомодный купальник красного цвета."
	icon_state = "swim_red"

/obj/item/clothing/under/swimsuit/striped
	name = "полосатый купальник"
	desc = "Весьма откровенный полосатый купальник."
	icon_state = "swim_striped"

/obj/item/clothing/under/swimsuit/white
	name = "белый купальник"
	desc = "Классика жанра."
	icon_state = "swim_white"

/obj/item/clothing/under/swimsuit/earth
	name = "земляной купальник"
	desc = "Дизайн, популярный в наше время на Земле."
	icon_state = "swim_earth"

/obj/item/clothing/under/swimsuit/stripper/stripper_pink
	name = "розовый купальник"
	desc = "Скудноватый розовый купальник."
	icon_state = "stripper_p"

/obj/item/clothing/under/swimsuit/stripper/stripper_green
	name = "зеленый купальник"
	desc = "Скудноватый зелёный купальник."
	icon_state = "stripper_g"

/obj/item/clothing/under/swimsuit/stripper/mankini
	name = "мужское бикини"
	desc = "Уважающий себя мужчина такое убожество не наденет."
	icon_state = "mankini"

/*
 * pyjamas
 */
/obj/item/clothing/under/bluepyjamas
	name = "синяя пижама"
	desc = "Старомодная постельная одежда."
	icon_state = "blue_pyjamas"
	item_state_slots = list(slot_r_hand_str = "blue", slot_l_hand_str = "blue")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS

/obj/item/clothing/under/redpyjamas
	name = "красная пижама"
	desc = "Старомодная постельная одежда."
	icon_state = "red_pyjamas"
	item_state_slots = list(slot_r_hand_str = "red", slot_l_hand_str = "red")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS

/*
 *Misc Uniforms
 */

/obj/item/clothing/under/aether
	name = "комбинезон Aether"
	desc = "Комбинезон корпорации Aether Atmospherics and Recycling, поставляющий колониям системы переработки и атмосферного контроля."
	icon_state = "aether"
	worn_state = "aether"

/obj/item/clothing/under/pcrc
	name = "униформа PCRC"
	desc = "Униформа Proxima Centauri Risk Control, частного агенства безопасности."
	icon_state = "pcrc"
	item_state = "jensensuit"
	worn_state = "pcrc"

/obj/item/clothing/under/grayson
	name = "комбинезон Grayson"
	desc = "Комбинезон Grayson Manufactories, рудодобывающего предприятия."
	icon_state = "mechanic"
	worn_state = "mechanic"

/obj/item/clothing/under/wardt
	name = "комбинезон Ward-Takahashi"
	desc = "Комбинезон Ward-Takahashi, известной корпорации в потребительской сфере."
	icon_state = "robotics2"
	worn_state = "robotics2"

/obj/item/clothing/under/mbill
	name = "униформа Major Bill's"
	desc = "Комбинезон Major Bill's Transportation, мегакорпорации, занимающейся доставкой товаров."
	icon_state = "mbill"
	worn_state = "mbill"
	catalogue_data = list(/datum/category_item/catalogue/information/organization/major_bills)

/obj/item/clothing/under/confederacy
	name = "униформа Конфедерации"
	desc = "Военная униформа Конфедерации Человека, независимого правительства человеческой расы."
	icon_state = "confed"
	worn_state = "confed"

/obj/item/clothing/under/saare
	name = "униформа SAARE"
	desc = "Униформа Stealth Assault Enterprises, частной военной корпорации."
	icon_state = "saare"
	worn_state = "saare"

/obj/item/clothing/under/frontier
	name = "одежда работника с границы"
	desc = "Изношенная фланелевая рубашка с денимовым комбинезоном. В моде среди обитателей колоний на границе."
	icon_state = "frontier"
	worn_state = "frontier"

/obj/item/clothing/under/focal
	name = "комбинезон Focal Point"
	desc = "Комбинезон Focal Point Energistics, мегакорпорации в сфере техобслуживания."
	icon_state = "focal"
	worn_state = "focal"

/obj/item/clothing/under/hephaestus
	name = "комбинезон Hephaestus"
	desc = "Комбинезон Hephaestus Industries, корпорации по производству оружия."
	icon_state = "heph"
	worn_state = "heph"

/obj/item/clothing/under/rank/psych/turtleneck/sweater
	desc = "Тёплый на вид свитер и пара тёмно-синих брюк."
	name = "свитер"
	icon_state = "turtleneck"
	worn_state = "turtleneck"

//Uniforms end above here.

/obj/item/clothing/under/medigown
	name = "медицинская маечка"
	desc = "Маечка для медицинских обследований. На спине не сходятся пуговицы."
	icon_state = "medicalgown"
	worn_state = "medicalgown"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/bathrobe
	name = "банный халат"
	desc = "Пушистый халат, дабы не хвастаться перед всем светом."
	icon_state = "bathrobe"
	worn_state = "bathrobe"

/obj/item/clothing/under/explorer
	desc = "Зелёный комбинезон для проведения исследований в суровых условиях."
	name = "комбинезон искателя"
	icon_state = "explorer"

/obj/item/clothing/under/explorer/armored
	desc = "Зелёный комбинезон для проведения исследований в суровых условиях. Этот комбинезон, кажется, был модифицирован."
	armor = list(melee = 10, bullet = 10, laser = 10,energy = 10, bomb = 10, bio = 10, rad = 30)
	armorsoak = list(melee = 5, bullet = 5, laser = 5,energy = 5, bomb = 5, bio = 5, rad = 0)

/obj/item/clothing/under/cohesion
	name = "черный когезионный костюм"
	desc = "Простой чёрный костюм для поддержания когезии, позволяющий Прометеанам поддерживать свою форму и защищающий от прямого физического контакта."
	icon_state = "cohesionsuit"
	rolled_sleeves = -1 // defeats the purpose!!!

/obj/item/clothing/under/cohesion/striped
	name = "красный когезионный костюм"
	desc = "Чёрный костюм для поддержания когезии в красную полоску, позволяющий Прометеанам поддерживать свою форму и защищающий от прямого физического контакта."
	icon_state = "cohesionsuit_striped"

/obj/item/clothing/under/cohesion/decal
	name = "фиолетовый когезионный костюм"
	desc = "Белый костюм для поддержания когезии с фиолетовыми полосами, позволяющий Прометеанам поддерживать свою форму и защищающий от прямого физического контакта."
	icon_state = "cohesionsuit_decal"

/obj/item/clothing/under/cohesion/pattern
	name = "синий когезионный костюм"
	desc = "Белый костюм для поддержания когезии с синими принтами, позволяющий Прометеанам поддерживать свою форму и защищающий от прямого физического контакта."
	icon_state = "cohesionsuit_pattern"

/obj/item/clothing/under/cohesion/hazard
	name = "аварийный когезионный костюм"
	desc = "Оранжевый костюм поддержания когезии с яркими жёлтыми полосами, позволяющий Прометеанам поддерживать свою форму и защищающий от прямого физического контакта."
	icon_state = "cohesionsuit_hazard"

//Ranger uniforms
//On-mob sprites go in icons\mob\uniform.dmi with the format "white_ranger_uniform_s" - with 'white' replaced with green, cyan, etc... of course! Note the _s - this is not optional.
//Item sprites go in icons\obj\clothing\ranger.dmi with the format "white_ranger_uniform"
/obj/item/clothing/under/color/ranger
	var/unicolor = "white"
	name = "костюм рейнджера"
	desc = "Изготовленная из герметичных материалов и плотно прилегающая к телу, эта форма предоставляет рейнджерам защиту, не препятствуя передвижению. \
	Однако этот костюм изготовлен из хлопка по подобию костюмов из третьего сезона."
	icon = 'icons/obj/clothing/ranger.dmi'
	icon_state = "white_ranger_uniform"
	rolled_down = 0
	rolled_sleeves = 0

/obj/item/clothing/under/color/ranger/Initialize()
	. = ..()
	if(icon_state == "ranger_uniform") //allows for custom items
		name = "[unicolor] ranger uniform"
		icon_state = "[unicolor]_ranger_uniform"

/obj/item/clothing/under/color/ranger/black
	unicolor = "black"

/obj/item/clothing/under/color/ranger/pink
	unicolor = "pink"

/obj/item/clothing/under/color/ranger/green
	unicolor = "green"

/obj/item/clothing/under/color/ranger/cyan
	unicolor = "cyan"

/obj/item/clothing/under/color/ranger/orange
	unicolor = "orange"

/obj/item/clothing/under/color/ranger/yellow
	unicolor = "yellow"