// Stuff worn on the ears. Items here go in the "ears" sort_category but they must not use
// the slot_r_ear or slot_l_ear as the slot, or else players will spawn with no headset.
/datum/gear/ears
	display_name = "Наушники, защитные"
	path = /obj/item/clothing/ears/earmuffs
	sort_category = "Уши"

/datum/gear/ears/headphones
	display_name = "Наушники"
	path = /obj/item/clothing/ears/earmuffs/headphones

/datum/gear/ears/circuitry
	display_name = "Программируемый наушник (пустой)"
	path = /obj/item/clothing/ears/circuitry


/datum/gear/ears/earrings
	display_name = "Серьги (выбор)"
	description = "Ассортимент стильных серёжек."
	path = /obj/item/clothing/ears/earring

/datum/gear/ears/earrings/New()
	..()
	var/earrings = list()
	earrings["Гвоздики, жемчуг"] = /obj/item/clothing/ears/earring/stud
	earrings["Гвоздики, стекло"] = /obj/item/clothing/ears/earring/stud/glass
	earrings["Гвоздики, дерево"] = /obj/item/clothing/ears/earring/stud/wood
	earrings["Гвоздики, железо"] = /obj/item/clothing/ears/earring/stud/iron
	earrings["Гвоздики, сталь"] = /obj/item/clothing/ears/earring/stud/steel
	earrings["Гвоздики, серебро"] = /obj/item/clothing/ears/earring/stud/silver
	earrings["Гвоздики, золото"] = /obj/item/clothing/ears/earring/stud/gold
	earrings["Гвоздики, платина"] = /obj/item/clothing/ears/earring/stud/platinum
	earrings["Гвоздики, алмаз"] = /obj/item/clothing/ears/earring/stud/diamond
	earrings["Висячие, стекло"] = /obj/item/clothing/ears/earring/dangle/glass
	earrings["Висячие, дерево"] = /obj/item/clothing/ears/earring/dangle/wood
	earrings["Висячие, железо"] = /obj/item/clothing/ears/earring/dangle/iron
	earrings["Висячие, сталь"] = /obj/item/clothing/ears/earring/dangle/steel
	earrings["Висячие, серебро"] = /obj/item/clothing/ears/earring/dangle/silver
	earrings["Висячие, золото"] = /obj/item/clothing/ears/earring/dangle/gold
	earrings["Висячие, платина"] = /obj/item/clothing/ears/earring/dangle/platinum
	earrings["Висячие, бриллиант"] = /obj/item/clothing/ears/earring/dangle/diamond
	gear_tweaks += new/datum/gear_tweak/path(earrings)
