/datum/design/item/medical
	materials = list(DEFAULT_WALL_MATERIAL = 30, "glass" = 20)

/datum/design/item/medical/AssembleDesignName()
	..()
	name = "Medical equipment prototype ([item_name])"

// Surgical devices

/datum/design/item/medical/scalpel_laser1
	name = "Базовый лазерный скальпель"
	desc = "Скальпель с направленным лазером для более точной резки без попадания крови на пол. Выглядит просто и может быть улучшено."
	id = "scalpel_laser1"
	req_tech = list(TECH_BIO = 2, TECH_MATERIAL = 2, TECH_MAGNET = 2)
	materials = list(DEFAULT_WALL_MATERIAL = 12500, "glass" = 7500, MAT_COPPER = 120)
	build_path = /obj/item/weapon/surgical/scalpel/laser1
	sort_string = "KAAAA"

/datum/design/item/medical/scalpel_laser2
	name = "Улучшенный лазерный скальпель"
	desc = "Скальпель с направленным лазером для более точной резки без попадания крови на пол. Выглядит несколько продвинутым."
	id = "scalpel_laser2"
	req_tech = list(TECH_BIO = 3, TECH_MATERIAL = 4, TECH_MAGNET = 4)
	materials = list(DEFAULT_WALL_MATERIAL = 12500, "glass" = 7500, "silver" = 2500)
	build_path = /obj/item/weapon/surgical/scalpel/laser2
	sort_string = "KAAAB"

/datum/design/item/medical/scalpel_laser3
	name = "Улучшенный лазерный скальпель G2"
	desc = "Скальпель с направленным лазером для более точной резки без попадания крови на пол. Выглядит как вершина точных энергетических медицинских приборов!"
	id = "scalpel_laser3"
	req_tech = list(TECH_BIO = 4, TECH_MATERIAL = 6, TECH_MAGNET = 5)
	materials = list(DEFAULT_WALL_MATERIAL = 12500, "glass" = 7500, "silver" = 2000, "gold" = 1500)
	build_path = /obj/item/weapon/surgical/scalpel/laser3
	sort_string = "KAAAC"

/datum/design/item/medical/scalpel_manager
	name = "Система управления разрезами"
	desc = "Настоящее расширение тела хирурга, это чудо мгновенно и полностью подготавливает разрез, позволяющий немедленно приступить к терапевтическим этапам."
	id = "scalpel_manager"
	req_tech = list(TECH_BIO = 4, TECH_MATERIAL = 7, TECH_MAGNET = 5, TECH_DATA = 4)
	materials = list (DEFAULT_WALL_MATERIAL = 12500, "glass" = 7500, "silver" = 1500, "gold" = 1500, "diamond" = 750)
	build_path = /obj/item/weapon/surgical/scalpel/manager
	sort_string = "KAAAD"

/datum/design/item/medical/saw_manager
	name = "Электрический отводчик костей"
	desc = "Странное развитие после I.M.S., этот тяжелый инструмент может расщеплять и открывать или закрывать и закрывать умышленные отверстия в костях."
	id = "advanced_saw"
	req_tech = list(TECH_BIO = 4, TECH_MATERIAL = 7, TECH_MAGNET = 6, TECH_DATA = 5)
	materials = list (DEFAULT_WALL_MATERIAL = 12500, MAT_PLASTIC = 800, "silver" = 1500, "gold" = 1500, MAT_OSMIUM = 1000)
	build_path = /obj/item/weapon/surgical/circular_saw/manager
	sort_string = "KAAAE"

/datum/design/item/medical/organ_ripper
	name = "Потрошитель органов"
	desc = "Современный и устрашающий вариант древней практики медицины, этот инструмент способен быстро удалить орган у пациента, который, как мы надеемся, ему не нужен, не повредив его."
	id = "organ_ripper"
	req_tech = list(TECH_BIO = 3, TECH_MATERIAL = 5, TECH_MAGNET = 4, TECH_ILLEGAL = 3)
	materials = list (DEFAULT_WALL_MATERIAL = 12500, MAT_PLASTIC = 8000, MAT_OSMIUM = 2500)
	build_path = /obj/item/weapon/surgical/scalpel/ripper
	sort_string = "KAAAF"

/datum/design/item/medical/bone_clamp
	name = "Костный зажим"
	desc = "Чудо современной науки, этот инструмент быстро соединяет кости без костного геля."
	id = "bone_clamp"
	req_tech = list(TECH_BIO = 4, TECH_MATERIAL = 5, TECH_MAGNET = 4, TECH_DATA = 4)
	materials = list (DEFAULT_WALL_MATERIAL = 12500, "glass" = 7500, "silver" = 2500)
	build_path = /obj/item/weapon/surgical/bone_clamp
	sort_string = "KAABA"

/datum/design/item/medical/medical_analyzer
	name = "анализатор здоровья"
	desc = "Ручной сканер тела, способный распознавать жизненно важные признаки субъекта."
	id = "medical_analyzer"
	req_tech = list(TECH_MAGNET = 2, TECH_BIO = 2)
	materials = list(DEFAULT_WALL_MATERIAL = 500, "glass" = 500, MAT_COPPER = 20)
	build_path = /obj/item/device/healthanalyzer
	sort_string = "KBAAA"

/datum/design/item/medical/improved_analyzer
	name = "улучшенный анализатор здоровья"
	desc = "Прототип обычного анализатора здоровья, способный определять место более серьезных травм, а также точно определять уровень радиации."
	id = "improved_analyzer"
	req_tech = list(TECH_MAGNET = 5, TECH_BIO = 6)
	materials = list(DEFAULT_WALL_MATERIAL = 2000, "glass" = 1000, "silver" = 1000, "gold" = 1500)
	build_path = /obj/item/device/healthanalyzer/improved
	sort_string = "KBAAB"

/datum/design/item/medical/advanced_roller
	name = "усовершенствованная роликовая кровать"
	desc = "Более продвинутая версия обычной роликовой кровати со встроенными хирургическими стабилизаторами и улучшенной системой складывания."
	id = "roller_bed"
	req_tech = list(TECH_BIO = 3, TECH_MATERIAL = 3, TECH_MAGNET = 3)
	materials = list(DEFAULT_WALL_MATERIAL = 4000, "glass" = 2000, "phoron" = 2000, MAT_COPPER = 100)
	build_path = /obj/item/roller/adv
	sort_string = "KCAAA"