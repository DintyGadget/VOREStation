//copy pasta of the space piano, don't hurt me -Pete
/obj/item/device/instrument
	name = "generic instrument"
	var/datum/song/handheld/song
	var/instrumentId = "generic"
	var/instrumentExt = "mid"
	icon = 'icons/obj/musician.dmi'
	force = 10

/obj/item/device/instrument/New()
	..()
	song = new(instrumentId, src)
	song.instrumentExt = instrumentExt

/obj/item/device/instrument/Destroy()
	qdel(song)
	song = null
	..()

/obj/item/device/instrument/attack_self(mob/user as mob)
	if(!user.IsAdvancedToolUser())
		to_chat(user, "<span class='warning'>У вас не хватит ловкости, чтобы сделать это!</span>")
		return 1
	interact(user)

/obj/item/device/instrument/interact(mob/user as mob)
	if(!user)
		return

	if(user.incapacitated() || user.lying)
		return

	user.set_machine(src)
	song.interact(user)

/obj/item/device/instrument/violin
	name = "космическая скрипка"
	desc = "Деревянный музыкальный инструмент с четырьмя струнами и смычком. \"Дьявол спустился в космос, он искал помощника скорби.\""
	icon_state = "violin"
	attack_verb = list("smashed")
	instrumentId = "violin"
