var/global/list/prevent_respawns = list()

/hook/death/proc/quit_notify(mob/dead)
	if(ishuman(dead))
		to_chat(dead,"<span class='notice'>Вы мертвы! Если Вы не планируете играть за этого персонажа в раунде, пожалуйста, используйте глагол <b>Покинуть Раунд</b> во вкладке ООС, чтобы освободить свой рабочий слот.</span>")

	return TRUE

/mob/observer/dead/verb/cleanup()
	set name = "Покинуть Раунд"
	set category = "OOC"
	set desc = "Освободить слот на работу, убрать себя из списка экипажа и запретить респавн персонажа в этом раунде."

	var/confirm = alert("Это действие освободит Ваш рабочий слот, удалит Вас из списка экипажа и позволит Вам респавниться за другого персонажа. \
	Вы точно хотите этого?","Покинуть Раунд","Покинуть","Остаться")
	if(confirm != "Покинуть")
		return

	//Why are you clicking this button?
	if(!mind || !mind.assigned_role)
		to_chat(src,"<span class='warning'>Вы либо ещё не играли в этом раунде, либо уже воспользовались этим глаголом.</span>")
		return

	//Add them to the nope list
	//prevent_respawns += mind.name //Replaced by PR 4785

	//Update any existing objectives involving this mob.
	for(var/datum/objective/O in all_objectives)
		if(O.target == src.mind)
			if(O.owner && O.owner.current)
				to_chat(O.owner.current,"<span class='warning'>Вы чувствуете, как Ваша цель ускользает от Вас...</span>")
			qdel(O)

	//Resleeving cleanup
	if(src.mind.name in SStranscore.backed_up)
		var/datum/transhuman/mind_record/MR = SStranscore.backed_up[src.mind.name]
		SStranscore.stop_backup(MR)
	if(src.mind.name in SStranscore.body_scans) //This uses mind names to avoid people cryo'ing a printed body to delete body scans.
		var/datum/transhuman/body_record/BR = SStranscore.body_scans[src.mind.name]
		SStranscore.remove_body(BR)

	//Job slot cleanup
	var/job = src.mind.assigned_role
	job_master.FreeRole(job)

	//Their objectives cleanup
	if(src.mind.objectives.len)
		qdel(src.mind.objectives)
		src.mind.special_role = null

	//Cut the PDA manifest (ugh)
	if(PDA_Manifest.len)
		PDA_Manifest.Cut()
	for(var/datum/data/record/R in data_core.medical)
		if((R.fields["name"] == src.real_name))
			qdel(R)
	for(var/datum/data/record/T in data_core.security)
		if((T.fields["name"] == src.real_name))
			qdel(T)
	for(var/datum/data/record/G in data_core.general)
		if((G.fields["name"] == src.real_name))
			qdel(G)

	//This removes them from being 'active' list on join screen
	src.mind.assigned_role = null

	//Feedback
	to_chat(src,"<span class='notice'>Ваш слот был освобождён, и Вы можете зайти за другого персонажа или покинуть игру. Спасибо за использование этого глагола, это помогает серверу!</span>")
