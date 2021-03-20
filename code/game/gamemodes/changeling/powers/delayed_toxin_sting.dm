/datum/power/changeling/delayed_toxic_sting
	name = "Delayed Toxic Sting"
	desc = "We silently sting a biological, causing a significant amount of toxins after a few minutes, allowing us to not \
	implicate ourselves."
	helptext = "Токсин начинает действовать примерно через две минуты. Многократное нанесение в течение двух минут не вызовет повышенной токсичности."
	enhancedtext = "Токсический урон увеличивается вдвое."
	ability_icon_state = "ling_sting_del_toxin"
	genomecost = 1
	verbpath = /mob/proc/changeling_delayed_toxic_sting

/datum/modifier/delayed_toxin_sting
	name = "delayed toxin injection"
	hidden = TRUE
	stacks = MODIFIER_STACK_FORBID
	on_expired_text = "<span class='danger'>You feel a burning sensation flowing through your veins!</span>"

/datum/modifier/delayed_toxin_sting/on_expire()
	holder.adjustToxLoss(rand(20, 30))

/datum/modifier/delayed_toxin_sting/strong/on_expire()
	holder.adjustToxLoss(rand(40, 60))

/mob/proc/changeling_delayed_toxic_sting()
	set category = "Changeling"
	set name = "Отложенный ядовитый укус (20)"
	set desc = "Injects the target with a toxin that will take effect after a few minutes."

	var/mob/living/carbon/T = changeling_sting(20,/mob/proc/changeling_delayed_toxic_sting)
	if(!T)
		return 0
	add_attack_logs(src,T,"Delayed toxic sting (chagneling)")
	var/type_to_give = /datum/modifier/delayed_toxin_sting
	if(src.mind.changeling.recursive_enhancement)
		type_to_give = /datum/modifier/delayed_toxin_sting/strong
		to_chat(src, "<span class='notice'>Наш токсин будет очень мощным, когда он нанесет удар.</span>")

	T.add_modifier(type_to_give, 2 MINUTES)


	feedback_add_details("changeling_powers","DTS")
	return 1