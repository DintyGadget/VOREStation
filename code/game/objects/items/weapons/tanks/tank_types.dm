/* Types of tanks!
 * Contains:
 *		Oxygen
 *		Anesthetic
 *		Air
 *		Phoron
 *		Emergency Oxygen
 */

/*
 * Oxygen
 */
/obj/item/weapon/tank/oxygen
	name = "кислородный баллон"
	desc = "Баллон с кислородом."
	icon_state = "oxygen"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD

/obj/item/weapon/tank/oxygen/Initialize()
	. = ..()
	air_contents.adjust_gas("oxygen", (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/weapon/tank/oxygen/examine(mob/user)
	. = ..()
	if(loc == user && (air_contents.gas["oxygen"] < 10))
		. += "<span class='warning'>Измеритель на [src] показывает, что у вас почти закончился кислород!</span>"

/obj/item/weapon/tank/oxygen/yellow
	desc = "Баллон с кислородом, этот желтый."
	icon_state = "oxygen_f"

/obj/item/weapon/tank/oxygen/red
	desc = "Баллон с кислородом, этот красный."
	icon_state = "oxygen_fr"

/*
 * Anesthetic
 */
/obj/item/weapon/tank/anesthetic
	name = "баллон с анестетиком"
	desc = "Баллон с газовой смесью N2O/O2."
	icon_state = "anesthetic"

/obj/item/weapon/tank/anesthetic/Initialize()
	. = ..()

	air_contents.gas["oxygen"] = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD
	air_contents.gas["nitrous_oxide"] = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD
	air_contents.update_values()

/*
 * Air
 */
/obj/item/weapon/tank/air
	name = "баллон с воздухом"
	desc = "Кто-нибудь смешал?"
	icon_state = "oxygen"

/obj/item/weapon/tank/air/examine(mob/user)
	. = ..()
	if(loc == user && (air_contents.gas["oxygen"] < 1))
		. += "<span class='warning'>Измеритель на [src] показывает, что у вас почти закончился воздух!</span>"
		user << sound('sound/effects/alert.ogg')

/obj/item/weapon/tank/air/Initialize()
	. = ..()
	src.air_contents.adjust_multi("oxygen", (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD, "nitrogen", (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD)

/*
 * Phoron
 */
/obj/item/weapon/tank/phoron
	name = "баллон с фороном"
	desc = "Содержит опасный форон. Не вдыхайте. Предупреждение: очень легко воспламеняется."
	icon_state = "phoron"
	gauge_icon = null
	slot_flags = null	//they have no straps!

/obj/item/weapon/tank/phoron/Initialize()
	. = ..()
	src.air_contents.adjust_gas("phoron", (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/weapon/tank/phoron/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()

	if (istype(W, /obj/item/weapon/flamethrower))
		var/obj/item/weapon/flamethrower/F = W
		if ((!F.status)||(F.ptank))	return
		src.master = F
		F.ptank = src
		user.remove_from_mob(src)
		src.loc = F
	return

/obj/item/weapon/tank/vox	//Can't be a child of phoron or the gas amount gets screwey.
	name = "баллон с фороном"
	desc = "Содержит опасный форон. Не вдыхайте. Предупреждение: очень легко воспламеняется."
	icon_state = "phoron_vox"
	gauge_icon = null
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	slot_flags = SLOT_BACK	//these ones have straps!

/obj/item/weapon/tank/vox/Initialize()
	. = ..()
	air_contents.adjust_gas("phoron", (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)) //VOREStation Edit

/obj/item/weapon/tank/phoron/pressurized
	name = "топливная канистра"
	icon_state = "phoron_vox"
	w_class = ITEMSIZE_NORMAL

/obj/item/weapon/tank/phoron/pressurized/Initialize()
	. = ..()
	adjust_scale(0.8)
	air_contents.adjust_gas("phoron", (7*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/*
 * Emergency Oxygen
 */

/obj/item/weapon/tank/emergency
	name = "аварийный баллон"
	icon_state = "emergency"
	gauge_icon = "indicator_emergency"
	gauge_cap = 4
	slot_flags = SLOT_BELT
	w_class = ITEMSIZE_SMALL
	force = 4
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	volume = 2 //Tiny. Real life equivalents only have 21 breaths of oxygen in them. They're EMERGENCY tanks anyway -errorage (dangercon 2011)

/obj/item/weapon/tank/emergency/oxygen
	name = "запасной кислородный баллон"
	desc = "Used for emergencies. Contains very little oxygen, so try to conserve it until you actually need it."
	icon_state = "emergency"
	gauge_icon = "indicator_emergency"

/obj/item/weapon/tank/emergency/oxygen/Initialize()
	. = ..()
	src.air_contents.adjust_gas("oxygen", (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/weapon/tank/emergency/oxygen/examine(mob/user)
	. = ..()
	if(loc == user && (air_contents.gas["oxygen"] < 0.2))
		. += "<span class='danger'>Счетчик на [src.name] показывает, что у вас почти закончился воздух!</span>"
		user << sound('sound/effects/alert.ogg')

/obj/item/weapon/tank/emergency/oxygen/engi
	name = "extended-capacity emergency oxygen tank"
	icon_state = "emergency_engi"
	volume = 6

/obj/item/weapon/tank/emergency/oxygen/double
	name = "double emergency oxygen tank"
	icon_state = "emergency_double"
	gauge_icon = "indicator_emergency_double"
	volume = 10

/obj/item/weapon/tank/stasis/oxygen // Stasis bags need to have initial pressure within safe bounds for human atmospheric pressure (NOT breath pressure)
	name = "stasis oxygen tank"
	desc = "Oxygen tank included in most stasis bag designs."
	icon_state = "emergency_double"
	gauge_icon = "indicator_emergency_double"
	volume = 10

/obj/item/weapon/tank/stasis/oxygen/Initialize()
	. = ..()
	src.air_contents.adjust_gas("oxygen", (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/weapon/tank/emergency/nitrogen
	name = "emergency nitrogen tank"
	desc = "An emergency air tank hastily painted red."
	icon_state = "emergency_nitro"
	gauge_icon = "indicator_emergency"

/obj/item/weapon/tank/emergency/nitrogen/Initialize()
	. = ..()
	src.air_contents.adjust_gas("nitrogen", (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/weapon/tank/emergency/nitrogen/double
	name = "double emergency nitrogen tank"
	icon_state = "emergency_double_nitrogen"
	gauge_icon = "indicator_emergency_double"
	volume = 10

/obj/item/weapon/tank/emergency/phoron
	name = "emergency phoron tank"
	desc = "An emergency air tank hastily painted red."
	icon_state = "emergency_nitro"
	gauge_icon = "indicator_emergency"

/obj/item/weapon/tank/emergency/phoron/Initialize()
	. = ..()
	src.air_contents.adjust_gas("phoron", (10*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/weapon/tank/emergency/phoron/double
	name = "double emergency phoron tank"
	icon_state = "emergency_double_nitro"
	gauge_icon = "indicator_emergency_double"
	volume = 10

/*
 * Nitrogen
 */
/obj/item/weapon/tank/nitrogen
	name = "nitrogen tank"
	desc = "A tank of nitrogen."
	icon_state = "oxygen_fr"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD

/obj/item/weapon/tank/nitrogen/Initialize()
	. = ..()
	src.air_contents.adjust_gas("nitrogen", (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C))

/obj/item/weapon/tank/nitrogen/examine(mob/user)
	. = ..()
	if(loc == user && (air_contents.gas["nitrogen"] < 10))
		. += "<span class='danger'>The meter on \the [src] indicates you are almost out of nitrogen!</span>"
		//playsound(user, 'sound/effects/alert.ogg', 50, 1)

/obj/item/weapon/tank/stasis/nitro_cryo // Synthmorph bags need to have initial pressure within safe bounds for human atmospheric pressure, but low temperature to stop unwanted degredation.
	name = "stasis cryogenic nitrogen tank"
	desc = "Cryogenic Nitrogen tank included in most synthmorph bag designs."
	icon_state = "emergency_double_nitro"
	gauge_icon = "indicator_emergency_double"
	volume = 10

/obj/item/weapon/tank/stasis/nitro_cryo/Initialize()
	. = ..()
	src.air_contents.adjust_gas_temp("nitrogen", (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*TN60C), TN60C)
