/obj/item/clothing/under/vox
	has_sensor = 0
	species_restricted = list(SPECIES_VOX)
	starting_accessories = list(/obj/item/clothing/accessory/storage/vox)	// Dont' start with a backback, so free webbing
	flags = PHORONGUARD

/obj/item/clothing/under/vox/vox_casual
	name = "инопланетный наряд"
	desc = "На вид не очень удобно."
	icon_state = "vox-casual-1"
	item_state = "vox-casual-1"
	body_parts_covered = LEGS

/obj/item/clothing/under/vox/vox_robes
	name = "инопланетная роба"
	desc = "Странная и весьма приметная!"
	icon_state = "vox-casual-2"
	item_state = "vox-casual-2"

//Vox Accessories
/obj/item/clothing/accessory/storage/vox
	name = "инопланетные сети"
	desc = "Инопланетные сети. Изготовлены, кажется, из кармашков и дёргающейся плоти."
	icon_state = "webbing-vox"

	flags = PHORONGUARD

	slots = 3

/obj/item/clothing/accessory/storage/vox/Initialize()
	..()
	hold.max_storage_space = slots * ITEMSIZE_COST_NORMAL
	hold.max_w_class = ITEMSIZE_NORMAL