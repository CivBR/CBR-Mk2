--==========================================================================================================================
-- Units
--==========================================================================================================================	
INSERT OR REPLACE INTO Units 	
			(Class, 	Type, 							FoundAbroad,	Cost, 	FaithCost,	Capture, CivilianAttackPriority, Moves, Domain, DefaultUnitAI, Description, 	Civilopedia, 	Strategy,	Help, 	CombatLimit, ObsoleteTech, UnitArtInfo, UnitFlagIconOffset, UnitArtInfoCulturalVariation, UnitFlagAtlas,	PortraitIndex, 	IconAtlas)
SELECT		Class, 		('UNIT_JFD_SETTLER_OCEANIC'), 	1,				-1, 	-1,			Capture, CivilianAttackPriority, Moves, Domain, DefaultUnitAI, Description, 	Civilopedia, 	Strategy, 	Help,	CombatLimit, ObsoleteTech, UnitArtInfo,	UnitFlagIconOffset,	UnitArtInfoCulturalVariation, UnitFlagAtlas,	('4'),		 	('TECH_ATLAS_DLC_03')
FROM Units WHERE (Type = 'UNIT_SETTLER');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================	
INSERT OR REPLACE INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_SETTLER_OCEANIC'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_SETTLER');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================	
INSERT OR REPLACE INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		('UNIT_JFD_SETTLER_OCEANIC'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SETTLER');	
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================	
INSERT OR REPLACE INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_JFD_SETTLER_OCEANIC'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_SETTLER');	
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================	
INSERT OR REPLACE INTO Unit_FreePromotions 
			(UnitType, 						PromotionType)
VALUES		('UNIT_JFD_SETTLER_OCEANIC', 	'PROMOTION_ALLWATER_EMBARKATION');
--==========================================================================================================================	
--==========================================================================================================================	