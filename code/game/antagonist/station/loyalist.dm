var/datum/antagonist/loyalists/loyalists

/datum/antagonist/loyalists
	id = MODE_LOYALIST
	role_type = BE_LOYALIST
	role_text = "Head Loyalist"
	role_text_plural = "Loyalists"
	bantype = "loyalist"
	feedback_tag = "loyalist_objective"
	antag_indicator = "loyal_head"
	welcome_text = "Вы принадлежите Компании душой и телом. Защищайте свои интересы от заговорщиков из команды экипажа."
	antag_sound = 'sound/effects/antag_notice/general_goodie_alert.ogg'
	victory_text = "Руководители отделов остались на своих постах! Лоялисты побеждают!"
	loss_text = "Руководители отделов не остановили революцию!"
	victory_feedback_tag = "win - rev heads killed"
	loss_feedback_tag = "loss - heads killed"
	antaghud_indicator = "hudloyalist"
	flags = 0

	hard_cap = 2
	hard_cap_round = 4
	initial_spawn_req = 2
	initial_spawn_target = 4

	// Inround loyalists.
	faction_role_text = "Loyalist"
	faction_descriptor = "Company"
	faction_verb = /mob/living/proc/convert_to_loyalist
	faction_welcome = "Защитите интересы NanoTrasen от предателей-рецидивистов среди членов экипажа. Защитите руководителей любой ценой."
	faction_indicator = "loyal"
	faction_invisible = 1
	avoid_silicons = TRUE

/datum/antagonist/loyalists/New()
	..()
	loyalists = src

/datum/antagonist/loyalists/create_global_objectives()
	if(!..())
		return
	global_objectives = list()
	for(var/mob/living/carbon/human/player in mob_list)
		if(!player.mind || player.stat==2 || !(SSjob.is_job_in_department(player.mind.assigned_role, DEPARTMENT_COMMAND)))
			continue
		var/datum/objective/protect/loyal_obj = new
		loyal_obj.target = player.mind
		loyal_obj.explanation_text = "Защитите [player.real_name], [player.mind.assigned_role]."
		global_objectives += loyal_obj
