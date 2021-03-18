/obj/item/weapon/storage/toolbox/lunchbox/survival
	name = "походный ланчбокс"
	icon = 'icons/obj/storage_vr.dmi'
	icon_state = "lunchbox_survival"
	item_state_slots = list(slot_r_hand_str = "toolbox_syndi", slot_l_hand_str = "toolbox_syndi")
	desc = "Небольшой ланчбокс. Этот значительно прочнее остальных ланчбоксов, так как изготовлен из прочной стали!"
	max_storage_space = ITEMSIZE_COST_SMALL * 6

/obj/item/weapon/storage/toolbox/lunchbox/survival/zaddat
	starts_with = list(/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/glucose = 6)