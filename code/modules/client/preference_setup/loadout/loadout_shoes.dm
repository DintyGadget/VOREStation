// Shoelocker
/datum/gear/shoes
	display_name = "Сандали"
	path = /obj/item/clothing/shoes/sandal
	slot = slot_shoes
	sort_category = "Обувь"

/datum/gear/shoes/jackboots
	display_name = "Сапоги, военные"
	path = /obj/item/clothing/shoes/boots/jackboots

/datum/gear/shoes/kneeboots
	display_name = "Сапоги, военные по колени"
	path = /obj/item/clothing/shoes/boots/jackboots/knee

/datum/gear/shoes/thighboots
	display_name = "Сапоги, военные по бедра"
	path = /obj/item/clothing/shoes/boots/jackboots/thigh

/datum/gear/shoes/workboots
	display_name = "Ботинки, рабочие"
	path = /obj/item/clothing/shoes/boots/workboots

/datum/gear/shoes/workboots/toeless
	display_name = "Ботинки, рабочие, без пальцев"
	path = /obj/item/clothing/shoes/boots/workboots/toeless

/datum/gear/shoes/black
	display_name = "Кроссовки, черные"
	path = /obj/item/clothing/shoes/black

/datum/gear/shoes/blue
	display_name = "Кроссовки, синие"
	path = /obj/item/clothing/shoes/blue

/datum/gear/shoes/brown
	display_name = "Кроссовки, коричневые"
	path = /obj/item/clothing/shoes/brown

/datum/gear/shoes/lacey
	display_name = "Оксфорды (выбор)"
	path = /obj/item/clothing/shoes/laceup

/datum/gear/shoes/lacey/New()
    ..()
    var/list/laces = list()
    for(var/lace in typesof(/obj/item/clothing/shoes/laceup))
        var/obj/item/clothing/shoes/laceup/lace_type = lace
        laces[initial(lace_type.name)] = lace_type
    gear_tweaks += new/datum/gear_tweak/path(sortAssoc(laces))

/datum/gear/shoes/green
	display_name = "Кроссовки, зеленые"
	path = /obj/item/clothing/shoes/green

/datum/gear/shoes/orange
	display_name = "Кроссовки, оранжевые"
	path = /obj/item/clothing/shoes/orange

/datum/gear/shoes/purple
	display_name = "Кроссовки, фиолетовые"
	path = /obj/item/clothing/shoes/purple

/datum/gear/shoes/rainbow
	display_name = "Кроссовки, радужные"
	path = /obj/item/clothing/shoes/rainbow

/datum/gear/shoes/red
	display_name = "Кроссовки, красные"
	path = /obj/item/clothing/shoes/red

/datum/gear/shoes/white
	display_name = "Кроссовки, белые"
	path = /obj/item/clothing/shoes/white

/datum/gear/shoes/yellow
	display_name = "Кроссовки, желтые"
	path = /obj/item/clothing/shoes/yellow

/datum/gear/shoes/hitops/
	display_name = "Охотничьи ботинки (выбор)"
	path = /obj/item/clothing/shoes/hitops/

/datum/gear/shoes/hitops/New()
    ..()
    var/list/hitops = list()
    for(var/hitop in typesof(/obj/item/clothing/shoes/hitops))
        var/obj/item/clothing/shoes/hitops/hitop_type = hitop
        hitops[initial(hitop_type.name)] = hitop_type
    gear_tweaks += new/datum/gear_tweak/path(sortAssoc(hitops))

/datum/gear/shoes/flipflops
	display_name = "Шлёпанцы"
	path = /obj/item/clothing/shoes/flipflop

/datum/gear/shoes/flipflops/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/shoes/athletic
	display_name = "Кеды, спортивные"
	path = /obj/item/clothing/shoes/athletic

/datum/gear/shoes/athletic/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/shoes/skater
	display_name = "Кеды, скейтерские"
	path = /obj/item/clothing/shoes/skater

/datum/gear/shoes/skater/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/shoes/flats
	display_name = "Балетки"
	path = /obj/item/clothing/shoes/flats/white/color

/datum/gear/shoes/flats/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/shoes/cowboy
	display_name = "Сапоги ковбойские"
	path = /obj/item/clothing/shoes/boots/cowboy

/datum/gear/shoes/cowboy/classic
	display_name = "Сапоги ковбойские, классические"
	path = /obj/item/clothing/shoes/boots/cowboy/classic

/datum/gear/shoes/cowboy/snakeskin
	display_name = "Сапоги ковбойские, змеиная кожа"
	path = /obj/item/clothing/shoes/boots/cowboy/snakeskin

/datum/gear/shoes/jungle
	display_name = "Ботинки, для джунглей"
	path = /obj/item/clothing/shoes/boots/jungle
	cost = 2

/datum/gear/shoes/duty
	display_name = "Ботинки, служебные"
	path = 	/obj/item/clothing/shoes/boots/duty
	cost = 2

/datum/gear/shoes/dress
	display_name = "Кожаные туфли"
	path = 	/obj/item/clothing/shoes/dress

/datum/gear/shoes/dress/white
	display_name = "Кожаные туфли, белые"
	path = 	/obj/item/clothing/shoes/dress/white

/datum/gear/shoes/heels
	display_name = "Каблуки"
	path = /obj/item/clothing/shoes/heels

/datum/gear/shoes/heels/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/shoes/slippers
	display_name = "Тапочки"
	path = /obj/item/clothing/shoes/slippers

/datum/gear/shoes/boots/winter
	display_name = "Зимние ботинки"
	path = /obj/item/clothing/shoes/boots/winter

/datum/gear/shoes/boots/winter/security
	display_name = "Зимние ботинки (СБ)"
	path = /obj/item/clothing/shoes/boots/winter/security
	allowed_roles = list("Офицер безопасности", "Глава службы безопасности", "Надзиратель", "Детектив")

/datum/gear/shoes/boots/winter/science
	display_name = "Зимние ботинки (Учёный)"
	path = /obj/item/clothing/shoes/boots/winter/science

/datum/gear/shoes/boots/winter/command
	display_name = "Зимние ботинки (ДК)"
	path = /obj/item/clothing/shoes/boots/winter/command
	allowed_roles = list("Директор колонии")

/datum/gear/shoes/boots/winter/engineering
	display_name = "Зимние ботинки инженера"
	path = /obj/item/clothing/shoes/boots/winter/engineering

/datum/gear/shoes/boots/winter/atmos
	display_name = "Зимние ботинки атмосферщика"
	path = /obj/item/clothing/shoes/boots/winter/atmos

/datum/gear/shoes/boots/winter/medical
	display_name = "Зимние ботинки медика"
	path = /obj/item/clothing/shoes/boots/winter/medical

/datum/gear/shoes/boots/winter/mining
	display_name = "Зимние ботинки шахтера"
	path = /obj/item/clothing/shoes/boots/winter/mining

/datum/gear/shoes/boots/winter/supply
	display_name = "Зимние ботинки карго"
	path = /obj/item/clothing/shoes/boots/winter/supply

/datum/gear/shoes/boots/winter/hydro
	display_name = "Зимние ботинки ботаника"
	path = /obj/item/clothing/shoes/boots/winter/hydro

/datum/gear/shoes/circuitry
	display_name = "Ботинки, программируемые (пустые)"
	path = /obj/item/clothing/shoes/circuitry
