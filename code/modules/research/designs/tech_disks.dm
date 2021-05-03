/datum/design/item/disk/AssembleDesignName()
	..()
	name = "Data storage design ([name])"

/datum/design/item/disk/design_disk
	name = "Design Storage Disk"
	desc = "Изготовить дополнительные диски для хранения конструкций устройств."
	id = "design_disk"
	req_tech = list(TECH_DATA = 1)
	materials = list(DEFAULT_WALL_MATERIAL = 30, "glass" = 10)
	build_path = /obj/item/weapon/disk/design_disk
	sort_string = "CAAAA"

/datum/design/item/disk/tech_disk
	name = "Technology Data Storage Disk"
	desc = "Изготовить дополнительные диски для хранения технологических данных."
	id = "tech_disk"
	req_tech = list(TECH_DATA = 1)
	materials = list(DEFAULT_WALL_MATERIAL = 30, "glass" = 10)
	build_path = /obj/item/weapon/disk/tech_disk
	sort_string = "CAAAB"