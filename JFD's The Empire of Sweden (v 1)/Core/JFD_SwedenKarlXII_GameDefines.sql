--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 							BuildingClass, Cost, GoldMaintenance, PrereqTech,			FreeStartEra, Description, 							Civilopedia, 							Help, 										Strategy,								 		ArtDefineTag, 	MinAreaSize, NeverCapture, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT	('BUILDING_JFD_WAR_ACADEMY'),	BuildingClass, Cost, GoldMaintenance, ('TECH_METALLURGY'),  FreeStartEra, ('TXT_KEY_BUILDING_JFD_WAR_ACADEMY'),	('TXT_KEY_CIV5_JFD_WAR_ACADEMY_TEXT'),  ('TXT_KEY_BUILDING_JFD_WAR_ACADEMY_HELP'),  ('TXT_KEY_BUILDING_JFD_WAR_ACADEMY_STRATEGY'),  ArtDefineTag,	MinAreaSize, NeverCapture, HurryCostModifier, 3, 				('JFD_SWEDEN_KARL_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_MILITARY_ACADEMY');
------------------------------	                                                                                                                 				
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 					BuildingClassType)
SELECT	('BUILDING_JFD_WAR_ACADEMY'),	BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_MILITARY_ACADEMY');
------------------------------	
-- Building_DomainFreeExperiences
------------------------------	
INSERT INTO Building_DomainFreeExperiences 	
		(BuildingType, 					DomainType,		Experience)
SELECT	('BUILDING_JFD_WAR_ACADEMY'),	DomainType,		Experience+5
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_MILITARY_ACADEMY');
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 					FlavorType,		Flavor)
SELECT	('BUILDING_JFD_WAR_ACADEMY'),	FlavorType,		Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_MILITARY_ACADEMY');	
--==========================================================================================================================	
-- IMPROVEMENTS
--==========================================================================================================================
-- Improvements
--------------------------------	
INSERT INTO Improvements
		(Type,									Description, NearbyEnemyDamage, BuildableOnResources, DefenseModifier, Civilopedia, ArtDefineTag, CultureBombRadius, CreatedByGreatPerson, InAdjacentFriendly, PillageGold, PortraitIndex, IconAtlas)
SELECT	('IMPROVEMENT_JFD_SWEDISH_CITADEL'),	Description, NearbyEnemyDamage, BuildableOnResources, DefenseModifier, Civilopedia, ArtDefineTag, CultureBombRadius, CreatedByGreatPerson, InAdjacentFriendly, PillageGold, PortraitIndex, IconAtlas
FROM Improvements WHERE (Type = 'IMPROVEMENT_CITADEL');
--------------------------------
-- Improvement_Yields
--------------------------------
INSERT INTO Improvement_Yields
		(ImprovementType,					YieldType,		Yield)
VALUES	('IMPROVEMENT_JFD_SWEDISH_CITADEL',	'YIELD_FOOD',	2);		

INSERT INTO Improvement_Yields
		(ImprovementType,						YieldType, Yield)
SELECT	('IMPROVEMENT_JFD_SWEDISH_CITADEL'), 	YieldType, Yield
FROM Improvement_Yields WHERE (ImprovementType = 'IMPROVEMENT_CITADEL');
--------------------------------
-- Improvement_ResourceTypes
--------------------------------
INSERT INTO Improvement_ResourceTypes
		(ImprovementType,						ResourceType)
SELECT	('IMPROVEMENT_JFD_SWEDISH_CITADEL'), 	ResourceType
FROM Improvement_ResourceTypes WHERE (ImprovementType = 'IMPROVEMENT_CITADEL');
--------------------------------
-- Improvement_ResourceType_Yields
--------------------------------
INSERT INTO Improvement_ResourceType_Yields
		(ImprovementType,						ResourceType, YieldType, Yield)
SELECT	('IMPROVEMENT_JFD_SWEDISH_CITADEL'), 	ResourceType, YieldType, Yield
FROM Improvement_ResourceType_Yields WHERE (ImprovementType = 'IMPROVEMENT_CITADEL');
--------------------------------
-- Belief_ImprovementYieldChanges
--------------------------------
INSERT INTO Belief_ImprovementYieldChanges
		(ImprovementType,						BeliefType,	YieldType, Yield)
SELECT	('IMPROVEMENT_JFD_SWEDISH_CITADEL'),	BeliefType,	YieldType, Yield
FROM Belief_ImprovementYieldChanges WHERE (ImprovementType = 'IMPROVEMENT_CITADEL');
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
		(Type, 								 Description, 								Help, 											Sound, 				CannotBeChosen, PortraitIndex,  IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_CAROLEAN_SNOW',		'TXT_KEY_PROMOTION_JFD_CAROLEAN_SNOW',		'TXT_KEY_PROMOTION_JFD_CAROLEAN_SNOW_HELP',		'AS2D_IF_LEVELUP',	1, 				57, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_CAROLEAN_SNOW'),
		('PROMOTION_JFD_CAROLEAN_TUNDRA',	'TXT_KEY_PROMOTION_JFD_CAROLEAN_TUNDRA',	'TXT_KEY_PROMOTION_JFD_CAROLEAN_TUNDRA_HELP',	'AS2D_IF_LEVELUP',	1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_CAROLEAN_TUNDRA');
--------------------------------	
-- UnitPromotion_Terrains
--------------------------------	
INSERT INTO UnitPromotions_Terrains
		(PromotionType,						TerrainType,		Attack, Defense)
VALUES	('PROMOTION_JFD_CAROLEAN_SNOW',		'TERRAIN_SNOW',		0,		-10),
		('PROMOTION_JFD_CAROLEAN_TUNDRA',	'TERRAIN_TUNDRA',	15,		0);
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Unit_FreePromotions
--------------------------------
INSERT INTO Unit_FreePromotions
		(UnitType, 					PromotionType)
VALUES	('UNIT_SWEDISH_CAROLEAN', 	'PROMOTION_JFD_CAROLEAN_SNOW'),
		('UNIT_SWEDISH_CAROLEAN', 	'PROMOTION_JFD_CAROLEAN_TUNDRA');
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 						Description, 				Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES	('LEADER_JFD_KARL', 		'TXT_KEY_LEADER_JFD_KARL', 	'TXT_KEY_LEADER_JFD_KARL_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_KARL', 	'KarlXII_Scene.xml',	8, 						3, 						3, 							8, 			6, 				6, 				5, 						5, 				6, 			6, 			4, 				4, 			4, 			'JFD_SWEDEN_KARL_ATLAS', 	1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_KARL', 		'MAJOR_CIV_APPROACH_WAR', 			7),
		('LEADER_JFD_KARL', 		'MAJOR_CIV_APPROACH_HOSTILE', 		3),
		('LEADER_JFD_KARL', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
		('LEADER_JFD_KARL', 		'MAJOR_CIV_APPROACH_GUARDED', 		4),
		('LEADER_JFD_KARL', 		'MAJOR_CIV_APPROACH_AFRAID', 		3),
		('LEADER_JFD_KARL', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_JFD_KARL', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_KARL', 		'MINOR_CIV_APPROACH_IGNORE', 		3),
		('LEADER_JFD_KARL', 		'MINOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_JFD_KARL', 		'MINOR_CIV_APPROACH_PROTECTIVE', 	3),
		('LEADER_JFD_KARL', 		'MINOR_CIV_APPROACH_CONQUEST', 		7),
		('LEADER_JFD_KARL', 		'MINOR_CIV_APPROACH_BULLY', 		4);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 				FlavorType, 						Flavor)
VALUES	('LEADER_JFD_KARL', 		'FLAVOR_OFFENSE', 					7),
		('LEADER_JFD_KARL', 		'FLAVOR_DEFENSE', 					7),
		('LEADER_JFD_KARL', 		'FLAVOR_CITY_DEFENSE', 				4),
		('LEADER_JFD_KARL', 		'FLAVOR_MILITARY_TRAINING', 		8),
		('LEADER_JFD_KARL', 		'FLAVOR_RECON', 					4),
		('LEADER_JFD_KARL', 		'FLAVOR_RANGED', 					7),
		('LEADER_JFD_KARL', 		'FLAVOR_MOBILE', 					8),
		('LEADER_JFD_KARL', 		'FLAVOR_NAVAL', 					4),
		('LEADER_JFD_KARL', 		'FLAVOR_NAVAL_RECON', 				4),
		('LEADER_JFD_KARL', 		'FLAVOR_NAVAL_GROWTH', 				3),
		('LEADER_JFD_KARL', 		'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	3),
		('LEADER_JFD_KARL', 		'FLAVOR_AIR', 						4),
		('LEADER_JFD_KARL', 		'FLAVOR_EXPANSION', 				7),
		('LEADER_JFD_KARL', 		'FLAVOR_GROWTH', 					7),
		('LEADER_JFD_KARL', 		'FLAVOR_TILE_IMPROVEMENT', 			8),
		('LEADER_JFD_KARL', 		'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_JFD_KARL', 		'FLAVOR_PRODUCTION', 				4),
		('LEADER_JFD_KARL', 		'FLAVOR_GOLD', 						6),
		('LEADER_JFD_KARL', 		'FLAVOR_SCIENCE', 					3),
		('LEADER_JFD_KARL', 		'FLAVOR_CULTURE', 					4),
		('LEADER_JFD_KARL', 		'FLAVOR_HAPPINESS', 				6),
		('LEADER_JFD_KARL', 		'FLAVOR_GREAT_PEOPLE', 				6),
		('LEADER_JFD_KARL', 		'FLAVOR_WONDER', 					4),
		('LEADER_JFD_KARL', 		'FLAVOR_RELIGION', 					3),
		('LEADER_JFD_KARL', 		'FLAVOR_DIPLOMACY', 				2),
		('LEADER_JFD_KARL', 		'FLAVOR_SPACESHIP', 				2),
		('LEADER_JFD_KARL', 		'FLAVOR_WATER_CONNECTION', 			2),
		('LEADER_JFD_KARL', 		'FLAVOR_NUKE', 						2),
		('LEADER_JFD_KARL', 		'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_KARL', 		'FLAVOR_ESPIONAGE', 				4),
		('LEADER_JFD_KARL', 		'FLAVOR_AIRLIFT', 					2),
		('LEADER_JFD_KARL', 		'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_KARL', 		'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_KARL', 		'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_KARL', 		'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_KARL', 		'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_KARL', 		'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 				TraitType)
VALUES	('LEADER_JFD_KARL', 		'TRAIT_JFD_SWEDEN_KARL');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 						Description, 						ShortDescription)
VALUES	('TRAIT_JFD_SWEDEN_KARL', 	'TXT_KEY_TRAIT_JFD_SWEDEN_KARL', 	'TXT_KEY_TRAIT_JFD_SWEDEN_KARL_SHORT');	
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
UPDATE Civilizations
SET DawnOfManQuote = 'TXT_KEY_CIV5_DAWN_SWEDEN_KARL_TEXT', DawnOfManAudio = null
WHERE Type = 'CIVILIZATION_SWEDEN';
--------------------------------	
-- Civilization_CityNames
--------------------------------	
DELETE FROM Civilization_CityNames WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
INSERT INTO Civilization_CityNames
        (CivilizationType,        CityName)
VALUES	('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_1'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_2'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_3'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_4'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_5'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_6'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_7'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_8'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_9'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_10'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_11'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_12'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_13'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_14'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_15'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_16'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_17'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_18'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_19'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_20'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_21'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_22'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_23'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_24'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_25'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_26'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_27'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_28'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_29'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_30'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_31'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_32'),
        ('CIVILIZATION_SWEDEN',   'TXT_KEY_CITY_NAME_CIVILIZATION_JFD_SWEDEN_KARL_33');
--------------------------------	
-- Civilization_Leaders
--------------------------------	
DELETE FROM Civilization_Leaders WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
INSERT INTO Civilization_Leaders 
		(CivilizationType, 						LeaderheadType)
VALUES	('CIVILIZATION_SWEDEN',					'LEADER_JFD_KARL');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
DELETE FROM Civilization_UnitClassOverrides WHERE CivilizationType = 'CIVILIZATION_SWEDEN';
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 						UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_SWEDEN', 				'UNITCLASS_RIFLEMAN',	'UNIT_SWEDISH_CAROLEAN');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------	
DELETE FROM Civilization_BuildingClassOverrides WHERE CivilizationType = 'CIVILIZATION_SWEDEN';	
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 						BuildingClassType, 					BuildingType)
VALUES	('CIVILIZATION_SWEDEN', 				'BUILDINGCLASS_MILITARY_ACADEMY', 	'BUILDING_JFD_WAR_ACADEMY');
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
DELETE FROM Civilization_SpyNames WHERE (CivilizationType = 'CIVILIZATION_SWEDEN');
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 						SpyName)
VALUES	('CIVILIZATION_SWEDEN', 				'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_0'),	
		('CIVILIZATION_SWEDEN', 				'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_1'),
		('CIVILIZATION_SWEDEN', 				'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_2'),
		('CIVILIZATION_SWEDEN', 				'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_3'),
		('CIVILIZATION_SWEDEN', 				'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_4'),
		('CIVILIZATION_SWEDEN', 				'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_5'),
		('CIVILIZATION_SWEDEN', 				'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_6'),
		('CIVILIZATION_SWEDEN', 				'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_7'),
		('CIVILIZATION_SWEDEN', 				'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_8'),
		('CIVILIZATION_SWEDEN', 				'TXT_KEY_SPY_NAME_JFD_SWEDEN_KARL_9');
--------------------------------	
-- Civilization_Start_Region_Avoid 
--------------------------------		
INSERT INTO Civilization_Start_Region_Avoid 
		(CivilizationType, 			RegionType)
VALUES	('CIVILIZATION_SWEDEN', 	'REGION_HILLS');
--==========================================================================================================================
--==========================================================================================================================