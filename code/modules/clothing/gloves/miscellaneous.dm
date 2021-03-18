/obj/item/clothing/gloves/captain
	desc = "Роскошные синие перчатки с золотыми краями. Красотища."
	name = "Перчатки Директора колонии"
	icon_state = "captain"
	item_state_slots = list(slot_r_hand_str = "blue", slot_l_hand_str = "blue")

/obj/item/clothing/gloves/cyborg
	desc = "бип-буп"
	name = "Перчатки киборга"
	icon_state = "black"
	item_state = "r_hands"
	siemens_coefficient = 1.0

/obj/item/clothing/gloves/forensic
	desc = "Перчатки, предназначенные специально для криминалистов. Люминесцентные нитки вшиты в основной материал."
	name = "Перчатки криминалиста"
	icon_state = "forensic"
	item_state = "black"
	permeability_coefficient = 0.05

	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/swat
	desc = "Боевые перчатки, частично защищающие от огня и ударов."
	name = "Перчатки СОБР"
	icon_state = "swat"
	item_state = "swat"
	siemens_coefficient = 0.50
	permeability_coefficient = 0.05
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/combat //Combined effect of SWAT gloves and insulated gloves
	desc = "Боевые перчатки, частично защищающие от огня и ударов."
	name = "Боевые перчатки"
	icon_state = "swat"
	item_state = "swat"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/sterile
	name = "стерильные перчатки"
	desc = "Стерильные перчатки."
	icon_state = "latex"
	item_state_slots = list(slot_r_hand_str = "white", slot_l_hand_str = "white")
	siemens_coefficient = 1.0 //thin latex gloves, much more conductive than fabric gloves (basically a capacitor for AC)
	permeability_coefficient = 0.01
	germ_level = 0
	fingerprint_chance = 25
	drop_sound = 'sound/items/drop/rubber.ogg'
	pickup_sound = 'sound/items/pickup/rubber.ogg'
//	var/balloonPath = /obj/item/latexballon

//TODO: Make inflating gloves a thing
/*/obj/item/clothing/gloves/sterile/proc/Inflate(/mob/living/carbon/human/user)
	user.visible_message("<span class='notice'>\The [src] expands!</span>")
	qdel(src)*/

/obj/item/clothing/gloves/sterile/latex
	name = "Латексные перчатки"
	desc = "Стерильные латексные перчатки."

/obj/item/clothing/gloves/sterile/nitrile
	name = "Нитриловые перчатки"
	desc = "Стерильные нитриловые перчатки."
	icon_state = "nitrile"
	item_state = "ngloves"
//	balloonPath = /obj/item/nitrileballoon

/obj/item/clothing/gloves/botanic_leather
	desc = "Эти кожаные перчатки защищают от шипов и прочих вредоносных объектов растительного происхождения."
	name = "Кожаные перчатки ботаника"
	icon_state = "leather"
	item_state_slots = list(slot_r_hand_str = "lightbrown", slot_l_hand_str = "lightbrown")
	permeability_coefficient = 0.05
	siemens_coefficient = 0.75 //thick work gloves
	drop_sound = 'sound/items/drop/leather.ogg'
	pickup_sound = 'sound/items/pickup/leather.ogg'

/obj/item/clothing/gloves/duty
	desc = "Эти коричневые рабочие перчатки изготовлены из прочного синтетического материала."
	name = "Рабочие перчатки"
	icon_state = "work"
	item_state = "wgloves"
	armor = list(melee = 10, bullet = 10, laser = 10, energy = 5, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/gloves/tactical
	desc = "Эти коричневые боевые перчатки изготовлены из прочного синтетического материала и имеют упрочненные костяшки."
	name = "Защитные рабочие перчатки"
	icon_state = "work"
	item_state = "wgloves"
	force = 5
	punch_force = 3
	siemens_coefficient = 0.75
	permeability_coefficient = 0.05
	armor = list(melee = 30, bullet = 10, laser = 10, energy = 15, bomb = 20, bio = 0, rad = 0)

/obj/item/clothing/gloves/vox
	desc = "Эти странные наручи, кажется, хорошо сядут на... птичьи когти?"
	name = "Изолирующие рукавицы"
	icon_state = "gloves-vox"
	item_state = "gloves-vox"
	flags = PHORONGUARD
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	species_restricted = list("Вокс")
	drop_sound = 'sound/items/drop/metalboots.ogg'
	pickup_sound = 'sound/items/pickup/toolbox.ogg'

	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/knuckledusters
	name = "Кастеты"
	desc = "Пара латунных кастетов, усиливающих удары носителя."
	icon_state = "knuckledusters"
	matter = list(DEFAULT_WALL_MATERIAL = 500)
	attack_verb = list("ударяет", "стукает", "врезает")
	flags = THICKMATERIAL	// Stops rings from increasing hit strength
	siemens_coefficient = 1
	fingerprint_chance = 100
	overgloves = 1
	force = 5
	punch_force = 5
	drop_sound = 'sound/items/drop/metalboots.ogg'
	pickup_sound = 'sound/items/pickup/toolbox.ogg'

/obj/item/clothing/gloves/ranger
	var/glovecolor = "white"
	name = "Перчатки рейнджера"
	desc = "Перчатки Рейнджеров - самая незапоминающаяся часть их внешнего вида. В сериале они даже не изолирующие, \
	чтобы детям не хотелось разбирать всякие тостеры без необходимых мер предосторожности. Они нужны лишь для завершения стильного костюма."
	icon = 'icons/obj/clothing/ranger.dmi'
	icon_state = "ranger_gloves"

/obj/item/clothing/gloves/ranger/Initialize()
	. = ..()
	if(icon_state == "ranger_gloves")
		icon_state = "[glovecolor]_ranger_gloves"

/obj/item/clothing/gloves/ranger/black
	glovecolor = "black"

/obj/item/clothing/gloves/ranger/pink
	glovecolor = "pink"

/obj/item/clothing/gloves/ranger/green
	glovecolor = "green"

/obj/item/clothing/gloves/ranger/cyan
	glovecolor = "cyan"

/obj/item/clothing/gloves/ranger/orange
	glovecolor = "orange"

/obj/item/clothing/gloves/ranger/yellow
	glovecolor = "yellow"