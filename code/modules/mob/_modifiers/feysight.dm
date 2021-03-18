/datum/modifier/feysight
	name = "feysight"
	desc = "Вы наполнены внутренним покоем и расширили зрение."
	client_color = "#42e6ca"

	on_created_text = "<span class='alien'>Вы чувствуете внутренний покой, когда ваш мысленный взор расширяется!</span>"
	on_expired_text = "<span class='notice'>Ваше зрение возвращается к тому, что было раньше.</span>"
	stacks = MODIFIER_STACK_EXTEND

	accuracy = -15
	accuracy_dispersion = 1

/datum/modifier/feysight/on_applied()
	holder.see_invisible = 60
	holder.see_invisible_default = 60

/datum/modifier/feysight/on_expire()
	holder.see_invisible_default = initial(holder.see_invisible_default)
	holder.see_invisible = holder.see_invisible_default

/datum/modifier/feysight/can_apply(var/mob/living/L)
	if(L.stat)
		to_chat(L, "<span class='warning'>Вы не можете быть без сознания или мертвым, чтобы испытать спокойствие.</span>")
		return FALSE

	if(!L.is_sentient())
		return FALSE // Drones don't feel anything.

	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.species.name == "Diona")
			to_chat(L, "<span class='warning'>На мгновение вы чувствуете себя странно, но это проходит.</span>")
			return FALSE // Happy trees aren't affected by tranquility.

	return ..()

/datum/modifier/feysight/tick()
	..()

	if(ishuman(holder))
		var/mob/living/carbon/human/H = holder
		H.druggy = min(15, H.druggy + 4)
