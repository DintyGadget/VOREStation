/datum/admins/Topic(href, href_list)
	..()

	if(usr.client != src.owner || !check_rights(0))
		log_admin("[key_name(usr)] tried to use the admin panel without authorization.")
		message_admins("[usr.key] has attempted to override the admin panel!")
		return

	if(ticker.mode && ticker.mode.check_antagonists_topic(href, href_list))
		check_antagonists()
		return

	if(href_list["ahelp"])
		if(!check_rights(R_ADMIN|R_MOD|R_DEBUG|R_EVENT))
			return

		var/ahelp_ref = href_list["ahelp"]
		var/datum/admin_help/AH = locate(ahelp_ref)
		if(AH)
			AH.Action(href_list["ahelp_action"])
		else
			to_chat(usr, "Ticket [ahelp_ref] has been deleted!")

	else if(href_list["ahelp_tickets"])
		GLOB.ahelp_tickets.BrowseTickets(text2num(href_list["ahelp_tickets"]))

	if(href_list["dbsearchckey"] || href_list["dbsearchadmin"])

		var/adminckey = href_list["dbsearchadmin"]
		var/playerckey = href_list["dbsearchckey"]
		var/playerip = href_list["dbsearchip"]
		var/playercid = href_list["dbsearchcid"]
		var/dbbantype = text2num(href_list["dbsearchbantype"])
		var/match = 0

		if("dbmatch" in href_list)
			match = 1

		DB_ban_panel(playerckey, adminckey, playerip, playercid, dbbantype, match)
		return

	else if(href_list["dbbanedit"])
		var/banedit = href_list["dbbanedit"]
		var/banid = text2num(href_list["dbbanid"])
		if(!banedit || !banid)
			return

		DB_ban_edit(banid, banedit)
		return

	else if(href_list["dbbanaddtype"])

		var/bantype = text2num(href_list["dbbanaddtype"])
		var/banckey = href_list["dbbanaddckey"]
		var/banip = href_list["dbbanaddip"]
		var/bancid = href_list["dbbanaddcid"]
		var/banduration = text2num(href_list["dbbaddduration"])
		var/banjob = href_list["dbbanaddjob"]
		var/banreason = href_list["dbbanreason"]

		banckey = ckey(banckey)

		switch(bantype)
			if(BANTYPE_PERMA)
				if(!banckey || !banreason)
					to_chat(usr, "<span class='filter_adminlog'>Not enough parameters (Requires ckey and reason)</span>")
					return
				banduration = null
				banjob = null
			if(BANTYPE_TEMP)
				if(!banckey || !banreason || !banduration)
					to_chat(usr, "<span class='filter_adminlog'>Not enough parameters (Requires ckey, reason and duration)</span>")
					return
				banjob = null
			if(BANTYPE_JOB_PERMA)
				if(!banckey || !banreason || !banjob)
					to_chat(usr, "<span class='filter_adminlog'>Not enough parameters (Requires ckey, reason and job)</span>")
					return
				banduration = null
			if(BANTYPE_JOB_TEMP)
				if(!banckey || !banreason || !banjob || !banduration)
					to_chat(usr, "<span class='filter_adminlog'>Not enough parameters (Requires ckey, reason and job)</span>")
					return

		var/mob/playermob

		for(var/mob/M in player_list)
			if(M.ckey == banckey)
				playermob = M
				break


		banreason = "(MANUAL BAN) "+banreason

		if(!playermob)
			if(banip)
				banreason = "[banreason] (CUSTOM IP)"
			if(bancid)
				banreason = "[banreason] (CUSTOM CID)"
		else
			message_admins("Ban process: A mob matching [playermob.ckey] was found at location [playermob.x], [playermob.y], [playermob.z]. Custom ip and computer id fields replaced with the ip and computer id from the located mob")
		notes_add(banckey,banreason,usr)

		DB_ban_record(bantype, playermob, banduration, banreason, banjob, null, banckey, banip, bancid )

	else if(href_list["editrights"])
		if(!check_rights(R_PERMISSIONS))
			message_admins("[key_name_admin(usr)] attempted to edit the admin permissions without sufficient rights.")
			log_admin("[key_name(usr)] attempted to edit the admin permissions without sufficient rights.")
			return

		var/adm_ckey

		var/task = href_list["editrights"]
		if(task == "add")
			var/new_ckey = ckey(input(usr,"New admin's ckey","Admin ckey", null) as text|null)
			if(!new_ckey)	return
			if(new_ckey in admin_datums)
				to_chat(usr, "<span class='filter_adminlog warning'>Error: Topic 'editrights': [new_ckey] is already an admin</span>")
				return
			adm_ckey = new_ckey
			task = "rank"
		else if(task != "show")
			adm_ckey = ckey(href_list["ckey"])
			if(!adm_ckey)
				to_chat(usr, "<span class='filter_adminlog warning'>Error: Topic 'editrights': No valid ckey</span>")
				return

		var/datum/admins/D = admin_datums[adm_ckey]

		if(task == "remove")
			if(tgui_alert(usr, "Are you sure you want to remove [adm_ckey]?","Message",list("Yes","Cancel")) == "Yes")
				if(!D)	return
				admin_datums -= adm_ckey
				D.disassociate()

				message_admins("[key_name_admin(usr)] removed [adm_ckey] from the admins list")
				log_admin("[key_name(usr)] removed [adm_ckey] from the admins list")
				log_admin_rank_modification(adm_ckey, "Removed")

		else if(task == "rank")
			var/new_rank
			if(admin_ranks.len)
				new_rank = tgui_input_list(usr, "Please select a rank", "New rank", (admin_ranks|"*New Rank*"))
			else
				new_rank = tgui_input_list(usr, "Please select a rank", "New rank", list("Game Master","Game Admin", "Trial Admin", "Admin Observer","*New Rank*"))

			var/rights = 0
			if(D)
				rights = D.rights
			switch(new_rank)
				if(null,"") return
				if("*New Rank*")
					new_rank = input(usr, "Please input a new rank", "New custom rank", null, null) as null|text
					if(config.admin_legacy_system)
						new_rank = ckeyEx(new_rank)
					if(!new_rank)
						to_chat(usr, "<span class='filter_adminlog warning'>Error: Topic 'editrights': Invalid rank</span>")
						return
					if(config.admin_legacy_system)
						if(admin_ranks.len)
							if(new_rank in admin_ranks)
								rights = admin_ranks[new_rank]		//we typed a rank which already exists, use its rights
							else
								admin_ranks[new_rank] = 0			//add the new rank to admin_ranks
				else
					if(config.admin_legacy_system)
						new_rank = ckeyEx(new_rank)
						rights = admin_ranks[new_rank]				//we input an existing rank, use its rights

			if(D)
				D.disassociate()								//remove adminverbs and unlink from client
				D.rank = new_rank								//update the rank
				D.rights = rights								//update the rights based on admin_ranks (default: 0)
			else
				D = new /datum/admins(new_rank, rights, adm_ckey)

			var/client/C = GLOB.directory[adm_ckey]						//find the client with the specified ckey (if they are logged in)
			D.associate(C)											//link up with the client and add verbs

			message_admins("[key_name_admin(usr)] edited the admin rank of [adm_ckey] to [new_rank]")
			log_admin("[key_name(usr)] edited the admin rank of [adm_ckey] to [new_rank]")
			log_admin_rank_modification(adm_ckey, new_rank)

		else if(task == "permissions")
			if(!D)	return
			var/list/permissionlist = list()
			for(var/i=1, i<=R_MAXPERMISSION, i<<=1)		//that <<= is shorthand for i = i << 1. Which is a left bitshift
				permissionlist[rights2text(i)] = i
			var/new_permission = tgui_input_list(usr, "Select a permission to turn on/off", "Permission toggle", permissionlist)
			if(!new_permission)	return
			D.rights ^= permissionlist[new_permission]

			message_admins("[key_name_admin(usr)] toggled the [new_permission] permission of [adm_ckey]")
			log_admin("[key_name(usr)] toggled the [new_permission] permission of [adm_ckey]")
			log_admin_permission_modification(adm_ckey, permissionlist[new_permission])

		edit_admin_permissions()

	else if(href_list["call_shuttle"])
		if(!check_rights(R_ADMIN|R_EVENT))	return

		if( ticker.mode.name == "blob" )
			tgui_alert_async(usr, "You can't call the shuttle during blob!")
			return

		switch(href_list["call_shuttle"])
			if("1")
				if ((!( ticker ) || !emergency_shuttle.location()))
					return
				if (emergency_shuttle.can_call())
					emergency_shuttle.call_evac()
					log_admin("[key_name(usr)] called the Emergency Shuttle")
					message_admins("<font color='blue'>[key_name_admin(usr)] called the Emergency Shuttle to the station.</font>", 1)

			if("2")
				if (!( ticker ) || !emergency_shuttle.location())
					return
				if (emergency_shuttle.can_call())
					emergency_shuttle.call_evac()
					log_admin("[key_name(usr)] called the Emergency Shuttle")
					message_admins("<font color='blue'>[key_name_admin(usr)] called the Emergency Shuttle to the station.</font>", 1)

				else if (emergency_shuttle.can_recall())
					emergency_shuttle.recall()
					log_admin("[key_name(usr)] sent the Emergency Shuttle back")
					message_admins("<font color='blue'>[key_name_admin(usr)] sent the Emergency Shuttle back.</font>", 1)

		href_list["secretsadmin"] = "check_antagonist"

	else if(href_list["edit_shuttle_time"])
		if(!check_rights(R_SERVER))	return

		if (emergency_shuttle.wait_for_launch)
			var/new_time_left = input(usr, "Enter new shuttle launch countdown (seconds):","Edit Shuttle Launch Time", emergency_shuttle.estimate_launch_time() ) as num

			emergency_shuttle.launch_time = world.time + new_time_left*10

			log_admin("[key_name(usr)] edited the Emergency Shuttle's launch time to [new_time_left]")
			message_admins("<font color='blue'>[key_name_admin(usr)] edited the Emergency Shuttle's launch time to [new_time_left*10]</font>", 1)
		else if (emergency_shuttle.shuttle.has_arrive_time())

			var/new_time_left = input(usr, "Enter new shuttle arrival time (seconds):","Edit Shuttle Arrival Time", emergency_shuttle.estimate_arrival_time() ) as num
			emergency_shuttle.shuttle.arrive_time = world.time + new_time_left*10

			log_admin("[key_name(usr)] edited the Emergency Shuttle's arrival time to [new_time_left]")
			message_admins("<font color='blue'>[key_name_admin(usr)] edited the Emergency Shuttle's arrival time to [new_time_left*10]</font>", 1)
		else
			tgui_alert_async(usr, "The shuttle is neither counting down to launch nor is it in transit. Please try again when it is.")

		href_list["secretsadmin"] = "check_antagonist"

	else if(href_list["delay_round_end"])
		if(!check_rights(R_SERVER))	return //VOREStation Edit

		ticker.delay_end = !ticker.delay_end
		log_admin("[key_name(usr)] [ticker.delay_end ? "delayed the round end" : "has made the round end normally"].")
		message_admins("<font color='blue'>[key_name(usr)] [ticker.delay_end ? "delayed the round end" : "has made the round end normally"].</font>", 1)
		href_list["secretsadmin"] = "check_antagonist"

	else if(href_list["simplemake"])

		if(!check_rights(R_SPAWN))	return

		var/mob/M = locate(href_list["mob"])
		if(!ismob(M))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob</span>")
			return

		var/delmob = 0
		switch(tgui_alert(usr, "Delete old mob?","Message",list("Yes","No","Cancel")))
			if("Cancel")	return
			if("Yes")		delmob = 1

		log_admin("[key_name(usr)] has used rudimentary transformation on [key_name(M)]. Transforming to [href_list["simplemake"]]; deletemob=[delmob]")
		message_admins("<font color='blue'>[key_name_admin(usr)] has used rudimentary transformation on [key_name_admin(M)]. Transforming to [href_list["simplemake"]]; deletemob=[delmob]</font>", 1)

		switch(href_list["simplemake"])
			if("observer")			M.change_mob_type( /mob/observer/dead , null, null, delmob )
			if("larva")				M.change_mob_type( /mob/living/carbon/alien/larva , null, null, delmob )
			if("nymph")				M.change_mob_type( /mob/living/carbon/alien/diona , null, null, delmob )
			if("human")				M.change_mob_type( /mob/living/carbon/human , null, null, delmob, href_list["species"])
			if("slime")				M.change_mob_type( /mob/living/simple_mob/slime/xenobio , null, null, delmob )
			if("monkey")			M.change_mob_type( /mob/living/carbon/human/monkey , null, null, delmob )
			if("robot")				M.change_mob_type( /mob/living/silicon/robot , null, null, delmob )
			if("cat")				M.change_mob_type( /mob/living/simple_mob/animal/passive/cat , null, null, delmob )
			if("runtime")			M.change_mob_type( /mob/living/simple_mob/animal/passive/cat/runtime , null, null, delmob )
			if("corgi")				M.change_mob_type( /mob/living/simple_mob/animal/passive/dog/corgi , null, null, delmob )
			if("ian")				M.change_mob_type( /mob/living/simple_mob/animal/passive/dog/corgi/Ian , null, null, delmob )
			if("crab")				M.change_mob_type( /mob/living/simple_mob/animal/passive/crab , null, null, delmob )
			if("coffee")			M.change_mob_type( /mob/living/simple_mob/animal/passive/crab/Coffee , null, null, delmob )
			if("parrot")			M.change_mob_type( /mob/living/simple_mob/animal/passive/bird/parrot , null, null, delmob )
			if("polyparrot")		M.change_mob_type( /mob/living/simple_mob/animal/passive/bird/parrot/poly , null, null, delmob )
			if("constructarmoured")	M.change_mob_type( /mob/living/simple_mob/construct/juggernaut , null, null, delmob )
			if("constructbuilder")	M.change_mob_type( /mob/living/simple_mob/construct/artificer , null, null, delmob )
			if("constructwraith")	M.change_mob_type( /mob/living/simple_mob/construct/wraith , null, null, delmob )
			if("shade")				M.change_mob_type( /mob/living/simple_mob/construct/shade , null, null, delmob )


	/////////////////////////////////////new ban stuff
	else if(href_list["unbanf"])
		if(!check_rights(R_BAN))	return

		var/banfolder = href_list["unbanf"]
		Banlist.cd = "/base/[banfolder]"
		var/key = Banlist["key"]
		if(tgui_alert(usr, "Are you sure you want to unban [key]?", "Confirmation", list("Yes", "No")) == "Yes")
			if(RemoveBan(banfolder))
				unbanpanel()
			else
				tgui_alert_async(usr, "This ban has already been lifted / does not exist.", "Error")
				unbanpanel()

	else if(href_list["warn"])
		usr.client.warn(href_list["warn"])

	else if(href_list["unbane"])
		if(!check_rights(R_BAN))	return

		UpdateTime()
		var/reason

		var/banfolder = href_list["unbane"]
		Banlist.cd = "/base/[banfolder]"
		var/reason2 = Banlist["reason"]
		var/temp = Banlist["temp"]

		var/minutes = Banlist["minutes"]

		var/banned_key = Banlist["key"]
		Banlist.cd = "/base"

		var/duration

		switch(tgui_alert(usr, "Temporary Ban?","Temporary Ban",list("Yes","No")))
			if("Yes")
				temp = 1
				var/mins = 0
				if(minutes > CMinutes)
					mins = minutes - CMinutes
				mins = input(usr,"How long (in minutes)? (Default: 1440)","Ban time",mins ? mins : 1440) as num|null
				if(!mins)	return
				mins = min(525599,mins)
				minutes = CMinutes + mins
				duration = GetExp(minutes)
				reason = sanitize(input(usr,"Reason?","reason",reason2) as text|null)
				if(!reason)	return
			if("No")
				temp = 0
				duration = "Perma"
				reason = sanitize(input(usr,"Reason?","reason",reason2) as text|null)
				if(!reason)	return

		log_admin("[key_name(usr)] edited [banned_key]'s ban. Reason: [reason] Duration: [duration]")
		ban_unban_log_save("[key_name(usr)] edited [banned_key]'s ban. Reason: [reason] Duration: [duration]")
		message_admins("<font color='blue'>[key_name_admin(usr)] edited [banned_key]'s ban. Reason: [reason] Duration: [duration]</font>", 1)
		Banlist.cd = "/base/[banfolder]"
		Banlist["reason"] << reason
		Banlist["temp"] << temp
		Banlist["minutes"] << minutes
		Banlist["bannedby"] << usr.ckey
		Banlist.cd = "/base"
		feedback_inc("ban_edit",1)
		unbanpanel()

	/////////////////////////////////////new ban stuff

	else if(href_list["jobban2"])
//		if(!check_rights(R_BAN))	return

		var/mob/M = locate(href_list["jobban2"])
		if(!ismob(M))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob</span>")
			return

		if(!M.ckey)	//sanity
			to_chat(usr, "<span class='filter_adminlog'>This mob has no ckey</span>")
			return
		if(!job_master)
			to_chat(usr, "<span class='filter_adminlog'>Job Master has not been setup!</span>")
			return

		var/dat = ""
		var/header = "<head><title>Job-Ban Panel: [M.name]</title></head>"
		var/body
		var/jobs = ""

	/***********************************WARNING!************************************
				      The jobban stuff looks mangled and disgusting
						      But it looks beautiful in-game
						                -Nodrak
	************************************WARNING!***********************************/
		var/counter = 0
//Regular jobs
	//Command (Blue)
		jobs += "<table cellpadding='1' cellspacing='0' width='100%'>"
		jobs += "<tr align='center' bgcolor='ccccff'><th colspan='[length(SSjob.get_job_titles_in_department(DEPARTMENT_COMMAND))]'><a href='?src=\ref[src];jobban3=commanddept;jobban4=\ref[M]'>Command Positions</a></th></tr><tr align='center'>"
		for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_COMMAND))
			if(!jobPos)	continue
			var/datum/job/job = job_master.GetJob(jobPos)
			if(!job) continue

			if(jobban_isbanned(M, job.title))
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'><font color=red>[replacetext(job.title, " ", "&nbsp")]</font></a></td>"
				counter++
			else
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'>[replacetext(job.title, " ", "&nbsp")]</a></td>"
				counter++

			if(counter >= 6) //So things dont get squiiiiished!
				jobs += "</tr><tr>"
				counter = 0
		jobs += "</tr></table>"

	//Security (Red)
		counter = 0
		jobs += "<table cellpadding='1' cellspacing='0' width='100%'>"
		jobs += "<tr bgcolor='ffddf0'><th colspan='[length(SSjob.get_job_titles_in_department(DEPARTMENT_SECURITY))]'><a href='?src=\ref[src];jobban3=securitydept;jobban4=\ref[M]'>Security Positions</a></th></tr><tr align='center'>"
		for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_SECURITY))
			if(!jobPos)	continue
			var/datum/job/job = job_master.GetJob(jobPos)
			if(!job) continue

			if(jobban_isbanned(M, job.title))
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'><font color=red>[replacetext(job.title, " ", "&nbsp")]</font></a></td>"
				counter++
			else
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'>[replacetext(job.title, " ", "&nbsp")]</a></td>"
				counter++

			if(counter >= 5) //So things dont get squiiiiished!
				jobs += "</tr><tr align='center'>"
				counter = 0
		jobs += "</tr></table>"

	//Engineering (Yellow)
		counter = 0
		jobs += "<table cellpadding='1' cellspacing='0' width='100%'>"
		jobs += "<tr bgcolor='fff5cc'><th colspan='[length(SSjob.get_job_titles_in_department(DEPARTMENT_ENGINEERING))]'><a href='?src=\ref[src];jobban3=engineeringdept;jobban4=\ref[M]'>Engineering Positions</a></th></tr><tr align='center'>"
		for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_ENGINEERING))
			if(!jobPos)	continue
			var/datum/job/job = job_master.GetJob(jobPos)
			if(!job) continue

			if(jobban_isbanned(M, job.title))
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'><font color=red>[replacetext(job.title, " ", "&nbsp")]</font></a></td>"
				counter++
			else
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'>[replacetext(job.title, " ", "&nbsp")]</a></td>"
				counter++

			if(counter >= 5) //So things dont get squiiiiished!
				jobs += "</tr><tr align='center'>"
				counter = 0
		jobs += "</tr></table>"

	//Cargo (Yellow)
		counter = 0
		jobs += "<table cellpadding='1' cellspacing='0' width='100%'>"
		jobs += "<tr bgcolor='fff5cc'><th colspan='[length(SSjob.get_job_titles_in_department(DEPARTMENT_CARGO))]'><a href='?src=\ref[src];jobban3=cargodept;jobban4=\ref[M]'>Cargo Positions</a></th></tr><tr align='center'>"
		for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_CARGO))
			if(!jobPos)	continue
			var/datum/job/job = job_master.GetJob(jobPos)
			if(!job) continue

			if(jobban_isbanned(M, job.title))
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'><font color=red>[replacetext(job.title, " ", "&nbsp")]</font></a></td>"
				counter++
			else
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'>[replacetext(job.title, " ", "&nbsp")]</a></td>"
				counter++

			if(counter >= 5) //So things dont get squiiiiished!
				jobs += "</tr><tr align='center'>"
				counter = 0
		jobs += "</tr></table>"

	//Medical (White)
		counter = 0
		jobs += "<table cellpadding='1' cellspacing='0' width='100%'>"
		jobs += "<tr bgcolor='ffeef0'><th colspan='[length(SSjob.get_job_titles_in_department(DEPARTMENT_MEDICAL))]'><a href='?src=\ref[src];jobban3=medicaldept;jobban4=\ref[M]'>Medical Positions</a></th></tr><tr align='center'>"
		for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_MEDICAL))
			if(!jobPos)	continue
			var/datum/job/job = job_master.GetJob(jobPos)
			if(!job) continue

			if(jobban_isbanned(M, job.title))
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'><font color=red>[replacetext(job.title, " ", "&nbsp")]</font></a></td>"
				counter++
			else
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'>[replacetext(job.title, " ", "&nbsp")]</a></td>"
				counter++

			if(counter >= 5) //So things dont get squiiiiished!
				jobs += "</tr><tr align='center'>"
				counter = 0
		jobs += "</tr></table>"

	//Science (Purple)
		counter = 0
		jobs += "<table cellpadding='1' cellspacing='0' width='100%'>"
		jobs += "<tr bgcolor='e79fff'><th colspan='[length(SSjob.get_job_titles_in_department(DEPARTMENT_RESEARCH))]'><a href='?src=\ref[src];jobban3=sciencedept;jobban4=\ref[M]'>Science Positions</a></th></tr><tr align='center'>"
		for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_RESEARCH))
			if(!jobPos)	continue
			var/datum/job/job = job_master.GetJob(jobPos)
			if(!job) continue

			if(jobban_isbanned(M, job.title))
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'><font color=red>[replacetext(job.title, " ", "&nbsp")]</font></a></td>"
				counter++
			else
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'>[replacetext(job.title, " ", "&nbsp")]</a></td>"
				counter++

			if(counter >= 5) //So things dont get squiiiiished!
				jobs += "</tr><tr align='center'>"
				counter = 0
		jobs += "</tr></table>"
	//VOREStation Edit Start
	//Exploration (Purple)
		counter = 0
		jobs += "<table cellpadding='1' cellspacing='0' width='100%'>"
		jobs += "<tr bgcolor='e79fff'><th colspan='[length(SSjob.get_job_titles_in_department(DEPARTMENT_PLANET))]'><a href='?src=\ref[src];jobban3=sciencedept;jobban4=\ref[M]'>Science Positions</a></th></tr><tr align='center'>"
		for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_PLANET))
			if(!jobPos)	continue
			var/datum/job/job = job_master.GetJob(jobPos)
			if(!job) continue

			if(jobban_isbanned(M, job.title))
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'><font color=red>[replacetext(job.title, " ", "&nbsp")]</font></a></td>"
				counter++
			else
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'>[replacetext(job.title, " ", "&nbsp")]</a></td>"
				counter++

			if(counter >= 5) //So things dont get squiiiiished!
				jobs += "</tr><tr align='center'>"
				counter = 0
		jobs += "</tr></table>"
	//VOREstation Edit End
	//Civilian (Grey)
		counter = 0
		jobs += "<table cellpadding='1' cellspacing='0' width='100%'>"
		jobs += "<tr bgcolor='dddddd'><th colspan='[length(SSjob.get_job_titles_in_department(DEPARTMENT_CIVILIAN))]'><a href='?src=\ref[src];jobban3=civiliandept;jobban4=\ref[M]'>Civilian Positions</a></th></tr><tr align='center'>"
		for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_CIVILIAN))
			if(!jobPos)	continue
			var/datum/job/job = job_master.GetJob(jobPos)
			if(!job) continue

			if(jobban_isbanned(M, job.title))
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'><font color=red>[replacetext(job.title, " ", "&nbsp")]</font></a></td>"
				counter++
			else
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'>[replacetext(job.title, " ", "&nbsp")]</a></td>"
				counter++

			if(counter >= 5) //So things dont get squiiiiished!
				jobs += "</tr><tr align='center'>"
				counter = 0

		if(jobban_isbanned(M, "Internal Affairs Agent"))
			jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=Internal Affairs Agent;jobban4=\ref[M]'><font color=red>Internal Affairs Agent</font></a></td>"
		else
			jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=Internal Affairs Agent;jobban4=\ref[M]'>Internal Affairs Agent</a></td>"

		jobs += "</tr></table>"

	//Non-Human (Green)
		counter = 0
		jobs += "<table cellpadding='1' cellspacing='0' width='100%'>"
		jobs += "<tr bgcolor='ccffcc'><th colspan='[length(SSjob.get_job_titles_in_department(DEPARTMENT_SYNTHETIC))+1]'><a href='?src=\ref[src];jobban3=nonhumandept;jobban4=\ref[M]'>Non-human Positions</a></th></tr><tr align='center'>"
		for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_SYNTHETIC))
			if(!jobPos)	continue
			var/datum/job/job = job_master.GetJob(jobPos)
			if(!job) continue

			if(jobban_isbanned(M, job.title))
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'><font color=red>[replacetext(job.title, " ", "&nbsp")]</font></a></td>"
				counter++
			else
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[job.title];jobban4=\ref[M]'>[replacetext(job.title, " ", "&nbsp")]</a></td>"
				counter++

			if(counter >= 5) //So things dont get squiiiiished!
				jobs += "</tr><tr align='center'>"
				counter = 0

		//pAI isn't technically a job, but it goes in here.

		if(jobban_isbanned(M, "pAI"))
			jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=pAI;jobban4=\ref[M]'><font color=red>pAI</font></a></td>"
		else
			jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=pAI;jobban4=\ref[M]'>pAI</a></td>"
		if(jobban_isbanned(M, "AntagHUD"))
			jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=AntagHUD;jobban4=\ref[M]'><font color=red>AntagHUD</font></a></td>"
		else
			jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=AntagHUD;jobban4=\ref[M]'>AntagHUD</a></td>"
		jobs += "</tr></table>"

	//Antagonist (Orange)
		var/isbanned_dept = jobban_isbanned(M, "Syndicate")
		jobs += "<table cellpadding='1' cellspacing='0' width='100%'>"
		jobs += "<tr bgcolor='ffeeaa'><th colspan='10'><a href='?src=\ref[src];jobban3=Syndicate;jobban4=\ref[M]'>Antagonist Positions</a></th></tr><tr align='center'>"

		// Antagonists.
		for(var/antag_type in all_antag_types)
			var/datum/antagonist/antag = all_antag_types[antag_type]
			if(!antag || !antag.bantype)
				continue
			if(jobban_isbanned(M, "[antag.bantype]") || isbanned_dept)
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[antag.bantype];jobban4=\ref[M]'><font color=red>[replacetext("[antag.role_text]", " ", "&nbsp")]</font></a></td>"
			else
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[antag.bantype];jobban4=\ref[M]'>[replacetext("[antag.role_text]", " ", "&nbsp")]</a></td>"

		jobs += "</tr></table>"

	//Other races (Blue) ... And also graffiti.
		var/list/misc_roles = list("Dionaea", "Graffiti", "Custom loadout")
		jobs += "<tr bgcolor='ccccff'><th colspan='[LAZYLEN(misc_roles)]'>Other Roles</th></tr><tr align='center'>"
		for(var/entry in misc_roles)
			if(jobban_isbanned(M, entry))
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[entry];jobban4=\ref[M]'><font color=red>[entry]</font></a></td>"
			else
				jobs += "<td width='20%'><a href='?src=\ref[src];jobban3=[entry];jobban4=\ref[M]'>[entry]</a></td>"
				jobs += "</tr></table>"
		body = "<body>[jobs]</body>"
		dat = "<tt>[header][body]</tt>"
		usr << browse(dat, "window=jobban2;size=800x490")
		return

	//JOBBAN'S INNARDS
	else if(href_list["jobban3"])
		if(!check_rights(R_MOD,0) && !check_rights(R_ADMIN,0))
			to_chat(usr, "<span class='filter_adminlog warning'>You do not have the appropriate permissions to add job bans!</span>")
			return

		if(check_rights(R_MOD,0) && !check_rights(R_ADMIN,0) && !config.mods_can_job_tempban) // If mod and tempban disabled
			to_chat(usr, "<span class='filter_adminlog warning'>Mod jobbanning is disabled!</span>")
			return

		var/mob/M = locate(href_list["jobban4"])
		if(!ismob(M))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob</span>")
			return

		if(M != usr)																//we can jobban ourselves
			if(M.client && M.client.holder && (M.client.holder.rights & R_BAN))		//they can ban too. So we can't ban them
				tgui_alert_async(usr, "You cannot perform this action. You must be of a higher administrative rank!")
				return

		if(!job_master)
			to_chat(usr, "<span class='filter_adminlog'>Job Master has not been setup!</span>")
			return

		//get jobs for department if specified, otherwise just returnt he one job in a list.
		var/list/joblist = list()
		switch(href_list["jobban3"])
			if("commanddept")
				for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_COMMAND))
					if(!jobPos)	continue
					var/datum/job/temp = job_master.GetJob(jobPos)
					if(!temp) continue
					joblist += temp.title
			if("securitydept")
				for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_SECURITY))
					if(!jobPos)	continue
					var/datum/job/temp = job_master.GetJob(jobPos)
					if(!temp) continue
					joblist += temp.title
			if("engineeringdept")
				for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_ENGINEERING))
					if(!jobPos)	continue
					var/datum/job/temp = job_master.GetJob(jobPos)
					if(!temp) continue
					joblist += temp.title
			if("cargodept")
				for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_CARGO))
					if(!jobPos)	continue
					var/datum/job/temp = job_master.GetJob(jobPos)
					if(!temp) continue
					joblist += temp.title
			if("medicaldept")
				for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_MEDICAL))
					if(!jobPos)	continue
					var/datum/job/temp = job_master.GetJob(jobPos)
					if(!temp) continue
					joblist += temp.title
			if("sciencedept")
				for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_RESEARCH))
					if(!jobPos)	continue
					var/datum/job/temp = job_master.GetJob(jobPos)
					if(!temp) continue
					joblist += temp.title
			//VOREStation Edit Start
			if("explorationdept")
				for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_PLANET))
					if(!jobPos)	continue
					var/datum/job/temp = job_master.GetJob(jobPos)
					if(!temp) continue
					joblist += temp.title
			//VOREStation Edit End
			if("civiliandept")
				for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_CIVILIAN))
					if(!jobPos)	continue
					var/datum/job/temp = job_master.GetJob(jobPos)
					if(!temp) continue
					joblist += temp.title
			if("nonhumandept")
				joblist += "pAI"
				for(var/jobPos in SSjob.get_job_titles_in_department(DEPARTMENT_SYNTHETIC))
					if(!jobPos)	continue
					var/datum/job/temp = job_master.GetJob(jobPos)
					if(!temp) continue
					joblist += temp.title
			else
				joblist += href_list["jobban3"]

		//Create a list of unbanned jobs within joblist
		var/list/notbannedlist = list()
		for(var/job in joblist)
			if(!jobban_isbanned(M, job))
				notbannedlist += job

		//Banning comes first
		if(notbannedlist.len) //at least 1 unbanned job exists in joblist so we have stuff to ban.
			switch(tgui_alert(usr, "Temporary Ban?","Temporary Ban", list("Yes","No","Cancel")))
				if("Yes")
					if(!check_rights(R_MOD,0) && !check_rights(R_BAN, 0))
						to_chat(usr, "<span class='filter_adminlog warning'> You cannot issue temporary job-bans!</span>")
						return
					if(config.ban_legacy_system)
						to_chat(usr, "<span class='filter_adminlog warning'>Your server is using the legacy banning system, which does not support temporary job bans. Consider upgrading. Aborting ban.</span>")
						return
					var/mins = input(usr,"How long (in minutes)?","Ban time",1440) as num|null
					if(!mins)
						return
					if(check_rights(R_MOD, 0) && !check_rights(R_BAN, 0) && mins > config.mod_job_tempban_max)
						to_chat(usr, "<span class='filter_adminlog warning'> Moderators can only job tempban up to [config.mod_job_tempban_max] minutes!</span>")
						return
					var/reason = sanitize(input(usr,"Reason?","Please State Reason","") as text|null)
					if(!reason)
						return

					var/msg
					for(var/job in notbannedlist)
						ban_unban_log_save("[key_name(usr)] temp-jobbanned [key_name(M)] from [job] for [mins] minutes. reason: [reason]")
						log_admin("[key_name(usr)] temp-jobbanned [key_name(M)] from [job] for [mins] minutes")
						feedback_inc("ban_job_tmp",1)
						DB_ban_record(BANTYPE_JOB_TEMP, M, mins, reason, job)
						feedback_add_details("ban_job_tmp","- [job]")
						jobban_fullban(M, job, "[reason]; By [usr.ckey] on [time2text(world.realtime)]") //Legacy banning does not support temporary jobbans.
						if(!msg)
							msg = job
						else
							msg += ", [job]"
					notes_add(M.ckey, "Banned  from [msg] - [reason]", usr)
					message_admins("<font color='blue'>[key_name_admin(usr)] banned [key_name_admin(M)] from [msg] for [mins] minutes</font>", 1)
					to_chat(M, "<span class='filter_system'><font color='red'><BIG><B>You have been jobbanned by [usr.client.ckey] from: [msg].</B></BIG></font></span>")
					to_chat(M, "<span class='filter_system'><font color='red'><B>The reason is: [reason]</B></font></span>")
					to_chat(M, "<span class='filter_system'><font color='red'>This jobban will be lifted in [mins] minutes.</font></span>")
					href_list["jobban2"] = 1 // lets it fall through and refresh
					return 1
				if("No")
					if(!check_rights(R_BAN))  return
					var/reason = sanitize(input(usr,"Reason?","Please State Reason","") as text|null)
					if(reason)
						var/msg
						for(var/job in notbannedlist)
							ban_unban_log_save("[key_name(usr)] perma-jobbanned [key_name(M)] from [job]. reason: [reason]")
							log_admin("[key_name(usr)] perma-banned [key_name(M)] from [job]")
							feedback_inc("ban_job",1)
							DB_ban_record(BANTYPE_JOB_PERMA, M, -1, reason, job)
							feedback_add_details("ban_job","- [job]")
							jobban_fullban(M, job, "[reason]; By [usr.ckey] on [time2text(world.realtime)]")
							if(!msg)	msg = job
							else		msg += ", [job]"
						notes_add(M.ckey, "Banned  from [msg] - [reason]", usr)
						message_admins("<font color='blue'>[key_name_admin(usr)] banned [key_name_admin(M)] from [msg]</font>", 1)
						to_chat(M, "<span class='filter_system'><font color='red'><BIG><B>You have been jobbanned by [usr.client.ckey] from: [msg].</B></BIG></font></span>")
						to_chat(M, "<span class='filter_system'><font color='red'><B>The reason is: [reason]</B></font></span>")
						to_chat(M, "<span class='filter_system'><font color='red'>Jobban can be lifted only upon request.</font></span>")
						href_list["jobban2"] = 1 // lets it fall through and refresh
						return 1
				if("Cancel")
					return

		//Unbanning joblist
		//all jobs in joblist are banned already OR we didn't give a reason (implying they shouldn't be banned)
		if(joblist.len) //at least 1 banned job exists in joblist so we have stuff to unban.
			if(!config.ban_legacy_system)
				to_chat(usr, "<span class='filter_adminlog'>Unfortunately, database based unbanning cannot be done through this panel</span>")
				DB_ban_panel(M.ckey)
				return
			var/msg
			for(var/job in joblist)
				var/reason = jobban_isbanned(M, job)
				if(!reason) continue //skip if it isn't jobbanned anyway
				switch(tgui_alert(usr, "Job: '[job]' Reason: '[reason]' Un-jobban?","Please Confirm",list("Yes","No")))
					if("Yes")
						ban_unban_log_save("[key_name(usr)] unjobbanned [key_name(M)] from [job]")
						log_admin("[key_name(usr)] unbanned [key_name(M)] from [job]")
						DB_ban_unban(M.ckey, BANTYPE_JOB_PERMA, job)
						feedback_inc("ban_job_unban",1)
						feedback_add_details("ban_job_unban","- [job]")
						jobban_unban(M, job)
						if(!msg)	msg = job
						else		msg += ", [job]"
					else
						continue
			if(msg)
				message_admins("<font color='blue'>[key_name_admin(usr)] unbanned [key_name_admin(M)] from [msg]</font>", 1)
				to_chat(M, "<span class='filter_system danger'><BIG>You have been un-jobbanned by [usr.client.ckey] from [msg].</BIG></span>")
				href_list["jobban2"] = 1 // lets it fall through and refresh
			return 1
		return 0 //we didn't do anything!

	else if(href_list["boot2"])
		var/mob/M = locate(href_list["boot2"])
		if (ismob(M))
			if(!check_if_greater_rights_than(M.client))
				return
			var/reason = sanitize(input(usr, "Please enter reason.") as null|message)
			if(!reason)
				return

			to_chat(M, span("filter_system critical", "You have been kicked from the server: [reason]"))
			log_admin("[key_name(usr)] booted [key_name(M)] for reason: '[reason]'.")
			message_admins("<font color='blue'>[key_name_admin(usr)] booted [key_name_admin(M)] for reason '[reason]'.</font>", 1)
			//M.client = null
			admin_action_message(usr.key, M.key, "kicked", reason, 0) //VOREStation Add
			qdel(M.client)

	else if(href_list["removejobban"])
		if(!check_rights(R_BAN))	return

		var/t = href_list["removejobban"]
		if(t)
			if((tgui_alert(usr, "Do you want to unjobban [t]?","Unjobban confirmation", list("Yes", "No")) == "Yes") && t) //No more misclicks! Unless you do it twice.
				log_admin("[key_name(usr)] removed [t]")
				message_admins("<font color='blue'>[key_name_admin(usr)] removed [t]</font>", 1)
				jobban_remove(t)
				href_list["ban"] = 1 // lets it fall through and refresh
				var/t_split = splittext(t, " - ")
				var/key = t_split[1]
				var/job = t_split[2]
				DB_ban_unban(ckey(key), BANTYPE_JOB_PERMA, job)

	else if(href_list["newban"])
		if(!check_rights(R_MOD,0) && !check_rights(R_BAN, 0))
			to_chat(usr, "<span class='warning'>You do not have the appropriate permissions to add bans!</span>")
			return

		if(check_rights(R_MOD,0) && !check_rights(R_ADMIN, 0) && !config.mods_can_job_tempban) // If mod and tempban disabled
			to_chat(usr, "<span class='warning'>Mod jobbanning is disabled!</span>")
			return

		var/mob/M = locate(href_list["newban"])
		if(!ismob(M)) return

		if(M.client && M.client.holder)	return	//admins cannot be banned. Even if they could, the ban doesn't affect them anyway

		switch(tgui_alert(usr, "Temporary Ban?","Temporary Ban",list("Yes","No","Cancel")))
			if("Yes")
				var/mins = input(usr,"How long (in minutes)?","Ban time",1440) as num|null
				if(!mins)
					return
				if(check_rights(R_MOD, 0) && !check_rights(R_BAN, 0) && mins > config.mod_tempban_max)
					to_chat(usr, "<span class='warning'>Moderators can only job tempban up to [config.mod_tempban_max] minutes!</span>")
					return
				if(mins >= 525600) mins = 525599
				var/reason = sanitize(input(usr,"Reason?","reason","Griefer") as text|null)
				if(!reason)
					return
				AddBan(M.ckey, M.computer_id, reason, usr.ckey, 1, mins)
				ban_unban_log_save("[usr.client.ckey] has banned [M.ckey]. - Reason: [reason] - This will be removed in [mins] minutes.")
				notes_add(M.ckey,"[usr.client.ckey] has banned [M.ckey]. - Reason: [reason] - This will be removed in [mins] minutes.",usr)
				to_chat(M, "<span class='filter_system critical'>You have been banned by [usr.client.ckey].\nReason: [reason].</span>")
				to_chat(M, "<span class='filter_system warning'>This is a temporary ban, it will be removed in [mins] minutes.</span>")
				feedback_inc("ban_tmp",1)
				DB_ban_record(BANTYPE_TEMP, M, mins, reason)
				feedback_inc("ban_tmp_mins",mins)
				if(config.banappeals)
					to_chat(M, "<span class='filter_system warning'>To try to resolve this matter head to [config.banappeals]</span>")
				else
					to_chat(M, "<span class='filter_system warning'>No ban appeals URL has been set.</span>")
				log_admin("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis will be removed in [mins] minutes.")
				message_admins("<font color='blue'>[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis will be removed in [mins] minutes.</font>")
				var/datum/admin_help/AH = M.client ? M.client.current_ticket : null
				if(AH)
					AH.Resolve()
				qdel(M.client)
				//qdel(M)	// See no reason why to delete mob. Important stuff can be lost. And ban can be lifted before round ends.
			if("No")
				if(!check_rights(R_BAN))   return
				var/reason = sanitize(input(usr,"Reason?","reason","Griefer") as text|null)
				if(!reason)
					return
				switch(tgui_alert(usr,"IP ban?","IP Ban",list("Yes","No","Cancel")))
					if("Cancel")	return
					if("Yes")
						AddBan(M.ckey, M.computer_id, reason, usr.ckey, 0, 0, M.lastKnownIP)
					if("No")
						AddBan(M.ckey, M.computer_id, reason, usr.ckey, 0, 0)
				to_chat(M, "<span class='filter_system critical'>You have been banned by [usr.client.ckey].\nReason: [reason].</span>")
				to_chat(M, "<span class='filter_system warning'>This is a permanent ban.</span>")
				if(config.banappeals)
					to_chat(M, "<span class='filter_system warning'>To try to resolve this matter head to [config.banappeals]</span>")
				else
					to_chat(M, "<span class='filter_system warning'>No ban appeals URL has been set.</span>")
				ban_unban_log_save("[usr.client.ckey] has permabanned [M.ckey]. - Reason: [reason] - This is a permanent ban.")
				notes_add(M.ckey,"[usr.client.ckey] has permabanned [M.ckey]. - Reason: [reason] - This is a permanent ban.",usr)
				log_admin("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis is a permanent ban.")
				message_admins("<font color='blue'>[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis is a permanent ban.</font>")
				feedback_inc("ban_perma",1)
				DB_ban_record(BANTYPE_PERMA, M, -1, reason)
				var/datum/admin_help/AH = M.client ? M.client.current_ticket : null
				if(AH)
					AH.Resolve()
				qdel(M.client)
				//qdel(M)
			if("Cancel")
				return

	else if(href_list["mute"])
		if(!check_rights(R_MOD,0) && !check_rights(R_ADMIN))  return

		var/mob/M = locate(href_list["mute"])
		if(!ismob(M))	return
		if(!M.client)	return

		var/mute_type = href_list["mute_type"]
		if(istext(mute_type))	mute_type = text2num(mute_type)
		if(!isnum(mute_type))	return

		cmd_admin_mute(M, mute_type)

	else if(href_list["c_mode"])
		if(!check_rights(R_ADMIN|R_EVENT))	return

		if(ticker && ticker.mode)
			return tgui_alert_async(usr, "The game has already started.")
		var/dat = {"<B>What mode do you wish to play?</B><HR>"}
		for(var/mode in config.modes)
			dat += {"<A href='?src=\ref[src];c_mode2=[mode]'>[config.mode_names[mode]]</A><br>"}
		dat += {"<A href='?src=\ref[src];c_mode2=secret'>Secret</A><br>"}
		dat += {"<A href='?src=\ref[src];c_mode2=random'>Random</A><br>"}
		dat += {"Now: [master_mode]"}
		usr << browse(dat, "window=c_mode")

	else if(href_list["f_secret"])
		if(!check_rights(R_ADMIN|R_EVENT))	return

		if(ticker && ticker.mode)
			return tgui_alert_async(usr, "The game has already started.")
		if(master_mode != "secret")
			return tgui_alert_async(usr, "The game mode has to be secret!")
		var/dat = {"<B>What game mode do you want to force secret to be? Use this if you want to change the game mode, but want the players to believe it's secret. This will only work if the current game mode is secret.</B><HR>"}
		for(var/mode in config.modes)
			dat += {"<A href='?src=\ref[src];f_secret2=[mode]'>[config.mode_names[mode]]</A><br>"}
		dat += {"<A href='?src=\ref[src];f_secret2=secret'>Random (default)</A><br>"}
		dat += {"Now: [secret_force_mode]"}
		usr << browse(dat, "window=f_secret")

	else if(href_list["c_mode2"])
		if(!check_rights(R_ADMIN|R_SERVER|R_EVENT))	return

		if (ticker && ticker.mode)
			return tgui_alert_async(usr, "The game has already started.")
		master_mode = href_list["c_mode2"]
		log_admin("[key_name(usr)] set the mode as [config.mode_names[master_mode]].")
		message_admins("<font color='blue'>[key_name_admin(usr)] set the mode as [config.mode_names[master_mode]].</font>", 1)
		to_world("<font color='blue'><b>The mode is now: [config.mode_names[master_mode]]</b></font>")
		Game() // updates the main game menu
		world.save_mode(master_mode)
		.(href, list("c_mode"=1))

	else if(href_list["f_secret2"])
		if(!check_rights(R_ADMIN|R_SERVER|R_EVENT))	return

		if(ticker && ticker.mode)
			return tgui_alert_async(usr, "The game has already started.")
		if(master_mode != "secret")
			return tgui_alert_async(usr, "The game mode has to be secret!")
		secret_force_mode = href_list["f_secret2"]
		log_admin("[key_name(usr)] set the forced secret mode as [secret_force_mode].")
		message_admins("<font color='blue'>[key_name_admin(usr)] set the forced secret mode as [secret_force_mode].</font>", 1)
		Game() // updates the main game menu
		.(href, list("f_secret"=1))

	else if(href_list["monkeyone"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/human/H = locate(href_list["monkeyone"])
		if(!istype(H))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob/living/carbon/human</span>")
			return

		log_admin("[key_name(usr)] attempting to monkeyize [key_name(H)]")
		message_admins("<font color='blue'>[key_name_admin(usr)] attempting to monkeyize [key_name_admin(H)]</font>", 1)
		H.monkeyize()

	else if(href_list["corgione"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/human/H = locate(href_list["corgione"])
		if(!istype(H))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob/living/carbon/human</span>")
			return

		log_admin("[key_name(usr)] attempting to corgize [key_name(H)]")
		message_admins("<font color='blue'>[key_name_admin(usr)] attempting to corgize [key_name_admin(H)]</font>", 1)
		H.corgize()

	else if(href_list["forcespeech"])
		if(!check_rights(R_FUN))	return

		var/mob/M = locate(href_list["forcespeech"])
		if(!ismob(M))
			to_chat(usr, "<span class='filter_adminlog'>this can only be used on instances of type /mob</span>")

		var/speech = input(usr, "What will [key_name(M)] say?.", "Force speech", "") // Don't need to sanitize, since it does that in say(), we also trust our admins.
		if(!speech)	return
		M.say(speech)
		speech = sanitize(speech) // Nah, we don't trust them
		log_admin("[key_name(usr)] forced [key_name(M)] to say: [speech]")
		message_admins("<font color='blue'>[key_name_admin(usr)] forced [key_name_admin(M)] to say: [speech]</font>")

	else if(href_list["sendtoprison"])
		if(!check_rights(R_ADMIN))	return

		if(tgui_alert(usr, "Send to admin prison for the round?", "Message", list("Yes", "No")) != "Yes")
			return

		var/mob/M = locate(href_list["sendtoprison"])
		if(!ismob(M))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob</span>")
			return
		if(istype(M, /mob/living/silicon/ai))
			to_chat(usr, "<span class='filter_adminlog'>This cannot be used on instances of type /mob/living/silicon/ai</span>")
			return

		var/turf/prison_cell = pick(prisonwarp)
		if(!prison_cell)	return

		var/obj/structure/closet/secure_closet/brig/locker = new /obj/structure/closet/secure_closet/brig(prison_cell)
		locker.opened = 0
		locker.locked = 1

		//strip their stuff and stick it in the crate
		for(var/obj/item/I in M)
			M.drop_from_inventory(I, locker)

		//so they black out before warping
		M.Paralyse(5)
		sleep(5)
		if(!M)	return

		M.loc = prison_cell
		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/prisoner = M
			prisoner.equip_to_slot_or_del(new /obj/item/clothing/under/color/prison(prisoner), slot_w_uniform)
			prisoner.equip_to_slot_or_del(new /obj/item/clothing/shoes/orange(prisoner), slot_shoes)

		to_chat(M, "<span class='filter_system warning'>You have been sent to the prison station!</span>")
		log_admin("[key_name(usr)] sent [key_name(M)] to the prison station.")
		message_admins("<font color='blue'>[key_name_admin(usr)] sent [key_name_admin(M)] to the prison station.</font>", 1)

	else if(href_list["sendbacktolobby"])
		if(!check_rights(R_ADMIN))
			return

		var/mob/M = locate(href_list["sendbacktolobby"])
		if(!isobserver(M))
			to_chat(usr, "<span class='filter_adminlog notice'>You can only send ghost players back to the Lobby.</span>")
			return

		if(!M.client)
			to_chat(usr, "<span class='filter_adminlog warning'>[M] doesn't seem to have an active client.</span>")
			return

		if(tgui_alert(usr, "Send [key_name(M)] back to Lobby?", "Message", list("Yes", "No")) != "Yes")
			return

		log_admin("[key_name(usr)] has sent [key_name(M)] back to the Lobby.")
		message_admins("[key_name(usr)] has sent [key_name(M)] back to the Lobby.")

		var/mob/new_player/NP = new()
		NP.ckey = M.ckey
		qdel(M)

	else if(href_list["tdome1"])
		if(!check_rights(R_FUN))	return

		if(tgui_alert(usr, "Confirm?", "Message", list("Yes", "No")) != "Yes")
			return

		var/mob/M = locate(href_list["tdome1"])
		if(!ismob(M))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob</span>")
			return
		if(istype(M, /mob/living/silicon/ai))
			to_chat(usr, "<span class='filter_adminlog'>This cannot be used on instances of type /mob/living/silicon/ai</span>")
			return

		for(var/obj/item/I in M)
			M.drop_from_inventory(I)

		M.Paralyse(5)
		sleep(5)
		M.loc = pick(tdome1)
		spawn(50)
			to_chat(M, "<span class='filter_system notice'>You have been sent to the Thunderdome.</span>")
		log_admin("[key_name(usr)] has sent [key_name(M)] to the thunderdome. (Team 1)")
		message_admins("[key_name_admin(usr)] has sent [key_name_admin(M)] to the thunderdome. (Team 1)", 1)

	else if(href_list["tdome2"])
		if(!check_rights(R_FUN))	return

		if(tgui_alert(usr, "Confirm?", "Message", list("Yes", "No")) != "Yes")
			return

		var/mob/M = locate(href_list["tdome2"])
		if(!ismob(M))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob</span>")
			return
		if(istype(M, /mob/living/silicon/ai))
			to_chat(usr, "<span class='filter_adminlog'>This cannot be used on instances of type /mob/living/silicon/ai</span>")
			return

		for(var/obj/item/I in M)
			M.drop_from_inventory(I)

		M.Paralyse(5)
		sleep(5)
		M.loc = pick(tdome2)
		spawn(50)
			to_chat(M, "<span class='filter_system notice'>You have been sent to the Thunderdome.</span>")
		log_admin("[key_name(usr)] has sent [key_name(M)] to the thunderdome. (Team 2)")
		message_admins("[key_name_admin(usr)] has sent [key_name_admin(M)] to the thunderdome. (Team 2)", 1)

	else if(href_list["tdomeadmin"])
		if(!check_rights(R_FUN))	return

		if(tgui_alert(usr, "Confirm?", "Message", list("Yes", "No")) != "Yes")
			return

		var/mob/M = locate(href_list["tdomeadmin"])
		if(!ismob(M))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob</span>")
			return
		if(istype(M, /mob/living/silicon/ai))
			to_chat(usr, "<span class='filter_adminlog'>This cannot be used on instances of type /mob/living/silicon/ai</span>")
			return

		M.Paralyse(5)
		sleep(5)
		M.loc = pick(tdomeadmin)
		spawn(50)
			to_chat(M, "<span class='filter_system notice'>You have been sent to the Thunderdome.</span>")
		log_admin("[key_name(usr)] has sent [key_name(M)] to the thunderdome. (Admin.)")
		message_admins("[key_name_admin(usr)] has sent [key_name_admin(M)] to the thunderdome. (Admin.)", 1)

	else if(href_list["tdomeobserve"])
		if(!check_rights(R_FUN))	return

		if(tgui_alert(usr, "Confirm?", "Message", list("Yes", "No")) != "Yes")
			return

		var/mob/M = locate(href_list["tdomeobserve"])
		if(!ismob(M))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob</span>")
			return
		if(istype(M, /mob/living/silicon/ai))
			to_chat(usr, "<span class='filter_adminlog'>This cannot be used on instances of type /mob/living/silicon/ai</span>")
			return

		for(var/obj/item/I in M)
			M.drop_from_inventory(I)

		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/observer = M
			observer.equip_to_slot_or_del(new /obj/item/clothing/under/suit_jacket(observer), slot_w_uniform)
			observer.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(observer), slot_shoes)
		M.Paralyse(5)
		sleep(5)
		M.loc = pick(tdomeobserve)
		spawn(50)
			to_chat(M, "<span class='filter_system notice'>You have been sent to the Thunderdome.</span>")
		log_admin("[key_name(usr)] has sent [key_name(M)] to the thunderdome. (Observer.)")
		message_admins("[key_name_admin(usr)] has sent [key_name_admin(M)] to the thunderdome. (Observer.)", 1)

	else if(href_list["revive"])
		if(!check_rights(R_REJUVINATE))	return

		var/mob/living/L = locate(href_list["revive"])
		if(!istype(L))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob/living</span>")
			return

		if(config.allow_admin_rev)
			L.revive()
			message_admins("<font color='red'>Admin [key_name_admin(usr)] healed / revived [key_name_admin(L)]!</font>", 1)
			log_admin("[key_name(usr)] healed / Rrvived [key_name(L)]")
		else
			to_chat(usr, "<span class='filter_adminlog filter_warning'>Admin Rejuvinates have been disabled</span>")

	else if(href_list["makeai"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/human/H = locate(href_list["makeai"])
		if(!istype(H))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob/living/carbon/human</span>")
			return

		message_admins("<font color='red'>Admin [key_name_admin(usr)] AIized [key_name_admin(H)]!</font>", 1)
		log_admin("[key_name(usr)] AIized [key_name(H)]")
		H.AIize()

	else if(href_list["makealien"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/human/H = locate(href_list["makealien"])
		if(!istype(H))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob/living/carbon/human</span>")
			return

		usr.client.cmd_admin_alienize(H)

	else if(href_list["makerobot"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/human/H = locate(href_list["makerobot"])
		if(!istype(H))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob/living/carbon/human</span>")
			return

		usr.client.cmd_admin_robotize(H)

	else if(href_list["makeanimal"])
		if(!check_rights(R_SPAWN))	return

		var/mob/M = locate(href_list["makeanimal"])
		if(istype(M, /mob/new_player))
			to_chat(usr, "<span class='filter_adminlog'>This cannot be used on instances of type /mob/new_player</span>")
			return

		usr.client.cmd_admin_animalize(M)

	else if(href_list["respawn"])
		if(!check_rights(R_SPAWN))
			return

		var/client/C = locate(href_list["respawn"])
		if(!istype(C))
			return
		usr.client.respawn_character_proper(C)

	else if(href_list["togmutate"])
		if(!check_rights(R_SPAWN))	return

		var/mob/living/carbon/human/H = locate(href_list["togmutate"])
		if(!istype(H))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob/living/carbon/human</span>")
			return
		var/block=text2num(href_list["block"])
		usr.client.cmd_admin_toggle_block(H,block)
		show_player_panel(H)

	else if(href_list["adminplayeropts"])
		var/mob/M = locate(href_list["adminplayeropts"])
		show_player_panel(M)

	else if(href_list["adminplayerobservejump"])
		if(!check_rights(R_MOD|R_ADMIN|R_SERVER))	return //VOREStation Edit

		var/mob/M = locate(href_list["adminplayerobservejump"])

		var/client/C = usr.client
		if(!isobserver(usr))	C.admin_ghost()
		sleep(2)
		C.jumptomob(M)

	else if(href_list["adminplayerobservefollow"])
		if(!check_rights(R_MOD|R_ADMIN|R_SERVER)) //VOREStation Edit
			return

		var/mob/M = locate(href_list["adminplayerobservefollow"])

		var/client/C = usr.client
		if(!isobserver(usr))	C.admin_ghost()
		var/mob/observer/dead/G = C.mob
		sleep(2)
		G.ManualFollow(M)

	else if(href_list["check_antagonist"])
		check_antagonists()

	else if(href_list["take_question"])

		var/mob/M = locate(href_list["take_question"])
		if(ismob(M))
			var/take_msg = "<span class='notice'><b>ADMINHELP</b>: <b>[key_name(usr.client)]</b> is attending to <b>[key_name(M)]'s</b> adminhelp, please don't dogpile them.</span>"
			for(var/client/X in GLOB.admins)
				if((R_ADMIN|R_MOD|R_SERVER) & X.holder.rights) //VOREStation Edit
					to_chat(X, take_msg)
			to_chat(M, "<span class='filter_pm notice'><b>Your adminhelp is being attended to by [usr.client]. Thanks for your patience!</b></span>")
			// VoreStation Edit Start
			if (config.chat_webhook_url)
				spawn(0)
					var/query_string = "type=admintake"
					query_string += "&key=[url_encode(config.chat_webhook_key)]"
					query_string += "&admin=[url_encode(key_name(usr.client))]"
					query_string += "&user=[url_encode(key_name(M))]"
					world.Export("[config.chat_webhook_url]?[query_string]")
			// VoreStation Edit End
		else
			to_chat(usr, "<span class='warning'>Unable to locate mob.</span>")

	else if(href_list["adminplayerobservecoodjump"])
		if(!check_rights(R_ADMIN|R_SERVER|R_MOD))	return //VOREStation Edit

		var/x = text2num(href_list["X"])
		var/y = text2num(href_list["Y"])
		var/z = text2num(href_list["Z"])

		var/client/C = usr.client
		if(!isobserver(usr))	C.admin_ghost()
		sleep(2)
		C.jumptocoord(x,y,z)

	else if(href_list["adminchecklaws"])
		output_ai_laws()

	else if(href_list["adminmoreinfo"])
		var/mob/M = locate(href_list["adminmoreinfo"])
		if(!ismob(M))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob</span>")
			return

		var/location_description = ""
		var/special_role_description = ""
		var/health_description = ""
		var/gender_description = ""
		var/turf/T = get_turf(M)

		//Location
		if(isturf(T))
			if(isarea(T.loc))
				location_description = "([M.loc == T ? "at coordinates " : "in [M.loc] at coordinates "] [T.x], [T.y], [T.z] in area <b>[T.loc]</b>)"
			else
				location_description = "([M.loc == T ? "at coordinates " : "in [M.loc] at coordinates "] [T.x], [T.y], [T.z])"

		//Job + antagonist
		if(M.mind)
			special_role_description = "Role: <b>[M.mind.assigned_role]</b>; Antagonist: <font color='red'><b>[M.mind.special_role]</b></font>; Has been rev: [(M.mind.has_been_rev)?"Yes":"No"]"
		else
			special_role_description = "Role: <i>Mind datum missing</i> Antagonist: <i>Mind datum missing</i>; Has been rev: <i>Mind datum missing</i>;"

		//Health
		if(isliving(M))
			var/mob/living/L = M
			var/status
			switch (M.stat)
				if (0) status = "Alive"
				if (1) status = "<font color='orange'><b>Unconscious</b></font>"
				if (2) status = "<font color='red'><b>Dead</b></font>"
			health_description = "Status = [status]"
			health_description += "<BR>Oxy: [L.getOxyLoss()] - Tox: [L.getToxLoss()] - Fire: [L.getFireLoss()] - Brute: [L.getBruteLoss()] - Clone: [L.getCloneLoss()] - Brain: [L.getBrainLoss()]"
		else
			health_description = "This mob type has no health to speak of."

		//Gener
		switch(M.gender)
			if(MALE,FEMALE)	gender_description = "[M.gender]"
			else			gender_description = "<font color='red'><b>[M.gender]</b></font>"

		to_chat(src.owner, "<span class='filter_adminlog'><b>Info about [M.name]:</b><br>\
							Mob type = [M.type]; Gender = [gender_description] Damage = [health_description]<br>\
							Name = <b>[M.name]</b>; Real_name = [M.real_name]; Mind_name = [M.mind?"[M.mind.name]":""]; Key = <b>[M.key]</b>;<br>\
							Location = [location_description];<br>\
							[special_role_description]<br>\
							(<a href='?src=\ref[usr];priv_msg=\ref[M]'>PM</a>) (<A HREF='?src=\ref[src];adminplayeropts=\ref[M]'>PP</A>) (<A HREF='?_src_=vars;Vars=\ref[M]'>VV</A>) \
							(<A HREF='?src=\ref[src];subtlemessage=\ref[M]'>SM</A>) ([admin_jump_link(M, src)]) (<A HREF='?src=\ref[src];secretsadmin=check_antagonist'>CA</A>)</span>")

	else if(href_list["adminspawncookie"])
		if(!check_rights(R_ADMIN|R_FUN|R_EVENT))	return

		var/mob/living/carbon/human/H = locate(href_list["adminspawncookie"])
		if(!ishuman(H))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob/living/carbon/human</span>")
			return

		H.equip_to_slot_or_del( new /obj/item/weapon/reagent_containers/food/snacks/cookiesnack(H), slot_l_hand )
		if(!(istype(H.l_hand,/obj/item/weapon/reagent_containers/food/snacks/cookiesnack)))
			H.equip_to_slot_or_del( new /obj/item/weapon/reagent_containers/food/snacks/cookiesnack(H), slot_r_hand )
			if(!(istype(H.r_hand,/obj/item/weapon/reagent_containers/food/snacks/cookiesnack)))
				log_admin("[key_name(H)] has their hands full, so they did not receive their cookie, spawned by [key_name(src.owner)].")
				message_admins("[key_name(H)] has their hands full, so they did not receive their cookie, spawned by [key_name(src.owner)].")
				return
			else
				H.update_inv_r_hand()//To ensure the icon appears in the HUD
		else
			H.update_inv_l_hand()
		log_admin("[key_name(H)] got their cookie, spawned by [key_name(src.owner)]")
		message_admins("[key_name(H)] got their cookie, spawned by [key_name(src.owner)]")
		feedback_inc("admin_cookies_spawned",1)
		to_chat(H, "<span class='notice'>Your prayers have been answered!! You received the <b>best cookie</b>!</span>")

	else if(href_list["adminsmite"])
		if(!check_rights(R_ADMIN|R_FUN|R_EVENT))	return

		var/mob/living/carbon/human/H = locate(href_list["adminsmite"])
		if(!ishuman(H))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob/living/carbon/human</span>")
			return

		owner.smite(H)

	else if(href_list["BlueSpaceArtillery"])
		if(!check_rights(R_ADMIN|R_FUN|R_EVENT))	return

		var/mob/living/M = locate(href_list["BlueSpaceArtillery"])
		if(!isliving(M))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob/living</span>")
			return

		if(tgui_alert(src.owner, "Are you sure you wish to hit [key_name(M)] with Blue Space Artillery?", "Confirm Firing?", list("Yes", "No")) != "Yes")
			return

		bluespace_artillery(M,src)

	else if(href_list["CentComReply"])
		var/mob/living/L = locate(href_list["CentComReply"])
		if(!istype(L))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob/living/</span>")
			return

		if(L.can_centcom_reply())
			var/input = sanitize(input(src.owner, "Please enter a message to reply to [key_name(L)] via their headset.","Outgoing message from CentCom", ""))
			if(!input)		return

			to_chat(src.owner, "<span class='filter_adminlog'>You sent [input] to [L] via a secure channel.</span>")
			log_admin("[src.owner] replied to [key_name(L)]'s CentCom message with the message [input].")
			message_admins("[src.owner] replied to [key_name(L)]'s CentCom message with: \"[input]\"")
			if(!isAI(L))
				to_chat(L, "<span class='info'>You hear something crackle in your headset for a moment before a voice speaks.</span>")
			to_chat(L, "<span class='info'>Please stand by for a message from Central Command.</span>")
			to_chat(L, "<span class='info'>Message as follows.</span>")
			to_chat(L, "<span class='notice'>[input]</span>")
			to_chat(L, "<span class='info'>Message ends.</span>")
		else
			to_chat(src.owner, "<span class='filter_adminlog'>The person you are trying to contact does not have functional radio equipment.</span>")


	else if(href_list["SyndicateReply"])
		var/mob/living/carbon/human/H = locate(href_list["SyndicateReply"])
		if(!istype(H))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob/living/carbon/human</span>")
			return
		if(!istype(H.l_ear, /obj/item/device/radio/headset) && !istype(H.r_ear, /obj/item/device/radio/headset))
			to_chat(usr, "<span class='filter_adminlog'>The person you are trying to contact is not wearing a headset</span>")
			return

		var/input = sanitize(input(src.owner, "Please enter a message to reply to [key_name(H)] via their headset.","Outgoing message from a shadowy figure...", ""))
		if(!input)	return

		to_chat(src.owner, "<span class='filter_adminlog'>You sent [input] to [H] via a secure channel.</span>")
		log_admin("[src.owner] replied to [key_name(H)]'s illegal message with the message [input].")
		to_chat(H, "<span class='filter_notice'>You hear something crackle in your headset for a moment before a voice speaks.  \
					\"Please stand by for a message from your benefactor.  Message as follows, agent. <b>\"[input]\"</b>  Message ends.\"</span>")

	else if(href_list["AdminFaxView"])
		var/obj/item/fax = locate(href_list["AdminFaxView"])
		if (istype(fax, /obj/item/weapon/paper))
			var/obj/item/weapon/paper/P = fax
			P.show_content(usr,1)
		else if (istype(fax, /obj/item/weapon/photo))
			var/obj/item/weapon/photo/H = fax
			H.show(usr)
		else if (istype(fax, /obj/item/weapon/paper_bundle))
			//having multiple people turning pages on a paper_bundle can cause issues
			//open a browse window listing the contents instead
			var/data = ""
			var/obj/item/weapon/paper_bundle/B = fax

			for (var/page = 1, page <= B.pages.len, page++)
				var/obj/pageobj = B.pages[page]
				data += "<A href='?src=\ref[src];AdminFaxViewPage=[page];paper_bundle=\ref[B]'>Page [page] - [pageobj.name]</A><BR>"

			usr << browse(data, "window=[B.name]")
		else
			to_chat(usr, "<span class='warning'>The faxed item is not viewable. This is probably a bug, and should be reported on the tracker: [fax.type]</span>")

	else if (href_list["AdminFaxViewPage"])
		var/page = text2num(href_list["AdminFaxViewPage"])
		var/obj/item/weapon/paper_bundle/bundle = locate(href_list["paper_bundle"])

		if (!bundle) return

		if (istype(bundle.pages[page], /obj/item/weapon/paper))
			var/obj/item/weapon/paper/P = bundle.pages[page]
			P.show_content(src.owner, 1)
		else if (istype(bundle.pages[page], /obj/item/weapon/photo))
			var/obj/item/weapon/photo/H = bundle.pages[page]
			H.show(src.owner)
		return

	else if(href_list["FaxReply"])
		var/mob/sender = locate(href_list["FaxReply"])
		var/obj/machinery/photocopier/faxmachine/fax = locate(href_list["originfax"])
		var/replyorigin = href_list["replyorigin"]


		var/obj/item/weapon/paper/admin/P = new /obj/item/weapon/paper/admin( null ) //hopefully the null loc won't cause trouble for us
		faxreply = P

		P.admindatum = src
		P.origin = replyorigin
		P.destination = fax
		P.sender = sender

		P.adminbrowse()

	else if(href_list["jumpto"])
		if(!check_rights(R_ADMIN|R_EVENT|R_MOD))	return

		var/mob/M = locate(href_list["jumpto"])
		usr.client.jumptomob(M)

	else if(href_list["getmob"])
		if(!check_rights(R_ADMIN|R_EVENT|R_FUN))	return

		if(tgui_alert(usr, "Confirm?", "Message", list("Yes", "No")) != "Yes")	return
		var/mob/M = locate(href_list["getmob"])
		usr.client.Getmob(M)

	else if(href_list["sendmob"])
		if(!check_rights(R_ADMIN|R_EVENT|R_FUN))	return

		var/mob/M = locate(href_list["sendmob"])
		usr.client.sendmob(M)

	else if(href_list["narrateto"])
		if(!check_rights(R_ADMIN|R_EVENT|R_FUN))	return

		var/mob/M = locate(href_list["narrateto"])
		usr.client.cmd_admin_direct_narrate(M)

	else if(href_list["subtlemessage"])
		if(!check_rights(R_MOD|R_ADMIN|R_EVENT|R_FUN,0))  return

		var/mob/M = locate(href_list["subtlemessage"])
		usr.client.cmd_admin_subtle_message(M)

	else if(href_list["traitor"])
		if(!check_rights(R_ADMIN|R_MOD|R_EVENT))	return

		if(!ticker || !ticker.mode)
			tgui_alert_async(usr, "The game hasn't started yet!")
			return

		var/mob/M = locate(href_list["traitor"])
		if(!ismob(M))
			to_chat(usr, "<span class='filter_adminlog'>This can only be used on instances of type /mob.</span>")
			return
		show_traitor_panel(M)

	else if(href_list["create_object"])
		if(!check_rights(R_SPAWN))	return
		return create_object(usr)

	else if(href_list["quick_create_object"])
		if(!check_rights(R_SPAWN))	return
		return quick_create_object(usr)

	else if(href_list["create_turf"])
		if(!check_rights(R_SPAWN))	return
		return create_turf(usr)

	else if(href_list["create_mob"])
		if(!check_rights(R_SPAWN))	return
		return create_mob(usr)

	else if(href_list["object_list"])			//this is the laggiest thing ever
		if(!check_rights(R_SPAWN))	return

		if(!config.allow_admin_spawning)
			to_chat(usr, "<span class='filter_adminlog'>Spawning of items is not allowed.</span>")
			return

		var/atom/loc = usr.loc

		var/dirty_paths
		if (istext(href_list["object_list"]))
			dirty_paths = list(href_list["object_list"])
		else if (istype(href_list["object_list"], /list))
			dirty_paths = href_list["object_list"]

		var/paths = list()
		var/removed_paths = list()

		for(var/dirty_path in dirty_paths)
			var/path = text2path(dirty_path)
			if(!path)
				removed_paths += dirty_path
				continue
			else if(!ispath(path, /obj) && !ispath(path, /turf) && !ispath(path, /mob))
				removed_paths += dirty_path
				continue
			else if(ispath(path, /obj/item/weapon/gun/energy/pulse_rifle))
				if(!check_rights(R_FUN,0))
					removed_paths += dirty_path
					continue
			else if(ispath(path, /obj/item/weapon/melee/energy/blade))//Not an item one should be able to spawn./N
				if(!check_rights(R_FUN,0))
					removed_paths += dirty_path
					continue
			else if(ispath(path, /obj/effect/bhole))
				if(!check_rights(R_FUN,0))
					removed_paths += dirty_path
					continue
			paths += path

		if(!paths)
			tgui_alert(usr, "The path list you sent is empty")
			return
		if(length(paths) > 5)
			tgui_alert_async(usr, "Select fewer object types, (max 5)")
			return
		else if(length(removed_paths))
			tgui_alert_async(usr, "Removed:\n" + jointext(removed_paths, "\n"))

		var/list/offset = splittext(href_list["offset"],",")
		var/number = dd_range(1, 100, text2num(href_list["object_count"]))
		var/X = offset.len > 0 ? text2num(offset[1]) : 0
		var/Y = offset.len > 1 ? text2num(offset[2]) : 0
		var/Z = offset.len > 2 ? text2num(offset[3]) : 0
		var/tmp_dir = href_list["object_dir"]
		var/obj_dir = tmp_dir ? text2num(tmp_dir) : 2
		if(!obj_dir || !(obj_dir in list(1,2,4,8,5,6,9,10)))
			obj_dir = 2
		var/obj_name = sanitize(href_list["object_name"])
		var/where = href_list["object_where"]
		if (!( where in list("onfloor","inhand","inmarked") ))
			where = "onfloor"

		if( where == "inhand" )
			to_chat(usr, "<span class='filter_adminlog'>Support for inhand not available yet. Will spawn on floor.</span>")
			where = "onfloor"

		if ( where == "inhand" )	//Can only give when human or monkey
			if ( !( ishuman(usr) || issmall(usr) ) )
				to_chat(usr, "<span class='filter_adminlog'>Can only spawn in hand when you're a human or a monkey.</span>")
				where = "onfloor"
			else if ( usr.get_active_hand() )
				to_chat(usr, "<span class='filter_adminlog'>Your active hand is full. Spawning on floor.</span>")
				where = "onfloor"

		if ( where == "inmarked" )
			if ( !marked_datum )
				to_chat(usr, "<span class='filter_adminlog'>You don't have any object marked. Abandoning spawn.</span>")
				return
			else
				if ( !istype(marked_datum,/atom) )
					to_chat(usr, "<span class='filter_adminlog'>The object you have marked cannot be used as a target. Target must be of type /atom. Abandoning spawn.</span>")
					return

		var/atom/target //Where the object will be spawned
		switch ( where )
			if ( "onfloor" )
				switch (href_list["offset_type"])
					if ("absolute")
						target = locate(0 + X,0 + Y,0 + Z)
					if ("relative")
						target = locate(loc.x + X,loc.y + Y,loc.z + Z)
			if ( "inmarked" )
				target = marked_datum

		if(target)
			for (var/path in paths)
				for (var/i = 0; i < number; i++)
					if(path in typesof(/turf))
						var/turf/O = target
						var/turf/N = O.ChangeTurf(path)
						if(N)
							if(obj_name)
								N.name = obj_name
					else
						var/atom/O = new path(target)
						if(O)
							O.set_dir(obj_dir)
							if(obj_name)
								O.name = obj_name
								if(istype(O,/mob))
									var/mob/M = O
									M.real_name = obj_name

		log_and_message_admins("created [number] [english_list(paths)]")
		return

	else if(href_list["admin_secrets_panel"])
		var/datum/admin_secret_category/AC = locate(href_list["admin_secrets_panel"]) in admin_secrets.categories
		src.Secrets(AC)

	else if(href_list["admin_secrets"])
		var/datum/admin_secret_item/item = locate(href_list["admin_secrets"]) in admin_secrets.items
		item.execute(usr)

	else if(href_list["ac_view_wanted"])            //Admin newscaster Topic() stuff be here
		src.admincaster_screen = 18                 //The ac_ prefix before the hrefs stands for AdminCaster.
		src.access_news_network()

	else if(href_list["ac_set_channel_name"])
		src.admincaster_feed_channel.channel_name = sanitizeSafe(input(usr, "Provide a Feed Channel Name", "Network Channel Handler", ""))
		src.access_news_network()

	else if(href_list["ac_set_channel_lock"])
		src.admincaster_feed_channel.locked = !src.admincaster_feed_channel.locked
		src.access_news_network()

	else if(href_list["ac_submit_new_channel"])
		var/check = 0
		for(var/datum/feed_channel/FC in news_network.network_channels)
			if(FC.channel_name == src.admincaster_feed_channel.channel_name)
				check = 1
				break
		if(src.admincaster_feed_channel.channel_name == "" || src.admincaster_feed_channel.channel_name == "\[REDACTED\]" || check )
			src.admincaster_screen=7
		else
			var/choice = tgui_alert(usr, "Please confirm Feed channel creation","Network Channel Handler",list("Confirm","Cancel"))
			if(choice=="Confirm")
				news_network.CreateFeedChannel(admincaster_feed_channel.channel_name, admincaster_signature, admincaster_feed_channel.locked, 1)
				feedback_inc("newscaster_channels",1)                  //Adding channel to the global network
				log_admin("[key_name_admin(usr)] created command feed channel: [src.admincaster_feed_channel.channel_name]!")
				src.admincaster_screen=5
		src.access_news_network()

	else if(href_list["ac_set_channel_receiving"])
		var/list/available_channels = list()
		for(var/datum/feed_channel/F in news_network.network_channels)
			available_channels += F.channel_name
		src.admincaster_feed_channel.channel_name = sanitizeSafe(tgui_input_list(usr, "Choose receiving Feed Channel", "Network Channel Handler", available_channels ))
		src.access_news_network()

	else if(href_list["ac_set_new_title"])
		src.admincaster_feed_message.title = sanitize(input(usr, "Enter the Feed title", "Network Channel Handler", ""))
		src.access_news_network()

	else if(href_list["ac_set_new_message"])
		src.admincaster_feed_message.body = sanitize(input(usr, "Write your Feed story", "Network Channel Handler", "")  as message)
		src.access_news_network()

	else if(href_list["ac_submit_new_message"])
		if(src.admincaster_feed_message.body =="" || admincaster_feed_message.title == "" || admincaster_feed_message.body =="\[REDACTED\]" || admincaster_feed_channel.channel_name == "" )
			src.admincaster_screen = 6
		else
			feedback_inc("newscaster_stories",1)
			news_network.SubmitArticle(admincaster_feed_message.body, admincaster_signature, admincaster_feed_channel.channel_name, null, 1, "", admincaster_feed_message.title)
			src.admincaster_screen=4

		log_admin("[key_name_admin(usr)] submitted a feed story to channel: [src.admincaster_feed_channel.channel_name]!")
		src.access_news_network()

	else if(href_list["ac_create_channel"])
		src.admincaster_screen=2
		src.access_news_network()

	else if(href_list["ac_create_feed_story"])
		src.admincaster_screen=3
		src.access_news_network()

	else if(href_list["ac_menu_censor_story"])
		src.admincaster_screen=10
		src.access_news_network()

	else if(href_list["ac_menu_censor_channel"])
		src.admincaster_screen=11
		src.access_news_network()

	else if(href_list["ac_menu_wanted"])
		var/already_wanted = 0
		if(news_network.wanted_issue)
			already_wanted = 1

		if(already_wanted)
			src.admincaster_feed_message.author = news_network.wanted_issue.author
			src.admincaster_feed_message.body = news_network.wanted_issue.body
		src.admincaster_screen = 14
		src.access_news_network()

	else if(href_list["ac_set_wanted_name"])
		src.admincaster_feed_message.author = sanitize(input(usr, "Provide the name of the Wanted person", "Network Security Handler", ""))
		src.access_news_network()

	else if(href_list["ac_set_wanted_desc"])
		src.admincaster_feed_message.body = sanitize(input(usr, "Provide the a description of the Wanted person and any other details you deem important", "Network Security Handler", ""))
		src.access_news_network()

	else if(href_list["ac_submit_wanted"])
		var/input_param = text2num(href_list["ac_submit_wanted"])
		if(src.admincaster_feed_message.author == "" || src.admincaster_feed_message.body == "")
			src.admincaster_screen = 16
		else
			var/choice = tgui_alert(usr, "Please confirm Wanted Issue [(input_param==1) ? ("creation.") : ("edit.")]","Network Security Handler",list("Confirm","Cancel"))
			if(choice=="Confirm")
				if(input_param==1)          //If input_param == 1 we're submitting a new wanted issue. At 2 we're just editing an existing one. See the else below
					var/datum/feed_message/WANTED = new /datum/feed_message
					WANTED.author = src.admincaster_feed_message.author               //Wanted name
					WANTED.body = src.admincaster_feed_message.body                   //Wanted desc
					WANTED.backup_author = src.admincaster_signature                  //Submitted by
					WANTED.is_admin_message = 1
					news_network.wanted_issue = WANTED
					for(var/obj/machinery/newscaster/NEWSCASTER in allCasters)
						NEWSCASTER.newsAlert()
						NEWSCASTER.update_icon()
					src.admincaster_screen = 15
				else
					news_network.wanted_issue.author = src.admincaster_feed_message.author
					news_network.wanted_issue.body = src.admincaster_feed_message.body
					news_network.wanted_issue.backup_author = src.admincaster_feed_message.backup_author
					src.admincaster_screen = 19
				log_admin("[key_name_admin(usr)] issued a Station-wide Wanted Notification for [src.admincaster_feed_message.author]!")
		src.access_news_network()

	else if(href_list["ac_cancel_wanted"])
		var/choice = tgui_alert(usr, "Please confirm Wanted Issue removal","Network Security Handler",list("Confirm","Cancel"))
		if(choice=="Confirm")
			news_network.wanted_issue = null
			for(var/obj/machinery/newscaster/NEWSCASTER in allCasters)
				NEWSCASTER.update_icon()
			src.admincaster_screen=17
		src.access_news_network()

	else if(href_list["ac_censor_channel_author"])
		var/datum/feed_channel/FC = locate(href_list["ac_censor_channel_author"])
		if(FC.author != "<B>\[REDACTED\]</B>")
			FC.backup_author = FC.author
			FC.author = "<B>\[REDACTED\]</B>"
		else
			FC.author = FC.backup_author
		src.access_news_network()

	else if(href_list["ac_censor_channel_story_author"])
		var/datum/feed_message/MSG = locate(href_list["ac_censor_channel_story_author"])
		if(MSG.author != "<B>\[REDACTED\]</B>")
			MSG.backup_author = MSG.author
			MSG.author = "<B>\[REDACTED\]</B>"
		else
			MSG.author = MSG.backup_author
		src.access_news_network()

	else if(href_list["ac_censor_channel_story_body"])
		var/datum/feed_message/MSG = locate(href_list["ac_censor_channel_story_body"])
		if(MSG.body != "<B>\[REDACTED\]</B>")
			MSG.backup_body = MSG.body
			MSG.body = "<B>\[REDACTED\]</B>"
		else
			MSG.body = MSG.backup_body
		src.access_news_network()

	else if(href_list["ac_pick_d_notice"])
		var/datum/feed_channel/FC = locate(href_list["ac_pick_d_notice"])
		src.admincaster_feed_channel = FC
		src.admincaster_screen=13
		src.access_news_network()

	else if(href_list["ac_toggle_d_notice"])
		var/datum/feed_channel/FC = locate(href_list["ac_toggle_d_notice"])
		FC.censored = !FC.censored
		src.access_news_network()

	else if(href_list["ac_view"])
		src.admincaster_screen=1
		src.access_news_network()

	else if(href_list["ac_setScreen"]) //Brings us to the main menu and resets all fields~
		src.admincaster_screen = text2num(href_list["ac_setScreen"])
		if (src.admincaster_screen == 0)
			if(src.admincaster_feed_channel)
				src.admincaster_feed_channel = new /datum/feed_channel
			if(src.admincaster_feed_message)
				src.admincaster_feed_message = new /datum/feed_message
		src.access_news_network()

	else if(href_list["ac_show_channel"])
		var/datum/feed_channel/FC = locate(href_list["ac_show_channel"])
		src.admincaster_feed_channel = FC
		src.admincaster_screen = 9
		src.access_news_network()

	else if(href_list["ac_pick_censor_channel"])
		var/datum/feed_channel/FC = locate(href_list["ac_pick_censor_channel"])
		src.admincaster_feed_channel = FC
		src.admincaster_screen = 12
		src.access_news_network()

	else if(href_list["ac_refresh"])
		src.access_news_network()

	else if(href_list["ac_set_signature"])
		src.admincaster_signature = sanitize(input(usr, "Provide your desired signature", "Network Identity Handler", ""))
		src.access_news_network()

	else if(href_list["populate_inactive_customitems"])
		if(check_rights(R_ADMIN|R_SERVER))
			populate_inactive_customitems_list(src.owner)

	else if(href_list["vsc"])
		if(check_rights(R_ADMIN|R_SERVER|R_EVENT))
			if(href_list["vsc"] == "airflow")
				vsc.ChangeSettingsDialog(usr,vsc.settings)
			if(href_list["vsc"] == "phoron")
				vsc.ChangeSettingsDialog(usr,vsc.plc.settings)
			if(href_list["vsc"] == "default")
				vsc.SetDefault(usr)

	else if(href_list["toglang"])
		if(check_rights(R_SPAWN)) //VOREStation Edit
			var/mob/M = locate(href_list["toglang"])
			if(!istype(M))
				to_chat(usr, "<span class='filter_adminlog'>[M] is illegal type, must be /mob!</span>")
				return
			var/lang2toggle = href_list["lang"]
			var/datum/language/L = GLOB.all_languages[lang2toggle]

			if(L in M.languages)
				if(!M.remove_language(lang2toggle))
					to_chat(usr, "<span class='filter_adminlog'>Failed to remove language '[lang2toggle]' from \the [M]!</span>")
			else
				if(!M.add_language(lang2toggle))
					to_chat(usr, "<span class='filter_adminlog'>Failed to add language '[lang2toggle]' from \the [M]!</span>")

			show_player_panel(M)

	else if(href_list["cryoplayer"])
		if(!check_rights(R_ADMIN|R_EVENT))	return

		var/mob/living/carbon/M = locate(href_list["cryoplayer"]) //VOREStation edit from just an all mob check to mob/living/carbon
		if(!istype(M))
			to_chat(usr, "<span class='warning'>Mob doesn't exist!</span>")
			return

		var/client/C = usr.client
		C.despawn_player(M)

	// player info stuff

	if(href_list["add_player_info"])
		var/key = href_list["add_player_info"]
		var/add = sanitize(input(usr, "Add Player Info") as null|text)
		if(!add) return

		notes_add(key,add,usr)
		show_player_info(key)

	if(href_list["remove_player_info"])
		var/key = href_list["remove_player_info"]
		var/index = text2num(href_list["remove_index"])

		notes_del(key, index)
		show_player_info(key)

	if(href_list["notes"])
		var/ckey = href_list["ckey"]
		if(!ckey)
			var/mob/M = locate(href_list["mob"])
			if(ismob(M))
				ckey = M.ckey

		switch(href_list["notes"])
			if("show")
				show_player_info(ckey)
			if("list")
				var/filter
				if(href_list["filter"] && href_list["filter"] != "0")
					filter = url_decode(href_list["filter"])
				PlayerNotesPage(text2num(href_list["index"]), filter)
			if("filter")
				PlayerNotesFilter()
		return

/mob/living/proc/can_centcom_reply()
	return 0

/mob/living/carbon/human/can_centcom_reply()
	return istype(l_ear, /obj/item/device/radio/headset) || istype(r_ear, /obj/item/device/radio/headset)

/mob/living/silicon/ai/can_centcom_reply()
	return common_radio != null && !check_unable(2)

/atom/proc/extra_admin_link()
	return

/mob/extra_admin_link(var/source)
	if(client && eyeobj)
		return "|<A HREF='?[source];adminplayerobservejump=\ref[eyeobj]'>EYE</A>"

/mob/observer/dead/extra_admin_link(var/source)
	if(mind && mind.current)
		return "|<A HREF='?[source];adminplayerobservejump=\ref[mind.current]'>BDY</A>"

/proc/admin_jump_link(var/atom/target, var/source)
	if(!target) return
	// The way admin jump links handle their src is weirdly inconsistent...
	if(istype(source, /datum/admins))
		source = "src=\ref[source]"
	else
		source = "_src_=holder"

	. = "<A HREF='?[source];adminplayerobservejump=\ref[target]'>JMP</A>"
	. += target.extra_admin_link(source)
