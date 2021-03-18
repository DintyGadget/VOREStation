/obj/item/weapon/storage/briefcase
	name = "чемодан"
	desc = "Сделан из САМОЙ НАСТОЯЩЕЙ искусственной кожи, и на ручке всё ещё висит ценни. Владелец, должно быть, самый настоящий профессионал."
	icon_state = "briefcase"
	force = 8.0
	throw_speed = 1
	throw_range = 4
	w_class = ITEMSIZE_LARGE
	max_w_class = ITEMSIZE_NORMAL
	max_storage_space = ITEMSIZE_COST_NORMAL * 4
	use_sound = 'sound/items/storage/briefcase.ogg'
	drop_sound = 'sound/items/drop/backpack.ogg'
	pickup_sound = 'sound/items/pickup/backpack.ogg'

/obj/item/weapon/storage/briefcase/clutch
	name = "клатч"
	desc = "Стильная женская сумочка."
	icon_state = "clutch"
	item_state_slots = list(slot_r_hand_str = "smpurse", slot_l_hand_str = "smpurse")
	force = 0
	w_class = ITEMSIZE_NORMAL
	max_w_class = ITEMSIZE_SMALL
	max_storage_space = ITEMSIZE_COST_SMALL * 4