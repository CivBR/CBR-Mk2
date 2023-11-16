--=======================================================================================================================
-- BUILDINGCLASSES
--=======================================================================================================================
-- BuildingClasses
------------------------------	
INSERT INTO BuildingClasses 	
			(Type, 						 				DefaultBuilding, 						Description)
VALUES		('BUILDINGCLASS_JFD_ROYAL_ACADEMY_ARTIST', 	'BUILDING_JFD_ROYAL_ACADEMY_ARTIST', 	'TXT_KEY_BUILDING_JFD_ROYAL_ACADEMY'),
			('BUILDINGCLASS_JFD_ROYAL_ACADEMY_WRITER', 	'BUILDING_JFD_ROYAL_ACADEMY_WRITER', 	'TXT_KEY_BUILDING_JFD_ROYAL_ACADEMY');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
			(Type, 							BuildingClass, Cost, GoldMaintenance,	PrereqTech,	FreeStartEra, SpecialistType,	SpecialistCount, Description, 								Civilopedia, 							 Help, 											Strategy,								 		 ArtDefineTag, 	MinAreaSize, NeverCapture, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_JFD_ROYAL_ACADEMY'),	BuildingClass, Cost, GoldMaintenance-1, PrereqTech,	FreeStartEra, SpecialistType,	SpecialistCount, ('TXT_KEY_BUILDING_JFD_ROYAL_ACADEMY'), 	('TXT_KEY_CIV5_JFD_ROYAL_ACADEMY_TEXT'), ('TXT_KEY_BUILDING_JFD_ROYAL_ACADEMY_HELP'),	('TXT_KEY_BUILDING_JFD_ROYAL_ACADEMY_STRATEGY'), ArtDefineTag,	MinAreaSize, NeverCapture, HurryCostModifier, 3, 				('JFD_SWEDEN_NORWAY_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_PUBLIC_SCHOOL');

INSERT INTO Buildings 	
			(Type, 									BuildingClass,								Cost,	SpecialistType,			SpecialistCount,	Description, 								Help, 											ArtDefineTag, 	MinAreaSize, NeverCapture, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_JFD_ROYAL_ACADEMY_ARTIST'),	('BUILDINGCLASS_JFD_ROYAL_ACADEMY_ARTIST'), -1,		('SPECIALIST_ARTIST'),	1,					('TXT_KEY_BUILDING_JFD_ROYAL_ACADEMY'),		('TXT_KEY_BUILDING_JFD_ROYAL_ACADEMY_HELP'),	ArtDefineTag,	MinAreaSize, NeverCapture, HurryCostModifier, 3, 				('JFD_SWEDEN_NORWAY_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_PUBLIC_SCHOOL');

INSERT INTO Buildings 	
			(Type, 									BuildingClass,								Cost,	SpecialistType,			SpecialistCount,	Description, 								Help, 											ArtDefineTag, 	MinAreaSize, NeverCapture, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_JFD_ROYAL_ACADEMY_WRITER'),	('BUILDINGCLASS_JFD_ROYAL_ACADEMY_WRITER'), -1,		('SPECIALIST_WRITER'),	1,					('TXT_KEY_BUILDING_JFD_ROYAL_ACADEMY'),		('TXT_KEY_BUILDING_JFD_ROYAL_ACADEMY_HELP'),	ArtDefineTag,	MinAreaSize, NeverCapture, HurryCostModifier, 3, 				('JFD_SWEDEN_NORWAY_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_PUBLIC_SCHOOL');
------------------------------	                                                                                                                 				
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 					BuildingClassType)
SELECT		('BUILDING_JFD_ROYAL_ACADEMY'),	BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');
------------------------------	
-- Building_YieldChangesPerPop
------------------------------	
INSERT INTO Building_YieldChangesPerPop 	
			(BuildingType, 					YieldType,		Yield)
SELECT		('BUILDING_JFD_ROYAL_ACADEMY'),	YieldType,		Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
			(BuildingType, 					FlavorType,		Flavor)
SELECT		('BUILDING_JFD_ROYAL_ACADEMY'),	FlavorType,		Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');	

INSERT INTO Building_Flavors 	
			(BuildingType, 					FlavorType,						Flavor)
VALUES		('BUILDING_JFD_ROYAL_ACADEMY',	'FLAVOR_GROWTH',				20),
			('BUILDING_JFD_ROYAL_ACADEMY',	'FLAVOR_DEFENSE',				20);
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT OR REPLACE INTO UnitPromotions 
			(Type, 									Description, 								Help, 											Sound, 				AttackMod,	DefenseMod,	 CannotBeChosen,	PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_JFD_TORDENSKJOLD_BONUS',	'TXT_KEY_PROMOTION_TORDENSKJOLD_BONUS',		'TXT_KEY_PROMOTION_TORDENSKJOLD_BONUS_HELP', 	'AS2D_IF_LEVELUP', 	0,			25,			 1,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_TORDENSKJOLD_BONUS'),
			('PROMOTION_JFD_TORDENSKJOLD_PENALTY',	'TXT_KEY_PROMOTION_TORDENSKJOLD_PENALTY',	'TXT_KEY_PROMOTION_TORDENSKJOLD_PENALTY_HELP', 	'AS2D_IF_LEVELUP', 	-25,		0,			 1,					57, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_TORDENSKJOLD_PENALTY');
--==========================================================================================================================	
-- BUILDS
--==========================================================================================================================	
-- Builds
--------------------------------	
INSERT INTO Builds
			(Type,										ImprovementType, Time, Recommendation, Description,	Help, Water, CtrlDown, OrderPriority, IconIndex, IconAtlas,	HotKey, EntityEvent)
SELECT		('BUILD_JFD_TORDENSKJOLD_FISHING_BOATS'),	ImprovementType, 700, Recommendation, Description,	Help, Water, CtrlDown, OrderPriority, IconIndex, IconAtlas,	HotKey,	EntityEvent
FROM Builds WHERE Type = 'BUILD_FISHING_BOATS';

INSERT INTO Builds
			(Type,											ImprovementType, Time, Recommendation, Description,	Help, Water, CtrlDown, OrderPriority, IconIndex, IconAtlas,	HotKey, EntityEvent)
SELECT		('BUILD_JFD_TORDENSKJOLD_OFFSHORE_PLATFORM'),	ImprovementType, 900, Recommendation, Description,	Help, Water, CtrlDown, OrderPriority, IconIndex, IconAtlas,	HotKey,	EntityEvent
FROM Builds WHERE Type = 'BUILD_OFFSHORE_PLATFORM';
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units 	
			(Type, 						PrereqTech,	Class, Combat,	WorkRate,	RangedCombat, CombatClass, Cost, Moves, Range, Domain, DefaultUnitAI,	Description, 						Civilopedia, 							Strategy, 									Help, 									Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, 					 UnitFlagIconOffset, UnitFlagAtlas,							PortraitIndex, 	IconAtlas,						MoveRate)
SELECT		('UNIT_JFD_TORDENSKJOLD'),	PrereqTech,	Class, Combat,	100,		RangedCombat, CombatClass, Cost, Moves, Range, Domain, DefaultUnitAI,	('TXT_KEY_UNIT_JFD_TORDENSKJOLD'), 	('TXT_KEY_UNIT_JFD_TORDENSKJOLD_TEXT'), 	('TXT_KEY_UNIT_JFD_TORDENSKJOLD_STRATEGY'), 	('TXT_KEY_UNIT_HELP_JFD_TORDENSKJOLD'), 	Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, ('ART_DEF_UNIT_JFD_TORDENSKJOLD'), 0,					 ('JFD_UNIT_FLAG_TORDENSKJOLD_ATLAS'),	2, 				('JFD_SWEDEN_NORWAY_ATLAS'),	MoveRate
FROM Units WHERE (Type = 'UNIT_BATTLESHIP');	
--------------------------------
-- UnitGameplay2DScripts
--------------------------------	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_TORDENSKJOLD'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_BATTLESHIP');	
--------------------------------
-- Unit_AITypes
--------------------------------	
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_JFD_TORDENSKJOLD'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_BATTLESHIP');
--------------------------------	
-- Unit_ResourceQuantityRequirements
--------------------------------		
INSERT INTO Unit_ResourceQuantityRequirements 	
			(UnitType, 					ResourceType)
SELECT		('UNIT_JFD_TORDENSKJOLD'), 	ResourceType
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_BATTLESHIP');
--------------------------------
-- Unit_Flavors
--------------------------------	
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_JFD_TORDENSKJOLD'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_BATTLESHIP');
--------------------------------
-- Unit_ClassUpgrades
--------------------------------	
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_JFD_TORDENSKJOLD'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_BATTLESHIP');
--------------------------------
-- Unit_Builds
--------------------------------	
INSERT INTO Unit_Builds 	
			(UnitType, 					BuildType)
VALUES		('UNIT_JFD_TORDENSKJOLD', 	'BUILD_JFD_TORDENSKJOLD_FISHING_BOATS'),
			('UNIT_JFD_TORDENSKJOLD', 	'BUILD_JFD_TORDENSKJOLD_OFFSHORE_PLATFORM'),
			('UNIT_JFD_TORDENSKJOLD', 	'BUILD_REPAIR');
--------------------------------
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
SELECT		('UNIT_JFD_TORDENSKJOLD'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_BATTLESHIP');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
VALUES		('UNIT_JFD_TORDENSKJOLD', 	'PROMOTION_JFD_TORDENSKJOLD_BONUS'),
			('UNIT_JFD_TORDENSKJOLD', 	'PROMOTION_JFD_TORDENSKJOLD_PENALTY');
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
			(Type, 						Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_JFD_OSCAR', 		'TXT_KEY_LEADER_JFD_OSCAR', 	'TXT_KEY_LEADER_JFD_OSCAR_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_OSCAR', 	'Oscar_Scene.xml',		4, 						2, 						9, 							4, 			7, 				8, 				4, 						8, 				9, 			2, 			6, 				7, 			2, 			'JFD_SWEDEN_NORWAY_ATLAS', 	1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_OSCAR', 		'MAJOR_CIV_APPROACH_WAR', 			1),
			('LEADER_JFD_OSCAR', 		'MAJOR_CIV_APPROACH_HOSTILE', 		1),
			('LEADER_JFD_OSCAR', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_JFD_OSCAR', 		'MAJOR_CIV_APPROACH_GUARDED', 		3),
			('LEADER_JFD_OSCAR', 		'MAJOR_CIV_APPROACH_AFRAID', 		5),
			('LEADER_JFD_OSCAR', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_JFD_OSCAR', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		3);
--------------------------------	
-- Leader_MinorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_OSCAR', 		'MINOR_CIV_APPROACH_IGNORE', 		1),
			('LEADER_JFD_OSCAR', 		'MINOR_CIV_APPROACH_FRIENDLY', 		9),
			('LEADER_JFD_OSCAR', 		'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_JFD_OSCAR', 		'MINOR_CIV_APPROACH_CONQUEST', 		1),
			('LEADER_JFD_OSCAR', 		'MINOR_CIV_APPROACH_BULLY', 		1);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_JFD_OSCAR', 		'FLAVOR_OFFENSE', 					1),
			('LEADER_JFD_OSCAR', 		'FLAVOR_DEFENSE', 					5),
			('LEADER_JFD_OSCAR', 		'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_JFD_OSCAR', 		'FLAVOR_MILITARY_TRAINING', 		3),
			('LEADER_JFD_OSCAR', 		'FLAVOR_RECON', 					3),
			('LEADER_JFD_OSCAR', 		'FLAVOR_RANGED', 					3),
			('LEADER_JFD_OSCAR', 		'FLAVOR_MOBILE', 					3),
			('LEADER_JFD_OSCAR', 		'FLAVOR_NAVAL', 					6),
			('LEADER_JFD_OSCAR', 		'FLAVOR_NAVAL_RECON', 				6),
			('LEADER_JFD_OSCAR', 		'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_JFD_OSCAR', 		'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	7),
			('LEADER_JFD_OSCAR', 		'FLAVOR_AIR', 						3),
			('LEADER_JFD_OSCAR', 		'FLAVOR_EXPANSION', 				3),
			('LEADER_JFD_OSCAR', 		'FLAVOR_GROWTH', 					5),
			('LEADER_JFD_OSCAR', 		'FLAVOR_TILE_IMPROVEMENT', 			4),
			('LEADER_JFD_OSCAR', 		'FLAVOR_INFRASTRUCTURE', 			3),
			('LEADER_JFD_OSCAR', 		'FLAVOR_PRODUCTION', 				4),
			('LEADER_JFD_OSCAR', 		'FLAVOR_GOLD', 						5),
			('LEADER_JFD_OSCAR', 		'FLAVOR_SCIENCE', 					7),
			('LEADER_JFD_OSCAR', 		'FLAVOR_CULTURE', 					7),
			('LEADER_JFD_OSCAR', 		'FLAVOR_HAPPINESS', 				6),
			('LEADER_JFD_OSCAR', 		'FLAVOR_GREAT_PEOPLE', 				9),
			('LEADER_JFD_OSCAR', 		'FLAVOR_WONDER', 					6),
			('LEADER_JFD_OSCAR', 		'FLAVOR_RELIGION', 					4),
			('LEADER_JFD_OSCAR', 		'FLAVOR_DIPLOMACY', 				9),
			('LEADER_JFD_OSCAR', 		'FLAVOR_SPACESHIP', 				2),
			('LEADER_JFD_OSCAR', 		'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_JFD_OSCAR', 		'FLAVOR_NUKE', 						2),
			('LEADER_JFD_OSCAR', 		'FLAVOR_USE_NUKE', 					2),
			('LEADER_JFD_OSCAR', 		'FLAVOR_ESPIONAGE', 				3),
			('LEADER_JFD_OSCAR', 		'FLAVOR_AIRLIFT', 					2),
			('LEADER_JFD_OSCAR', 		'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_JFD_OSCAR', 		'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_JFD_OSCAR', 		'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_JFD_OSCAR', 		'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_JFD_OSCAR', 		'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_JFD_OSCAR', 		'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_JFD_OSCAR', 		'TRAIT_JFD_SWEDEN_OSCAR');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
			(Type, 						Description, 						ShortDescription,							GreatPersonGiftInfluence,	DOFGreatPersonModifier)
VALUES		('TRAIT_JFD_SWEDEN_OSCAR', 	'TXT_KEY_TRAIT_JFD_SWEDEN_OSCAR', 	'TXT_KEY_TRAIT_JFD_SWEDEN_OSCAR_SHORT',		90,							15);	
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 	
			(Type, 								Description,							 ShortDescription, 								Adjective, 									  Civilopedia,								  CivilopediaTag,						DefaultPlayerColor,					ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 						PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 	MapImage, 						DawnOfManQuote,								DawnOfManImage)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),	('TXT_KEY_CIV_JFD_SWEDEN_NORWAY_DESC'),  ('TXT_KEY_CIV_JFD_SWEDEN_NORWAY_SHORT_DESC'),  ('TXT_KEY_CIV_JFD_SWEDEN_NORWAY_ADJECTIVE'),  ('TXT_KEY_CIV5_JFD_SWEDEN_NORWAY_TEXT_1'),  ('TXT_KEY_CIV5_JFD_SWEDEN_NORWAY'),	('PLAYERCOLOR_JFD_SWEDEN_NORWAY'),	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('JFD_SWEDEN_NORWAY_ATLAS'), 	0, 				('JFD_SWEDEN_NORWAY_ALPHA_ATLAS'), 	('Sweden'), 	('SwedenOscarMap_512.dds'),		('TXT_KEY_CIV5_DAWN_SWEDEN_NORWAY_TEXT'),	('DOM_OscarII.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_SWEDEN');
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames
            (CivilizationType,					CityName)
VALUES		('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_0'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_1'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_2'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_3'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_4'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_5'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_6'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_7'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_8'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_9'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_10'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_11'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_12'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_13'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_14'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_15'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_16'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_17'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_18'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_19'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_20'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_21'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_22'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_23'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_24'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_25'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_26'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_27'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_28'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_29'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_30'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_31'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_32'),
            ('CIVILIZATION_JFD_SWEDEN_NORWAY',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_NORWAY_33');
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 						BuildingClassType)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_SWEDEN');
--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 						TechType)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_SWEDEN');
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 						UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_SWEDEN');
--------------------------------	
-- Civilization_Leaders
--------------------------------	
INSERT INTO Civilization_Leaders 
			(CivilizationType, 						LeaderheadType)
VALUES		('CIVILIZATION_JFD_SWEDEN_NORWAY',		'LEADER_JFD_OSCAR');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 						UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_JFD_SWEDEN_NORWAY', 		'UNITCLASS_BATTLESHIP',		'UNIT_JFD_TORDENSKJOLD');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 						BuildingClassType, 				BuildingType)
VALUES		('CIVILIZATION_JFD_SWEDEN_NORWAY', 		'BUILDINGCLASS_PUBLIC_SCHOOL', 	'BUILDING_JFD_ROYAL_ACADEMY');
--------------------------------	
-- Civilization_Religions
--------------------------------			
INSERT INTO Civilization_Religions 
			(CivilizationType, 						ReligionType)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'), 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_SWEDEN');
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 						SpyName)
VALUES		('CIVILIZATION_JFD_SWEDEN_NORWAY', 		'TXT_KEY_SPY_NAME_JFD_SWEDEN_NORWAY_0'),	
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 		'TXT_KEY_SPY_NAME_JFD_SWEDEN_NORWAY_1'),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 		'TXT_KEY_SPY_NAME_JFD_SWEDEN_NORWAY_2'),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 		'TXT_KEY_SPY_NAME_JFD_SWEDEN_NORWAY_3'),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 		'TXT_KEY_SPY_NAME_JFD_SWEDEN_NORWAY_4'),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 		'TXT_KEY_SPY_NAME_JFD_SWEDEN_NORWAY_5'),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 		'TXT_KEY_SPY_NAME_JFD_SWEDEN_NORWAY_6'),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 		'TXT_KEY_SPY_NAME_JFD_SWEDEN_NORWAY_7'),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 		'TXT_KEY_SPY_NAME_JFD_SWEDEN_NORWAY_8'),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 		'TXT_KEY_SPY_NAME_JFD_SWEDEN_NORWAY_9');
--------------------------------	
-- Civilization_Start_Along_Ocean
--------------------------------	
INSERT INTO Civilization_Start_Along_Ocean 
			(CivilizationType, 						StartAlongOcean)
VALUES		('CIVILIZATION_JFD_SWEDEN_NORWAY', 		1);
--==========================================================================================================================
--==========================================================================================================================