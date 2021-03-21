// Gloves
/datum/gear/gloves
	display_name = "Перчатки, черные"
	path = /obj/item/clothing/gloves/black
	cost = 1
	slot = slot_gloves
	sort_category = "Перчатки"

/datum/gear/gloves/blue
	display_name = "Перчатки, синие"
	path = /obj/item/clothing/gloves/blue

/datum/gear/gloves/brown
	display_name = "Перчатки, коричневые"
	path = /obj/item/clothing/gloves/brown

/datum/gear/gloves/light_brown
	display_name = "Перчатки, светло-коричневые"
	path = /obj/item/clothing/gloves/light_brown

/datum/gear/gloves/green
	display_name = "Перчатки, зеленые"
	path = /obj/item/clothing/gloves/green

/datum/gear/gloves/grey
	display_name = "Перчатки, серые"
	path = /obj/item/clothing/gloves/grey

/datum/gear/gloves/latex
	display_name = "Перчатки, латексные"
	path = /obj/item/clothing/gloves/sterile/latex
	cost = 2

/datum/gear/gloves/nitrile
	display_name = "Перчатки, нитриловые"
	path = /obj/item/clothing/gloves/sterile/nitrile
	cost = 2

/datum/gear/gloves/orange
	display_name = "Перчатки, оранжевые"
	path = /obj/item/clothing/gloves/orange

/datum/gear/gloves/purple
	display_name = "Перчатки, фиолетовые"
	path = /obj/item/clothing/gloves/purple

/datum/gear/gloves/rainbow
	display_name = "Перчатки, радужные"
	path = /obj/item/clothing/gloves/rainbow

/datum/gear/gloves/red
	display_name = "Перчатки, красные"
	path = /obj/item/clothing/gloves/red

/datum/gear/gloves/white
	display_name = "Перчатки, белые"
	path = /obj/item/clothing/gloves/white

/datum/gear/gloves/evening
	display_name = "Перчатки, вечерние"
	path = /obj/item/clothing/gloves/evening

/datum/gear/gloves/evening/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/gloves/duty
	display_name = "Перчатки, рабочие"
	path = /obj/item/clothing/gloves/duty
	cost = 3

/datum/gear/gloves/forensic
	display_name = "Детектив: Перчатки криминалиста"
	path = /obj/item/clothing/gloves/forensic
	allowed_roles = list("Детектив")

/datum/gear/gloves/fingerless
	display_name = "Перчатки, без пальцев"
	path = /obj/item/clothing/gloves/fingerless

/datum/gear/gloves/ring
	display_name = "Кольцо (выбор)"
	description = "Ассортимент различных колец."
	path = /obj/item/clothing/gloves/ring
	cost = 1

/datum/gear/gloves/ring/New()
	..()
	var/ringtype = list()
	ringtype["Кольцо CTI"] = /obj/item/clothing/gloves/ring/cti
	ringtype["Кольцо Mariner University"] = /obj/item/clothing/gloves/ring/mariner
	ringtype["Обручальное кольцо"] = /obj/item/clothing/gloves/ring/engagement
	ringtype["Кольцо-печатка"] = /obj/item/clothing/gloves/ring/seal/signet
	ringtype["Масонское кольцо"] = /obj/item/clothing/gloves/ring/seal/mason
	ringtype["Кольцо, сталь"] = /obj/item/clothing/gloves/ring/material/steel
	ringtype["Кольцо, железо"] = /obj/item/clothing/gloves/ring/material/iron
	ringtype["Кольцо, серебро"] = /obj/item/clothing/gloves/ring/material/silver
	ringtype["Кольцо, золото"] = /obj/item/clothing/gloves/ring/material/gold
	ringtype["Кольцо, платина"] = /obj/item/clothing/gloves/ring/material/platinum
	ringtype["Кольцо, стекло"] = /obj/item/clothing/gloves/ring/material/glass
	ringtype["Кольцо, дерево"] = /obj/item/clothing/gloves/ring/material/wood
	ringtype["Кольцо, пластик"] = /obj/item/clothing/gloves/ring/material/plastic
	gear_tweaks += new/datum/gear_tweak/path(ringtype)

/datum/gear/gloves/circuitry
	display_name = "Перчатки, программируемые (пустые)"
	path = /obj/item/clothing/gloves/circuitry