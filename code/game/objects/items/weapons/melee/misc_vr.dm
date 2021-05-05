/obj/item/weapon/melee/rapier
	name = "рапира"
	desc = "Блестящее стальное лезвие с золотым цевьем, инкрустированным выдающимся красным камнем."
	icon = 'icons/obj/weapons_vr.dmi'
	icon_state = "rapier"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_melee_vr.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_melee_vr.dmi',
		)
	force = 15
	throwforce = 10
	w_class = ITEMSIZE_NORMAL
	sharp = 1
	edge = 0
	attack_verb = list("stabbed", "lunged at", "dextrously struck", "sliced", "lacerated", "impaled", "diced", "charioted")
	hitsound = 'sound/weapons/bladeslice.ogg'