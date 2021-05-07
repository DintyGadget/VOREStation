//For synths who have no hands.
/obj/item/device/communicator/integrated
	name = "интегрированный коммуникатор"
	desc = "Схема, используемая для дальней связи, способная быть интегрированной в систему."

//A stupid hack because synths don't use languages properly or something.
//I don't want to go digging in saycode for a week, so BS it as translation software or something.

// Proc: open_connection_to_ghost()
// Parameters: 2 (refer to base definition for arguments)
// Description: Synths don't use languages properly, so this is a bandaid fix until that can be resolved..
/obj/item/device/communicator/integrated/open_connection_to_ghost(user, candidate)
	..(user, candidate)
	spawn(1)
		for(var/mob/living/voice/V in contents)
			V.universal_speak = 1
			V.universal_understand = 1

// Verb: activate()
// Parameters: None
// Description: Lets synths use their communicators without hands.
/obj/item/device/communicator/integrated/verb/activate()
	set category = "AI IM"
	set name = "Use Communicator"
	set desc = "Utilizes your built-in communicator."
	set src in usr

	if(usr.stat == 2)
		to_chat(usr, "You can't do that because you are dead!")
		return

	src.attack_self(usr)