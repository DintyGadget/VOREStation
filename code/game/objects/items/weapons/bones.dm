//These bone objects are mostly for mapping and decoration. They have no actual medical use, so maybe don't try to put them in anybody.
/obj/item/weapon/bone
	name = "кость"
	desc = "Неописуемая кость. Она такая старая и изношенная, что едва ли можно сказать, из какой части тела она сделана."
	icon = 'icons/obj/bones.dmi'
	icon_state = "bone"
	force = 5
	throwforce = 6
	item_state = "bone"
	w_class = ITEMSIZE_SMALL
	attack_verb = list("attacked", "bashed", "battered", "bludgeoned", "whacked", "bonked", "boned")

/obj/item/weapon/bone/skull
	name = "череп"
	desc = "Череп. Судя по форме и размеру, можно было предположить, что это человек."
	icon_state = "skull"
	throwforce = 7

/obj/item/weapon/bone/skull/tajaran
	desc = "Череп. Судя по форме и размеру, можно было предположить, что это таяра."
	icon_state = "tajskull"

/obj/item/weapon/bone/skull/unathi
	desc = "Череп. Судя по форме и размеру, можно было предположить, что это унати."
	icon_state = "unaskull"

/obj/item/weapon/bone/skull/unknown
	desc = "Череп. Однако вы не уверены, что это за вид."
	icon_state = "xenoskull"

/obj/item/weapon/bone/arm
	name = "кость руки"
	desc = "Вооружившись этим, вы вооружены и опасны, без всяких сомнений."
	attack_verb = list("attacked", "bashed", "battered", "bludgeoned", "whacked", "bonked", "boned", "slapped", "punched")
	icon_state = "arm"

/obj/item/weapon/bone/leg
	name = "кость ноги"
	desc = "Не беспокойтесь о том, чтобы спорить с владельцем этого. У них нет ноги, на которой можно стоять."
	attack_verb = list("attacked", "bashed", "battered", "bludgeoned", "whacked", "bonked", "boned", "kicked")
	icon_state = "leg"

/obj/item/weapon/bone/ribs
	name = "грудная клетка"
	desc = "Если бы у вас были молотки, вы, вероятно, могли бы использовать их как импровизированный ксилофон."
	icon_state = "ribs"
