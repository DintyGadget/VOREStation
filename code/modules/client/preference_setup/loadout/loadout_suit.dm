// Suit slot
/datum/gear/suit
	display_name = "Фартук, синий"
	path = /obj/item/clothing/suit/storage/apron
	slot = slot_wear_suit
	sort_category = "Костюмы и верхняя одежда"
	cost = 2

/datum/gear/suit/apron_white
	display_name = "Фартук (окрашиваемый)"
	path = /obj/item/clothing/suit/storage/apron/white

/datum/gear/suit/apron_white/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/suit/greatcoat
	display_name = "Шинель"
	path = /obj/item/clothing/suit/greatcoat

/datum/gear/suit/leather_coat
	display_name = "Пальто кожаное"
	path = /obj/item/clothing/suit/leathercoat

/datum/gear/suit/puffer_coat
	display_name = "Куртка, пуховик"
	path = /obj/item/clothing/suit/jacket/puffer

/datum/gear/suit/puffer_vest
	display_name = "Безрукавка, пуховик"
	path = /obj/item/clothing/suit/jacket/puffer/vest

/datum/gear/suit/bomber
	display_name = "Куртка, бомбер"
	path = /obj/item/clothing/suit/storage/toggle/bomber

/datum/gear/suit/bomber_alt
	display_name = "Куртка, бомбер, альт"
	path = /obj/item/clothing/suit/storage/bomber/alt

/datum/gear/suit/leather_jacket
	display_name = "Куртка, кожаная, черная"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket

/datum/gear/suit/leather_jacket_sleeveless
	display_name = "Безрукавка, кожаная, черная"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/sleeveless

/datum/gear/suit/leather_jacket_alt
	display_name = "Куртка, кожаная, черная, альт"
	path = /obj/item/clothing/suit/storage/leather_jacket_alt

/datum/gear/suit/leather_jacket_nt
	display_name = "Куртка, кожаная, фирменная, черная"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/nanotrasen

/datum/gear/suit/leather_jacket_nt/sleeveless
	display_name = "Безрукавка, кожаная, фирменная, черная"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/nanotrasen/sleeveless

/datum/gear/suit/brown_jacket
	display_name = "Куртка, кожаная, коричневая"
	path = /obj/item/clothing/suit/storage/toggle/brown_jacket

/datum/gear/suit/brown_jacket_sleeveless
	display_name = "Безрукавка, кожаная, коричневая"
	path = /obj/item/clothing/suit/storage/toggle/brown_jacket/sleeveless

/datum/gear/suit/brown_jacket_nt
	display_name = "Куртка, кожаная, фирменная, коричневая"
	path = /obj/item/clothing/suit/storage/toggle/brown_jacket/nanotrasen

/datum/gear/suit/brown_jacket_nt/sleeveless
	display_name = "Безрукавка, кожаная, фирменная, коричневая"
	path = /obj/item/clothing/suit/storage/toggle/brown_jacket/nanotrasen/sleeveless

/datum/gear/suit/mil
	display_name = "Куртка, милитари (выбор)"
	path = /obj/item/clothing/suit/storage/miljacket

/datum/gear/suit/mil/New()
	..()
	var/list/mil_jackets = list()
	for(var/military_style in typesof(/obj/item/clothing/suit/storage/miljacket))
		var/obj/item/clothing/suit/storage/miljacket/miljacket = military_style
		mil_jackets[initial(miljacket.name)] = miljacket
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(mil_jackets))

/datum/gear/suit/greyjacket
	display_name = "Куртка, серая"
	path = /obj/item/clothing/suit/storage/greyjacket

/datum/gear/suit/brown_trenchcoat
	display_name = "Тренчкот, коричневый"
	path = /obj/item/clothing/suit/storage/trench

/datum/gear/suit/grey_trenchcoat
	display_name = "Тренчкот, серый"
	path = /obj/item/clothing/suit/storage/trench/grey

datum/gear/suit/duster
	display_name = "Ковбойский пыльник"
	path = /obj/item/clothing/suit/storage/duster

/datum/gear/suit/duster/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/suit/hazard_vest
	display_name = "Аварийный жилет (выбор)"
	path = /obj/item/clothing/suit/storage/hazardvest

/datum/gear/suit/hazard_vest/New()
	..()
	var/list/hazards = list()
	for(var/hazard_style in typesof(/obj/item/clothing/suit/storage/hazardvest))
		if(hazard_style in typesof(/obj/item/clothing/suit/storage/hazardvest/fluff))	//VOREStation addition
			continue																	//VOREStation addition
		var/obj/item/clothing/suit/storage/hazardvest/hazardvest = hazard_style
		hazards[initial(hazardvest.name)] = hazardvest
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(hazards))

/datum/gear/suit/hoodie
	display_name = "Худи (выбор)"
	path = /obj/item/clothing/suit/storage/toggle/hoodie

/datum/gear/suit/hoodie/New()
	..()
	var/list/hoodies = list()
	for(var/hoodie_style in typesof(/obj/item/clothing/suit/storage/toggle/hoodie))
		var/obj/item/clothing/suit/storage/toggle/hoodie/hoodie = hoodie_style
		hoodies[initial(hoodie.name)] = hoodie
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(hoodies))

/datum/gear/suit/labcoat
	display_name = "Лаб. халат"
	path = /obj/item/clothing/suit/storage/toggle/labcoat

/datum/gear/suit/labcoat/blue
	display_name = "Лаб. халат, синий"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/blue

/datum/gear/suit/labcoat/blue_edge
	display_name = "Лаб. халат, синяя кромка"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/blue_edge

/datum/gear/suit/labcoat/green
	display_name = "Лаб. халат, зеленый"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/green

/datum/gear/suit/labcoat/orange
	display_name = "Лаб. халат, оранжевый"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/orange

/datum/gear/suit/labcoat/purple
	display_name = "Лаб. халат, фиолетовый"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/purple

/datum/gear/suit/labcoat/pink
	display_name = "Лаб. халат, розовый"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/pink

/datum/gear/suit/labcoat/red
	display_name = "Лаб. халат, красный"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/red

/datum/gear/suit/labcoat/yellow
	display_name = "Лаб. халат, желтый"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/yellow

/datum/gear/suit/labcoat/emt
	display_name = "Врач: Халат"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/emt
	allowed_roles = list("Medical Doctor","Chief Medical Officer","Chemist","Paramedic","Geneticist", "Psychiatrist")

/datum/gear/suit/miscellaneous/labcoat
	display_name = "plague doctor's coat"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/plaguedoctor

/datum/gear/suit/roles/surgical_apron
	display_name = "Врач: Фартук хирурга"
	path = /obj/item/clothing/suit/surgicalapron
	allowed_roles = list("Medical Doctor","Chief Medical Officer")

/datum/gear/suit/overalls
	display_name = "Комбинезон"
	path = /obj/item/clothing/suit/storage/apron/overalls
	cost = 1

/datum/gear/suit/poncho
	display_name = "Пончо (выбор)"
	path = /obj/item/clothing/accessory/poncho
	cost = 1

/datum/gear/suit/poncho/New()
	..()
	var/list/ponchos = list()
	for(var/poncho_style in (typesof(/obj/item/clothing/accessory/poncho) - typesof(/obj/item/clothing/accessory/poncho/roles)))
		var/obj/item/clothing/accessory/poncho/poncho = poncho_style
		ponchos[initial(poncho.name)] = poncho
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(ponchos))

/datum/gear/suit/roles/poncho
	display_name = "Карго: Пончо"
	path = /obj/item/clothing/accessory/poncho/roles/cargo
	cost = 1

/datum/gear/suit/roles/poncho/security
	display_name = "СБ: Пончо"
	path = /obj/item/clothing/accessory/poncho/roles/security

/datum/gear/suit/roles/poncho/medical
	display_name = "Врач: Пончо"
	path = /obj/item/clothing/accessory/poncho/roles/medical

/datum/gear/suit/roles/poncho/engineering
	display_name = "Инженер: Пончо"
	path = /obj/item/clothing/accessory/poncho/roles/engineering

/datum/gear/suit/roles/poncho/science
	display_name = "Учёный: Пончо"
	path = /obj/item/clothing/accessory/poncho/roles/science

/datum/gear/suit/roles/poncho/cloak/hos
	display_name = "СБ: Плащ Главы Службы Безопасности"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/hos
	allowed_roles = list("Head of Security")

/datum/gear/suit/roles/poncho/cloak/cmo
	display_name = "Врач: Плащ Главврача"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/cmo
	allowed_roles = list("Chief Medical Officer")

/datum/gear/suit/roles/poncho/cloak/ce
	display_name = "Инженер: Плащ Главного Инженера"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/ce
	allowed_roles = list("Chief Engineer")

/datum/gear/suit/roles/poncho/cloak/rd
	display_name = "Учёный: Плащ Директора Исследований"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/rd
	allowed_roles = list("Research Director")

/datum/gear/suit/roles/poncho/cloak/qm
	display_name = "Карго: Плащ Квартирмейстера"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/qm
	allowed_roles = list("Quartermaster")

/datum/gear/suit/roles/poncho/cloak/captain
	display_name = "Управление: Плащ Директора Колонии"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/captain
	allowed_roles = list("Site Manager")

/datum/gear/suit/roles/poncho/cloak/hop
	display_name = "Управление: Плащ Главы Персонала"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/hop
	allowed_roles = list("Head of Personnel")

/datum/gear/suit/roles/poncho/cloak/cargo
	display_name = "Карго: Плащ карго"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/cargo

/datum/gear/suit/roles/poncho/cloak/mining
	display_name = "Карго: Плащ шахтёра"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/mining

/datum/gear/suit/roles/poncho/cloak/security
	display_name = "СБ: Плащ"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/security

/datum/gear/suit/roles/poncho/cloak/service
	display_name = "Сервис: Плащ"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/service

/datum/gear/suit/roles/poncho/cloak/engineer
	display_name = "Инженер: Плащ инженера"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/engineer

/datum/gear/suit/roles/poncho/cloak/atmos
	display_name = "Инженер: Плащ атмосферщика"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/atmos

/datum/gear/suit/roles/poncho/cloak/research
	display_name = "Учёный: Плащ"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/research

/datum/gear/suit/roles/poncho/cloak/medical
	display_name = "Врач: Плащ"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/medical

/datum/gear/suit/roles/poncho/cloak/custom //A colorable cloak
	display_name = "Плащ (окрашиваемый)"
	path = /obj/item/clothing/accessory/poncho/roles/cloak/custom

/datum/gear/suit/roles/poncho/cloak/custom/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/suit/unathi_robe
	display_name = "Домотканая туника"
	path = /obj/item/clothing/suit/unathi/robe
	cost = 1

/datum/gear/suit/black_lawyer_jacket
	display_name = "Формальный пиджак, черный"
	path = /obj/item/clothing/suit/storage/toggle/internalaffairs

/datum/gear/suit/blue_lawyer_jacket
	display_name = "Формальный пиджак, синий"
	path = /obj/item/clothing/suit/storage/toggle/lawyer/bluejacket

/datum/gear/suit/purple_lawyer_jacket
	display_name = "Формальный пиджак, фиолетовый"
	path = /obj/item/clothing/suit/storage/toggle/lawyer/purpjacket

/datum/gear/suit/suspenders
	display_name = "Подтяжки"
	path = /obj/item/clothing/suit/suspenders

/datum/gear/suit/forensics
	display_name = "Детектив: Длинный пиджак, красный"
	path = /obj/item/clothing/suit/storage/forensics/red/long
	allowed_roles = list("Detective")

/datum/gear/suit/forensics/blue
	display_name = "Детектив: Длинный пиджак, синий"
	path = /obj/item/clothing/suit/storage/forensics/blue/long
	allowed_roles = list("Detective")

/datum/gear/suit/forensics/blue/short
	display_name = "Детектив: Пиджак, синий"
	path = /obj/item/clothing/suit/storage/forensics/blue
	allowed_roles = list("Detective")

/datum/gear/suit/forensics/red/short
	display_name = "Детектив: Пиджак, красный"
	path = /obj/item/clothing/suit/storage/forensics/red
	allowed_roles = list("Detective")

// winter coats go here

/datum/gear/suit/wintercoat
	display_name = "Пальто зимнее"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat

/datum/gear/suit/wintercoat/captain
	display_name = "Управление: Зимнее пальто ДК"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/captain
	allowed_roles = list("Site Manager")

/datum/gear/suit/wintercoat/hop
	display_name = "winter coat, head of personnel"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/hop
	allowed_roles = list("Head of Personnel")

/datum/gear/suit/wintercoat/security
	display_name = "СБ: Зимнее пальто"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/security
	allowed_roles = list("Security Officer", "Head of Security", "Warden", "Detective")

/datum/gear/suit/wintercoat/security/hos
	display_name = "winter coat, head of security"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/security/hos
	allowed_roles = list("Head of Security")

/datum/gear/suit/wintercoat/medical
	display_name = "Врач: Зимнее пальто"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/medical
	allowed_roles = list("Medical Doctor","Chief Medical Officer","Chemist","Paramedic","Geneticist", "Psychiatrist", "Field Medic")

/datum/gear/suit/wintercoat/medical/alt
	display_name = "winter coat, medical alt"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/medical/alt
	allowed_roles = list("Medical Doctor","Chief Medical Officer","Chemist","Paramedic","Geneticist", "Psychiatrist", "Field Medic")

/datum/gear/suit/wintercoat/medical/viro
	display_name = "winter coat, virologist"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/medical/viro
	allowed_roles = list("Medical Doctor","Chief Medical Officer")

/datum/gear/suit/wintercoat/medical/para
	display_name = "winter coat, paramedic"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/medical/para
	allowed_roles = list("Medical Doctor","Chief Medical Officer","Paramedic")

/datum/gear/suit/wintercoat/medical/chemist
	display_name = "winter coat, chemist"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/medical/chemist
	allowed_roles = list("Chief Medical Officer","Chemist")

/datum/gear/suit/wintercoat/medical/cmo
	display_name = "winter coat, chief medical officer"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/medical/cmo
	allowed_roles = list("Chief Medical Officer")

/datum/gear/suit/wintercoat/medical/sar
	display_name = "winter coat, search and rescue"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/medical/sar
	allowed_roles = list("Chief Medical Officer", "Field Medic")

/datum/gear/suit/wintercoat/science
	display_name = "Учёный: Зимнее пальто"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/science
	allowed_roles = list("Research Director","Scientist", "Roboticist", "Xenobiologist", "Xenobotanist")


/datum/gear/suit/wintercoat/science/robotics
	display_name = "winter coat, robotics"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/science/robotics
	allowed_roles = list("Research Director", "Roboticist")

/datum/gear/suit/wintercoat/science/rd
	display_name = "winter coat, research director"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/science/rd
	allowed_roles = list("Research Director")

/datum/gear/suit/wintercoat/engineering
	display_name = "Инженер: Зимнее пальто инженера"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/engineering
	allowed_roles = list("Chief Engineer","Atmospheric Technician", "Station Engineer")

/datum/gear/suit/wintercoat/engineering/atmos
	display_name = "Инженер: Зимнее пальто атмосферщика"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/engineering/atmos
	allowed_roles = list("Chief Engineer", "Atmospheric Technician")

/datum/gear/suit/wintercoat/engineering/ce
	display_name = "winter coat, chief engineer"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/engineering/ce
	allowed_roles = list("Chief Engineer")

/datum/gear/suit/wintercoat/hydro
	display_name = "Сервис: Зимнее пальто ботаника"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/hydro
	allowed_roles = list("Botanist", "Xenobotanist")

/datum/gear/suit/wintercoat/cargo
	display_name = "Карго: Зимнее пальто карго"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/cargo
	allowed_roles = list("Quartermaster","Cargo Technician")

/datum/gear/suit/wintercoat/miner
	display_name = "Карго: Зимнее пальто шахтера"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/miner
	allowed_roles = list("Shaft Miner")

/datum/gear/suit/wintercoat/cargo/qm
	display_name = "winter coat, quartermaster"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/cargo/qm
	allowed_roles = list("Quartermaster")

/datum/gear/suit/wintercoat/bar
	display_name = "winter coat, bartender"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/bar
	allowed_roles = list("Bartender")

/datum/gear/suit/wintercoat/janitor
	display_name = "winter coat, janitor"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/janitor
	allowed_roles = list("Janitor")

/datum/gear/suit/wintercoat/aformal
	display_name = "winter coat, assistant formal"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/aformal

/datum/gear/suit/wintercoat/ratvar
	display_name = "winter coat, brassy"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/ratvar

/datum/gear/suit/wintercoat/narsie
	display_name = "winter coat, runed"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/narsie

/datum/gear/suit/wintercoat/cosmic
	display_name = "winter coat, cosmic"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/cosmic

// winter coats end here

/datum/gear/suit/varsity
	display_name = "Куртка, университетская (выбор)"
	path = /obj/item/clothing/suit/varsity

/datum/gear/suit/varsity/New()
	..()
	var/list/varsities = list()
	for(var/varsity_style in typesof(/obj/item/clothing/suit/varsity))
		var/obj/item/clothing/suit/varsity/varsity = varsity_style
		varsities[initial(varsity.name)] = varsity
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(varsities))

/datum/gear/suit/track
	display_name = "Куртка, спортивная (выбор)"
	path = /obj/item/clothing/suit/storage/toggle/track

/datum/gear/suit/track/New()
	..()
	var/list/tracks = list()
	for(var/track_style in typesof(/obj/item/clothing/suit/storage/toggle/track))
		var/obj/item/clothing/suit/storage/toggle/track/track = track_style
		tracks[initial(track.name)] = track
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(tracks))

/datum/gear/suit/flannel
	display_name = "Рубашка фланелевая, серая"
	path = /obj/item/clothing/suit/storage/flannel

/datum/gear/suit/flannel/red
	display_name = "Рубашка фланелевая, красная"
	path = /obj/item/clothing/suit/storage/flannel/red

/datum/gear/suit/flannel/aqua
	display_name = "Рубашка фланелевая, морская волна"
	path = /obj/item/clothing/suit/storage/flannel/aqua

/datum/gear/suit/flannel/brown
	display_name = "Рубашка фланелевая, коричневая"
	path = /obj/item/clothing/suit/storage/flannel/brown

/datum/gear/suit/denim_jacket
	display_name = "Куртка, деним"
	path = /obj/item/clothing/suit/storage/toggle/denim_jacket

/datum/gear/suit/denim_jacket/corporate
	display_name = "Куртка, деним, фирменная"
	path = /obj/item/clothing/suit/storage/toggle/denim_jacket/nanotrasen

/datum/gear/suit/denim_vest
	display_name = "Безрукавка, деним"
	path = /obj/item/clothing/suit/storage/toggle/denim_jacket/sleeveless

/datum/gear/suit/denim_vest/corporate
	display_name = "Безрукавка, деним, фирменная"
	path = /obj/item/clothing/suit/storage/toggle/denim_jacket/nanotrasen/sleeveless

/datum/gear/suit/miscellaneous/kimono
	display_name = "Кимоно"
	path = /obj/item/clothing/suit/kimono

/datum/gear/suit/miscellaneous/kimono/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/suit/miscellaneous/sec_dep_jacket
	display_name = "СБ: Куртка отдела"
	path = /obj/item/clothing/suit/storage/toggle/sec_dep_jacket

/datum/gear/suit/miscellaneous/engi_dep_jacket
	display_name = "Инженер: Куртка отдела"
	path = /obj/item/clothing/suit/storage/toggle/engi_dep_jacket

/datum/gear/suit/miscellaneous/supply_dep_jacket
	display_name = "Карго: Куртка отдела"
	path = /obj/item/clothing/suit/storage/toggle/supply_dep_jacket

/datum/gear/suit/miscellaneous/sci_dep_jacket
	display_name = "Учёный: Куртка отдела"
	path = /obj/item/clothing/suit/storage/toggle/sci_dep_jacket

/datum/gear/suit/miscellaneous/med_dep_jacket
	display_name = "Врача: Куртка отдела"
	path = /obj/item/clothing/suit/storage/toggle/med_dep_jacket

/datum/gear/suit/miscellaneous/peacoat
	display_name = "Бушлат"
	path = /obj/item/clothing/suit/storage/toggle/peacoat

/datum/gear/suit/miscellaneous/peacoat/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/suit/miscellaneous/kamishimo
	display_name = "Камисимо"
	path = /obj/item/clothing/suit/kamishimo

/datum/gear/suit/snowsuit
	display_name = "Зимняя куртка"
	path = /obj/item/clothing/suit/storage/snowsuit

/datum/gear/suit/snowsuit/command
	display_name = "Управление: Зимняя куртка"
	path = /obj/item/clothing/suit/storage/snowsuit/command
	allowed_roles = list("Site Manager","Research Director","Head of Personnel","Head of Security","Chief Engineer","Command Secretary")

/datum/gear/suit/snowsuit/security
	display_name = "СБ: Зимняя куртка"
	path = /obj/item/clothing/suit/storage/snowsuit/security
	allowed_roles = list("Security Officer", "Head of Security", "Warden", "Detective")

/datum/gear/suit/snowsuit/medical
	display_name = "Врач: Зимняя куртка"
	path = /obj/item/clothing/suit/storage/snowsuit/medical
	allowed_roles = list("Medical Doctor","Chief Medical Officer","Chemist","Paramedic","Geneticist", "Psychiatrist", "Search and Rescue")

/datum/gear/suit/snowsuit/science
	display_name = "Учёный: Зимняя куртка"
	path = /obj/item/clothing/suit/storage/snowsuit/science
	allowed_roles = list("Research Director","Scientist", "Roboticist", "Xenobiologist")

/datum/gear/suit/snowsuit/engineering
	display_name = "Инженер: Зимняя куртка"
	path = /obj/item/clothing/suit/storage/snowsuit/engineering
	allowed_roles = list("Chief Engineer","Atmospheric Technician", "Station Engineer")

/datum/gear/suit/snowsuit/cargo
	display_name = "Карго: Зимняя куртка"
	path = /obj/item/clothing/suit/storage/snowsuit/cargo
	allowed_roles = list("Quartermaster","Shaft Miner","Cargo Technician","Head of Personnel")

/datum/gear/suit/miscellaneous/cardigan
	display_name = "Кардиган (окрашиваемый)"
	path = /obj/item/clothing/suit/storage/toggle/cardigan

/datum/gear/suit/miscellaneous/cardigan/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice