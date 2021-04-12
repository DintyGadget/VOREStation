// Collars

/datum/gear/choker //A colorable choker
	display_name = "Чокер (окрашиваемый, без бирки)"
	path = /obj/item/clothing/accessory/choker
	slot = slot_tie
	sort_category = "Аксессуары"

/datum/gear/choker/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/collar
	display_name = "Ошейник, серебряный"
	path = /obj/item/clothing/accessory/collar/silver
	slot = slot_tie
	sort_category = "Аксессуары"

/datum/gear/collar/New()
	..()
	gear_tweaks += gear_tweak_collar_tag

/datum/gear/collar/golden
	display_name = "Ошейник, золотой"
	path = /obj/item/clothing/accessory/collar/gold

/datum/gear/collar/bell
	display_name = "Ошейник, с колокольчиком"
	path = /obj/item/clothing/accessory/collar/bell

/datum/gear/collar/shock
	display_name = "Ошейник, электрический"
	path = /obj/item/clothing/accessory/collar/shock

/datum/gear/collar/spike
	display_name = "Ошейник, шипованный"
	path = /obj/item/clothing/accessory/collar/spike

/datum/gear/collar/pink
	display_name = "Ошейник, розовый"
	path = /obj/item/clothing/accessory/collar/pink

/datum/gear/collar/holo
	display_name = "Ошейник, голографический"
	path = /obj/item/clothing/accessory/collar/holo

/datum/gear/collar/holo/indigestible
	display_name = "Ошейник, неперевариваемый"
	path = /obj/item/clothing/accessory/collar/holo/indigestible

/datum/gear/accessory/holster
	display_name = "Кобура, выбор (СБ, ДК, ГП, Иск)"
	allowed_roles = list("Site Manager", "Head of Personnel", "Security Officer", "Warden", "Head of Security","Detective","Explorer","Pathfinder","Talon Guard")

/datum/gear/accessory/brown_vest
	display_name = "Жилет из лямок, коричневый (Инж, СБ, Мед, Иск, Шахт)"
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Field Medic","Explorer","Pathfinder","Shaft Miner","Talon Captain","Talon Doctor","Talon Engineer","Talon Guard")

/datum/gear/accessory/black_vest
	display_name = "Жилет из лямок, черный (Инж, СБ, Мед, Иск, Шахт)"
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Field Medic","Explorer","Pathfinder","Shaft Miner","Talon Captain","Talon Doctor","Talon Engineer","Talon Guard")

/datum/gear/accessory/white_vest
	display_name = "Жилет из лямок, белый (Мед)"
	allowed_roles = list("Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Field Medic","Talon Doctor")

/datum/gear/accessory/brown_drop_pouches
	display_name = "Сумочки, коричневые (Инж, СБ, Мед, Иск, Шахт)"
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Field Medic","Explorer","Pathfinder","Shaft Miner","Talon Captain","Talon Doctor","Talon Engineer","Talon Guard")

/datum/gear/accessory/black_drop_pouches
	display_name = "Сумочки, черные (Инж, СБ, Мед, Иск, Шахт)"
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Field Medic","Explorer","Pathfinder","Shaft Miner","Talon Captain","Talon Doctor","Talon Engineer","Talon Guard")

/datum/gear/accessory/white_drop_pouches
	display_name = "Сумочки, белые (Мед)"
	allowed_roles = list("Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Field Medic","Talon Doctor")

/datum/gear/accessory/bluespace
	display_name = "bluespace badge (Eng, Sec, Med, Exploration, Miner)"
	path = /obj/item/clothing/accessory/storage/bluespace
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor","Chemist","Field Medic","Explorer","Pathfinder","Shaft Miner","Talon Captain","Talon Doctor","Talon Engineer","Talon Guard")
	cost = 2

/datum/gear/accessory/webbing
	cost = 1

/datum/gear/accessory/stethoscope
	allowed_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Psychiatrist","Paramedic","Field Medic","Talon Doctor")

/datum/gear/accessory/khcrystal
	display_name = "Жизненный кристалл KH"
	path = /obj/item/weapon/storage/box/khcrystal
	description = "A small necklace device that will notify an offsite cloning facility should you expire after activating it."

/datum/gear/accessory/tronket
	display_name = "Металлический кулон"
	description = "Блестящая стальная цепь, на которой висит металлический объект."
	path = /obj/item/clothing/accessory/tronket

/datum/gear/accessory/pilotpin
	display_name = "Значок квалифицированного пилота"
	description = "Железный значок, выдаваемый квалифицированным пилотам."
	path = /obj/item/clothing/accessory/solgov/specialty/pilot
	allowed_roles = list("Первопроходец", "Пилот", "Военврач")

/datum/gear/accessory/flops
	display_name = "Лямки по бокам"
	description = "Подтяжки через плечи? Это уже несколько веков не в моде, и Вы выше этого."
	path = /obj/item/clothing/accessory/flops

/datum/gear/accessory/flops/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice
