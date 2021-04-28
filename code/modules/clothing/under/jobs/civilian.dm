//Alphabetical order of civilian jobs.

/obj/item/clothing/under/rank/bartender
	desc = "Костюму не хватает немножко выразительности."
	name = "униформа бармена"
	icon_state = "ba_suit"
	rolled_sleeves = 0

/obj/item/clothing/under/rank/bartender/skirt
	desc = "Короткая, милая."
	name = "юбка бармена"
	icon_state = "ba_suit_skirt"
	item_state_slots = list(slot_r_hand_str = "ba_suit", slot_l_hand_str = "ba_suit")

/obj/item/clothing/under/rank/captain //Alright, technically not a 'civilian' but its better then giving a .dm file for a single define.
	desc = "Синий комбинезон с золотыми метакми подстать цветам униформы Директора Колонии."
	name = "комбинезон Директора Колонии"
	icon_state = "captain"
	rolled_sleeves = 0

/obj/item/clothing/under/rank/cargo
	name = "комбинезон Квартирмейстера"
	desc = "Комбинезон, предназначенный для Квартирмейстера. Изготовлен специально для предупреждения болезней спины от постоянного таскания бумаг."
	icon_state = "qm"
	item_state_slots = list(slot_r_hand_str = "cargo", slot_l_hand_str = "cargo")
	rolled_sleeves = 0

/obj/item/clothing/under/rank/cargo/jeans
	name = "джинсы Квартирмейстера"
	desc = "Джиииинсы! Удобные!"
	icon_state = "qmj"

/obj/item/clothing/under/rank/cargo/jeans/female
	name = "джинсы Квартирмейстера"
	desc = "Джиииинсы! Удобные!"
	icon_state = "qmjf"
	rolled_sleeves = -1

/obj/item/clothing/under/rank/cargotech
	name = "комбинезон грузчика"
	desc = "Шоооорты! Лёгкие и удобные!"
	icon_state = "cargo"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	rolled_sleeves = 0

/obj/item/clothing/under/rank/cargotech/jeans
	name = "джинсы грузчика"
	desc = "Джиииинсы! Удобные!"
	icon_state = "cargoj"
	item_state_slots = list(slot_r_hand_str = "cargo", slot_l_hand_str = "cargo")
	rolled_sleeves = -1

/obj/item/clothing/under/rank/cargotech/jeans/female
	name = "джинсы грузчика"
	desc = "Джиииинсы! Удобные!"
	icon_state = "cargojf"

/obj/item/clothing/under/rank/chaplain
	desc = "Чёрные комбинезон, популярный среди верующих."
	name = "комбинезон капеллана"
	icon_state = "chaplain"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	rolled_sleeves = 0

/obj/item/clothing/under/rank/chef
	desc = "Униформа, вручаемая лишь самым <b>жёстким</b> шеф-поварам космоса."
	name = "униформа повара"
	icon_state = "chef"
	rolled_sleeves = 0

/obj/item/clothing/under/rank/clown
	name = "костюм клоуна"
	desc = "<i><font face='comic sans ms'>Хонк!</i></font>"
	icon_state = "clown"
	rolled_sleeves = -1

/obj/item/clothing/under/rank/head_of_personnel
	desc = "Комбинезон, предназначенный для Главы Персонала."
	name = "комбинезон Главы Персонала"
	icon_state = "hop"
	rolled_sleeves = 0

/obj/item/clothing/under/rank/head_of_personnel_whimsy
	desc = "Синий пиджак с красным галстуком. Нехило! От такого вида Вы чувствуете себя гораздо большей шишкой, чем являетесь на самом деле."
	name = "костюм Главы Персонала"
	icon_state = "hopwhimsy"
	item_state_slots = list(slot_r_hand_str = "hop", slot_l_hand_str = "hop")
	rolled_sleeves = -1

/obj/item/clothing/under/rank/hydroponics
	desc = "Комбинезон, предназначенный для защиты от малоопасных угроз растительного происхождения."
	name = "комбинезон ботаника"
	icon_state = "hydroponics"
	item_state_slots = list(slot_r_hand_str = "green", slot_l_hand_str = "green")
	permeability_coefficient = 0.50
	rolled_sleeves = 0

/obj/item/clothing/under/rank/internalaffairs
	desc = "Официальный костюм агента внутренних дел. Ошейник <i>на удивление</i> хорошо закрахмален."
	name = "униформа агента внутренних дел"
	icon_state = "internalaffairs"
	item_state_slots = list(slot_r_hand_str = "ba_suit", slot_l_hand_str = "ba_suit")
	rolled_sleeves = 0
	starting_accessories = list(/obj/item/clothing/accessory/tie/black)

/obj/item/clothing/under/rank/internalaffairs/skirt
	desc = "Официальный костюм агента внутренних дел. Верхняя пуговица вшита полностью."
	name = "юбка агента внутренних дел"
	icon_state = "internalaffairs_skirt"

/obj/item/clothing/under/rank/janitor
	desc = "Официальная униформа уборщика станции. Предоставляет слабую защиту от биологических угроз."
	name = "комбинезон уборщика"
	icon_state = "janitor"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	rolled_sleeves = 0

/obj/item/clothing/under/lawyer
	desc = "Роскошные нити."
	name = "костюм юриста"

/obj/item/clothing/under/lawyer/black
	name = "черный костюм"
	icon_state = "lawyer_black"

/obj/item/clothing/under/lawyer/black/skirt
	name = "черная юбка"
	icon_state = "lawyer_black_skirt"
	item_state_slots = list(slot_r_hand_str = "lawyer_black", slot_l_hand_str = "lawyer_black")

/obj/item/clothing/under/lawyer/female
	name = "черный костюм"
	icon_state = "black_suit_fem"
	item_state_slots = list(slot_r_hand_str = "lawyer_black", slot_l_hand_str = "lawyer_black")

/obj/item/clothing/under/lawyer/red
	name = "красный костюм"
	icon_state = "lawyer_red"

/obj/item/clothing/under/lawyer/red/skirt
	name = "красный костюм с юбкой"
	icon_state = "lawyer_red_skirt"
	item_state_slots = list(slot_r_hand_str = "lawyer_red", slot_l_hand_str = "lawyer_red")

/obj/item/clothing/under/lawyer/blue
	name = "синий костюм"
	icon_state = "lawyer_blue"

/obj/item/clothing/under/lawyer/blue/skirt
	name = "синий костюм с юбкой"
	icon_state = "lawyer_blue_skirt"
	item_state_slots = list(slot_r_hand_str = "lawyer_blue", slot_l_hand_str = "lawyer_blue")

/obj/item/clothing/under/lawyer/bluesuit
	name = "синий костюм"
	desc = "Элегантный костюм."
	icon_state = "bluesuit"
	item_state_slots = list(slot_r_hand_str = "lawyer_blue", slot_l_hand_str = "lawyer_blue")
	starting_accessories = list(/obj/item/clothing/accessory/tie/red)

/obj/item/clothing/under/lawyer/bluesuit/skirt
	name = "синий костюм с юбкой"
	icon_state = "bluesuit_skirt"

/obj/item/clothing/under/lawyer/purpsuit
	name = "фиолетовый костюм"
	icon_state = "lawyer_purp"
	item_state_slots = list(slot_r_hand_str = "purple", slot_l_hand_str = "purple")

/obj/item/clothing/under/lawyer/purpsuit/skirt
	name = "фиолетовый костюм с юбкой"
	icon_state = "lawyer_purp_skirt"

/obj/item/clothing/under/lawyer/oldman
	name = "костюм пожилого мужчины"
	desc = "Классический наряд пожилого джентльмена."
	icon_state = "oldman"
	item_state_slots = list(slot_r_hand_str = "johnny", slot_l_hand_str = "johnny")

/obj/item/clothing/under/oldwoman
	name = "костюм пожилой женщины"
	desc = "Типичный наряд пожилой леди: прелестный кардиган и удобная юбка."
	icon_state = "oldwoman"
	item_state_slots = list(slot_r_hand_str = "johnny", slot_l_hand_str = "johnny")

/obj/item/clothing/under/librarian
	name = "костюм начитанного человека"
	desc = "Вот так дела."
	icon_state = "red_suit"
	item_state_slots = list(slot_r_hand_str = "lawyer_red", slot_l_hand_str = "lawyer_red")

/obj/item/clothing/under/mime
	name = "костюм мима"
	desc = "Не очень выразительный."
	icon_state = "mime"

/obj/item/clothing/under/rank/miner
	desc = "Контрастный комбинезон. Изношенный и грязный."
	name = "комбинезон шахтера"
	icon_state = "miner"
	rolled_sleeves = 0
