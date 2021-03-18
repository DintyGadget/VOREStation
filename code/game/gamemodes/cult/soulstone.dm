/////////////////////////
//		Soulstone
/////////////////////////

/obj/item/device/soulstone
	name = "Soul Stone Shard"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "soulstone"
	item_state = "electronic"
	desc = "Фрагмент легендарного сокровища, известного просто как «Камень души». Осколок все еще мерцает на части полной мощности артефактов."
	w_class = ITEMSIZE_SMALL
	slot_flags = SLOT_BELT
	origin_tech = list(TECH_BLUESPACE = 4, TECH_MATERIAL = 4, TECH_ARCANE = 1)
	var/imprinted = "empty"
	var/possible_constructs = list("Juggernaut","Wraith","Artificer","Harvester")

/obj/item/device/soulstone/cultify()
	return

//////////////////////////////Capturing////////////////////////////////////////////////////////

/obj/item/device/soulstone/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	if(!istype(M, /mob/living/carbon/human))//If target is not a human.
		return ..()
	if(istype(M, /mob/living/carbon/human/dummy))
		return..()
	if(jobban_isbanned(M, "cultist"))
		to_chat(user, "<span class='warning'>Душа этого человека слишком испорчена и не может быть захвачена!</span>")
		return..()

	if(M.has_brain_worms()) //Borer stuff - RR
		to_chat(user, "<span class='warning'>Это существо испорчено инопланетным разумом и не может попасть в ловушку души.</span>")
		return..()

	add_attack_logs(user,M,"Камень души с [src.name]")
	transfer_soul("VICTIM", M, user)
	return


///////////////////Options for using captured souls///////////////////////////////////////

/obj/item/device/soulstone/attack_self(mob/user)
	if (!in_range(src, user))
		return
	user.set_machine(src)
	var/dat = "<meta charset=\"utf-8\"><TT><B>Камень души</B><BR>"
	for(var/mob/living/simple_mob/construct/shade/A in src)
		dat += "Захваченная душа: [A.name]<br>"
		dat += {"<A href='byond://?src=\ref[src];choice=Summon'>Призвать тень</A>"}
		dat += "<br>"
		dat += {"<a href='byond://?src=\ref[src];choice=Close'> Закрыть</a>"}
	user << browse(dat, "window=aicard")
	onclose(user, "aicard")
	return




/obj/item/device/soulstone/Topic(href, href_list)
	var/mob/U = usr
	if (!in_range(src, U)||U.machine!=src)
		U << browse(null, "window=aicard")
		U.unset_machine()
		return

	add_fingerprint(U)
	U.set_machine(src)

	switch(href_list["choice"])//Now we switch based on choice.
		if ("Close")
			U << browse(null, "window=aicard")
			U.unset_machine()
			return

		if ("Summon")
			for(var/mob/living/simple_mob/construct/shade/A in src)
				A.status_flags &= ~GODMODE
				A.canmove = 1
				to_chat(A, "<b>Вас выпустили из тюрьмы, но вы по-прежнему связаны волей [U.name]. Помогите им добиться успеха любой ценой.</b>")
				A.forceMove(U.loc)
				A.cancel_camera()
				src.icon_state = "soulstone"
	attack_self(U)

///////////////////////////Transferring to constructs/////////////////////////////////////////////////////
/obj/structure/constructshell
	name = "empty shell"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "construct"
	desc = "Злая машина, используемая мастерами магии. Неактивна."

/obj/structure/constructshell/cultify()
	return

/obj/structure/constructshell/cult
	icon_state = "construct-cult"
	desc = "Это жуткое изобретение выглядит так, будто оно ожило бы, если бы в него не входил ингредиент."

/obj/structure/constructshell/attackby(obj/item/O as obj, mob/user as mob)
	if(istype(O, /obj/item/device/soulstone))
		var/obj/item/device/soulstone/S = O;
		S.transfer_soul("CONSTRUCT",src,user)


////////////////////////////Proc for moving soul in and out off stone//////////////////////////////////////
/obj/item/device/soulstone/proc/transfer_human(var/mob/living/carbon/human/T,var/mob/U)
	if(!istype(T))
		return;
	if(src.imprinted != "empty")
		to_chat(U, "<span class='danger'>Захват не удался!</span>: Камень души уже отпечатан в разуме [src.imprinted]!")
		return
	if ((T.health + T.halloss) > config.health_threshold_crit && T.stat != DEAD)
		to_chat(U, "<span class='danger'>Захват не удался!</span>: Сначала убейте или покалечите жертву!")
		return
	if(T.client == null)
		to_chat(U, "<span class='danger'>Захват не удался!</span>: Душа уже покинула свой смертный каркас.")
		return
	if(src.contents.len)
		to_chat(U, "<span class='danger'>Захват не удался!</span>: Камень души полон! Используйте или освободите существующую душу, чтобы освободить место.")
		return

	for(var/obj/item/W in T)
		T.drop_from_inventory(W)

	new /obj/effect/decal/remains/human(T.loc) //Spawns a skeleton
	T.invisibility = 101

	var/atom/movable/overlay/animation = new /atom/movable/overlay( T.loc )
	animation.icon_state = "blank"
	animation.icon = 'icons/mob/mob.dmi'
	animation.master = T
	flick("dust-h", animation)
	qdel(animation)

	var/mob/living/simple_mob/construct/shade/S = new /mob/living/simple_mob/construct/shade( T.loc )
	S.forceMove(src) //put shade in stone
	S.status_flags |= GODMODE //So they won't die inside the stone somehow
	S.canmove = 0//Can't move out of the soul stone
	S.name = "Тень [T.real_name]"
	S.real_name = "Тень [T.real_name]"
	S.icon = T.icon
	S.icon_state = T.icon_state
	S.overlays = T.overlays
	S.color = rgb(254,0,0)
	S.alpha = 127
	if (T.client)
		T.client.mob = S
	S.cancel_camera()


	src.icon_state = "soulstone2"
	src.name = "Камень души: [S.real_name]"
	to_chat(S, "Ваша душа захвачена! Теперь вы связаны волей [U.name], помогите им добиться успеха любой ценой.")
	to_chat(U, "<span class='notice'>Захват успешен!</span> : Душа [T.real_name] была вырвана из тела и сохранена в камне души.")
	to_chat(U, "Камень души был отпечатан в разуме [S.real_name], он больше не будет реагировать на другие души.")
	src.imprinted = "[S.name]"
	qdel(T)

/obj/item/device/soulstone/proc/transfer_shade(var/mob/living/simple_mob/construct/shade/T,var/mob/U)
	if(!istype(T))
		return;
	if (T.stat == DEAD)
		to_chat(U, "<span class='danger'>Захват не удался!</span>: Тень уже прогнали!")
		return
	if(src.contents.len)
		to_chat(U, "<span class='danger'>Захват не удался!</span>: Камень души полон! Используйте или освободите существующую душу, чтобы освободить место.")
		return
	if(T.name != src.imprinted)
		to_chat(U, "<span class='danger'>Захват не удался!</span>: Камень души уже отпечатан в разуме [src.imprinted]!")
		return

	T.forceMove(src) //put shade in stone
	T.status_flags |= GODMODE
	T.canmove = 0
	T.health = T.getMaxHealth()
	src.icon_state = "soulstone2"

	to_chat(T, "Ваша душа была захвачена камнем души, его тайные энергии воссоединяют вашу эфирную форму")
	to_chat(U, "<span class='notice'>Захват успешен!</span> : [T.name] был захвачен и сохранен в камне души.")

/obj/item/device/soulstone/proc/transfer_construct(var/obj/structure/constructshell/T,var/mob/U)
	var/mob/living/simple_mob/construct/shade/A = locate() in src
	if(!A)
		to_chat(U, "<span class='danger'>Захват не удался!</span>: Камень души пуст! Убей кого-нибудь!")
		return;
	var/construct_class = input(U, "Пожалуйста, выберите, какой тип конструкции вы хотите создать.") as null|anything in possible_constructs
	switch(construct_class)
		if("Juggernaut")
			var/mob/living/simple_mob/construct/juggernaut/Z = new /mob/living/simple_mob/construct/juggernaut (get_turf(T.loc))
			Z.key = A.key
			if(iscultist(U))
				cult.add_antagonist(Z.mind)
			qdel(T)
			to_chat(Z, "<B>Сейчас вы играете за Juggernaut. Несмотря на то, что вы медленный, вы можете выдержать жестокое наказание и разорвать врагов, и стены.</B>")
			to_chat(Z, "<B>Вы по-прежнему обязаны служить своему создателю, выполнять его приказы и любой ценой помогать ему в достижении своих целей.</B>")
			Z.cancel_camera()
			qdel(src)
		if("Wraith")
			var/mob/living/simple_mob/construct/wraith/Z = new /mob/living/simple_mob/construct/wraith (get_turf(T.loc))
			Z.key = A.key
			if(iscultist(U))
				cult.add_antagonist(Z.mind)
			qdel(T)
			to_chat(Z, "<B>Сейчас вы играете за Wraith. Хотя вы относительно хрупки, вы быстры, смертоносны и даже способны проходить сквозь стены.</B>")
			to_chat(Z, "<B>Вы по-прежнему обязаны служить своему создателю, выполнять его приказы и любой ценой помогать ему в достижении своих целей.</B>")
			Z.cancel_camera()
			qdel(src)
		if("Artificer")
			var/mob/living/simple_mob/construct/artificer/Z = new /mob/living/simple_mob/construct/artificer (get_turf(T.loc))
			Z.key = A.key
			if(iscultist(U))
				cult.add_antagonist(Z.mind)
			qdel(T)
			to_chat(Z, "<B>Сейчас вы играете за Artificer. Вы невероятно слабы и хрупки, но вы можете строить укрепления, ремонтировать союзные конструкции (щелкая по ним) и даже создавать новые конструкции.</B>")
			to_chat(Z, "<B>Вы по-прежнему обязаны служить своему создателю, выполнять его приказы и любой ценой помогать ему в достижении своих целей.</B>")
			Z.cancel_camera()
			qdel(src)
		if("Harvester")
			var/mob/living/simple_mob/construct/harvester/Z = new /mob/living/simple_mob/construct/harvester (get_turf(T.loc))
			Z.key = A.key
			if(iscultist(U))
				cult.add_antagonist(Z.mind)
			qdel(T)
			to_chat(Z, "<B>Сейчас вы играете за Harvester. Вы относительно слабы, но ваша физическая слабость компенсируется вашими способностями дальнего боя.</B>")
			to_chat(Z, "<B>Вы по-прежнему обязаны служить своему создателю, выполнять его приказы и любой ценой помогать ему в достижении своих целей.</B>")
			Z.cancel_camera()
			qdel(src)
		if("Behemoth")
			var/mob/living/simple_mob/construct/juggernaut/behemoth/Z = new /mob/living/simple_mob/construct/juggernaut/behemoth (get_turf(T.loc))
			Z.key = A.key
			if(iscultist(U))
				cult.add_antagonist(Z.mind)
			qdel(T)
			to_chat(Z, "<B>Сейчас вы играете за Behemoth. Вы невероятно медлительны, хотя ваша медлительность компенсируется тем, что ваша оболочка намного больше, чем у любого из ваших собратьев. Вы - неудержимая сила и неподвижный объект.</B>")
			to_chat(Z, "<B>Вы по-прежнему обязаны служить своему создателю, выполнять его приказы и любой ценой помогать ему в достижении своих целей.</B>")
			Z.cancel_camera()
			qdel(src)

/obj/item/device/soulstone/proc/transfer_soul(var/choice as text, var/target, var/mob/U as mob)
	switch(choice)
		if("VICTIM")
			transfer_human(target,U)
		if("SHADE")
			transfer_shade(target,U)
		if("CONSTRUCT")
			transfer_construct(target,U)
