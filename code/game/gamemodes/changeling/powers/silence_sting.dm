/datum/power/changeling/silence_sting
	name = "Silence Sting"
	desc = "Мы молча ужалим человека, полностью заставляя его замолчать на короткое время."
	helptext = "Не предупреждает жертву о том, что ее ужалили, пока она не попытается заговорить и не сможет."
	enhancedtext = "Продолжительность молчания увеличена."
	ability_icon_state = "ling_sting_mute"
	genomecost = 2
	allowduringlesserform = 1
	verbpath = /mob/proc/changeling_silence_sting

/mob/proc/changeling_silence_sting()
	set category = "Changeling"
	set name = "Укус тишины (10)"
	set desc="Sting target"

	var/mob/living/carbon/T = changeling_sting(10,/mob/proc/changeling_silence_sting)
	if(!T)	return 0
	add_attack_logs(src,T,"Silence sting (changeling)")
	var/duration = 30
	if(src.mind.changeling.recursive_enhancement)
		duration = duration + 10
		to_chat(src, "<span class='notice'>Они не смогут еще немного кричать от страха.</span>")
	T.silent += duration
	feedback_add_details("changeling_powers","SS")
	return 1