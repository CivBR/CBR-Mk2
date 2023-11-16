--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 							Description, 						ShortDescription, 							Adjective, 								Civilopedia, 							CivilopediaTag, 				DefaultPlayerColor, 			ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 				PortraitIndex, 	AlphaIconAtlas, 			SoundtrackTag, 	MapImage, 				DawnOfManQuote, 								DawnOfManAudio,						DawnOfManImage)
SELECT		('CIVILIZATION_MC_TIBET'), 		('TXT_KEY_CIV_MC_TIBET_DESC'), 		('TXT_KEY_CIV_MC_TIBET_SHORT_DESC'), 		('TXT_KEY_CIV_MC_TIBET_ADJECTIVE'), 	('TXT_KEY_CIV_MC_TIBET_SHORT_DESC'), 	('TXT_KEY_CIV5_MC_TIBET'), 		('PLAYERCOLOR_MC_TIBET'), 		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('MC_TIBET_ATLAS'), 	0, 				('MC_TIBET_ALPHA_ATLAS'), 	('China'), 		('Tibet_Map512.dds'), 	('TXT_KEY_CIV5_DOM_MC_SONGTSAN_GAMPO_TEXT'),	('AS2D_DOM_SPEECH_MC_TIBET'), 		('DOM_Tibet.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_CHINA');
--------------------------------	
-- Ethnic Units Support
--------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_CHINA' )
	THEN '_CHINA'
	ELSE '_ASIA' END) 
WHERE Type = 'CIVILIZATION_MC_TIBET';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_LHASA'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_XIGAZE'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_GYANTSE'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_CHAMDO'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_SENGGEZANGBO'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_NAGCHUKHA'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_BAMDA'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_RUTOG'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_NYINGCHI'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_NEDONG'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_COQEN'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_BARKAM'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_SAKYA'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_GARTSE'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_PELBAR'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_LHATSE'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_TINGRI'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_DARTSEDO'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_GYEGU'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_MACHEN'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_GOLMUD'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_TAWANG'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_LEH'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_GANGTOK'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_LADAKH'),
			('CIVILIZATION_MC_TIBET', 		'TXT_KEY_CITY_NAME_MC_TIBET_BATANG');
--------------------------------	
-- ExCE Support
--------------------------------
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);
	
INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 						ColonyName,								LinguisticType)
VALUES		('CIVILIZATION_MC_TIBET', 				null,									'JFD_Oriental');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_MC_TIBET'), 		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_CHINA');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 			TechType)
SELECT		('CIVILIZATION_MC_TIBET'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_CHINA');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 			UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_MC_TIBET'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_CHINA');
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_MC_TIBET', 		'LEADER_MC_SONGTSAN_GAMPO');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_MC_TIBET', 		'UNITCLASS_KNIGHT', 		'UNIT_MC_TIBET_HIMALAYAN_CAVALRY');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides
--==========================================================================================================================		
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_MC_TIBET', 	'BUILDINGCLASS_TEMPLE',				'BUILDING_MC_TIBET_CHORTEN');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================		
INSERT INTO Civilization_Religions 
			(CivilizationType, 			ReligionType)
VALUES		('CIVILIZATION_MC_TIBET', 		'RELIGION_BUDDHISM');
--------------------------------	
-- Historical Religions Support
--------------------------------	
UPDATE Civilization_Religions 
SET ReligionType = ( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_VAJRAYANA' )
		THEN 'RELIGION_VAJRAYANA'
		ELSE 'RELIGION_BUDDHISM' END) 
WHERE CivilizationType = 'CIVILIZATION_MC_TIBET';

CREATE TRIGGER ReligionMCTibet
AFTER INSERT ON Religions WHEN 'RELIGION_VAJRAYANA' = NEW.Type
BEGIN
	UPDATE Civilization_Religions 
	SET ReligionType = 'RELIGION_VAJRAYANA'
	WHERE CivilizationType = 'CIVILIZATION_MC_TIBET';
END;
--==========================================================================================================================	
-- Civilization_Start_Region_Priority
--==========================================================================================================================		
INSERT INTO Civilization_Start_Region_Priority 
			(CivilizationType, 			RegionType)
VALUES		('CIVILIZATION_MC_TIBET', 	'REGION_HILLS');			
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 			SpyName)
VALUES		('CIVILIZATION_MC_TIBET', 	'TXT_KEY_SPY_NAME_MC_TIBET_0'),	
			('CIVILIZATION_MC_TIBET', 	'TXT_KEY_SPY_NAME_MC_TIBET_1'),
			('CIVILIZATION_MC_TIBET', 	'TXT_KEY_SPY_NAME_MC_TIBET_2'),
			('CIVILIZATION_MC_TIBET', 	'TXT_KEY_SPY_NAME_MC_TIBET_3'),
			('CIVILIZATION_MC_TIBET', 	'TXT_KEY_SPY_NAME_MC_TIBET_4'),
			('CIVILIZATION_MC_TIBET', 	'TXT_KEY_SPY_NAME_MC_TIBET_5'),
			('CIVILIZATION_MC_TIBET', 	'TXT_KEY_SPY_NAME_MC_TIBET_6'),
			('CIVILIZATION_MC_TIBET', 	'TXT_KEY_SPY_NAME_MC_TIBET_7'),
			('CIVILIZATION_MC_TIBET', 	'TXT_KEY_SPY_NAME_MC_TIBET_8'),
			('CIVILIZATION_MC_TIBET', 	'TXT_KEY_SPY_NAME_MC_TIBET_9');
--==========================================================================================================================		
--==========================================================================================================================