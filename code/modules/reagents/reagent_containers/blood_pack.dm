/obj/item/weapon/storage/box/bloodpacks
	name = "пакеты с кровью"
	desc = "В этой коробке находятся пакеты с кровью."
	icon_state = "sterile"

/obj/item/weapon/storage/box/bloodpacks/Initialize()
		. = ..()
		new /obj/item/weapon/reagent_containers/blood/empty(src)
		new /obj/item/weapon/reagent_containers/blood/empty(src)
		new /obj/item/weapon/reagent_containers/blood/empty(src)
		new /obj/item/weapon/reagent_containers/blood/empty(src)
		new /obj/item/weapon/reagent_containers/blood/empty(src)
		new /obj/item/weapon/reagent_containers/blood/empty(src)
		new /obj/item/weapon/reagent_containers/blood/empty(src)

/obj/item/weapon/reagent_containers/blood
	name = "IV пакет"
	var/base_name = " "
	desc = "Вмещает жидкости, используемые для переливания."
	var/base_desc = " "
	icon = 'icons/obj/bloodpack.dmi'
	icon_state = "empty"
	item_state = "bloodpack_empty"
	drop_sound = 'sound/items/drop/food.ogg'
	pickup_sound = 'sound/items/pickup/food.ogg'
	volume = 200
	var/label_text = ""

	var/blood_type = null
	var/reag_id = "blood"

/obj/item/weapon/reagent_containers/blood/Initialize()
	. = ..()
	base_name = name
	base_desc = desc
	if(blood_type != null)
		label_text = "[blood_type]"
		update_iv_label()
		reagents.add_reagent(reag_id, 200, list("donor"=null,"viruses"=null,"blood_DNA"=null,"blood_type"=blood_type,"resistances"=null,"trace_chem"=null))
		update_icon()

/obj/item/weapon/reagent_containers/blood/on_reagent_change()
	update_icon()

/obj/item/weapon/reagent_containers/blood/update_icon()
	var/percent = round((reagents.total_volume / volume) * 100)
	if(percent >= 0 && percent <= 9)
		icon_state = "empty"
		item_state = "bloodpack_empty"
	else if(percent >= 10 && percent <= 50)
		icon_state = "half"
		item_state = "bloodpack_half"
	else if(percent >= 51 && percent < INFINITY)
		icon_state = "full"
		item_state = "bloodpack_full"

/obj/item/weapon/reagent_containers/blood/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/pen) || istype(W, /obj/item/device/flashlight/pen))
		var/tmp_label = sanitizeSafe(input(user, "Введите ярлык для [name]", "Ярлык", label_text), MAX_NAME_LEN)
		if(length(tmp_label) > 50)
			to_chat(user, "<span class='notice'>Ярлык может содержать не более 50 символов.</span>")
		else if(length(tmp_label) > 10)
			to_chat(user, "<span class='notice'>Вы устанавливаете ярлычок.</span>")
			label_text = tmp_label
			update_iv_label()
		else
			to_chat(user, "<span class='notice'>Вы устанавливаете ярлычок \"[tmp_label]\".</span>")
			label_text = tmp_label
			update_iv_label()

/obj/item/weapon/reagent_containers/blood/proc/update_iv_label()
	if(label_text == "")
		name = base_name
	else if(length(label_text) > 10)
		var/short_label_text = copytext(label_text, 1, 11)
		name = "[base_name] ([short_label_text]...)"
	else
		name = "[base_name] ([label_text])"
	desc = "[base_desc] помечено как \"[label_text]\"."

/obj/item/weapon/reagent_containers/blood/APlus
	blood_type = "A+"

/obj/item/weapon/reagent_containers/blood/AMinus
	blood_type = "A-"

/obj/item/weapon/reagent_containers/blood/BPlus
	blood_type = "B+"

/obj/item/weapon/reagent_containers/blood/BMinus
	blood_type = "B-"

/obj/item/weapon/reagent_containers/blood/OPlus
	blood_type = "O+"

/obj/item/weapon/reagent_containers/blood/OMinus
	blood_type = "O-"

/obj/item/weapon/reagent_containers/blood/synthplas
	blood_type = "O-"
	reag_id = "synthblood_dilute"

/obj/item/weapon/reagent_containers/blood/synthblood
	blood_type = "O-"
	reag_id = "synthblood"

/obj/item/weapon/reagent_containers/blood/empty
	name = "Пустой пакет крови"
	desc = "Вроде бесполезно ... Но вроде как можно и заполнить?"
	icon_state = "empty"
	item_state = "bloodpack_empty"