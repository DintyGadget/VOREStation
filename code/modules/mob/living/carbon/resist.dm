/mob/living/carbon/resist_fire()
	adjust_fire_stacks(-1.2)
	Weaken(3)
	spin(32,2)
	visible_message(
		"<span class='danger'>[src] [src] катается по полу, пытаясь высвободиться!</span>",
		"<span class='notice'>Вы останавливаетесь, падаете и катитесь!</span>"
		)
	sleep(30)
	if(fire_stacks <= 0)
		visible_message(
			"<span class='danger'>[src] успешно затухает!</span>",
			"<span class='notice'>Вы гасите себя.</span>"
			)
		ExtinguishMob()
	return TRUE

/mob/living/carbon/resist_restraints()
	var/obj/item/I = null
	if(handcuffed)
		I = handcuffed
	else if(legcuffed)
		I = legcuffed

	if(I)
		setClickCooldown(100)
		cuff_resist(I, cuff_break = can_break_cuffs())

/mob/living/carbon/proc/reduce_cuff_time()
	return FALSE

/mob/living/carbon/proc/cuff_resist(obj/item/weapon/handcuffs/I, breakouttime = 1200, cuff_break = 0)

	if(istype(I))
		breakouttime = I.breakouttime

	var/displaytime = breakouttime / 10

	var/reduceCuffTime = reduce_cuff_time()
	if(reduceCuffTime)
		breakouttime /= reduceCuffTime
		displaytime /= reduceCuffTime

	if(cuff_break)
		visible_message("<span class='danger'>[src] пытается сломать [I]!</span>",
			"<span class='warning'>Вы пытаетесь сломать [I]. (Это займет около 5 секунд, и вам нужно будет стоять на месте.)</span>")

		if(do_after(src, 5 SECONDS, target = src, incapacitation_flags = INCAPACITATION_DEFAULT & ~INCAPACITATION_RESTRAINED))
			if(!I || buckled)
				return
			visible_message("<span class='danger'>[src] удается сломать [I]!</span>",
				"<span class='warning'>Вы успешно сломали [I].</span>")
			say(pick(";РАААААХХХ!", ";НННГГГХХХ!", ";ВАААААААРГХ!", "ННННГГГХХХХ!", ";АААААААА!" ))

			if(I == handcuffed)
				handcuffed = null
				update_handcuffed()
			else if(I == legcuffed)
				legcuffed = null
				update_inv_legcuffed()

			if(buckled && buckled.buckle_require_restraints)
				buckled.unbuckle_mob()

			qdel(I)
		else
			to_chat(src, "<span class='warning'>Вы не можете сломать [I].</span>")
		return

	visible_message("<span class='danger'>[src] пытается удалить [I]!</span>",
		"<span class='warning'>Вы пытаетесь удалить [I]. (Это займет около [displaytime] секунд, и вам нужно будет стоять на месте)</span>")
	if(do_after(src, breakouttime, target = src, incapacitation_flags = INCAPACITATION_DISABLED & INCAPACITATION_KNOCKDOWN))
		visible_message("<span class='danger'>[src] удается удалить [I]!</span>",
			"<span class='notice'>Вы успешно удалили [I].</span>")
		drop_from_inventory(I)

/mob/living/carbon/resist_buckle()
	if(!buckled)
		return

	if(!restrained())
		return ..()

	setClickCooldown(100)
	visible_message(
		"<span class='danger'>[src] attempts to unbuckle themself!</span>",
		"<span class='warning'>You attempt to unbuckle yourself. (This will take around 2 minutes and you need to stand still)</span>"
		)

	if(do_after(src, 2 MINUTES, incapacitation_flags = INCAPACITATION_DEFAULT & ~(INCAPACITATION_RESTRAINED | INCAPACITATION_BUCKLED_FULLY)))
		if(!buckled)
			return
		visible_message("<span class='danger'>[src] manages to unbuckle themself!</span>",
						"<span class='notice'>You successfully unbuckle yourself.</span>")
		buckled.user_unbuckle_mob(src, src)

/mob/living/carbon/proc/can_break_cuffs()
	if(HULK in mutations)
		return 1
