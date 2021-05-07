/* Cards
 * Contains:
 *		DATA CARD
 *		ID CARD
 *		FINGERPRINT CARD HOLDER
 *		FINGERPRINT CARD
 */



/*
 * DATA CARDS - Used for the teleporter
 */
/obj/item/weapon/card
	name = "карта"
	desc = "Занимается карточными делами."
	icon = 'icons/obj/card_new.dmi'
	w_class = ITEMSIZE_TINY
	slot_flags = SLOT_EARS
	var/associated_account_number = 0

	var/list/initial_sprite_stack = list("")
	var/base_icon = 'icons/obj/card_new.dmi'
	var/list/sprite_stack

	var/list/files = list(  )
	drop_sound = 'sound/items/drop/card.ogg'
	pickup_sound = 'sound/items/pickup/card.ogg'

/obj/item/weapon/card/New()
	. = ..()
	reset_icon()

/obj/item/weapon/card/proc/reset_icon()
	sprite_stack = initial_sprite_stack
	update_icon()

/obj/item/weapon/card/update_icon()
	if(!sprite_stack || !istype(sprite_stack) || sprite_stack == list(""))
		icon = base_icon
		icon_state = initial(icon_state)

	var/icon/I = null
	for(var/iconstate in sprite_stack)
		if(!iconstate)
			iconstate = icon_state
		if(I)
			var/icon/IC = new(base_icon, iconstate)
			I.Blend(IC, ICON_OVERLAY)
		else
			I = new/icon(base_icon, iconstate)
	if(I)
		icon = I

/obj/item/weapon/card/data
	name = "карта памяти"
	desc = "Твердотельная карта памяти, используемая для резервного копирования или передачи информации. Какие знания он мог содержать?"
	icon_state = "data"
	var/function = "storage"
	var/data = "null"
	var/special = null
	item_state = "card-id"
	drop_sound = 'sound/items/drop/disk.ogg'
	pickup_sound = 'sound/items/pickup/disk.ogg'

/obj/item/weapon/card/data/verb/label(t as text)
	set name = "Этикетка карты"
	set category = "Object"
	set src in usr

	if (t)
		src.name = text("карта памяти- '[]'", t)
	else
		src.name = "карта памяти"
	src.add_fingerprint(usr)
	return

/obj/item/weapon/card/data/clown
	name = "\proper the coordinates to clown planet"
	icon_state = "rainbow"
	item_state = "card-id"
	level = 2
	desc = "На этой карте указаны координаты легендарной планеты Клоун. Обращаться осторожно."
	function = "teleporter"
	data = "Clown Land"

/*
 * ID CARDS
 */

/obj/item/weapon/card/emag_broken
	desc = "Это карта с магнитной полосой, прикрепленной к какой-то схеме. Выглядит слишком разрушенной, чтобы её можно было использовать ни для чего, кроме спасения."
	name = "broken cryptographic sequencer"
	icon_state = "emag-spent"
	item_state = "card-id"
	origin_tech = list(TECH_MAGNET = 2, TECH_ILLEGAL = 2)

/obj/item/weapon/card/emag
	desc = "Это карта с магнитной полосой, прикрепленной к какой-то схеме."
	name = "cryptographic sequencer"
	icon_state = "emag"
	item_state = "card-id"
	origin_tech = list(TECH_MAGNET = 2, TECH_ILLEGAL = 2)
	var/uses = 10

/obj/item/weapon/card/emag/resolve_attackby(atom/A, mob/user, var/click_parameters)
	var/used_uses = A.emag_act(uses, user, src)
	if(used_uses < 0)
		return ..(A, user, click_parameters)

	uses -= used_uses
	A.add_fingerprint(user)
	//Vorestation Edit: Because some things (read lift doors) don't get emagged
	if(used_uses)
		log_and_message_admins("emagged \an [A].")
	else
		log_and_message_admins("attempted to emag \an [A].")
	// Vorestation Edit: End of Edit
	log_and_message_admins("emagged \an [A].")

	if(uses<1)
		user.visible_message("<span class='warning'>[src] шипит и вспыхивает - кажется, когда-то его использовали слишком часто, а теперь он потрачен.</span>")
		user.drop_item()
		var/obj/item/weapon/card/emag_broken/junk = new(user.loc)
		junk.add_fingerprint(user)
		qdel(src)

	return 1

/obj/item/weapon/card/emag/attackby(obj/item/O as obj, mob/user as mob)
	if(istype(O, /obj/item/stack/telecrystal))
		var/obj/item/stack/telecrystal/T = O
		if(T.amount < 1)
			to_chat(usr, "<span class='notice'>Вы не добавляете достаточно телекристаллов для подпитки [src].</span>")
			return
		uses += T.amount/2 //Gives 5 uses per 10 TC
		uses = CEILING(uses, 1) //Ensures no decimal uses nonsense, rounds up to be nice
		to_chat(usr, "<span class='notice'>Вы добавляете [O] в [src]. Увеличение использования [src] до [uses].</span>")
		qdel(O)
