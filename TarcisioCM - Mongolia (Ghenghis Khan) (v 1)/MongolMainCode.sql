--------------------------------	
-- Leader_Traits
--------------------------------	
DELETE FROM Leader_Traits WHERE LeaderType = 'LEADER_GENGHIS_KHAN';
INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_GENGHIS_KHAN', 	'TRAIT_TCM_WORLD_CONQUEST');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
			(Type, 							Description, 						ShortDescription)
VALUES		('TRAIT_TCM_WORLD_CONQUEST', 	'TXT_KEY_TRAIT_WORLD_CONQUEST', 	'TXT_KEY_TRAIT_WORLD_CONQUEST_SHORT');	
--==========================================================================================================================
--==========================================================================================================================
UPDATE Units
SET Civilopedia = 'TXT_KEY_CIV5_TCM_MONGOLIA_KHAN_INFO', Strategy = 'TXT_KEY_CIV5_TCM_MONGOLIA_KHAN_STRATEGY', Help = 'TXT_KEY_CIV5_TCM_MONGOLIA_KHAN_HELP'
WHERE Type = 'UNIT_MONGOLIAN_KHAN';

UPDATE Units
SET Strategy = 'TXT_KEY_CIV5_TCM_MONGOLIA_KESHIK_STRATEGY', Moves = 4
WHERE Type = 'UNIT_MONGOLIAN_KESHIK';
--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 					DefaultBuilding, 						Description)
VALUES		('BUILDINGCLASS_TCM_MONGOL_HAPPINESS', 			'BUILDING_TCM_MONGOL_HAPPINESS', 		'TXT_KEY_TRAIT_WORLD_CONQUEST_SHORT');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================			
INSERT INTO Buildings 	
			(Type, 								 	BuildingClass, 						  UnmoddedHappiness,	GreatWorkCount, Cost, FaithCost, NukeImmune, ConquestProb, PrereqTech,			Description, 							Help)
VALUES		('BUILDING_TCM_MONGOL_HAPPINESS', 		'BUILDINGCLASS_TCM_MONGOL_HAPPINESS', 1,					-1, 			-1,   -1, 		 1,			 0,			NULL, 		 'TXT_KEY_TRAIT_WORLD_CONQUEST_SHORT', 	'TXT_KEY_TRAIT_WORLD_CONQUEST');

-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
			(Type, 											Description, 									Help, 											Sound, 				MovesChange, CityAttack,	LostWithUpgrade, CannotBeChosen,	PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_TCM_MONGOL_BONUS_AGAINST_CITIES',	'TXT_KEY_PROMOTION_TCM_MONGOL_CITY_BONUS',		'TXT_KEY_PROMOTION_TCM_MONGOL_CITY_BONUS',		'AS2D_IF_LEVELUP',	0,			 33,			1,				 1,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_TCM_MONGOL_CITY_BONUS'),
			('PROMOTION_TCM_MONGOL_BONUS_MOVEMENT',			'TXT_KEY_PROMOTION_TCM_MONGOL_MOVEMENT',		'TXT_KEY_PROMOTION_TCM_MONGOL_MOVEMENT',		'AS2D_IF_LEVELUP',	1,			 0,				0,				 1,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_TCM_MONGOL_MOVEMENT');
--==========================================================================================================================	
-- Unit_FreePromotions
--==========================================================================================================================		
INSERT INTO Unit_FreePromotions
			(UnitType, 								PromotionType)
VALUES		('UNIT_MONGOLIAN_KESHIK', 				'PROMOTION_TCM_MONGOL_BONUS_MOVEMENT');