/datum/gear/gloves/goldring
	display_name = "Свадебное кольцо, золотое"
	path = /obj/item/clothing/gloves/ring/wedding

/datum/gear/gloves/silverring
	display_name = "Свадебное кольцо, серебряное"
	path = /obj/item/clothing/gloves/ring/wedding/silver

/datum/gear/gloves/colored
	display_name = "Перчатки (окрашиваемые)"
	path = /obj/item/clothing/gloves/color

/datum/gear/gloves/colored/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice


/datum/gear/gloves/latex/colorable
	display_name = "Перчатки, латексные (окрашиваемые)"
	path = /obj/item/clothing/gloves/sterile/latex

/datum/gear/gloves/latex/colorable/New()
	..()
	gear_tweaks += gear_tweak_free_color_choice

/datum/gear/gloves/siren
	display_name = "Перчатки, футуристические"
	path = /obj/item/clothing/gloves/fluff/siren