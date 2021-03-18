/datum/power/changeling/absorb_dna
	name = "Поглотить ДНК"
	desc = "Permits us to syphon the DNA from a human. They become one with us, and we become stronger if they were of our kind."
	ability_icon_state = "ling_absorb_dna"
	genomecost = 0
	verbpath = /mob/living/proc/changeling_absorb_dna

//Absorbs the victim's DNA. Requires a strong grip on the victim.
//Doesn't cost anything as it's the most basic ability.
/mob/living/proc/changeling_absorb_dna()
	set category = "Changeling"
	set name = "Поглотить ДНК"

	var/datum/changeling/changeling = changeling_power(0,0,100)
	if(!changeling)	return

	var/obj/item/weapon/grab/G = src.get_active_hand()
	if(!istype(G))
		to_chat(src, "<span class='warning'>Мы должны схватить существо в активную руку, чтобы поглотить его.</span>")
		return

	var/mob/living/carbon/human/T = G.affecting
	if(!istype(T) || T.isSynthetic())
		to_chat(src, "<span class='warning'>[T] несовместим с нашей биологией.</span>")
		return

	if(T.species.flags & NO_SCAN)
		to_chat(src, "<span class='warning'>Мы не знаем, как анализировать ДНК этого существа!</span>")
		return

	if(HUSK in T.mutations) //Lings can always absorb other lings, unless someone beat them to it first.
		if(!T.mind.changeling || T.mind.changeling && T.mind.changeling.geneticpoints < 0)
			to_chat(src, "<span class='warning'>ДНК этого существа испорчена до невозможности!</span>")
			return

	if(G.state != GRAB_KILL)
		to_chat(src, "<span class='warning'>Чтобы поглотить это существо, нужно крепче сжать его.</span>")
		return

	if(changeling.isabsorbing)
		to_chat(src, "<span class='warning'>Мы уже поглощаем!</span>")
		return

	changeling.isabsorbing = 1
	for(var/stage = 1, stage<=3, stage++)
		switch(stage)
			if(1)
				to_chat(src, "<span class='notice'>Это существо совместимо. Мы должны стоять на месте...</span>")
			if(2)
				to_chat(src, "<span class='notice'>Мы удлиняем хоботок.</span>")
				src.visible_message("<span class='warning'>[src] вытягивает хоботок!</span>")
			if(3)
				to_chat(src, "<span class='notice'>Мы наносим удар [T] хоботком.</span>")
				src.visible_message("<span class='danger'>[src] наносит удар [T] хоботком!</span>")
				to_chat(T, "<span class='danger'>Вы чувствуете резкую колющую боль!</span>")
				add_attack_logs(src,T,"Absorbed (changeling)")
				var/obj/item/organ/external/affecting = T.get_organ(src.zone_sel.selecting)
				if(affecting.take_damage(39,0,1,0,"большая органическая игла"))
					T:UpdateDamageIcon()

		feedback_add_details("changeling_powers","A[stage]")
		if(!do_mob(src, T, 150) || G.state != GRAB_KILL)
			to_chat(src, "<span class='warning'>Наше поглощение [T] было прервано!</span>")
			changeling.isabsorbing = 0
			return

	to_chat(src, "<span class='notice'>Мы поглотили [T]!</span>")
	src.visible_message("<span class='danger'>[src] высасывает [T] словно жидкость!</span>")
	to_chat(T, "<span class='danger'>Вы были поглощены подменышем!</span>")
	adjust_nutrition(T.nutrition)
	changeling.chem_charges += 10
	if(changeling.readapts <= 0)
		changeling.readapts = 0 //SANITYYYYYY
	changeling.readapts++
	if(changeling.readapts > changeling.max_readapts)
		changeling.readapts = changeling.max_readapts

	to_chat(src, "<span class='notice'>Теперь мы можем заново адаптироваться, повернув нашу эволюцию вспять, чтобы при необходимости начать все заново.</span>")

	var/datum/absorbed_dna/newDNA = new(T.real_name, T.dna, T.species.name, T.languages, T.identifying_gender, T.flavor_texts, T.modifiers)
	absorbDNA(newDNA)

	if(T.mind && T.mind.changeling)
		if(T.mind.changeling.absorbed_dna)
			for(var/datum/absorbed_dna/dna_data in T.mind.changeling.absorbed_dna)	//steal all their loot
				if(dna_data in changeling.absorbed_dna)
					continue
				absorbDNA(dna_data)
				changeling.absorbedcount++

			T.mind.changeling.absorbed_dna.len = 1

		// This is where lings get boosts from eating eachother
		if(T.mind.changeling.lingabsorbedcount)
			for(var/a = 1 to T.mind.changeling.lingabsorbedcount)
				changeling.lingabsorbedcount++
				changeling.geneticpoints += 4
				changeling.max_geneticpoints += 4

		to_chat(src, "<span class='notice'>Мы поглотили еще одного подменыша и становимся сильнее. Наши геномы увеличиваются.</span>")

		T.mind.changeling.chem_charges = 0
		T.mind.changeling.geneticpoints = -1
		T.mind.changeling.max_geneticpoints = -1 //To prevent revival.
		T.mind.changeling.absorbedcount = 0
		T.mind.changeling.lingabsorbedcount = 0

	changeling.absorbedcount++
	changeling.isabsorbing = 0

	T.death(0)
	T.Drain()
	return 1