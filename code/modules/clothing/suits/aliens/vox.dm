/obj/item/clothing/suit/armor/vox_scrap
	name = "Ржавая металлическая броня"
	desc = "Куча из различных кусков металла, представляющая собой подобие брони воксов."
	allowed = list(/obj/item/weapon/gun, /obj/item/weapon/tank)
	armor = list(melee = 60, bullet = 30, laser = 30,energy = 5, bomb = 40, bio = 0, rad = 0) //Higher melee armor versus lower everything else.
	icon_state = "vox-scrap"
	icon_state = "vox-scrap"
	body_parts_covered = UPPER_TORSO|ARMS|LOWER_TORSO|LEGS
	species_restricted = list(SPECIES_VOX)
	siemens_coefficient = 1 //Its literally metal