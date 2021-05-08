/obj/machinery/the_singularitygen/tesla
	name = "генератор энергетических шаров"
	desc = "Делает уорденклифф похожим на детскую игрушку, когда в него стреляют ускорителем частиц."
	icon = 'icons/obj/tesla_engine/tesla_generator.dmi'
	icon_state = "TheSingGen"
	creation_type = /obj/singularity/energy_ball

/obj/machinery/the_singularitygen/tesla/tesla_act(power, explosive = FALSE)
	if(explosive)
		energy += power
