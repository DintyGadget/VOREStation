/*
  A system for easily and quickly removing your own bodyparts, with a view towards
  swapping them out for new ones, or just doing it as a party trick to horrify an
  audience. Current implementation only supports robolimbs and uses a modular_bodypart
  value on the manufacturer datum, but I have tried to keep it generic for future work.
  PS. jesus christ this was meant to be a half an hour port
*/

// External organ procs:
// Does this bodypart count as a modular limb, and if so, what kind?
/obj/item/organ/external/proc/get_modular_limb_category()
	. = MODULAR_BODYPART_INVALID
	if(robotic >= ORGAN_ROBOT && model)
		var/datum/robolimb/manufacturer = all_robolimbs[model]
		if(!isnull(manufacturer?.modular_bodyparts))
			. = manufacturer.modular_bodyparts

// Checks if a limb could theoretically be removed.
// Note that this does not currently bother checking if a child or internal organ is vital.
/obj/item/organ/external/proc/can_remove_modular_limb(var/mob/living/carbon/human/user)
	if(vital || cannot_amputate)
		return FALSE
	var/bodypart_cat = get_modular_limb_category()
	if(bodypart_cat == MODULAR_BODYPART_CYBERNETIC)
		if(!parent_organ)
			return FALSE
		var/obj/item/organ/external/parent = user?.get_organ(parent_organ)
		if(!parent || parent.get_modular_limb_category(user) < MODULAR_BODYPART_CYBERNETIC)
			return FALSE
	. = (bodypart_cat != MODULAR_BODYPART_INVALID)

// Note that this proc is checking if the organ can be attached -to-, not attached itself.
/obj/item/organ/external/proc/can_attach_modular_limb_here(var/mob/living/carbon/human/user)
	var/list/limb_data = user?.species?.has_limbs[organ_tag]
	if(islist(limb_data) && limb_data["has_children"] > 0)
		. = (length(children) < limb_data["has_children"])

/obj/item/organ/external/proc/can_be_attached_modular_limb(var/mob/living/carbon/user)
	var/bodypart_cat = get_modular_limb_category()
	if(bodypart_cat == MODULAR_BODYPART_INVALID)
		return FALSE
	if(!parent_organ)
		return FALSE
	var/obj/item/organ/external/parent = user?.get_organ(parent_organ)
	if(!parent)
		return FALSE
	if(!parent.can_attach_modular_limb_here(user))
		return FALSE
	if(bodypart_cat == MODULAR_BODYPART_CYBERNETIC && parent.get_modular_limb_category(src) < MODULAR_BODYPART_CYBERNETIC)
		return FALSE
	return TRUE

// Checks if an organ (or the parent of one) is in a fit state for modular limb stuff to happen.
/obj/item/organ/external/proc/check_modular_limb_damage(var/mob/living/carbon/human/user)
	. =  damage >= min_broken_damage || (status & ORGAN_BROKEN) || is_stump() // can't use is_broken() as the limb has ORGAN_CUT_AWAY

// Human mob procs:
// Checks the organ list for limbs meeting a predicate. Way overengineered for such a limited use
// case but I can see it being expanded in the future if meat limbs or doona limbs use it.
/mob/living/carbon/human/proc/get_modular_limbs(var/return_first_found = FALSE, var/validate_proc)
	for(var/bp in organs)
		var/obj/item/organ/external/E = bp
		if(!validate_proc || call(E, validate_proc)(src) > MODULAR_BODYPART_INVALID)
			LAZYADD(., E)
			if(return_first_found)
				return
	// Prune children so we can't remove every individual component of an entire prosthetic arm
	// piece by piece. Technically a circular dependency here would remove the limb entirely but
	// if there's a parent whose child is also its parent, there's something wrong regardless.
	for(var/bp in .)
		var/obj/item/organ/external/E = bp
		if(length(E.children))
			. -= E.children

// Called in robotize(), replaced() and removed() to update our modular limb verbs.
/mob/living/carbon/human/proc/refresh_modular_limb_verbs()
	if(length(get_modular_limbs(return_first_found = TRUE, validate_proc = /obj/item/organ/external/proc/can_attach_modular_limb_here)))
		verbs |= .proc/attach_limb_verb
	else
		verbs -= .proc/attach_limb_verb
	if(length(get_modular_limbs(return_first_found = TRUE, validate_proc = /obj/item/organ/external/proc/can_remove_modular_limb)))
		verbs |= .proc/detach_limb_verb
	else
		verbs -= .proc/detach_limb_verb

// Proc helper for attachment verb.
/mob/living/carbon/human/proc/check_can_attach_modular_limb(var/obj/item/organ/external/E)
	if(world.time < last_special + (2 SECONDS) || get_active_hand() != E)
		return FALSE
	//VOREStation Addition Start
	if(species.name == SPECIES_PROTEAN)
		to_chat(src, SPAN_WARNING("Это несовместимо с телом вашей наномашины!"))
		return FALSE
	//VOREStation Addition End
	if(incapacitated() || restrained())
		to_chat(src, SPAN_WARNING("Вы не можете этого сделать в вашем текущем состоянии!"))
		return FALSE
	if(QDELETED(E) || !istype(E))
		to_chat(src, SPAN_WARNING("Вы не держите совместимую конечность, которую хотите прикрепить."))
		return FALSE
	if(!E.can_be_attached_modular_limb(src))
		to_chat(src, SPAN_WARNING("[E] не может быть прикреплен к вашему текущему телу."))
		return FALSE
	if(E.get_modular_limb_category() <= MODULAR_BODYPART_INVALID)
		to_chat(src, SPAN_WARNING("[E] нельзя прикрепить собственноручно."))
		return FALSE
	var/install_to_zone = E.organ_tag
	if(!isnull(get_organ(install_to_zone)))
		to_chat(src, SPAN_WARNING("К этой части вашего тела уже прикреплена конечность."))
		return FALSE
	if(E.check_modular_limb_damage(src))
		to_chat(src, SPAN_WARNING("[E] слишком поврежден, чтобы его можно было прикрепить."))
		return FALSE
	var/obj/item/organ/external/parent = E.parent_organ && get_organ(E.parent_organ)
	if(!parent)
		to_chat(src, SPAN_WARNING("[E] необходимо прикрепить к существующей конечности."))
		return FALSE
	if(parent.check_modular_limb_damage(src))
		to_chat(src, SPAN_WARNING("Ваше [parent.name] слишком поврежден, чтобы к нему что-либо было прикреплено."))
		return FALSE
	return TRUE

// Proc helper for detachment verb.
/mob/living/carbon/human/proc/check_can_detach_modular_limb(var/obj/item/organ/external/E)
	if(world.time < last_special + (2 SECONDS))
		return FALSE
	//VOREStation Addition Start
	if(species.name == SPECIES_PROTEAN)
		to_chat(src, SPAN_WARNING("Вы не можете просто отсоединить части тела вашей наномашины!"))
		return FALSE
	//VOREStation Addition End
	if(incapacitated() || restrained())
		to_chat(src, SPAN_WARNING("Вы не можете этого сделать в вашем текущем состоянии!"))
		return FALSE
	if(!istype(E) || QDELETED(src) || QDELETED(E) || E.owner != src || E.loc != src)
		return FALSE
	if(E.check_modular_limb_damage(src))
		to_chat(src, SPAN_WARNING("Эта конечность слишком повреждена, чтобы ее можно было удалить!"))
		return FALSE
	var/obj/item/organ/external/parent = E.parent_organ && get_organ(E.parent_organ)
	if(!parent)
		return FALSE
	if(parent.check_modular_limb_damage(src))
		to_chat(src, SPAN_WARNING("Ваш [parent.name] слишком поврежден, чтобы от него что-либо отделять."))
		return FALSE
	return (E in get_modular_limbs(return_first_found = FALSE, validate_proc = /obj/item/organ/external/proc/can_remove_modular_limb))

// Verbs below:
// Add or remove robotic limbs; check refresh_modular_limb_verbs() above.
/mob/living/carbon/human/proc/attach_limb_verb()
	set name = "Прикрепить конечность"
	set category = "Object"
	set desc = "Attach a replacement limb."
	set usr = src

	var/obj/item/organ/external/E = get_active_hand()
	if(!check_can_attach_modular_limb(E))
		return FALSE
	if(!do_after(src, 2 SECONDS, src))
		return FALSE
	if(!check_can_attach_modular_limb(E))
		return FALSE

	last_special = world.time
	drop_from_inventory(E)
	E.replaced(src)

	// Reconnect the organ and children as normally this is done with surgery.
	E.status &= ~ORGAN_CUT_AWAY
	for(var/obj/item/organ/external/child in E.children)
		child.status &= ~ORGAN_CUT_AWAY

	var/datum/gender/G = gender_datums[gender]
	visible_message(
		SPAN_NOTICE("[src] прикрепляет [E] к [G.his] телу!"),
		SPAN_NOTICE("Вы прикрепляете [E] к своему телу!"))
	regenerate_icons() // Not sure why this isn't called by removed(), but without it we don't update our limb appearance.
	return TRUE

/mob/living/carbon/human/proc/detach_limb_verb()
	set name = "Удалить конечность"
	set category = "Object"
	set desc = "Detach one of your limbs."
	set usr = src

	var/list/detachable_limbs = get_modular_limbs(return_first_found = FALSE, validate_proc = /obj/item/organ/external/proc/can_remove_modular_limb)
	if(!length(detachable_limbs))
		to_chat(src, SPAN_WARNING("У вас нет съемных конечностей."))
		return FALSE
	var/obj/item/organ/external/E = input(usr, "Какую конечность вы хотите отсоединить?", "Limb Removal") as null|anything in detachable_limbs
	if(!check_can_detach_modular_limb(E))
		return FALSE
	if(!do_after(src, 2 SECONDS, src))
		return FALSE
	if(!check_can_detach_modular_limb(E))
		return FALSE

	last_special = world.time
	E.removed(src)
	E.dropInto(loc)
	put_in_hands(E)
	var/datum/gender/G = gender_datums[gender]
	visible_message(
		SPAN_NOTICE("[src] отсоединяет [G.his] [E.name]!"),
		SPAN_NOTICE("Вы отключаете свой [E.name]!"))
	return TRUE
