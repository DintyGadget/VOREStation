/datum/power/changeling/arm_blade
	name = "Arm Blade"
	desc = "Мы превращаем одну из наших рук в смертоносный клинок."
	helptext = "Мы можем убрать наш нарукавный клинок, уронив его. Он может отклонять снаряды."
	enhancedtext = "Лезвие будет иметь бронепробиваемость."
	ability_icon_state = "ling_armblade"
	genomecost = 2
	verbpath = /mob/proc/changeling_arm_blade

//Grows a scary, and powerful arm blade.
/mob/proc/changeling_arm_blade()
	set category = "Changeling"
	set name = "Рука-лезвие (20)"

	if(src.mind.changeling.recursive_enhancement)
		if(changeling_generic_weapon(/obj/item/weapon/melee/changeling/arm_blade/greater))
			to_chat(src, "<span class='notice'>Мы готовим особо острое лезвие.</span>")
			return 1

	else
		if(changeling_generic_weapon(/obj/item/weapon/melee/changeling/arm_blade))
			return 1
		return 0

//Claws
/datum/power/changeling/claw
	name = "Claw"
	desc = "Мы превращаем одну из наших рук в смертоносную клешню."
	helptext = "Мы можем убрать коготь, уронив его."
	enhancedtext = "Коготь будет пробивать броню."
	ability_icon_state = "ling_claw"
	genomecost = 1
	verbpath = /mob/proc/changeling_claw

//Grows a scary, and powerful claw.
/mob/proc/changeling_claw()
	set category = "Changeling"
	set name = "Коготь (15)"

	if(src.mind.changeling.recursive_enhancement)
		if(changeling_generic_weapon(/obj/item/weapon/melee/changeling/claw/greater, 1, 15))
			to_chat(src, "<span class='notice'>Мы готовим особо острый коготь.</span>")
			return 1

	else
		if(changeling_generic_weapon(/obj/item/weapon/melee/changeling/claw, 1, 15))
			return 1
		return 0

/obj/item/weapon/melee/changeling
	name = "arm weapon"
	desc = "Гротескное оружие, сделанное из костей и плоти, пронзающее людей, как горячий нож сквозь масло."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "arm_blade"
	w_class = ITEMSIZE_HUGE
	force = 5
	anchored = 1
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	var/mob/living/creator //This is just like ninja swords, needed to make sure dumb shit that removes the sword doesn't make it stay around.
	var/weapType = "weapon"
	var/weapLocation = "arm"

	defend_chance = 40	// The base chance for the weapon to parry.
	projectile_parry_chance = 15	// The base chance for a projectile to be deflected.

/obj/item/weapon/melee/changeling/New(location)
	..()
	START_PROCESSING(SSobj, src)
	if(ismob(loc))
		visible_message("<span class='warning'>Гротескное оружие формируется вокруг руки [loc.name]!</span>",
		"<span class='warning'>Наша рука крутится и видоизменяется, превращая ее в смертоносное оружие.</span>",
		"<span class='italics'>Вы слышите, как рвется органическое вещество!</span>")
		src.creator = loc

/obj/item/weapon/melee/changeling/dropped(mob/user)
	visible_message("<span class='warning'>С тошнотворным хрустом, [creator] поправляет их в руку!</span>",
	"<span class='notice'>Мы ассимилируем оружие обратно в свое тело.</span>",
	"<span class='italics'>Вы слышите, как рвется органическое вещество!</span>")
	playsound(src, 'sound/effects/blobattack.ogg', 30, 1)
	spawn(1)
		if(src)
			qdel(src)

/obj/item/weapon/melee/changeling/Destroy()
	STOP_PROCESSING(SSobj, src)
	creator = null
	..()

/obj/item/weapon/melee/changeling/suicide_act(mob/user)
	var/datum/gender/T = gender_datums[user.get_visible_gender()]
	user.visible_message("<span class='danger'>[user] пронзает [T.himself] [src.name]! Похоже, [T.he] [T.is] пытается покончить жизнь самоубийством.</span>")
	return(BRUTELOSS)

/obj/item/weapon/melee/changeling/process()  //Stolen from ninja swords.
	if(!creator || loc != creator || !creator.item_is_in_hands(src))
		// Tidy up a bit.
		if(istype(loc,/mob/living))
			var/mob/living/carbon/human/host = loc
			if(istype(host))
				for(var/obj/item/organ/external/organ in host.organs)
					for(var/obj/item/O in organ.implants)
						if(O == src)
							organ.implants -= src
			host.pinned -= src
			host.embedded -= src
			host.drop_from_inventory(src)
		spawn(1)
			if(src)
				qdel(src)

/obj/item/weapon/melee/changeling/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(default_parry_check(user, attacker, damage_source) && prob(defend_chance))
		user.visible_message("<span class='danger'>[user] парирует [attack_text] с помощью [src]!</span>")
		playsound(src, 'sound/weapons/slash.ogg', 50, 1)
		return 1
	if(unique_parry_check(user, attacker, damage_source) && prob(projectile_parry_chance))
		user.visible_message("<span class='danger'>\The [user] уклоняется [attack_text] с помощью [src]!</span>")
		playsound(src, 'sound/weapons/slash.ogg', 50, 1)
		return 1

	return 0

/obj/item/weapon/melee/changeling/unique_parry_check(mob/user, mob/attacker, atom/damage_source)
	if(user.incapacitated() || !istype(damage_source, /obj/item/projectile))
		return 0

	var/bad_arc = reverse_direction(user.dir)
	if(!check_shield_arc(user, bad_arc, damage_source, attacker))
		return 0

	return 1

/obj/item/weapon/melee/changeling/arm_blade
	name = "arm blade"
	desc = "Гротескный клинок, сделанный из костей и плоти, пронзающий людей, как горячий нож сквозь масло."
	icon_state = "arm_blade"
	force = 40
	armor_penetration = 15
	sharp = 1
	edge = 1
	pry = 1
	attack_verb = list("атакует", "режет", "рубит", "разрезает", "режет", "рубит", "рубит", "режет")
	defend_chance = 60
	projectile_parry_chance = 25

/obj/item/weapon/melee/changeling/arm_blade/greater
	name = "arm greatblade"
	desc = "Гротескный клинок, сделанный из костей и плоти, пронзающий людей и доспехи, как горячий нож сквозь масло."
	armor_penetration = 30
	defend_chance = 70
	projectile_parry_chance = 35

/obj/item/weapon/melee/changeling/claw
	name = "hand claw"
	desc = "Гротескный коготь, сделанный из костей и плоти, рассекает людей, как горячий нож через масло."
	icon_state = "ling_claw"
	force = 15
	sharp = 1
	edge = 1
	attack_verb = list("атакует", "режет", "рубит", "разрезает", "режет", "рубит", "рубит", "режет")
	defend_chance = 50
	projectile_parry_chance = 15

/obj/item/weapon/melee/changeling/claw/greater
	name = "hand greatclaw"
	force = 20
	armor_penetration = 20
	pry = 1
	defend_chance = 60
	projectile_parry_chance = 25
