--==========================================================================================================================	
-- Units
--==========================================================================================================================
INSERT INTO Units 	
			(Class, 	Type, 									PrereqTech, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled,	Moves, 	CombatClass, Domain, DefaultUnitAI, Description, 									Civilopedia, 										Strategy, 												Help, 												MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, 	XPValueAttack, XPValueDefense, GoodyHutUpgradeUnitClass, UnitArtInfo, 								UnitFlagIconOffset, 					UnitFlagAtlas,							PortraitIndex, 	IconAtlas,			MoveRate)
SELECT		Class, 		('UNIT_MC_TIBET_HIMALAYAN_CAVALRY'), 	PrereqTech, Combat,	Cost, FaithCost, RequiresFaithPurchaseEnabled,	Moves, 	CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_MC_TIBET_HIMALAYAN_CAVALRY'), 	('TXT_KEY_CIV5_MC_TIBET_HIMALAYAN_CAVALRY_TEXT'), 	('TXT_KEY_UNIT_MC_TIBET_HIMALAYAN_CAVALRY_STRATEGY'), 	('TXT_KEY_UNIT_HELP_MC_TIBET_HIMALAYAN_CAVALRY'),  	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech,	XPValueAttack, XPValueDefense, GoodyHutUpgradeUnitClass, ('ART_DEF_UNIT_MC_HIMALAYAN_CAVALRY'),		0,										('MC_HIMALAYAN_CAVALRY_FLAG_ATLAS'),	3, 				('MC_TIBET_ATLAS'),	MoveRate
FROM Units WHERE (Type = 'UNIT_KNIGHT');
--==========================================================================================================================	
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================		
INSERT INTO Unit_ResourceQuantityRequirements 	
			(UnitType, 						ResourceType)
SELECT		('UNIT_MC_TIBET_HIMALAYAN_CAVALRY'), 	ResourceType
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_KNIGHT');	
--==========================================================================================================================	
-- UnitGameplay2DScripts
--==========================================================================================================================		
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 								SelectionSound, FirstSelectionSound)
SELECT		('UNIT_MC_TIBET_HIMALAYAN_CAVALRY'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_KNIGHT');
--==========================================================================================================================	
-- Unit_AITypes
--==========================================================================================================================		
INSERT INTO Unit_AITypes 	
			(UnitType, 								UnitAIType)
SELECT		('UNIT_MC_TIBET_HIMALAYAN_CAVALRY'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_KNIGHT');	
--==========================================================================================================================	
-- Unit_ClassUpgrades
--==========================================================================================================================	
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 								UnitClassType)
SELECT		('UNIT_MC_TIBET_HIMALAYAN_CAVALRY'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_KNIGHT');	
--==========================================================================================================================	
-- Unit_Flavors
--==========================================================================================================================		
INSERT INTO Unit_Flavors 	
			(UnitType, 								FlavorType, Flavor)
SELECT		('UNIT_MC_TIBET_HIMALAYAN_CAVALRY'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_KNIGHT');	
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 									PromotionType)
SELECT		('UNIT_MC_TIBET_HIMALAYAN_CAVALRY'), 		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_KNIGHT');

INSERT INTO Unit_FreePromotions
			(UnitType, 								PromotionType)
VALUES		('UNIT_MC_TIBET_HIMALAYAN_CAVALRY', 	'PROMOTION_MC_TIBET_HIMALAYAN_CAVALRY');
--==========================================================================================================================		
--==========================================================================================================================