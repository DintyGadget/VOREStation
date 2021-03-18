/obj/item/organ/internal/intestine
	name = "intestine"
	icon_state = "intestine"
	organ_tag = O_INTESTINE
	parent_organ = BP_GROIN

/obj/item/organ/internal/intestine/handle_germ_effects()
	. = ..() //Up should return an infection level as an integer
	if(!.) return

	//Viral Gastroenteritis
	if (. >= 1)
		if(prob(1))
			owner.custom_pain("Ваш живот скручивает от боли!",1)
			owner.vomit()
	if (. >= 2)
		if(prob(1))
			owner.custom_pain("Ваш живот словно разрывается на части!",1)
			owner.m_intent = "walk"
			owner.hud_used.move_intent.icon_state = "walking"

/obj/item/organ/internal/intestine/xeno
	color = "#555555"
