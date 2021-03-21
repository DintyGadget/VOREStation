/datum/gear/head
	display_name = "Бандана, красная пиратская"
	path = /obj/item/clothing/head/bandana
	slot = slot_head
	sort_category = "Голова"

/datum/gear/head/bandana_green
	display_name = "Бандана, зеленая"
	path = /obj/item/clothing/head/greenbandana

/datum/gear/head/bandana_orange
	display_name = "Бандана, оранжевая"
	path = /obj/item/clothing/head/orangebandana

/datum/gear/head/beret
	display_name = "Берет, красный"
	path = /obj/item/clothing/head/beret

/datum/gear/head/beret/bsec
	display_name = "СБ: Берет, ВМС (Офицер)"
	path = /obj/item/clothing/head/beret/sec/navy/officer
	allowed_roles = list("Security Officer","Head of Security","Warden")

/datum/gear/head/beret/bsec_warden
	display_name = "СБ: Берет, ВМС (Надзиратель)"
	path = /obj/item/clothing/head/beret/sec/navy/warden
	allowed_roles = list("Head of Security","Warden")

/datum/gear/head/beret/bsec_hos
	display_name = "СБ: Берет, ВМС (Глава СБ)"
	path = /obj/item/clothing/head/beret/sec/navy/hos
	allowed_roles = list("Head of Security")

/datum/gear/head/beret/csec
	display_name = "СБ: Берет, фирменный"
	path = /obj/item/clothing/head/beret/sec/corporate/officer
	allowed_roles = list("Security Officer","Head of Security","Warden", "Detective")

/datum/gear/head/beret/csec_warden
	display_name = "СБ: Берет, фирменный (Надзиратель)"
	path = /obj/item/clothing/head/beret/sec/corporate/warden
	allowed_roles = list("Head of Security","Warden")

/datum/gear/head/beret/csec_hos
	display_name = "СБ: Берет, фирменный (Глава СБ)"
	path = /obj/item/clothing/head/beret/sec/corporate/hos
	allowed_roles = list("Head of Security")

/datum/gear/head/beret/eng
	display_name = "Берет, инженерно-оранжевый"
	path = /obj/item/clothing/head/beret/engineering

/datum/gear/head/beret/purp
	display_name = "Берет, фиолетовый"
	path = /obj/item/clothing/head/beret/purple

/datum/gear/head/beret/sec
	display_name = "СБ: Берет, красный"
	path = /obj/item/clothing/head/beret/sec
	allowed_roles = list("Security Officer","Head of Security","Warden", "Detective")

/datum/gear/head/cap
	display_name = "Кепка, черная"
	path = /obj/item/clothing/head/soft/black

/datum/gear/head/cap/blue
	display_name = "Кепка, синяя"
	path = /obj/item/clothing/head/soft/blue

/datum/gear/head/cap/mailman
	display_name = "Кепка, синяя почтовая"
	path = /obj/item/clothing/head/mailman

/datum/gear/head/cap/flat
	display_name = "Плоская кепка, коричневая"
	path = /obj/item/clothing/head/flatcap

/datum/gear/head/cap/corp
	display_name = "СБ: Фуражка, фирменная"
	path = /obj/item/clothing/head/soft/sec/corp
	allowed_roles = list("Security Officer","Head of Security","Warden", "Detective")

/datum/gear/head/cap/green
	display_name = "Кепка, зеленая"
	path = /obj/item/clothing/head/soft/green

/datum/gear/head/cap/grey
	display_name = "Кепка, серая"
	path = /obj/item/clothing/head/soft/grey

/datum/gear/head/cap/med
	display_name = "Кепка, (Мед.)"
	path = /obj/item/clothing/head/soft/med
	allowed_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Psychiatrist","Paramedic","Search and Rescue")

/datum/gear/head/cap/orange
	display_name = "Кепка, оранжевая"
	path = /obj/item/clothing/head/soft/orange

/datum/gear/head/cap/purple
	display_name = "Кепка, фиолетовая"
	path = /obj/item/clothing/head/soft/purple

/datum/gear/head/cap/rainbow
	display_name = "Кепка, радужная"
	path = /obj/item/clothing/head/soft/rainbow

/datum/gear/head/cap/red
	display_name = "Кепка, красная"
	path = /obj/item/clothing/head/soft/red

/datum/gear/head/cap/sec
	display_name = "СБ: Фуражка"
	path = /obj/item/clothing/head/soft/sec
	allowed_roles = list("Security Officer","Head of Security","Warden", "Detective")

/datum/gear/head/cap/yellow
	display_name = "Кепка, желтая"
	path = /obj/item/clothing/head/soft/yellow

/datum/gear/head/cap/white
	display_name = "Кепка (окрашиваемая)"
	path = /obj/item/clothing/head/soft/mime

/datum/gear/head/cap/white/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/head/cap/mbill
	display_name = "Кепка, Major Bill's"
	path = /obj/item/clothing/head/soft/mbill

/datum/gear/head/cap/sol
	display_name = "Кепка, Сол"
	path = /obj/item/clothing/head/soft/solgov

/datum/gear/head/cowboy
	display_name = "Ковбойская шляпа, родео"
	path = /obj/item/clothing/head/cowboy_hat

/datum/gear/head/cowboy/black
	display_name = "Ковбойская шляпа, черная"
	path = /obj/item/clothing/head/cowboy_hat/black

/datum/gear/head/cowboy/wide
	display_name = "Ковбойская шляпа, широкая"
	path = /obj/item/clothing/head/cowboy_hat/wide

/datum/gear/head/fedora
	display_name = "Федора, коричневая"
	path = /obj/item/clothing/head/fedora/brown

/datum/gear/head/fedora/grey
	display_name = "Федора, серая"
	path = /obj/item/clothing/head/fedora/grey

/datum/gear/head/hairflower
	display_name = "Заколка, цветочная (окрашиваемая)"
	path = /obj/item/clothing/head/pin/flower/white

/datum/gear/head/hairflower/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/head/pin
	display_name = "Заколка (выбор)"
	path = /obj/item/clothing/head/pin

/datum/gear/head/pin/New()
	..()
	var/list/pins = list()
	for(var/pin in typesof(/obj/item/clothing/head/pin))
		var/obj/item/clothing/head/pin/pin_type = pin
		pins[initial(pin_type.name)] = pin_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(pins))

/datum/gear/head/hardhat
	display_name = "Каска (выбор)"
	path = /obj/item/clothing/head/hardhat
	cost = 2

/datum/gear/head/hardhat/New()
	..()
	var/list/hardhats = list()
	for(var/hardhat in typesof(/obj/item/clothing/head/hardhat))
		var/obj/item/clothing/head/hardhat/hardhat_type = hardhat
		hardhats[initial(hardhat_type.name)] = hardhat_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(hardhats))

/datum/gear/head/boater
	display_name = "Шляпа лодочника"
	path = /obj/item/clothing/head/boaterhat

/datum/gear/head/bowler
	display_name = "Котелок"
	path = /obj/item/clothing/head/bowler

/datum/gear/head/fez
	display_name = "Феска"
	path = /obj/item/clothing/head/fez

/datum/gear/head/tophat
	display_name = "Цилиндр"
	path = /obj/item/clothing/head/that

/datum/gear/head/wig/philosopher
	display_name = "Парик философа"
	path = /obj/item/clothing/head/philosopher_wig

/datum/gear/head/wig
	display_name = "Парик пудреный"
	path = /obj/item/clothing/head/powdered_wig

/datum/gear/head/ushanka
	display_name = "Шапка-ушанка"
	path = /obj/item/clothing/head/ushanka

/datum/gear/head/santahat
	display_name = "Шапка Санты"
	path = /obj/item/clothing/head/santa
	cost = 2

/datum/gear/head/santahat/New()
	..()
	var/list/santahats = list()
	for(var/santahat in typesof(/obj/item/clothing/head/santa))
		var/obj/item/clothing/head/santa/santahat_type = santahat
		santahats[initial(santahat_type.name)] = santahat_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(santahats))

/datum/gear/head/hijab
	display_name = "Хиджаб"
	path = /obj/item/clothing/head/hijab

/datum/gear/head/hijab/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/head/kippa
	display_name = "Ермолка"
	path = /obj/item/clothing/head/kippa

/datum/gear/head/kippa/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/head/turban
	display_name = "Тюрбан"
	path = /obj/item/clothing/head/turban

/datum/gear/head/turban/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/head/taqiyah
	display_name = "Тафья"
	path = /obj/item/clothing/head/taqiyah

/datum/gear/head/taqiyah/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/head/kitty
	display_name = "Ушки, кошачьи"
	path = /obj/item/clothing/head/kitty

/datum/gear/head/rabbit
	display_name = "Ушки, кроличьи"
	path = /obj/item/clothing/head/rabbitears

/datum/gear/head/beanie
	display_name = "Шапка"
	path = /obj/item/clothing/head/beanie

/datum/gear/head/beanie/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/head/loose_beanie
	display_name = "Шапка, свисающая"
	path = /obj/item/clothing/head/beanie_loose

/datum/gear/head/loose_beanie/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/head/beretg
	display_name = "Берет"
	path = /obj/item/clothing/head/beretg

/datum/gear/head/beretg/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/head/sombrero
	display_name = "Сомбреро"
	path = /obj/item/clothing/head/sombrero

/datum/gear/head/flatcapg
	display_name = "Плоская кепка (окрашиваемая)"
	path = /obj/item/clothing/head/flatcap/grey

/datum/gear/head/flatcapg/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/head/bow/small
	display_name = "Бантик (окрашиваемый)"
	path = /obj/item/clothing/head/pin/bow

/datum/gear/head/bow/small/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/head/welding/
	display_name = "Сварочная маска, обычная (Инж/Робототехник)"
	path = /obj/item/clothing/head/welding
	cost = 2
	allowed_roles = list("Chief Engineer","Station Engineer","Atmospheric Technician","Research Director","Roboticist")

/datum/gear/head/welding/demon
	display_name = "Сварочная маска, демон (Инж/Робототехник)"
	path = /obj/item/clothing/head/welding/demon

/datum/gear/head/welding/knight
	display_name = "Сварочная маска, рыцарь (Инж/Робототехник)"
	path = /obj/item/clothing/head/welding/knight

/datum/gear/head/welding/fancy
	display_name = "Сварочная маска, дорогая (Инж/Робототехник)"
	path = /obj/item/clothing/head/welding/fancy

/datum/gear/head/welding/engie
	display_name = "Сварочная маска, инженерная (Инж/Робототехник)"
	path = /obj/item/clothing/head/welding/engie

/datum/gear/head/beret/solgov
	display_name = "Берет, Сол (выбор)"
	path = /obj/item/clothing/head/beret/solgov

/datum/gear/head/beret/solgov/New()
	..()
	var/list/sols = list()
	for(var/sol_style in typesof(/obj/item/clothing/head/beret/solgov))
		var/obj/item/clothing/head/beret/solgov/sol = sol_style
		sols[initial(sol.name)] = sol
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(sols))

/datum/gear/head/surgery
	display_name = "Хирургическая шапочка (выбор)"
	description = "Ассортимент различных хирургических шапочек."
	path = /obj/item/clothing/head/surgery

/datum/gear/head/surgery/New()
	..()
	var/cap_type = list()
	cap_type["Фиолетовая шапочка"] = /obj/item/clothing/head/surgery/purple
	cap_type["Голубая шапочка"] = /obj/item/clothing/head/surgery/blue
	cap_type["Зеленая шапочка"] = /obj/item/clothing/head/surgery/green
	cap_type["Черная шапочка"] = /obj/item/clothing/head/surgery/black
	cap_type["Темно-синяя шапочка"] = /obj/item/clothing/head/surgery/navyblue
	gear_tweaks += new/datum/gear_tweak/path(cap_type)

/datum/gear/head/circuitry
	display_name = "Головной убор, программируемый (пустой)"
	path = /obj/item/clothing/head/circuitry

/datum/gear/head/maangtikka
	display_name = "Манг тикка"
	path = /obj/item/clothing/head/maangtikka

/datum/gear/head/jingasa
	display_name = "Дзингаса"
	path = /obj/item/clothing/head/jingasa

/datum/gear/head/sunflower_crown
	display_name = "Венок, подсолнечный"
	path = /obj/item/clothing/head/sunflower_crown

/datum/gear/head/lavender_crown
	display_name = "Венок, лавандовый"
	path = /obj/item/clothing/head/lavender_crown

/datum/gear/head/poppy_crown
	display_name = "Венок, маковый"
	path = /obj/item/clothing/head/poppy_crown

/datum/gear/head/rose_crown
	display_name = "Венок, розовый"
	path = /obj/item/clothing/head/rose_crown

/datum/gear/head/blackngoldheaddress
	display_name = "Тиара, черно-золотая"
	path = /obj/item/clothing/head/blackngoldheaddress

/datum/gear/head/plaguedoctor2
	display_name = "golden plague doctor's hat"
	path = /obj/item/clothing/head/plaguedoctorhat/gold