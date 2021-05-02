//Procedures in this file: Fracture repair surgery
//////////////////////////////////////////////////////////////////
//						BONE SURGERY							//
//////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////
// Bone Glue Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/glue_bone
	allowed_tools = list(
		/obj/item/weapon/surgical/bonegel = 100
	)

	allowed_procs = list(IS_SCREWDRIVER = 75)

	can_infect = 1
	blood_level = 1

	min_duration = 50
	max_duration = 60

/datum/surgery_step/glue_bone/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (!hasorgans(target))
		return 0
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if(coverage_check(user, target, affected, tool))
		return 0
	return affected && (affected.robotic < ORGAN_ROBOT) && affected.open >= 2 && affected.stage == 0

/datum/surgery_step/glue_bone/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if (affected.stage == 0)
		user.visible_message("<span class='notice'>[user] начинает применять лекарство к поврежденным костям [target] внутри [affected.name] используя [tool].</span>" , \
		"<span class='notice'>Вы начинаете наносить лекарство на поврежденные кости [target] внутри [affected.name] используя [tool].</span>")
	target.custom_pain("Что-то в [affected.name] причиняет вам много боли!", 50)
	..()

/datum/surgery_step/glue_bone/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='notice'>[user] применяет [tool] к кости [target] внутри [affected.name]</span>", \
		"<span class='notice'>Вы применяете [tool] к костям [target] внутри [affected.name] используя [tool].</span>")
	affected.stage = 1

/datum/surgery_step/glue_bone/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='danger'>Рука [user] соскальзывает, размазывая [tool] в надрезе [target] внутри [affected.name] !</span>" , \
	"<span class='danger'>Ваша рука с [tool] соскальзывает в разрезе [target] внутри [affected.name]!</span>")

///////////////////////////////////////////////////////////////
// Bone Setting Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/set_bone
	allowed_tools = list(
		/obj/item/weapon/surgical/bonesetter = 100
	)

	allowed_procs = list(IS_WRENCH = 75)

	min_duration = 60
	max_duration = 70

/datum/surgery_step/set_bone/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (!hasorgans(target))
		return 0
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if(coverage_check(user, target, affected, tool))
		return 0
	return affected && affected.organ_tag != BP_HEAD && !(affected.robotic >= ORGAN_ROBOT) && affected.open >= 2 && affected.stage == 1

/datum/surgery_step/set_bone/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='notice'>[user] начинает устанавливать кость в [target] внутри [affected.name] на место, используя [tool].</span>" , \
		"<span class='notice'>Вы начинаете устанавливать кость в [target] внутри [affected.name] на место с помощью [tool].</span>")
	target.custom_pain("Из-за боли внутри [affected.name] вы теряете сознание!", 50)
	..()

/datum/surgery_step/set_bone/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if (affected.status & ORGAN_BROKEN)
		user.visible_message("<span class='notice'>[user] ставит на место кость [target] внутри [affected.name] используя [tool].</span>", \
			"<span class='notice'>Вы ставите кость [target] на место, внутри [affected.name] используя [tool].</span>")
		affected.stage = 2
	else
		user.visible_message("[user] ставит кость в [target] внутри [affected.name]<span class='danger'> в неправильное положение, используя [tool].</span>", \
			"Вы ставите кость [target] внутри [affected.name]<span class='danger'> в неправильное положение, используя [tool].</span>")
		affected.fracture()

/datum/surgery_step/set_bone/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='danger'>Рука [user] соскальзывает, повреждая кость [target] внутри [affected.name] используя [tool]!</span>" , \
		"<span class='danger'>Ваша рука соскальзывает, повреждая кость [target] внутри [affected.name] используя [tool]!</span>")
	affected.createwound(BRUISE, 5)

///////////////////////////////////////////////////////////////
// Skull Mending Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/mend_skull
	allowed_tools = list(
		/obj/item/weapon/surgical/bonesetter = 100
	)

	allowed_procs = list(IS_WRENCH = 75)

	min_duration = 60
	max_duration = 70

/datum/surgery_step/mend_skull/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (!hasorgans(target))
		return 0
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if(coverage_check(user, target, affected, tool))
		return 0
	return affected && affected.organ_tag == BP_HEAD && (affected.robotic < ORGAN_ROBOT) && affected.open >= 2 && affected.stage == 1

/datum/surgery_step/mend_skull/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	user.visible_message("<span class='notice'>[user] начинает собирать череп [target] используя [tool].</span>"  , \
		"<span class='notice'>Вы начинаете собирать череп [target] используя [tool].</span>")
	..()

/datum/surgery_step/mend_skull/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='notice'>[user] устанавливает череп [target] используя [tool].</span>" , \
		"<span class='notice'>Вы устанавливаете череп [target] используя [tool].</span>")
	affected.stage = 2

/datum/surgery_step/mend_skull/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='danger'>Рука [user] соскальзывает, повреждая лицо [target] используя [tool]!</span>"  , \
		"<span class='danger'>Ваша рука соскальзывает, повреждая лицо [target] используя [tool]!</span>")
	var/obj/item/organ/external/head/h = affected
	h.createwound(BRUISE, 10)
	h.disfigured = 1

///////////////////////////////////////////////////////////////
// Bone Fixing Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/finish_bone
	allowed_tools = list(
		/obj/item/weapon/surgical/bonegel = 100
	)

	allowed_procs = list(IS_SCREWDRIVER = 75)

	can_infect = 1
	blood_level = 1

	min_duration = 50
	max_duration = 60

/datum/surgery_step/finish_bone/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (!hasorgans(target))
		return 0
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if(coverage_check(user, target, affected, tool))
		return 0
	return affected && affected.open >= 2 && !(affected.robotic >= ORGAN_ROBOT) && affected.stage == 2

/datum/surgery_step/finish_bone/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='notice'>[user] начинает заканчивать восстанавливать кости [target] внутри [affected.name] используя [tool].</span>", \
	"<span class='notice'>Вы начинаете заканчивать восстанавливать кости [target] внутри [affected.name] используя [tool].</span>")
	..()

/datum/surgery_step/finish_bone/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='notice'>[user] восстанавливает поврежденные кости [target] внутри [affected.name] используя [tool].</span>"  , \
		"<span class='notice'>Вы восстанавливаете поврежденные кости [target] внутри [affected.name] используя [tool].</span>" )
	affected.status &= ~ORGAN_BROKEN
	affected.stage = 0

/datum/surgery_step/finish_bone/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='danger'>Рука [user] соскальзывает, размазывая [tool] в разрезе [target] внутри [affected.name]!</span>" , \
	"<span class='danger'>Ваша рука соскальзывает, размазывая [tool] в разрезе [target] внутри [affected.name]!</span>")

///////////////////////////////////////////////////////////////
// Bone Clamp Surgery
///////////////////////////////////////////////////////////////

/datum/surgery_step/clamp_bone
	allowed_tools = list(
		/obj/item/weapon/surgical/bone_clamp = 100
		)

	can_infect = 1
	blood_level = 1

	min_duration = 70
	max_duration = 90

/datum/surgery_step/clamp_bone/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (!hasorgans(target))
		return 0
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if(coverage_check(user, target, affected, tool))
		return 0
	return affected && (affected.robotic < ORGAN_ROBOT) && affected.open >= 2 && affected.stage == 0

/datum/surgery_step/clamp_bone/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if (affected.stage == 0)
		user.visible_message("<span class='notice'>[user] начинает восстанавливать поврежденные кости [target] внутри [affected.name] используя [tool].</span>" , \
		"<span class='notice'>Вы начинаете восстанавливать поврежденные кости [target] внутри [affected.name] используя [tool].</span>")
	target.custom_pain("Что-то внутри [affected.name] причиняет вам много боли!", 50)
	..()

/datum/surgery_step/clamp_bone/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='notice'>[user] устанавливает кость [target] внутри [affected.name] используя [tool].</span>", \
		"<span class='notice'>Вы устанавливаете кость [target] внутри [affected.name] используя [tool].</span>")
	affected.status &= ~ORGAN_BROKEN

/datum/surgery_step/clamp_bone/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='danger'>Рука [user] соскальзывает, повреждая кость [target] внутри [affected.name] используя [tool]!</span>" , \
		"<span class='danger'>Ваша рука соскальзывает, повреждая кость [target] внутри [affected.name] используя [tool]!</span>")
	affected.createwound(BRUISE, 5)