/datum/power/changeling/self_respiration
	name = "Self Respiration"
	desc = "Мы развиваем наше тело, чтобы больше не потреблять кислород из атмосферы."
	helptext = "Нам больше не понадобятся внутренние устройства, и мы не сможем вдыхать газы, в том числе вредные."
	ability_icon_state = "ling_toggle_breath"
	genomecost = 0
	verbpath = /mob/proc/changeling_self_respiration

//No breathing required
/mob/proc/changeling_self_respiration()
	set category = "Changeling"
	set name = "Переключить дыхание"
	set desc = "We choose whether or not to breathe."

	var/datum/changeling/changeling = changeling_power(0,0,100,UNCONSCIOUS)
	if(!changeling)
		return 0

	if(istype(src,/mob/living/carbon))
		var/mob/living/carbon/C = src
		if(C.suiciding)
			to_chat(src, "Вы совершаете самоубийство, это не сработает.")
			return 0
		if(C.does_not_breathe == 0)
			C.does_not_breathe = 1
			to_chat(src, "<span class='notice'>Мы перестаем дышать, так как нам больше не нужно.</span>")
			return 1
		else
			C.does_not_breathe = 0
			to_chat(src, "<span class='notice'>Мы возобновляем дыхание, как нам теперь снова нужно.</span>")
	return 0