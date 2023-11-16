--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================
INSERT INTO BuildingClasses 	
			(Type, 						 		 						DefaultBuilding, 										Description)
VALUES		('BUILDINGCLASS_MC_TIBET_RELIGIOUS_PRESSURE', 				'BUILDING_MC_TIBET_RELIGIOUS_PRESSURE', 				'TXT_KEY_BUILDING_MC_TIBET_RELIGIOUS_PRESSURE'),
			('BUILDINGCLASS_MC_TIBET_CHORTEN', 							'BUILDING_TEMPLE', 										'TXT_KEY_BUILDING_MC_TIBET_CHORTEN');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings 	
			(Type, 								BuildingClass, 						PrereqTech, Cost, GoldMaintenance, MinAreaSize,  	Description, 								Civilopedia, 								Help, 											Strategy,											ArtDefineTag, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_MC_TIBET_CHORTEN'), 		('BUILDINGCLASS_TEMPLE'), 			PrereqTech, Cost, GoldMaintenance, MinAreaSize, 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN'), 		('TXT_KEY_CIV5_MC_TIBET_CHORTEN_TEXT'),  	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_HELP'), 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_STRATEGY'),		ArtDefineTag, ConquestProb, HurryCostModifier, 2, 				('MC_TIBET_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';		

INSERT INTO Buildings 	
			(Type, 						 				BuildingClass, 										Description,									Help,													GreatWorkCount, Cost, FaithCost, PrereqTech, 	NeverCapture)
VALUES		('BUILDING_MC_TIBET_RELIGIOUS_PRESSURE', 	'BUILDINGCLASS_MC_TIBET_RELIGIOUS_PRESSURE',		'TXT_KEY_BUILDING_MC_TIBET_RELIGIOUS_PRESSURE',	'TXT_KEY_BUILDING_MC_TIBET_RELIGIOUS_PRESSURE_HELP',	-1, 			-1,   -1, 		 null,			1);

UPDATE Buildings
	SET ReligiousPressureModifier = 10
	WHERE Type = 'BUILDING_MC_TIBET_RELIGIOUS_PRESSURE';

UPDATE Buildings
	SET GreatWorkSlotType = 'GREAT_WORK_SLOT_ART_ARTIFACT', GreatWorkCount = 1
	WHERE Type = 'BUILDING_MC_TIBET_CHORTEN';
--==========================================================================================================================	
-- Buildings: Chortens
--==========================================================================================================================	
INSERT INTO Buildings 	
			(Type, 									BuildingClass, 						PrereqTech, Cost, FaithCost, NeverCapture, 	GoldMaintenance, MinAreaSize,  	Description, 									Civilopedia, 								Help, 											Strategy,											ArtDefineTag, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_MC_TIBET_CHORTEN_0'), 		('BUILDINGCLASS_MC_TIBET_CHORTEN'), NULL, 		-1,   -1, 		 1,				0,				 MinAreaSize, 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_0'), 		('TXT_KEY_CIV5_MC_TIBET_CHORTEN_TEXT'),  	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_HELP'), 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_STRATEGY'),		ArtDefineTag, ConquestProb, HurryCostModifier, 2, 				('MC_TIBET_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';

INSERT INTO Buildings 	
			(Type, 									BuildingClass, 						PrereqTech, Cost, FaithCost, NeverCapture, 	GoldMaintenance, MinAreaSize,  	Description, 									Civilopedia, 								Help, 											Strategy,											ArtDefineTag, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_MC_TIBET_CHORTEN_1'), 		('BUILDINGCLASS_MC_TIBET_CHORTEN'), NULL, 		-1,   -1, 		 1,				0,				 MinAreaSize, 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_1'), 		('TXT_KEY_CIV5_MC_TIBET_CHORTEN_TEXT'),  	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_HELP'), 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_STRATEGY'),		ArtDefineTag, ConquestProb, HurryCostModifier, 2, 				('MC_TIBET_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';

INSERT INTO Buildings 	
			(Type, 									BuildingClass, 						PrereqTech, Cost, FaithCost, NeverCapture, 	GoldMaintenance, MinAreaSize,  	Description, 									Civilopedia, 								Help, 											Strategy,											ArtDefineTag, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_MC_TIBET_CHORTEN_2'), 		('BUILDINGCLASS_MC_TIBET_CHORTEN'), NULL, 		-1,   -1, 		 1,				0,				 MinAreaSize, 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_2'), 		('TXT_KEY_CIV5_MC_TIBET_CHORTEN_TEXT'),  	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_HELP'), 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_STRATEGY'),		ArtDefineTag, ConquestProb, HurryCostModifier, 2, 				('MC_TIBET_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';

INSERT INTO Buildings 	
			(Type, 									BuildingClass, 						PrereqTech, Cost, FaithCost, NeverCapture, 	GoldMaintenance, MinAreaSize,  	Description, 									Civilopedia, 								Help, 											Strategy,											ArtDefineTag, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_MC_TIBET_CHORTEN_3'), 		('BUILDINGCLASS_MC_TIBET_CHORTEN'), NULL, 		-1,   -1, 		 1,				0,				 MinAreaSize, 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_3'), 		('TXT_KEY_CIV5_MC_TIBET_CHORTEN_TEXT'),  	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_HELP'), 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_STRATEGY'),		ArtDefineTag, ConquestProb, HurryCostModifier, 2, 				('MC_TIBET_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';

INSERT INTO Buildings 	
			(Type, 									BuildingClass, 						PrereqTech, Cost, FaithCost, NeverCapture, 	GoldMaintenance, MinAreaSize,  	Description, 									Civilopedia, 								Help, 											Strategy,											ArtDefineTag, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_MC_TIBET_CHORTEN_4'), 		('BUILDINGCLASS_MC_TIBET_CHORTEN'), NULL, 		-1,   -1, 		 1,				0,				 MinAreaSize, 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_4'), 		('TXT_KEY_CIV5_MC_TIBET_CHORTEN_TEXT'),  	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_HELP'), 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_STRATEGY'),		ArtDefineTag, ConquestProb, HurryCostModifier, 2, 				('MC_TIBET_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';

INSERT INTO Buildings 	
			(Type, 									BuildingClass, 						PrereqTech, Cost, FaithCost, NeverCapture, 	GoldMaintenance, MinAreaSize, 	Description, 									Civilopedia, 								Help, 											Strategy,											ArtDefineTag, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_MC_TIBET_CHORTEN_5'), 		('BUILDINGCLASS_MC_TIBET_CHORTEN'), NULL, 		-1,   -1, 		 1,				0,				 MinAreaSize,	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_5'), 		('TXT_KEY_CIV5_MC_TIBET_CHORTEN_TEXT'),  	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_HELP'), 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_STRATEGY'),		ArtDefineTag, ConquestProb, HurryCostModifier, 2, 				('MC_TIBET_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';

INSERT INTO Buildings 	
			(Type, 									BuildingClass, 						PrereqTech, Cost, FaithCost, NeverCapture, 	GoldMaintenance, MinAreaSize,  	Description, 									Civilopedia, 								Help, 											Strategy,											ArtDefineTag, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_MC_TIBET_CHORTEN_6'), 		('BUILDINGCLASS_MC_TIBET_CHORTEN'), NULL, 		-1,   -1, 		 1,				0,				 MinAreaSize, 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_6'), 		('TXT_KEY_CIV5_MC_TIBET_CHORTEN_TEXT'),  	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_HELP'), 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_STRATEGY'),		ArtDefineTag, ConquestProb, HurryCostModifier, 2, 				('MC_TIBET_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';

INSERT INTO Buildings 	
			(Type, 									BuildingClass, 						PrereqTech, Cost, FaithCost, NeverCapture, 	GoldMaintenance, MinAreaSize,  	Description, 									Civilopedia, 								Help, 											Strategy,											ArtDefineTag, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_MC_TIBET_CHORTEN_7'), 		('BUILDINGCLASS_MC_TIBET_CHORTEN'), NULL, 		-1,   -1, 		 1,				0,				 MinAreaSize, 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_7'), 		('TXT_KEY_CIV5_MC_TIBET_CHORTEN_TEXT'),  	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_HELP'), 	('TXT_KEY_BUILDING_MC_TIBET_CHORTEN_STRATEGY'),		ArtDefineTag, ConquestProb, HurryCostModifier, 2, 				('MC_TIBET_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================	
INSERT INTO Building_Flavors 	
			(BuildingType, 						FlavorType, Flavor)
SELECT		('BUILDING_MC_TIBET_CHORTEN'),		FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_TEMPLE';
--==========================================================================================================================	
-- Building_ClassesNeededInCity
--==========================================================================================================================	
INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 						BuildingClassType)
SELECT		('BUILDING_MC_TIBET_CHORTEN'),		BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_TEMPLE';
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================		
INSERT INTO Building_YieldChanges 	
			(BuildingType, 							YieldType, 				Yield)
VALUES		('BUILDING_MC_TIBET_CHORTEN',			'YIELD_FAITH',			2),
			('BUILDING_MC_TIBET_CHORTEN_0',			'YIELD_FAITH',			0),
			('BUILDING_MC_TIBET_CHORTEN_1',			'YIELD_FAITH',			1),
			('BUILDING_MC_TIBET_CHORTEN_2',			'YIELD_FAITH',			1),
			('BUILDING_MC_TIBET_CHORTEN_3',			'YIELD_FAITH',			2),
			('BUILDING_MC_TIBET_CHORTEN_4',			'YIELD_FAITH',			2),
			('BUILDING_MC_TIBET_CHORTEN_5',			'YIELD_FAITH',			2),
			('BUILDING_MC_TIBET_CHORTEN_6',			'YIELD_FAITH',			2),
			('BUILDING_MC_TIBET_CHORTEN_7',			'YIELD_FAITH',			3);
			
INSERT INTO Building_YieldChanges 	
			(BuildingType, 							YieldType, 				Yield)
VALUES		('BUILDING_MC_TIBET_CHORTEN',			'YIELD_CULTURE',		0),
			('BUILDING_MC_TIBET_CHORTEN_0',			'YIELD_CULTURE',		1),
			('BUILDING_MC_TIBET_CHORTEN_1',			'YIELD_CULTURE',		1),
			('BUILDING_MC_TIBET_CHORTEN_2',			'YIELD_CULTURE',		2),
			('BUILDING_MC_TIBET_CHORTEN_3',			'YIELD_CULTURE',		2),
			('BUILDING_MC_TIBET_CHORTEN_4',			'YIELD_CULTURE',		2),
			('BUILDING_MC_TIBET_CHORTEN_5',			'YIELD_CULTURE',		2),
			('BUILDING_MC_TIBET_CHORTEN_6',			'YIELD_CULTURE',		3),
			('BUILDING_MC_TIBET_CHORTEN_7',			'YIELD_CULTURE',		3);
			
INSERT INTO Building_YieldChanges 	
			(BuildingType, 							YieldType, 				Yield)
VALUES		('BUILDING_MC_TIBET_CHORTEN',			'YIELD_SCIENCE',		0),
			('BUILDING_MC_TIBET_CHORTEN_0',			'YIELD_SCIENCE',		0),
			('BUILDING_MC_TIBET_CHORTEN_1',			'YIELD_SCIENCE',		0),
			('BUILDING_MC_TIBET_CHORTEN_2',			'YIELD_SCIENCE',		0),
			('BUILDING_MC_TIBET_CHORTEN_3',			'YIELD_SCIENCE',		0),
			('BUILDING_MC_TIBET_CHORTEN_4',			'YIELD_SCIENCE',		1),
			('BUILDING_MC_TIBET_CHORTEN_5',			'YIELD_SCIENCE',		2),
			('BUILDING_MC_TIBET_CHORTEN_6',			'YIELD_SCIENCE',		2),
			('BUILDING_MC_TIBET_CHORTEN_7',			'YIELD_SCIENCE',		3);
--==========================================================================================================================	
--==========================================================================================================================	