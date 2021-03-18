//Due to how large this one is it gets its own file
/datum/job/chaplain
	title = "Chaplain"
	flag = CHAPLAIN
	departments = list(DEPARTMENT_CIVILIAN)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Главой Персонала"
	selection_color = "#515151"
	access = list(access_morgue, access_chapel_office, access_crematorium, access_maint_tunnels)
	minimal_access = list(access_chapel_office, access_crematorium)

	outfit_type = /decl/hierarchy/outfit/job/chaplain
	job_description = "Капеллан служит религиозным нуждам экипажа, проводя различные обряды и церемонии."
	alt_titles = list("Counselor" = /datum/alt_title/counselor)

// Chaplain Alt Titles
/datum/alt_title/counselor
	title = "Counselor"
	title_blurb = "Советник заботится об эмоциональных потребностях экипажа, не обращая внимания на конкретные медицинские или духовные аспекты."

/datum/job/chaplain/equip(var/mob/living/carbon/human/H, var/alt_title, var/ask_questions = TRUE)
	. = ..()
	if(!.)
		return
	if(!ask_questions)
		return

	var/obj/item/weapon/storage/bible/B = locate(/obj/item/weapon/storage/bible) in H
	if(!B)
		return

	if(GLOB.religion)
		B.deity_name = GLOB.deity
		B.name = GLOB.bible_name
		B.icon_state = GLOB.bible_icon_state
		B.item_state = GLOB.bible_item_state
		to_chat(H, "<span class='boldnotice'>На станции уже существует устоявшаяся религия. Вы послушник [GLOB.deity]. Обратитесь к [title].</span>")
		return

	INVOKE_ASYNC(src, .proc/religion_prompts, H, B)

/datum/job/chaplain/proc/religion_prompts(mob/living/carbon/human/H, obj/item/weapon/storage/bible/B)
	var/religion_name = "Unitarianism"
	var/new_religion = sanitize(input(H, "Вы офицер службы экипажа. Хотели бы вы изменить свою религию? По умолчанию - унитаризм", "Name change", religion_name), MAX_NAME_LEN)
	if(!new_religion)
		new_religion = religion_name

	switch(lowertext(new_religion))
		if("unitarianism")
			B.name = "The Great Canon"
		if("christianity")
			B.name = "The Holy Bible"
		if("judaism")
			B.name = "The Torah"
		if("islam")
			B.name = "Quran"
		if("buddhism")
			B.name = "Tripitakas"
		if("hinduism")
			B.name = pick("The Srimad Bhagvatam", "The Four Vedas", "The Shiv Mahapuran", "Devi Mahatmya")
		if("neopaganism")
			B.name = "Neopagan Hymnbook"
		if("phact shintoism")
			B.name = "The Kojiki"
		if("kishari national faith")
			B.name = "The Scriptures of Kishar"
		if("pleromanism")
			B.name = "The Revised Great Canon"
		if("spectralism")
			B.name = "The Book of the Spark"
		if("hauler")
			B.name = "Histories of Captaincy"
		if("nock")
			B.name = "The Book of the First"
		if("singulitarian worship")
			B.name = "The Book of the Precursors"
		if("starlit path of angessa martei")
			B.name = "Quotations of Exalted Martei"
		if("sikhism")
			B.name = "Guru Granth Sahib"
		else
			B.name = "The Holy Book of [new_religion]"
	feedback_set_details("religion_name","[new_religion]")

	var/deity_name = "Hashem"
	var/new_deity = sanitize(input(H, "Хотели бы вы изменить свое божество? По умолчанию - Хашем", "Name change", deity_name), MAX_NAME_LEN)

	if((length(new_deity) == 0) || (new_deity == "Hashem"))
		new_deity = deity_name
	B.deity_name = new_deity

	GLOB.religion = new_religion
	GLOB.bible_name = B.name
	GLOB.deity = B.deity_name
	feedback_set_details("religion_deity","[new_deity]")


