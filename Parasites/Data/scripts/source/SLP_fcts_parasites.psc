Scriptname SLP_fcts_parasites extends Quest  
{ USED }
Import Utility
Import SKSE
zadLibs Property libs Auto
SexLabFrameWork Property SexLab Auto

ReferenceAlias Property PlayerAlias  Auto  
ReferenceAlias Property SpiderEggInfectedAlias  Auto  
ReferenceAlias Property ChaurusWormInfectedAlias  Auto  
ReferenceAlias Property BarnaclesInfectedAlias  Auto  
ReferenceAlias Property TentacleMonsterInfectedAlias  Auto  
ReferenceAlias Property LivingArmorInfectedAlias  Auto  
ReferenceAlias Property FaceHuggerInfectedAlias  Auto  
ReferenceAlias Property SpiderFollowerAlias  Auto  

Quest Property KynesBlessingQuest  Auto 

ObjectReference Property DummyAlias  Auto  
 
GlobalVariable Property _SLP_GV_numInfections  Auto 
GlobalVariable Property _SLP_GV_numSpiderEggInfections  Auto 
GlobalVariable Property _SLP_GV_numChaurusWormInfections  Auto 
GlobalVariable Property _SLP_GV_numChaurusWormVagInfections  Auto 
GlobalVariable Property _SLP_GV_numEstrusTentaclesInfections  Auto 
GlobalVariable Property _SLP_GV_numTentacleMonsterInfections  Auto 
GlobalVariable Property _SLP_GV_numEstrusSlimeInfections  Auto 
GlobalVariable Property _SLP_GV_numLivingArmorInfections  Auto 
GlobalVariable Property _SLP_GV_numFaceHuggerInfections  Auto 
GlobalVariable Property _SLP_GV_numBarnaclesInfections  Auto 

Faction Property PlayerFollowerFaction Auto

SPELL Property StomachRot Auto

Container Property EggSac  Auto  
Ingredient  Property TrollFat Auto
Ingredient  Property IngredientChaurusWorm Auto

Keyword Property ArmorCuirass  Auto  
Keyword Property ClothingBody  Auto  

Keyword Property _SLP_ParasiteSpiderEgg  Auto  
Keyword Property _SLP_ParasiteSpiderPenis  Auto  
Keyword Property _SLP_ParasiteChaurusWorm  Auto  
Keyword Property _SLP_ParasiteChaurusWormVag Auto  
Keyword Property _SLP_ParasiteTentacleMonster  Auto  
Keyword Property _SLP_ParasiteLivingArmor  Auto  
Keyword Property _SLP_ParasiteFaceHugger  Auto  
Keyword Property _SLP_ParasiteFaceHuggerGag  Auto  
Keyword Property _SLP_ParasiteBarnacles  Auto  

Armor Property SLP_plugSpiderEggRendered Auto         ; Internal Device
Armor Property SLP_plugSpiderEggInventory Auto        	       ; Inventory Device
Armor Property SLP_plugSpiderPenisRendered Auto         ; Internal Device
Armor Property SLP_plugSpiderPenisInventory Auto        	       ; Inventory Device
Armor Property SLP_plugChaurusWormRendered Auto         ; Internal Device
Armor Property SLP_plugChaurusWormInventory Auto        	       ; Inventory Device
Armor Property SLP_plugChaurusWormVagRendered Auto         ; Internal Device
Armor Property SLP_plugChaurusWormVagInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessTentacleMonsterRendered Auto         ; Internal Device
Armor Property SLP_harnessTentacleMonsterInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessLivingArmorRendered Auto         ; Internal Device
Armor Property SLP_harnessLivingArmorInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessFaceHuggerRendered Auto         ; Internal Device
Armor Property SLP_harnessFaceHuggerInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessFaceHuggerGagRendered Auto         ; Internal Device
Armor Property SLP_harnessFaceHuggerGagInventory Auto        	       ; Inventory Device
Armor Property SLP_harnessBarnaclesRendered Auto         ; Internal Device
Armor Property SLP_harnessBarnaclesInventory Auto        	       ; Inventory Device

; String                   Property NINODE_SCHLONG	 	= "NPC Genitals01 [Gen01]" AutoReadOnly
string                   Property SLH_KEY               = "SexLab_Hormones.esp" AutoReadOnly
String                   Property NINODE_SCHLONG	 	= "NPC GenitalsBase [GenBase]" AutoReadOnly
String                   Property NINODE_LEFT_BREAST    = "NPC L Breast" AutoReadOnly
String                   Property NINODE_LEFT_BREAST01  = "NPC L Breast01" AutoReadOnly
String                   Property NINODE_LEFT_BUTT      = "NPC L Butt" AutoReadOnly
String                   Property NINODE_RIGHT_BREAST   = "NPC R Breast" AutoReadOnly
String                   Property NINODE_RIGHT_BREAST01 = "NPC R Breast01" AutoReadOnly
String                   Property NINODE_RIGHT_BUTT     = "NPC R Butt" AutoReadOnly
String                   Property NINODE_SKIRT02        = "SkirtBBone02" AutoReadOnly
String                   Property NINODE_SKIRT03        = "SkirtBBone03" AutoReadOnly
String                   Property NINODE_BELLY          = "NPC Belly" AutoReadOnly
Float                    Property NINODE_MAX_SCALE      = 4.0 AutoReadOnly
Float                    Property NINODE_MIN_SCALE      = 0.1 AutoReadOnly

; NiOverride version data
int                      Property NIOVERRIDE_VERSION    = 4 AutoReadOnly
int                      Property NIOVERRIDE_SCRIPT_VERSION = 4 AutoReadOnly

; XPMSE version data
float                    Property XPMSE_VERSION         = 3.0 AutoReadOnly
float                    Property XPMSELIB_VERSION      = 3.0 AutoReadOnly


int Property MAX_PRESETS = 4 AutoReadOnly
int Property MAX_MORPHS = 19 AutoReadOnly

Bool Property isNiOInstalled Auto


;  http://wiki.tesnexus.com/index.php/Skyrim_bodyparts_number
;
;  This is the list of the body parts used by Bethesda and named in the Creation Kit:
;    30   - head
;    31     - hair
;    32   - body (full)
;    33   - hands
;    34   - forearms
;    35   - amulet
;    36   - ring
;    37   - feet
;    38   - calves
;    39   - shield
;    40   - tail
;    41   - long hair
;    42   - circlet
;    43   - ears
;    50   - decapitated head
;    51   - decapitate
;    61   - FX01
;  
;  Other body parts that exist in vanilla nif models
;    44   - Used in bloodied dragon heads, so it is free for NPCs
;    45   - Used in bloodied dragon wings, so it is free for NPCs
;    47   - Used in bloodied dragon tails, so it is free for NPCs
;    130   - Used in helmetts that conceal the whole head and neck inside
;    131   - Used in open faced helmets\hoods (Also the nightingale hood)
;    141   - Disables Hair Geometry like 131 and 31
;    142   - Used in circlets
;    143   - Disabled Ear geometry to prevent clipping issues?
;    150   - The gore that covers a decapitated head neck
;    230   - Neck, where 130 and this meets is the decapitation point of the neck
;  
;  Free body slots and reference usage
;    44   - face/mouth
;    45   - neck (like a cape, scarf, or shawl, neck-tie etc)
;    46   - chest primary or outergarment
;    47   - back (like a backpack/wings etc)
;    48   - misc/FX (use for anything that doesnt fit in the list)
;    49   - pelvis primary or outergarment
;    52   - pelvis secondary or undergarment
;    53   - leg primary or outergarment or right leg
;    54   - leg secondary or undergarment or leftt leg
;    55   - face alternate or jewelry
;    56   - chest secondary or undergarment
;    57   - shoulder
;    58   - arm secondary or undergarment or left arm
;    59   - arm primary or outergarment or right arm
;    60   - misc/FX (use for anything that doesnt fit in the list)



; Devious Devices 2.9
; Gags: 44
; Collars: 45
; Armbinder: 46
; Plugs (Anal): 48
; Chastity Belts: 49
; Vaginal Piercings: 50
; Nipple Piercings: 51
; Cuffs (Legs): 53
; Blindfold: 55
; Chastity Bra: 56
; Plugs (Vaginal): 57
; Body Harness: 58
; Cuffs (Arms): 59


;---------------------------------------------------
Function lockParasiteByString(Actor akActor, String sParasiteString = "")
	Keyword kwDeviceKeyword = 	getDeviousKeywordByString(sParasiteString)

	if (kwDeviceKeyword != none)
		libs.JamLock(akActor, kwDeviceKeyword)
	endIf
EndFunction

Function unLockParasiteByString(Actor akActor, String sParasiteString = "")
	Keyword kwDeviceKeyword = 	getDeviousKeywordByString(sParasiteString)

	if (kwDeviceKeyword != none)
		libs.UnJamLock(akActor, kwDeviceKeyword)
	endIf
EndFunction


Function equipParasiteByString ( String sParasiteString = "", bool skipEvents = false, bool skipMutex = false)

	equipParasiteNPCByString ( Game.GetPlayer(),  sParasiteString, skipEvents, skipMutex)
EndFunction

Function equipParasiteNPCByString ( Actor akActor, String sParasiteString = "", String sOutfitString = "", bool skipEvents = false, bool skipMutex = false)
	Keyword kwDeviceKeyword = none
	Armor aWornDevice = none
	Armor aRenderedDevice = none
	String sGenericDeviceTags = ""
	Form kForm	
	Bool bDeviceEquipSuccess = False

 	if (akActor == none)
 		Return
 	endif

	kwDeviceKeyword = 	getDeviousKeywordByString(sParasiteString)
	aWornDevice = none
	aRenderedDevice = none 

	If (kwDeviceKeyword != None)

		if !akActor.WornHasKeyword(kwDeviceKeyword)
			Debug.Trace("[SLP] equipParasiteByString: " + sParasiteString)  
			Debug.Trace("[SLP] 		keyword: " + kwDeviceKeyword)  

			aWornDevice = getParasiteByKeyword(kwDeviceKeyword) ; libs.GetWornDevice(akActor, kwDeviceKeyword) as Armor
			aRenderedDevice = getParasiteRenderedByKeyword(kwDeviceKeyword) ; libs.GetRenderedDevice(aWornDevice) as Armor

			If (aRenderedDevice!=None)
				equipParasiteNPC ( akActor, aWornDevice,  aRenderedDevice,  kwDeviceKeyword)
			Else
				Debug.Trace("[SLP]    Can't get worn device")
			endif

 
		else
			Debug.Trace("[SLP] player is already wearing: " + sParasiteString)  
		endIf

	else
		Debug.Trace("[SLP] unknown device to equip " )  

	endif
EndFunction



Function clearParasiteByString ( String sParasiteString = "", bool skipEvents = false, bool skipMutex = false )
 	clearParasiteNPCByString ( Game.GetPlayer(), sParasiteString, skipEvents, skipMutex )
EndFunction

Function clearParasiteNPCByString ( Actor akActor, String sParasiteString = "", bool skipEvents = false, bool skipMutex = false )
	Keyword kwDeviceKeyword = none 
	Armor aWornDevice = none
	Armor aRenderedDevice = none 
	Form kForm

	Debug.Trace("[SLP] clearParasiteByString - NO override detected")  
	kwDeviceKeyword = 	getDeviousKeywordByString(sParasiteString)
	aWornDevice = none
	aRenderedDevice = none 
 
	If (kwDeviceKeyword != None)

		if akActor.WornHasKeyword(kwDeviceKeyword)
			; RemoveDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool destroyDevice=false, bool skipEvents=false, bool skipMutex=false)

			Debug.Trace("[SLP] clearing device string: " + sParasiteString)  
			Debug.Trace("[SLP] clearing device keyword: " + kwDeviceKeyword)  
  
			aWornDevice = getParasiteByKeyword(kwDeviceKeyword) ; libs.GetWornDevice(akActor, kwDeviceKeyword) as Armor
			aRenderedDevice = libs.GetRenderedDevice(aWornDevice) as Armor ; getParasiteRenderedByKeyword(kwDeviceKeyword) 

			If (aRenderedDevice!=None)
				clearParasiteNPC ( akActor, aWornDevice,  aRenderedDevice,  kwDeviceKeyword)
			Else
				Debug.Trace("[SLP]    Can't get worn device")
			endif
			
			; libs.ManipulateGenericDeviceByKeyword(PlayerActor, kwDeviceKeyword, False, skipEvents,  skipMutex)
  

		else
			Debug.Trace("[SLP] player is not wearing: " + sParasiteString)  
		endIf

	else
		Debug.Trace("[SLP] unknown device to clear " )  

	endif
EndFunction

Bool Function equipParasite ( Armor ddArmorInventory, Armor ddArmorRendered, Keyword ddArmorKeyword)
	Actor kPlayer = Game.GetPlayer() as Actor
	Keyword kwWornKeyword
	Bool bDeviceEquipSuccess = False

	bDeviceEquipSuccess = equipParasiteNPC ( kPlayer, ddArmorInventory, ddArmorRendered, ddArmorKeyword)

	return bDeviceEquipSuccess
EndFunction

Bool Function equipParasiteNPC ( Actor akActor, Armor ddArmorInventory, Armor ddArmorRendered, Keyword ddArmorKeyword)
	Keyword kwWornKeyword
	Bool bDeviceEquipSuccess = False

	libs.Log("[SLP] equipParasite " )

	if (ddArmorKeyword != None)
		if (!akActor.WornHasKeyword(ddArmorKeyword))

			bDeviceEquipSuccess = libs.equipDevice(akActor, ddArmorInventory , ddArmorRendered , ddArmorKeyword)
			bDeviceEquipSuccess = True
		Else
			libs.Log("[SLP]   	skipped - device already equipped " )
		EndIf
	Else
		Debug.Notification("[SLP] equipParasite - bad keyword " )
	endIf

	return bDeviceEquipSuccess
EndFunction

Bool Function clearParasite ( Armor ddArmorInventory, Armor ddArmorRendered, Keyword ddArmorKeyword, Bool bDestroy = False)
	Actor kPlayer = Game.GetPlayer() as Actor
	Keyword kwWornKeyword
	Bool bDeviceRemoveSuccess = False
 
	bDeviceRemoveSuccess = clearParasiteNPC ( kPlayer, ddArmorInventory, ddArmorRendered, ddArmorKeyword,  bDestroy)
 
	return bDeviceRemoveSuccess
EndFunction

Bool Function clearParasiteNPC ( Actor akActor, Armor ddArmorInventory, Armor ddArmorRendered, Keyword ddArmorKeyword, Bool bDestroy = False) 
	Keyword kwWornKeyword
	Bool bDeviceRemoveSuccess = False

	If (bDestroy)
		libs.Log("[SLP] clearParasite - destroy: " + ddArmorKeyword )
	Else
		libs.Log("[SLP] clearParasite - remove: " + ddArmorKeyword  )
	endIf

	; RemoveDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool destroyDevice=false, bool skipEvents=false, bool skipMutex=false)
	libs.RemoveDevice(akActor, ddArmorInventory , ddArmorRendered , ddArmorKeyword, bDestroy, False, True)
 
	bDeviceRemoveSuccess = True
 
	return bDeviceRemoveSuccess
EndFunction

Armor Function getParasiteByKeyword(Keyword thisKeyword  )
	Armor thisArmor = None

	if (thisKeyword == _SLP_ParasiteSpiderEgg)
		thisArmor = SLP_plugSpiderEggInventory

	Elseif (thisKeyword == _SLP_ParasiteSpiderPenis)
		thisArmor = SLP_plugSpiderPenisInventory

	Elseif (thisKeyword == _SLP_ParasiteChaurusWorm)
		thisArmor = SLP_plugChaurusWormInventory

	Elseif (thisKeyword == _SLP_ParasiteChaurusWormVag)
		thisArmor = SLP_plugChaurusWormVagInventory

	Elseif (thisKeyword == _SLP_ParasiteTentacleMonster)
		thisArmor = SLP_harnessTentacleMonsterInventory

	Elseif (thisKeyword == _SLP_ParasiteLivingArmor)
		thisArmor = SLP_harnessLivingArmorInventory

	Elseif (thisKeyword == _SLP_ParasiteFaceHugger)
		thisArmor = SLP_harnessFaceHuggerInventory

	Elseif (thisKeyword == _SLP_ParasiteFaceHuggerGag)
		thisArmor = SLP_harnessFaceHuggerGagInventory

	Elseif (thisKeyword == _SLP_ParasiteBarnacles)
		thisArmor = SLP_harnessBarnaclesInventory
	EndIf

	return thisArmor
EndFunction

Armor Function getParasiteRenderedByKeyword(Keyword thisKeyword  )
	Armor thisArmor = None

	if (thisKeyword == _SLP_ParasiteSpiderEgg)
		thisArmor = SLP_plugSpiderEggRendered

	Elseif (thisKeyword == _SLP_ParasiteSpiderPenis)
		thisArmor = SLP_plugSpiderPenisRendered

	Elseif (thisKeyword == _SLP_ParasiteChaurusWorm)
		thisArmor = SLP_plugChaurusWormRendered

	Elseif (thisKeyword == _SLP_ParasiteChaurusWormVag)
		thisArmor = SLP_plugChaurusWormVagRendered

	Elseif (thisKeyword == _SLP_ParasiteTentacleMonster)
		thisArmor = SLP_harnessTentacleMonsterRendered

	Elseif (thisKeyword == _SLP_ParasiteLivingArmor)
		thisArmor = SLP_harnessLivingArmorRendered

	Elseif (thisKeyword == _SLP_ParasiteFaceHugger)
		thisArmor = SLP_harnessFaceHuggerRendered

	Elseif (thisKeyword == _SLP_ParasiteFaceHuggerGag)
		thisArmor = SLP_harnessFaceHuggerGagRendered

	Elseif (thisKeyword == _SLP_ParasiteBarnacles)
		thisArmor = SLP_harnessBarnaclesRendered
	EndIf

	return thisArmor
EndFunction


Keyword Function getDeviousKeywordByString(String deviousKeyword = ""  )
	Keyword thisKeyword = None
 
	if (deviousKeyword == "SpiderEgg" )  
		thisKeyword = _SLP_ParasiteSpiderEgg

	elseif (deviousKeyword == "SpiderPenis" )  
		thisKeyword = _SLP_ParasiteSpiderPenis

	elseif (deviousKeyword == "ChaurusWorm" )  
		thisKeyword = _SLP_ParasiteChaurusWorm
		
	elseif (deviousKeyword == "ChaurusWormVag" )  
		thisKeyword = _SLP_ParasiteChaurusWormVag
		
	elseif (deviousKeyword == "TentacleMonster" )  
		thisKeyword = _SLP_ParasiteTentacleMonster
		
	elseif (deviousKeyword == "LivingArmor" )  
		thisKeyword = _SLP_ParasiteLivingArmor
		
	elseif (deviousKeyword == "FaceHugger" )  
		thisKeyword = _SLP_ParasiteFaceHugger
		
	elseif (deviousKeyword == "FaceHuggerGag" )  
		thisKeyword = _SLP_ParasiteFaceHuggerGag
		
	elseif (deviousKeyword == "Barnacles" )  
		thisKeyword = _SLP_ParasiteBarnacles
		
	elseif (deviousKeyword == "zad_BlockGeneric")
		thisKeyword = libs.zad_BlockGeneric
		
	elseif (deviousKeyword == "zad_Lockable")
		thisKeyword = libs.zad_Lockable

	elseif (deviousKeyword == "zad_DeviousCollar") || (deviousKeyword == "Collar") 
		thisKeyword = libs.zad_DeviousCollar

	elseif (deviousKeyword == "zad_DeviousArmbinder") || (deviousKeyword == "Armbinder")  || (deviousKeyword == "Armbinders") 
		thisKeyword = libs.zad_DeviousArmbinder

	elseif (deviousKeyword == "zad_DeviousLegCuffs") || (deviousKeyword == "LegCuffs")  || (deviousKeyword == "LegCuff") 
		thisKeyword = libs.zad_DeviousLegCuffs

	elseif (deviousKeyword == "zad_DeviousGag") || (deviousKeyword == "Gag") 
		thisKeyword = libs.zad_DeviousGag

	elseif (deviousKeyword == "zad_DeviousBlindfold") || (deviousKeyword == "Blindfold") 
		thisKeyword = libs.zad_DeviousBlindfold

	elseif (deviousKeyword == "zad_DeviousBelt") || (deviousKeyword == "Belt") 
		thisKeyword = libs.zad_DeviousBelt

	elseif (deviousKeyword == "zad_DeviousPlugAnal") || (deviousKeyword == "PlugAnal") 
		thisKeyword = libs.zad_DeviousPlugAnal

	elseif (deviousKeyword == "zad_DeviousPlugVaginal") || (deviousKeyword == "PlugVaginal") 
		thisKeyword = libs.zad_DeviousPlugVaginal

	elseif (deviousKeyword == "zad_DeviousBra") || (deviousKeyword == "Bra") 
		thisKeyword = libs.zad_DeviousBra

	elseif (deviousKeyword == "zad_DeviousArmCuffs") || (deviousKeyword == "ArmCuffs")  || (deviousKeyword == "ArmCuff") 
		thisKeyword = libs.zad_DeviousArmCuffs

	elseif (deviousKeyword == "zad_DeviousYoke") || (deviousKeyword == "Yoke") 
		thisKeyword = libs.zad_DeviousYoke

	elseif (deviousKeyword == "zad_DeviousCorset") || (deviousKeyword == "Corset") 
		thisKeyword = libs.zad_DeviousCorset

	elseif (deviousKeyword == "zad_DeviousClamps") || (deviousKeyword == "Clamps") 
		thisKeyword = libs.zad_DeviousClamps

	elseif (deviousKeyword == "zad_DeviousGloves") || (deviousKeyword == "Gloves") 
		thisKeyword = libs.zad_DeviousGloves

	elseif (deviousKeyword == "zad_DeviousHood") || (deviousKeyword == "Hood") 
		thisKeyword = libs.zad_DeviousHood

	elseif (deviousKeyword == "zad_DeviousSuit") || (deviousKeyword == "Suits") 
		thisKeyword = libs.zad_DeviousSuit

	elseif (deviousKeyword == "zad_DeviousGagPanel") || (deviousKeyword == "GagPanel") 
		thisKeyword = libs.zad_DeviousGagPanel

	elseif (deviousKeyword == "zad_DeviousPlug") || (deviousKeyword == "Plug") 
		thisKeyword = libs.zad_DeviousPlug

	elseif (deviousKeyword == "zad_DeviousHarness") || (deviousKeyword == "Harness") 
		thisKeyword = libs.zad_DeviousHarness

	elseif (deviousKeyword == "zad_DeviousBoots") || (deviousKeyword == "Boots") 
		thisKeyword = libs.zad_DeviousBoots

	elseif (deviousKeyword == "zad_DeviousPiercingsNipple") || (deviousKeyword == "PiercingNipple")  || (deviousKeyword == "NipplePiercing")|| (deviousKeyword == "NipplePiercings") 
		thisKeyword = libs.zad_DeviousPiercingsNipple

	elseif (deviousKeyword == "zad_DeviousPiercingsVaginal") || (deviousKeyword == "PiercingVaginal")|| (deviousKeyword == "VaginalPiercing")|| (deviousKeyword == "VaginalPiercings") 
		thisKeyword = libs.zad_DeviousPiercingsVaginal

	else
		Debug.Notification("[SD] getDeviousKeywordByString: Unknown generic keyword: " + deviousKeyword)  
		Debug.Trace("[SD] getDeviousKeywordByString: Unknown generic keyword: " + deviousKeyword)  
	endIf

	return thisKeyword
EndFunction

Bool Function ActorHasKeywordByString(actor akActor, String deviousKeyword = "")
	return libs.ActorHasKeyword(akActor, getDeviousKeywordByString( deviousKeyword ))
EndFunction

Bool Function isInfectedByString( Actor akActor,  String sParasiteString  )

	Return akActor.WornHasKeyword(getDeviousKeywordByString(sParasiteString))
EndFunction

Bool Function isDeviceEquippedKeyword( Actor akActor,  String sKeyword, String sParasiteString  )
	Actor PlayerActor = Game.GetPlayer() as Actor
	Form kForm
	Keyword kKeyword = getDeviousKeywordByString(sParasiteString)
 
 	If (kKeyword != None)
		kForm = libs.GetWornDevice(akActor, kKeyword) as Form
		If (kForm != None)
			; Debug.Trace("[SD] SetOutfit: test part " + iOutfitPart + " for keyword " +  deviousKeyword   )
			return (kForm.HasKeywordString(sKeyword) ) 
		Else
			; Debug.Trace("[SD] SetOutfit: test part " + iOutfitPart + " for keyword " +  deviousKeyword + " - nothing equipped "  )
			Return False
		EndIf
	else
		Debug.Trace("[SD] isDeviceEquippedKeyword: Keyword not found for: " + sParasiteString)  
	endIf
 
	Return False
EndFunction


;------------------------------------------------------------------------------
Function infectSpiderEgg( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()
  	Int iNumSpiderEggs
 
 	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderEgg" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (isInfectedByString( kActor,  "SpiderEgg" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	iNumSpiderEggs = Utility.RandomInt(5,10)
	If (StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount")!=0)
		iNumSpiderEggs = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount")
	Endif

	If (kActor == PlayerActor)
		SpiderEggInfectedAlias.ForceRefTo(PlayerActor)
	endIf
	if (iNumSpiderEggs>=8)
		StomachRot.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)
	endIf

	equipParasiteNPCByString (kActor, "SpiderEgg")

	ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iSpiderEggInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numSpiderEggInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections"))

	SendModEvent("SLPSpiderEggInfection")

	if (!KynesBlessingQuest.GetStageDone(20))
		KynesBlessingQuest.SetStage(20)
	endif
EndFunction

Function cureSpiderEgg( Actor kActor, String _args, Bool bHarvestParasite = False   )
  	Actor PlayerActor = Game.GetPlayer()
 	Int iNumSpiderEggs

	If (isInfectedByString( kActor,  "SpiderEgg" ))
		iNumSpiderEggs = StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggCount") - Utility.RandomInt(2,8)

		if (iNumSpiderEggs < 0) || (_args == "All")
			If (kActor == PlayerActor)
				SpiderEggInfectedAlias.ForceRefTo(DummyAlias)
			endIf
			iNumSpiderEggs = 0
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", 0 )

			kActor.DispelSpell(StomachRot)

			StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 0)
			clearParasiteNPCByString (kActor, "SpiderEgg")

			If (bHarvestParasite)
				PlayerActor.AddItem(SLP_plugSpiderEggInventory,1)
			Endif
		Endif

		ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ) )
 
		StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )
		SendModEvent("SLPSpiderEggInfection")

	EndIf
EndFunction


;------------------------------------------------------------------------------
Function infectSpiderPenis( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()
  	Int iNumSpiderEggs

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceSpiderPenis" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (isInfectedByString( kActor,  "SpiderPenis" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	iNumSpiderEggs = Utility.RandomInt(5,10)

	If (kActor == PlayerActor)
		SpiderEggInfectedAlias.ForceRefTo(PlayerActor)
	endIf
	if (iNumSpiderEggs>=4)
		StomachRot.RemoteCast(kActor as ObjectReference, kActor,kActor as ObjectReference)
	endIf

	equipParasiteNPCByString (kActor, "SpiderPenis")

	ApplyBodyChange( kActor, "SpiderEgg", "Belly", 1.0 + (4.0 * (iNumSpiderEggs as Float) / StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" )), StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxSpiderEgg" ) )

	If !StorageUtil.HasIntValue(kActor, "_SLP_iSpiderEggInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderPenisDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iSpiderEggCount", iNumSpiderEggs )

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numSpiderEggInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iSpiderEggInfections"))

	SendModEvent("SLPSpiderEggInfection")

	if (!KynesBlessingQuest.GetStageDone(20))
		KynesBlessingQuest.SetStage(20)
	endif

EndFunction

Function cureSpiderPenis( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()


	If (isInfectedByString( kActor,  "SpiderPenis" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderPenis", 0 )
		clearParasiteNPCByString (kActor, "SpiderPenis", true, true)

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_plugSpiderPenisInventory,1)
		Endif

		StorageUtil.SetIntValue(kActor, "_SLP_toggleSpiderEgg", 1 )
		equipParasiteNPCByString (kActor, "SpiderEgg")
	EndIf
EndFunction


;------------------------------------------------------------------------------
Function infectChaurusWorm( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWorm" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (isInfectedByString( kActor,  "ChaurusWorm" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	equipParasiteNPCByString (kActor, "ChaurusWorm")

	If (kActor == PlayerActor)
		ChaurusWormInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	ApplyBodyChange( kActor, "ChaurusWorm", "Butt", 1.5, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusWormInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormInfections") + 1)

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numChaurusWormInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormInfections"))

	SendModEvent("SLPChaurusWormInfection")

	if (!KynesBlessingQuest.GetStageDone(20))
		KynesBlessingQuest.SetStage(20)
	endif
EndFunction

Function cureChaurusWorm( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()

	If (isInfectedByString( kActor,  "ChaurusWorm" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWorm", 0)
		clearParasiteNPCByString (kActor, "ChaurusWorm")
		ApplyBodyChange( kActor, "ChaurusWorm", "Butt", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_plugChaurusWormInventory,1)
		Endif

		If (kActor == PlayerActor)
			ChaurusWormInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	EndIf
EndFunction

;------------------------------------------------------------------------------
Function infectChaurusWormVag( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceChaurusWormVag" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (isInfectedByString( kActor,  "ChaurusWormVag" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	equipParasiteNPCByString (kActor, "ChaurusWormVag")

	If (kActor == PlayerActor)
		ChaurusWormInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	ApplyBodyChange( kActor, "ChaurusWormVag", "Belly", 1.5, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

	If !StorageUtil.HasIntValue(kActor, "_SLP_iChaurusWormVagInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormVagInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormVagDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iChaurusWormVagInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormVagInfections") + 1)

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numChaurusWormVagInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iChaurusWormVagInfections"))

	SendModEvent("SLPChaurusWormVagInfection")

	if (!KynesBlessingQuest.GetStageDone(20))
		KynesBlessingQuest.SetStage(20)
	endif
EndFunction

Function cureChaurusWormVag( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()

	If (isInfectedByString( kActor,  "ChaurusWormVag" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleChaurusWormVag", 0)
		clearParasiteNPCByString (kActor, "ChaurusWormVag")
		ApplyBodyChange( kActor, "ChaurusWormVag", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_buttMaxChaurusWorm" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_plugChaurusWormVagInventory,1)
		Endif

		If (kActor == PlayerActor)
			ChaurusWormInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	EndIf
EndFunction

;------------------------------------------------------------------------------
Function infectEstrusTentacles( Actor kActor   )
  	Actor PlayerActor = Game.GetPlayer()

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusTentacles" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (!ActorHasKeywordByString(kActor,  "PlugVaginal")) && (!isInfectedByString( kActor,  "TentacleMonster" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceTentacleMonster" )))
			; PlayerActor.SendModEvent("SLPInfectTentacleMonster")
			infectTentacleMonster(kActor)
			Debug.MessageBox("The ground shakes around you as tentacles shoot around your body and a slimiy, sticky creature attaches itself around your back.")
	Else
		Debug.Trace("[SLP] Tentacle Monster infection failed")
		Debug.Trace("[SLP]   Vaginal Plug: " + ActorHasKeywordByString(kActor,  "PlugVaginal"))
		Debug.Trace("[SLP]   TentacleMonster: " + isInfectedByString( kActor,  "TentacleMonster" ))
		Debug.Trace("[SLP]   Chance infection: " + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceTentacleMonster" ))
	EndIf

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap, Game.GetPlayer())             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, 0)    			; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	endif

	If !StorageUtil.HasIntValue(kActor, "_SLP_iEstrusTentaclesInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iEstrusTentaclesInfections",  0)
	EndIf

	; StorageUtil.SetIntValue(kActor, "_SLP_toggleEstrusTentacle", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusTentaclseDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusTentaclesInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iEstrusTentaclesInfections") + 1)

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numEstrusTentaclesInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iEstrusTentaclesInfections"))

	SendModEvent("SLPEstrusTentaclesInfection")


	if (!KynesBlessingQuest.GetStageDone(20))
		KynesBlessingQuest.SetStage(20)
	endif
EndFunction

;------------------------------------------------------------------------------
Function infectTentacleMonster( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceTentacleMonster" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (isInfectedByString( kActor,  "TentacleMonster" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	equipParasiteNPCByString (kActor, "TentacleMonster")

	If (kActor == PlayerActor)
		TentacleMonsterInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iTentacleMonsterInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iTentacleMonsterInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iTentacleMonsterDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iTentacleMonsterInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iTentacleMonsterInfections") + 1)

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numTentacleMonsterInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iTentacleMonsterInfections"))

	SendModEvent("SLPTentacleMonsterInfection")

	if (!KynesBlessingQuest.GetStageDone(20))
		KynesBlessingQuest.SetStage(20)
	endif
EndFunction

Function cureTentacleMonster( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()

	If (isInfectedByString( kActor,  "TentacleMonster" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleTentacleMonster", 0 )
		clearParasiteNPCByString (kActor, "TentacleMonster")
		ApplyBodyChange( kActor, "TentacleMonster", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxTentacleMonster" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessTentacleMonsterInventory,1)
		Endif

		If (kActor == PlayerActor)
			TentacleMonsterInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	EndIf
EndFunction

;------------------------------------------------------------------------------
Function infectEstrusSlime( Actor kActor   )
  	Actor PlayerActor = Game.GetPlayer()

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusSlime" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (!ActorHasKeywordByString(kActor,  "Harness")) && (!isInfectedByString( kActor,  "LivingArmor" )) && (Utility.RandomInt(1,100)<= (1 + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceLivingArmor" )))
			; PlayerActor.SendModEvent("SLPInfectLivingArmor")
			infectLivingArmor(kActor)
			Debug.MessageBox("What looked like creepy clusters suddenly extends tentacles around your skin and strips you of your clothes. A deep shudder ripples down your spine as sharp hooks burry deep into the back of your neck.")
	Else
		Debug.Trace("[SLP] Living Armor infection failed")
		Debug.Trace("[SLP]   Harness: " + ActorHasKeywordByString(kActor,  "Harness"))
		Debug.Trace("[SLP]   LivingArmor: " + isInfectedByString( kActor,  "LivingArmor" ))
		Debug.Trace("[SLP]   Chance infection: " + StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceLivingArmor" ))
	EndIf

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap, Game.GetPlayer())             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, Utility.randomInt(3,4))    	; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	endif

	If !StorageUtil.HasIntValue(kActor, "_SLP_iEstrusSlimeInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iEstrusSlimeInfections",  0)
	EndIf

	; StorageUtil.SetIntValue(kActor, "_SLP_toggleEstrusTentacle", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusSlimeDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusSlimeInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iEstrusSlimeInfections") + 1)

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numEstrusSlimeInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iEstrusSlimeInfections"))

	SendModEvent("SLPEstrusSlimeInfection")

	if (!KynesBlessingQuest.GetStageDone(20))
		KynesBlessingQuest.SetStage(20)
	endif

EndFunction

;------------------------------------------------------------------------------
Function infectLivingArmor( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceLivingArmor" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (isInfectedByString( kActor,  "LivingArmor" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	equipParasiteNPCByString (kActor, "LivingArmor")

	If (kActor == PlayerActor)
		LivingArmorInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iLivingArmorInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iLivingArmorInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iLivingArmorDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iLivingArmorInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iLivingArmorInfections") + 1)

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numLivingArmorInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iLivingArmorInfections"))

	SendModEvent("SLPLivingArmorInfection")

	if (!KynesBlessingQuest.GetStageDone(20))
		KynesBlessingQuest.SetStage(20)
	endif
EndFunction

Function cureLivingArmor( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()

	If (isInfectedByString( kActor,  "LivingArmor" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleLivingArmor", 0 )
		clearParasiteNPCByString (kActor, "LivingArmor")
		ApplyBodyChange( kActor, "LivingArmor", "Breast", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_breastMaxLivingArmor" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessLivingArmorInventory,1)
		Endif

		If (kActor == PlayerActor)
			LivingArmorInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	EndIf
EndFunction

;------------------------------------------------------------------------------
Function infectFaceHugger( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHugger" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (isInfectedByString( kActor,  "FaceHugger" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	equipParasiteNPCByString (kActor, "FaceHugger")

	If (kActor == PlayerActor)
		FaceHuggerInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iFaceHuggerInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerInfections") + 1)

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerInfections"))

	SendModEvent("SLPFaceHuggerInfection")

	if (!KynesBlessingQuest.GetStageDone(20))
		KynesBlessingQuest.SetStage(20)
	endif
EndFunction

Function cureFaceHugger( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()

	If (isInfectedByString( kActor,  "FaceHugger" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHugger", 0 )
		clearParasiteNPCByString (kActor, "FaceHugger")
		ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessFaceHuggerInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "FaceHugger" ))
			FaceHuggerInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	EndIf
EndFunction

Function infectFaceHuggerGag( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceFaceHugger" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (isInfectedByString( kActor,  "FaceHuggerGag" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	equipParasiteNPCByString (kActor, "FaceHuggerGag")

	If (kActor == PlayerActor)
		FaceHuggerInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iFaceHuggerInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iFaceHuggerInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerInfections") + 1)

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numFaceHuggerInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iFaceHuggerInfections"))

	SendModEvent("SLPFaceHuggerInfection")

	if (!KynesBlessingQuest.GetStageDone(20))
		KynesBlessingQuest.SetStage(20)
	endif
EndFunction

Function cureFaceHuggerGag( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()

	If (isInfectedByString( kActor,  "FaceHuggerGag" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleFaceHuggerGag", 0 )
		clearParasiteNPCByString (kActor, "FaceHuggerGag")
		ApplyBodyChange( kActor, "FaceHugger", "Belly", 1.0, StorageUtil.GetFloatValue(PlayerActor, "_SLP_bellyMaxFaceHugger" ))

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessFaceHuggerGagInventory,1)
		Endif

		If (kActor == PlayerActor) && !(isInfectedByString( kActor,  "FaceHugger" ))
			FaceHuggerInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	EndIf
EndFunction

;------------------------------------------------------------------------------
Function infectBarnacles( Actor kActor   )
 	Actor PlayerActor = Game.GetPlayer()

	If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceBarnacles" )==0.0)
		Debug.Trace("		Parasite disabled - Aborting")
		Return
	Endif

	If (isInfectedByString( kActor,  "Barnacles" ))
		Debug.Trace("		Already infected - Aborting")
		Return
	Endif

	equipParasiteNPCByString (kActor, "Barnacles")

	If (kActor == PlayerActor)
		BarnaclesInfectedAlias.ForceRefTo(PlayerActor)
	endIf

	If !StorageUtil.HasIntValue(kActor, "_SLP_iBarnaclesInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iBarnaclesInfections",  0)
	EndIf

	StorageUtil.SetIntValue(kActor, "_SLP_toggleBarnacles", 1 )
	StorageUtil.SetIntValue(kActor, "_SLP_iBarnaclesDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iBarnaclesInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iBarnaclesInfections") + 1)

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	_SLP_GV_numBarnaclesInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iBarnaclesInfections"))

	SendModEvent("SLPBarnaclesInfection")

	if (!KynesBlessingQuest.GetStageDone(20))
		KynesBlessingQuest.SetStage(20)
	endif
EndFunction

Function cureBarnacles( Actor kActor, Bool bHarvestParasite = False   )
 	Actor PlayerActor = Game.GetPlayer()

	If (isInfectedByString( kActor,  "Barnacles" ))
		StorageUtil.SetIntValue(kActor, "_SLP_toggleBarnacles", 0 )
		clearParasiteNPCByString (kActor, "Barnacles")

		If (bHarvestParasite)
			PlayerActor.AddItem(SLP_harnessBarnaclesInventory,1)
		Endif

		If (kActor == PlayerActor)
			BarnaclesInfectedAlias.ForceRefTo(DummyAlias)
		endIf

	EndIf
EndFunction

;------------------------------------------------------------------------------
Function infectEstrusChaurusEgg( Actor kActor   )
  	Actor PlayerActor = Game.GetPlayer()

	; If (StorageUtil.GetFloatValue(PlayerActor, "_SLP_chanceEstrusChaurusEgg" )==0.0)
	;	Debug.Trace("		Parasite disabled - Aborting")
	;	Return
	; Endif

	int ECTrap = ModEvent.Create("ECStartAnimation")  ; Int  Does not have to be named "ECTrap" any name would do

	if (ECTrap) 
	    ModEvent.PushForm(ECTrap, Game.GetPlayer())             ; Form (Some SendModEvent scripting "black magic" - required)
	    ModEvent.PushForm(ECTrap, kActor)  ; Form The animation target
	    ModEvent.PushInt(ECTrap, -1)    	; Int The animation required -1 = Impregnation only with No Animation,
                                                ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
	    ModEvent.PushBool(ECTrap, true)         ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Exhaustion for Machine) 
	    ModEvent.Pushint(ECTrap, 500)           ; Int  Alarm radius in units (0 to disable) 
	    ModEvent.PushBool(ECTrap, true)         ; Bool Use EC (basic) crowd control on hostiles 
	    ModEvent.Send(ECtrap)
	endif

	If !StorageUtil.HasIntValue(kActor, "_SLP_iEstrusChaurusEggInfections")
			StorageUtil.SetIntValue(kActor, "_SLP_iEstrusChaurusEggInfections",  0)
	EndIf
 
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusChaurusEggDate", Game.QueryStat("Days Passed"))
	StorageUtil.SetIntValue(kActor, "_SLP_iInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iInfections") + 1)
	StorageUtil.SetIntValue(kActor, "_SLP_iEstrusChaurusEggInfections",  StorageUtil.GetIntValue(kActor, "_SLP_iEstrusChaurusEggInfections") + 1)

	_SLP_GV_numInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iInfections"))
	; _SLP_GV_numEstrusChaurusEggInfections.SetValue(StorageUtil.GetIntValue(kActor, "_SLP_iEstrusChaurusEggInfections"))

	SendModEvent("SLPEstrusChaurusEggInfection")

	if (!KynesBlessingQuest.GetStageDone(20))
		KynesBlessingQuest.SetStage(20)
	endif

EndFunction

;------------------------------------------------------------------------------
Function ApplyBodyChange(Actor kActor, String sParasite, String sBodyPart, Float fValue=1.0, Float fValueMax=1.0)
  	ActorBase pActorBase = kActor.GetActorBase()
 	Actor PlayerActor = Game.GetPlayer()
  	String NiOString = "SLP_" + sParasite

	if ( isNiOInstalled  )  

		Debug.Trace("[SLP] Receiving body change: " + sBodyPart)
		Debug.Trace("[SLP]  	Node string: " + sParasite)
		Debug.Trace("[SLP]  	Max node: " + fValueMax)

 		if (fValue < 1.0)
			fValue = 1.0     ; NiO node is reset with value of 1.0 - not 0.0!
		Endif		

 		if (fValue > fValueMax)
			fValue = fValueMax
		Endif


		if (( sBodyPart == "Breast"  ) && (pActorBase.GetSex()==1)) ; Female change
			Debug.Trace("[SLP]     Applying breast change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			XPMSELib.SetNodeScale(kActor, true, NINODE_LEFT_BREAST, fValue, NiOString)
			XPMSELib.SetNodeScale(kActor, true, NINODE_RIGHT_BREAST, fValue, NiOString)

		Elseif (( sBodyPart == "Belly"  ) && (pActorBase.GetSex()==1)) ; Female change
			Debug.Trace("[SLP]     Applying belly change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			XPMSELib.SetNodeScale(kActor, true, NINODE_BELLY, fValue, NiOString)

		Elseif (( sBodyPart == "Butt"  )) 
			Debug.Trace("[SLP]     Applying butt change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			XPMSELib.SetNodeScale(kActor, pActorBase.GetSex(), NINODE_LEFT_BUTT, fValue, NiOString)
			XPMSELib.SetNodeScale(kActor, pActorBase.GetSex(), NINODE_RIGHT_BUTT, fValue, NiOString)

		Elseif (( sBodyPart == "Schlong"  ) ) 
			Debug.Trace("[SLP]     Applying schlong change: " + NiOString)
			Debug.Trace("[SLP]     Value: " + fValue)

			XPMSELib.SetNodeScale(kActor, pActorBase.GetSex(), NINODE_SCHLONG, fValue, NiOString)

		Endif
	Else
		; Debug.Notification("[SLP] Receiving body change: NiO not installed")

	EndIf

EndFunction


bool Function CheckXPMSERequirements(Actor akActor, bool isFemale)
	return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction