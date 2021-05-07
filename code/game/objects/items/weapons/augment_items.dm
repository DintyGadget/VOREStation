// **For augment items that aren't subtypes of other things.**

/obj/item/weapon/melee/augment
	name = "integrated item"
	desc = "A surprisingly non-descript item, integrated into its user. You probably shouldn't be seeing this."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "augment_box"


/obj/item/weapon/melee/augment/blade
	name = "ручное лезвие"
	desc = "Элегантное телескопическое лезвие, которое легко помещается в руке. Излюбленный специалистами по проникновению и убийцами."
	icon_state = "augment_handblade"
	item_icons = list(
			slot_l_hand_str = 'icons/mob/items/lefthand_melee.dmi',
			slot_r_hand_str = 'icons/mob/items/righthand_melee.dmi',
			)
	w_class = ITEMSIZE_SMALL
	force = 15
	armor_penetration = 25
	sharp = 1
	attack_verb = list("атакует", "режет", "зарезает", "нарезает", "разрывает", "нарезает кубиками", "режет")
	defend_chance = 10
	projectile_parry_chance = 5
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/weapon/melee/augment/blade/arm
	name = "рука лезвие"
	desc = "Гладкий кибернетический клинок, пронзающий людей, как масло. Излюбленный психопатами и убийцами."
	icon_state = "augment_armblade"
	w_class = ITEMSIZE_HUGE
	force = 30
	armor_penetration = 15
	edge = 1
	pry = 1
	defend_chance = 40
	projectile_parry_chance = 20