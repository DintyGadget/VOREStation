/datum/gear/accessory
	display_name = "Аксессуар"
	slot = slot_tie
	sort_category = "Аксессуары"
	type_category = /datum/gear/accessory
	path = /obj/item/clothing/accessory
	cost = 1

/datum/gear/accessory/armband
	display_name = "Повязка на руку (выбор)"
	path = /obj/item/clothing/accessory/armband

/datum/gear/accessory/armband/New()
	..()
	var/list/armbands = list()
	for(var/armband in (typesof(/obj/item/clothing/accessory/armband) - typesof(/obj/item/clothing/accessory/armband/med/color)))
		var/obj/item/clothing/accessory/armband_type = armband
		armbands[initial(armband_type.name)] = armband_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(armbands))

/datum/gear/accessory/armband/colored
	display_name = "Повязка на руку (окрашиваемая)"
	path = /obj/item/clothing/accessory/armband/med/color

/datum/gear/accessory/armband/colored/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/accessory/wallet
	display_name = "Кошелёк, оранжевый"
	path = /obj/item/weapon/storage/wallet/random

/datum/gear/accessory/wallet_poly
	display_name = "Кошелёк, полихромный"
	path = /obj/item/weapon/storage/wallet/poly
	cost = 0 //VOREStation Edit


/datum/gear/accessory/wallet/womens
	display_name = "Кошелёк, женский"
	path = /obj/item/weapon/storage/wallet/womens
	cost = 0 //VOREStation Edit

/datum/gear/accessory/wallet/womens/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/accessory/clutch
	display_name = "Клатч"
	path = /obj/item/weapon/storage/briefcase/clutch
	cost = 2

/datum/gear/accessory/clutch/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/accessory/purse
	display_name = "Сумочка"
	path = /obj/item/weapon/storage/backpack/purse
	cost = 3

/datum/gear/accessory/purse/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/accessory/wcoat
	display_name = "Жилетка (выбор)"
	path = /obj/item/clothing/accessory/wcoat
	cost = 1

/datum/gear/accessory/wcoat/New()
	..()
	var/list/wcoats = list()
	for(var/wcoat in typesof(/obj/item/clothing/accessory/wcoat))
		var/obj/item/clothing/accessory/wcoat_type = wcoat
		wcoats[initial(wcoat_type.name)] = wcoat_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(wcoats))

/datum/gear/accessory/holster
	display_name = "Кобура (выбор) (СБ, ДК, ГП)"
	path = /obj/item/clothing/accessory/holster
	allowed_roles = list("Site Manager", "Head of Personnel", "Security Officer", "Warden", "Head of Security","Detective")

/datum/gear/accessory/holster/New()
	..()
	var/list/holsters = list()
	for(var/holster in typesof(/obj/item/clothing/accessory/holster))
		var/obj/item/clothing/accessory/holster_type = holster
		holsters[initial(holster_type.name)] = holster_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(holsters))

/datum/gear/accessory/tie
	display_name = "Галстук (выбор)"
	path = /obj/item/clothing/accessory/tie
	cost = 1

/datum/gear/accessory/tie/New()
	..()
	var/list/ties = list()
	for(var/tie in typesof(/obj/item/clothing/accessory/tie))
		var/obj/item/clothing/accessory/tie_type = tie
		ties[initial(tie_type.name)] = tie_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(ties))

/datum/gear/accessory/scarf
	display_name = "Шарф (выбор)"
	path = /obj/item/clothing/accessory/scarf
	cost = 1

/datum/gear/accessory/scarf/New()
	..()
	var/list/scarfs = list()
	for(var/scarf in typesof(/obj/item/clothing/accessory/scarf))
		var/obj/item/clothing/accessory/scarf_type = scarf
		scarfs[initial(scarf_type.name)] = scarf_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(scarfs))

/datum/gear/accessory/scarfcolor
	display_name = "Шарф (окрашиваемый)"
	path = /obj/item/clothing/accessory/scarf/white
	cost = 1

/datum/gear/accessory/scarfcolor/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/accessory/jacket
	display_name = "Формальный пиджак (выбор)"
	path = /obj/item/clothing/accessory/jacket
	cost = 1

/datum/gear/accessory/jacket/New()
	..()
	var/list/jackets = list()
	for(var/jacket in typesof(/obj/item/clothing/accessory/jacket))
		var/obj/item/clothing/accessory/jacket_type = jacket
		jackets[initial(jacket_type.name)] = jacket_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(jackets))

/datum/gear/accessory/suitvest
	display_name = "Формальный жилет"
	path = /obj/item/clothing/accessory/vest

/datum/gear/accessory/brown_vest
	display_name = "Жилет из лямок, коричневый"
	path = /obj/item/clothing/accessory/storage/brown_vest
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor", "Search and Rescue")

/datum/gear/accessory/black_vest
	display_name = "Жилет из лямок, черный"
	path = /obj/item/clothing/accessory/storage/black_vest
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor", "Search and Rescue")

/datum/gear/accessory/white_vest
	display_name = "Жилет из лямок, белый"
	path = /obj/item/clothing/accessory/storage/white_vest
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor", "Search and Rescue")

/datum/gear/accessory/brown_drop_pouches
	display_name = "Сумочки, коричневые"
	path = /obj/item/clothing/accessory/storage/brown_drop_pouches
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor", "Search and Rescue")

/datum/gear/accessory/black_drop_pouches
	display_name = "Сумочки, черные"
	path = /obj/item/clothing/accessory/storage/black_drop_pouches
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor", "Search and Rescue")

/datum/gear/accessory/white_drop_pouches
	display_name = "Сумочки, белые"
	path = /obj/item/clothing/accessory/storage/white_drop_pouches
	allowed_roles = list("Station Engineer","Atmospheric Technician","Chief Engineer","Security Officer","Detective","Head of Security","Warden","Paramedic","Chief Medical Officer","Medical Doctor", "Search and Rescue")

/datum/gear/accessory/fannypack
	display_name = "Поясная сумка (выбор)"
	cost = 2
	path = /obj/item/weapon/storage/belt/fannypack

/datum/gear/accessory/fannypack/New()
	..()
	var/list/fannys = list()
	for(var/fanny in typesof(/obj/item/weapon/storage/belt/fannypack))
		var/obj/item/weapon/storage/belt/fannypack/fanny_type = fanny
		fannys[initial(fanny_type.name)] = fanny_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(fannys))

/datum/gear/accessory/webbing
	display_name = "Жилет из лямок, простой"
	path = /obj/item/clothing/accessory/storage/webbing
	cost = 2

/datum/gear/accessory/chaps
	display_name = "Гамаши, коричневые"
	path = /obj/item/clothing/accessory/chaps

/datum/gear/accessory/chaps/black
	display_name = "Гамаши, черные"
	path = /obj/item/clothing/accessory/chaps/black

/datum/gear/accessory/hawaii
	display_name = "Гавайская рубашка"
	path = /obj/item/clothing/accessory/hawaii

/datum/gear/accessory/hawaii/New()
	..()
	var/list/shirts = list()
	shirts["Синяя гавайская рубашка"] = /obj/item/clothing/accessory/hawaii
	shirts["Красная гавайская рубашка"] = /obj/item/clothing/accessory/hawaii/red
	shirts["Случайная гавайская рубашка"] = /obj/item/clothing/accessory/hawaii/random
	gear_tweaks += new/datum/gear_tweak/path(shirts)


/datum/gear/accessory/sweater
	display_name = "Свитер (выбор)"
	path = /obj/item/clothing/accessory/sweater

/datum/gear/accessory/sweater/New()
	..()
	var/list/sweaters = list()
	for(var/sweater in typesof(/obj/item/clothing/accessory/sweater))
		if(sweater in typesof(/obj/item/clothing/accessory/sweater/fluff))	//VOREStation addition
			continue														//VOREStation addition
		var/obj/item/clothing/suit/sweater_type = sweater
		sweaters[initial(sweater_type.name)] = sweater_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(sweaters))

/datum/gear/accessory/bracelet/material
	display_name = "Браслет (выбор)"
	description = "Выберите браслет из списка."
	path = /obj/item/clothing/accessory/bracelet
	cost = 1

/datum/gear/accessory/bracelet/material/New()
	..()
	var/bracelettype = list()
	bracelettype["Стальной браслет"] = /obj/item/clothing/accessory/bracelet/material/steel
	bracelettype["Железный браслет"] = /obj/item/clothing/accessory/bracelet/material/iron
	bracelettype["Серебряный браслет"] = /obj/item/clothing/accessory/bracelet/material/silver
	bracelettype["Золотой браслет"] = /obj/item/clothing/accessory/bracelet/material/gold
	bracelettype["Платиновый браслет"] = /obj/item/clothing/accessory/bracelet/material/platinum
	bracelettype["Стеклянный браслет"] = /obj/item/clothing/accessory/bracelet/material/glass
	bracelettype["Деревянный браслет"] = /obj/item/clothing/accessory/bracelet/material/wood
	bracelettype["Пластиковый браслет"] = /obj/item/clothing/accessory/bracelet/material/plastic
	gear_tweaks += new/datum/gear_tweak/path(bracelettype)

/datum/gear/accessory/bracelet/friendship
	display_name = "Браслет дружбы"
	path = /obj/item/clothing/accessory/bracelet/friendship

/datum/gear/accessory/stethoscope
	display_name = "Стетоскоп"
	path = /obj/item/clothing/accessory/stethoscope
	allowed_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Psychiatrist","Paramedic", "Search and Rescue")

/datum/gear/accessory/locket
	display_name = "Медальон"
	path = /obj/item/clothing/accessory/locket

/datum/gear/accessory/halfcape
	display_name = "Плащ (половина)"
	path = /obj/item/clothing/accessory/halfcape

/datum/gear/accessory/fullcape
	display_name = "Плащ (полный)"
	path = /obj/item/clothing/accessory/fullcape

/datum/gear/accessory/sash
	display_name = "Кушак (окрашиваемый)"
	path = /obj/item/clothing/accessory/sash

/datum/gear/accessory/sash/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/accessory/asym
	display_name = "Асимметричная куртка (выбор)"
	path = /obj/item/clothing/accessory/asymmetric
	cost = 1

/datum/gear/accessory/asym/New()
	..()
	var/list/asyms = list()
	for(var/asym in typesof(/obj/item/clothing/accessory/asymmetric))
		var/obj/item/clothing/accessory/asymmetric_type = asym
		asyms[initial(asymmetric_type.name)] = asymmetric_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(asyms))

/datum/gear/accessory/cowledvest
	display_name = "Безрукавка с воротом"
	path = /obj/item/clothing/accessory/cowledvest

/datum/gear/accessory/asymovercoat
	display_name = "Асимметричное пальто, оранжевое"
	path = /obj/item/clothing/accessory/asymovercoat
