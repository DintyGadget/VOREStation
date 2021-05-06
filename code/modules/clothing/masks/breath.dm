/obj/item/clothing/mask/breath
	desc = "Плотно прилегающая маска, которую можно подключить к источнику воздуха."
	name = "дыхательная маска"
	icon_state = "breath"
	item_state_slots = list(slot_r_hand_str = "breath", slot_l_hand_str = "breath")
	item_flags = AIRTIGHT|FLEXIBLEMATERIAL
	body_parts_covered = FACE
	w_class = ITEMSIZE_SMALL
	gas_transfer_coefficient = 0.10
	permeability_coefficient = 0.50
	var/hanging = 0
	action_button_name = "Adjust Breath Mask"
	pickup_sound = 'sound/items/pickup/component.ogg'
	drop_sound = 'sound/items/drop/component.ogg'


/obj/item/clothing/mask/breath/proc/adjust_mask(mob/user)
	if(user.canmove && !user.stat)
		src.hanging = !src.hanging
		if (src.hanging)
			gas_transfer_coefficient = 1
			body_parts_covered = body_parts_covered & ~FACE
			item_flags = item_flags & ~AIRTIGHT
			icon_state = "breathdown"
			to_chat(user, "Ваша маска теперь висит у вас на шее.")
		else
			gas_transfer_coefficient = initial(gas_transfer_coefficient)
			body_parts_covered = initial(body_parts_covered)
			item_flags = initial(item_flags)
			icon_state = initial(icon_state)
			to_chat(user, "Вы натягиваете маску, чтобы закрыть лицо.")
		update_clothing_icon()

/obj/item/clothing/mask/breath/attack_self(mob/user)
	adjust_mask(user)

/obj/item/clothing/mask/breath/verb/toggle()
		set category = "Object"
		set name = "Настроить маску"
		set src in usr

		adjust_mask(usr)

/obj/item/clothing/mask/breath/medical
	desc = "Плотно прилегающая стерильная маска, которую можно подключить к источнику воздуха."
	name = "медицинская маска"
	icon_state = "medical"
	item_state_slots = list(slot_r_hand_str = "medical", slot_l_hand_str = "medical")
	permeability_coefficient = 0.01

/obj/item/clothing/mask/breath/emergency
	desc = "A close-fitting  mask that is used by the wallmounted emergency oxygen pump."
	name = "emergency mask"
	icon_state = "breath"
	item_state = "breath"
	permeability_coefficient = 0.50

/obj/item/clothing/mask/breath/anesthetic
	desc = "A close-fitting sterile mask that is used by the anesthetic wallmounted pump."
	name = "anesthetic mask"
	icon_state = "medical"
	item_state = "medical"
	permeability_coefficient = 0.01
