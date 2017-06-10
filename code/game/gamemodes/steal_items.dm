// Theft objectives.
//
// Separated into datums so we can prevent roles from getting certain objectives.

#define THEFT_FLAG_SPECIAL 1//unused, maybe someone will use it some day, I'll leave it here for the children
#define THEFT_FLAG_UNIQUE 2

/datum/theft_objective
	var/name = ""
	var/typepath=/atom
	var/list/protected_jobs = list()
	var/list/altitems = list()
	var/flags = 0

/datum/theft_objective/proc/check_completion(var/datum/mind/owner)
	if(!owner.current)
		return 0
	if(!isliving(owner.current))
		return 0
	var/list/all_items = owner.current.get_contents()
	for(var/obj/I in all_items) //Check for items
		if(istype(I, typepath) && check_special_completion(I))
			return 1
	return 0

/datum/proc/check_special_completion() //for objectives with special checks (is that slime extract unused? does that intellicard have an ai in it? etcetc)
	return 1

/datum/theft_objective/antique_laser_gun
	name = "the captain's antique laser gun"
	typepath = /obj/item/weapon/gun/energy/laser/captain
	protected_jobs = list("Captain")

/datum/theft_objective/hoslaser
	name = "the head of security's recreated antique laser gun"
	typepath = /obj/item/weapon/gun/energy/gun/hos
	protected_jobs = list("Head Of Security")

/datum/theft_objective/hand_tele
	name = "a hand teleporter"
	typepath = /obj/item/weapon/hand_tele
	protected_jobs = list("Captain", "Research Director")

/datum/theft_objective/ai
	name = "a functional AI"
	typepath = /obj/item/device/aicard

datum/theft_objective/ai/check_special_completion(var/obj/item/device/aicard/C)
	if(..())
		for(var/mob/living/silicon/ai/A in C)
			if(istype(A, /mob/living/silicon/ai) && A.stat != 2) //See if any AI's are alive inside that card.
				return 1
	return 0

/datum/theft_objective/defib
	name = "a compact defibrillator"
	typepath = /obj/item/weapon/defibrillator/compact
	protected_jobs = list("Chief Medical Officer")

/datum/theft_objective/magboots
	name = "the chief engineer's advanced magnetic boots"
	typepath = /obj/item/clothing/shoes/magboots/advance
	protected_jobs = list("Chief Engineer")

/datum/theft_objective/blueprints
	name = "the station blueprints"
	typepath = /obj/item/areaeditor/blueprints
	protected_jobs = list("Chief Engineer")
	altitems = list(/obj/item/weapon/photo)

/datum/objective_item/steal/blueprints/check_special_completion(obj/item/I)
	if(istype(I, /obj/item/areaeditor/blueprints))
		return 1
	if(istype(I, /obj/item/weapon/photo))
		var/obj/item/weapon/photo/P = I
		if(P.blueprints)
			return 1
	return 0

/datum/theft_objective/voidsuit
	name = "a nasa voidsuit"
	typepath = /obj/item/clothing/suit/space/nasavoid
	protected_jobs = list("Research Director")

/datum/theft_objective/slime_extract/check_special_completion(var/obj/item/slime_extract/E)
	if(..())
		if(E.Uses > 0)
			return 1
	return 0

/datum/theft_objective/capmedal
	name = "the medal of captaincy"
	typepath = /obj/item/clothing/accessory/medal/gold/captain
	protected_jobs = list("Captain")

/datum/theft_objective/nukedisc
	name = "the nuclear authentication disk"
	typepath = /obj/item/weapon/disk/nuclear
	protected_jobs = list("Captain")

/datum/theft_objective/reactive
	name = "the reactive teleport armor"
	typepath = /obj/item/clothing/suit/armor/reactive/teleport
	protected_jobs = list("Research Director")

/datum/theft_objective/steal/documents
	name = "any set of secret documents of any organization"
	typepath = /obj/item/documents //Any set of secret documents. Doesn't have to be NT's

/datum/theft_objective/hypospray
	name = "a hypospray"
	typepath = /obj/item/weapon/reagent_containers/hypospray/CMO
	protected_jobs = list("Chief Medical Officer")

/datum/theft_objective/ablative
	name = "an ablative armor vest"
	typepath = /obj/item/clothing/suit/armor/laserproof
	protected_jobs = list("Head of Security", "Warden")

/datum/theft_objective/krav
	name = "the warden's krav maga martial arts gloves"
	typepath = /obj/item/clothing/gloves/color/black/krav_maga/sec
	protected_jobs = list("Head Of Security", "Warden")

/datum/theft_objective/unique
	flags = THEFT_FLAG_UNIQUE

/datum/theft_objective/unique/docs_red
	name = "the \"Red\" secret documents"
	typepath = /obj/item/documents/syndicate/red

/datum/theft_objective/unique/docs_blue
	name = "the \"Blue\" secret documents"
	typepath = /obj/item/documents/syndicate/blue
