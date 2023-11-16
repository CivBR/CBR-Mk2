--==========================================================================================================================	
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------	
INSERT INTO Units 	
			(Type, 								Class,  ShowInPedia, SpreadReligion, ReligiousStrength,	ReligionSpreads, Combat, Cost, 	FaithCost, 	RequiresFaithPurchaseEnabled, Moves, HurryCostModifier, WorkRate, Domain, DefaultUnitAI, Description, Strategy, Help, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfoEraVariation, UnitArtInfo, UnitFlagAtlas, UnitFlagIconOffset, PortraitIndex, IconAtlas,	MoveRate)
SELECT		('UNIT_JFD_SWEDISH_GREAT_GENERAL'), Class, 	0,			 1,				 1000,				3,				 Combat, Cost, 	FaithCost, 	RequiresFaithPurchaseEnabled, Moves, HurryCostModifier, WorkRate, Domain, DefaultUnitAI, Description, Strategy, Help, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfoEraVariation, UnitArtInfo, UnitFlagAtlas, UnitFlagIconOffset, PortraitIndex, IconAtlas, MoveRate
FROM Units WHERE Type = 'UNIT_GREAT_GENERAL';
--------------------------------
-- UnitGameplay2DScripts
--------------------------------	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_SWEDISH_GREAT_GENERAL'), SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_GENERAL');	
--------------------------------
-- Unit_AITypes
--------------------------------	
INSERT INTO Unit_AITypes 	
			(UnitType, 							UnitAIType)
SELECT		('UNIT_JFD_SWEDISH_GREAT_GENERAL'), UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GREAT_GENERAL');	

INSERT INTO Unit_Flavors 	
			(UnitType, 							FlavorType,	Flavor)
SELECT		('UNIT_JFD_SWEDISH_GREAT_GENERAL'), FlavorType,	Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_GENERAL');	
--------------------------------
-- Unit_Builds
--------------------------------	
INSERT INTO Unit_Builds 	
			(UnitType, 							BuildType)
SELECT		('UNIT_JFD_SWEDISH_GREAT_GENERAL'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_GREAT_GENERAL');	
--------------------------------
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions 	
			(UnitType, 							PromotionType)
SELECT		('UNIT_JFD_SWEDISH_GREAT_GENERAL'), PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_GREAT_GENERAL');	
--------------------------------
-- Unit_UniqueNames
--------------------------------	
INSERT INTO Unit_UniqueNames 	
			(UnitType, 							UniqueName)
SELECT		('UNIT_JFD_SWEDISH_GREAT_GENERAL'),	UniqueName
FROM Unit_UniqueNames WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
UPDATE Leaders
SET MinorCivCompetitiveness = 2, Boldness = 8
WHERE Type = 'LEADER_GUSTAVUS_ADOLPHUS';
--------------------------------	
-- Leader_MinorCivApproachBiases
--------------------------------							
UPDATE Leader_MinorCivApproachBiases
SET Bias = 3
WHERE LeaderType = 'LEADER_GUSTAVUS_ADOLPHUS' AND MinorCivApproachType IN ('MINOR_CIV_APPROACH_FRIENDLY', 'MINOR_CIV_APPROACH_PROTECTIVE');

UPDATE Leader_MinorCivApproachBiases
SET Bias = 6
WHERE LeaderType = 'LEADER_GUSTAVUS_ADOLPHUS' AND MinorCivApproachType IN ('MINOR_CIV_APPROACH_CONQUEST', 'MINOR_CIV_APPROACH_BULLY');
--------------------------------	
-- Leader_Flavors
--------------------------------		
UPDATE Leader_Flavors
SET Flavor = 4
WHERE LeaderType = 'LEADER_GUSTAVUS_ADOLPHUS' AND FlavorType IN ('FLAVOR_GREAT_PEOPLE', 'FLAVOR_DIPLOMACY');
		
UPDATE Leader_Flavors
SET Flavor = 7
WHERE LeaderType = 'LEADER_GUSTAVUS_ADOLPHUS' AND FlavorType IN ('FLAVOR_RELIGION', 'FLAVOR_EXPANSION');
--------------------------------	
-- Leader_Traits
--------------------------------	
DELETE FROM Leader_Traits WHERE LeaderType = 'LEADER_GUSTAVUS_ADOLPHUS';
INSERT INTO Leader_Traits 
			(LeaderType, 					TraitType)
VALUES		('LEADER_GUSTAVUS_ADOLPHUS', 	'TRAIT_JFD_SWEDEN');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
			(Type, 							Description, 					ShortDescription)
VALUES		('TRAIT_JFD_SWEDEN', 			'TXT_KEY_TRAIT_JFD_SWEDEN', 	'TXT_KEY_TRAIT_JFD_SWEDEN_SHORT');	
--==========================================================================================================================
--==========================================================================================================================