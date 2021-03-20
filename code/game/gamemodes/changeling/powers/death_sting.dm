/datum/power/changeling/DeathSting
	name = "Death Sting"
	desc = "Мы молча ужалим человека, наполняя его сильнодействующими химикатами. Его быстрая смерть почти гарантирована."
	ability_icon_state = "ling_sting_death"
	genomecost = 10
	verbpath = /mob/proc/changeling_DEATHsting

/mob/proc/changeling_DEATHsting()
	set category = "Changeling"
	set name = "Укус смерти (50)"
	set desc = "Causes spasms onto death."

	var/mob/living/carbon/T = changeling_sting(50,/mob/proc/changeling_DEATHsting)
	if(!T)
		return 0
	add_attack_logs(src,T,"Death sting (changeling)")
	to_chat(T, "<span class='danger'>Вы чувствуете небольшой укол, и ваша грудь становится напряженной.</span>")
	T.silent = 10
	T.Paralyse(10)
	T.make_jittery(100)
	if(T.reagents)	T.reagents.add_reagent("lexorin", 40)
	feedback_add_details("changeling_powers","DTHS")
	return 1