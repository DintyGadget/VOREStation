var/datum/antagonist/revolutionary/revs

/datum/antagonist/revolutionary
	id = MODE_REVOLUTIONARY
	role_type = BE_REV
	role_text = "Head Revolutionary"
	role_text_plural = "Revolutionaries"
	bantype = "revolutionary"
	feedback_tag = "rev_objective"
	antag_indicator = "rev_head"
	welcome_text = "Долой капиталистов! Долой буржуазию!"
	victory_text = "Руководители отделов освобождены от занимаемых должностей! Революционеры побеждают!"
	loss_text = "Руководителям отделов удалось остановить революцию!"
	victory_feedback_tag = "win - heads killed"
	loss_feedback_tag = "loss - rev heads killed"
	flags = ANTAG_SUSPICIOUS | ANTAG_VOTABLE
	antaghud_indicator = "hudrevolutionary"

	hard_cap = 2
	hard_cap_round = 4
	initial_spawn_req = 2
	initial_spawn_target = 4

	//Inround revs.
	faction_role_text = "Revolutionary"
	faction_descriptor = "Revolution"
	faction_verb = /mob/living/proc/convert_to_rev
	faction_welcome = "Помогите делу свергнуть правящий класс. Не причиняйте вреда своим собратьям-борцам за свободу."
	faction_indicator = "rev"
	faction_invisible = 1

	avoid_silicons = TRUE
	protected_jobs = list("Security Officer", "Warden", "Detective", "Internal Affairs Agent", "Site Manager", "Head of Personnel", "Head of Security", "Chief Engineer", "Research Director", "Chief Medical Officer")
	roundstart_restricted = list("Internal Affairs Agent", "Site Manager", "Head of Personnel", "Head of Security", "Chief Engineer", "Research Director", "Chief Medical Officer")

/datum/antagonist/revolutionary/New()
	..()
	revs = src

/datum/antagonist/revolutionary/create_global_objectives()
	if(!..())
		return
	global_objectives = list()
	for(var/mob/living/carbon/human/player in mob_list)
		if(!player.mind || player.stat==2 || !(SSjob.is_job_in_department(player.mind.assigned_role, DEPARTMENT_COMMAND)))
			continue
		var/datum/objective/rev/rev_obj = new
		rev_obj.target = player.mind
		rev_obj.explanation_text = "Убить, захватить или обратить [player.real_name], [player.mind.assigned_role]."
		global_objectives += rev_obj
