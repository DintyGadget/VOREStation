/////////////////////
// DISABILITY GENES
//
// These activate either a mutation, disability, or sdisability.
//
// Gene is always activated.
/////////////////////

/datum/dna/gene/disability
	name="DISABILITY"

	// Mutation to give (or 0)
	var/mutation=0

	// Disability to give (or 0)
	var/disability=0

	// SDisability to give (or 0)
	var/sdisability=0

	// Activation message
	var/activation_message=""

	// Yay, you're no longer growing 3 arms
	var/deactivation_message=""

/datum/dna/gene/disability/can_activate(var/mob/M,var/flags)
	return 1 // Always set!

/datum/dna/gene/disability/activate(var/mob/M, var/connected, var/flags)
	if(mutation && !(mutation in M.mutations))
		M.mutations.Add(mutation)
	if(disability)
		M.disabilities|=disability
	if(sdisability)
		M.sdisabilities|=sdisability
	if(activation_message)
		to_chat(M, "<span class='warning'>[activation_message]</span>")
	else
		testing("[name] has no activation message.")

/datum/dna/gene/disability/deactivate(var/mob/M, var/connected, var/flags)
	if(mutation && (mutation in M.mutations))
		M.mutations.Remove(mutation)
	if(disability)
		M.disabilities &= (~disability)
	if(sdisability)
		M.sdisabilities &= (~sdisability)
	if(deactivation_message)
		to_chat(M, "<span class='warning'>[deactivation_message]</span>")
	else
		testing("[name] has no deactivation message.")

// Note: Doesn't seem to do squat, at the moment.
/datum/dna/gene/disability/hallucinate
	name="Hallucinate"
	activation_message="Ваш разум говорит «Привет»."
	mutation=mHallucination

	New()
		block=HALLUCINATIONBLOCK

/datum/dna/gene/disability/epilepsy
	name="Epilepsy"
	activation_message="У вас болит голова."
	disability=EPILEPSY

	New()
		block=HEADACHEBLOCK

/datum/dna/gene/disability/cough
	name="Coughing"
	activation_message="Вы начинаете кашлять."
	disability=COUGHING

	New()
		block=COUGHBLOCK

/datum/dna/gene/disability/clumsy
	name="Clumsiness"
	activation_message="Вы чувствуете головокружение."
	mutation=CLUMSY

	New()
		block=CLUMSYBLOCK

/datum/dna/gene/disability/tourettes
	name="Tourettes"
	activation_message="Вы дергаетесь."
	disability=TOURETTES

	New()
		block=TWITCHBLOCK

/datum/dna/gene/disability/nervousness
	name="Nervousness"
	activation_message="Вы нервничаете."
	disability=NERVOUS

	New()
		block=NERVOUSBLOCK

/datum/dna/gene/disability/blindness
	name="Blindness"
	activation_message="Вы ничего не видите."
	sdisability=BLIND

	New()
		block=BLINDBLOCK

/datum/dna/gene/disability/deaf
	name="Deafness"
	activation_message="Вокруг вроде как тихо."
	sdisability=DEAF

	New()
		block=DEAFBLOCK

	activate(var/mob/M, var/connected, var/flags)
		..(M,connected,flags)
		M.ear_deaf = 1

/datum/dna/gene/disability/nearsighted
	name="Nearsightedness"
	activation_message="Ваши глаза кажутся странными ..."
	disability=NEARSIGHTED

	New()
		block=GLASSESBLOCK
