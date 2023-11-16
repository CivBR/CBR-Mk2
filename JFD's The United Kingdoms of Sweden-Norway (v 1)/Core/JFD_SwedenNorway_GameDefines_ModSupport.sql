--=======================================================================================================================
-- Bingle's Civ IV Traits
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,			TraitOne,					TraitTwo)
VALUES      ('LEADER_JFD_OSCAR',	'POLICY_DIPLOMATIC_X',		'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Oscar II [ICON_INFLUENCE][ICON_GREAT_PEOPLE]'
	ELSE 'TXT_KEY_LEADER_JFD_OSCAR' END) 
WHERE Type = 'LEADER_JFD_OSCAR';

CREATE TRIGGER CivIVTraitsSwedenNorway
AFTER INSERT ON Leaders WHEN 'LEADER_JFD_OSCAR' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Oscar II [ICON_INFLUENCE][ICON_GREAT_PEOPLE]'
		ELSE 'TXT_KEY_LEADER_JFD_OSCAR' END) 
	WHERE Type = 'LEADER_JFD_OSCAR';
END;		
--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_SWEDEN' )
	THEN '_SWEDEN'
	ELSE '_EURO' END) 
WHERE Type = 'CIVILIZATION_JFD_SWEDEN_NORWAY';
--==========================================================================================================================
-- Gedemon's YnAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
			(Type,									X,	Y)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		X,	Y
FROM Civilizations_YagemStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,									X,	Y)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,									X,	Y)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,									X,	Y)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_EuroGiantStartPosition (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
			(Type,									X,	Y)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		X,	Y
FROM Civilizations_EuroGiantStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_EuroLargeStartPosition (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
			(Type,									X,	Y)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		X,	Y
FROM Civilizations_EuroLargeStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_NorthAtlanticStartPosition (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,									X,	Y)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_AmericasStartPosition (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,									X,	Y)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_NorthWestEuropeStartPosition (North-West Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthWestEuropeStartPosition
			(Type,									X,	Y)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		X,	Y
FROM Civilizations_NorthWestEuropeStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroGiantRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroGiantRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_AmericasRequestedResource (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_NorthAtlanticRequestedResource (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_NorthWestEuropeRequestedResource (North-West Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthWestEuropeRequestedResource
			(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthWestEuropeRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,							CultureType,	CultureEra)
VALUES		('CIVILIZATION_JFD_SWEDEN_NORWAY',	'GERMANIC',		'ANY');
--==========================================================================================================================
-- JFD's Cultural Diversity
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	CultureType 								text										default null,
	SplashScreenTag								text										default	null,
	SoundtrackTag								text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_CultureTypes
			(CivilizationType,					CultureType,	SplashScreenTag, SoundtrackTag)
VALUES		('CIVILIZATION_JFD_SWEDEN_NORWAY',	'JFD_Western', 	'JFD_Western',	 'JFD_Western');
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = (CASE WHEN EXISTS(SELECT SoundtrackTag FROM Civilizations WHERE SoundtrackTag = 'JFD_Western')
	THEN 'JFD_Western'
	ELSE 'Sweden' END) 
WHERE Type = 'CIVILIZATION_JFD_SWEDEN_NORWAY';
--==========================================================================================================================
-- JFD's Exploration Continued Expanded
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 					ColonyName,									LinguisticType)
VALUES		('CIVILIZATION_JFD_SWEDEN_NORWAY',	null,										'JFD_FinnoUgric'),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_01',		null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_02',		null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_03',		null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_04',		null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_05',		null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_06',		null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_01',		null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_02',		null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_03',		null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_04',		null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_05',		null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_06',		null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_01',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_02',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_03',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_04',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_05',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_06',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_07',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_08',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_09',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_10',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_11',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_12',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_13',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_14',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_15',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_16',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_17',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_18',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_19',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_20',	null),
			('CIVILIZATION_JFD_SWEDEN_NORWAY', 	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_NORWAY_21',	null);
------------------------------	
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,						RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_SWEDEN',					'CIVILIZATION_JFD_SWEDEN_NORWAY'),
			('CIVILIZATION_JFD_SWEDEN_NORWAY',		'CIVILIZATION_SWEDEN');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,						RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		('CIVILIZATION_JFD_SWEDEN_GUSTAV')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_SWEDEN_GUSTAV');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,						RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_JFD_SWEDEN_NORWAY'),		('CIVILIZATION_JFD_NORWAY')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_NORWAY');
--==========================================================================================================================	
-- JFD's Piety & Prestige
--==========================================================================================================================			
-- Civilization_JFD_Governments
------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  	text 		REFERENCES Civilizations(Type) 				default null,
	CultureType	  		text 		 											default null,
	GovernmentType		text													default	null,
	GovernmentName		text													default	null,
	Weight				integer													default	0);

INSERT INTO Civilization_JFD_Governments
			(CivilizationType,					GovernmentType,					GovernmentName, 						Weight)
VALUES		('CIVILIZATION_JFD_SWEDEN_NORWAY',	'GOVERNMENT_JFD_MONARCHY',		'TXT_KEY_JFD_GOVERNMENT_NAME_SWEDEN',	90);
------------------------------					
-- Flavors
------------------------------	
INSERT OR REPLACE INTO Flavors 
			(Type)
VALUES		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------
-- Leader_Flavors
------------------------------
INSERT INTO Leader_Flavors
			(LeaderType,			FlavorType,								Flavor)
VALUES		('LEADER_JFD_OSCAR',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		3);
--==========================================================================================================================
-- Sukritact's Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_SwedenNorway_Decisions.lua');
------------------------------
-- Policies
------------------------------
INSERT INTO Policies
			(Type, 												Description)
VALUES		('POLICY_DECISIONS_JFD_INNOVATE_OPEN_AIR_MUSEUMS', 	'TXT_KEY_DECISIONS_JFD_SWEDEN_NORWAY_INNOVATE_OPEN_AIR_MUSEUMS');
------------------------------
-- Policies
------------------------------
INSERT INTO Policy_ImprovementCultureChanges
			(PolicyType, 										ImprovementType, 				CultureChange)
VALUES		('POLICY_DECISIONS_JFD_INNOVATE_OPEN_AIR_MUSEUMS', 	'IMPROVEMENT_HOLY_SITE',		1),
			('POLICY_DECISIONS_JFD_INNOVATE_OPEN_AIR_MUSEUMS', 	'IMPROVEMENT_CUSTOMS_HOUSE',	1),
			('POLICY_DECISIONS_JFD_INNOVATE_OPEN_AIR_MUSEUMS', 	'IMPROVEMENT_CITADEL',			1),
			('POLICY_DECISIONS_JFD_INNOVATE_OPEN_AIR_MUSEUMS', 	'IMPROVEMENT_ACADEMY',			1),
			('POLICY_DECISIONS_JFD_INNOVATE_OPEN_AIR_MUSEUMS', 	'IMPROVEMENT_MANUFACTORY',		1);
------------------------------
-- GreatWorks
------------------------------
INSERT INTO GreatWorks 
			(Type, 									GreatWorkClassType,	 Description,								  Audio,						Image)
VALUES		('GREAT_WORK_DECISIONS_JFD_OSCAR_II', 	'GREAT_WORK_ART',	 'TXT_KEY_GREAT_WORK_DECISIONS_JFD_OSCAR_II', 'AS2D_GREAT_ARTIST_ARTWORK', 	'OscarII.dds');
------------------------------
-- Units
------------------------------
INSERT INTO Units 	
			(Type, 								Class, Moves, Special, Domain, Description,										ShowInPedia,  UnitArtInfoEraVariation, UnitArtInfo, UnitFlagIconOffset, UnitFlagAtlas, PortraitIndex, IconAtlas)
SELECT		('UNIT_DECISIONS_JFD_ANDERS_ZORN'), Class, Moves, Special, Domain, ('TXT_KEY_GREAT_PERSON_DECISIONS_JFD_ANDERS_ZORN'), 0,			  UnitArtInfoEraVariation, UnitArtInfo, UnitFlagIconOffset,	UnitFlagAtlas, PortraitIndex, IconAtlas
FROM Units WHERE (Type = 'UNIT_ARTIST');
------------------------------
-- Unit_UniqueNames
------------------------------
INSERT INTO Unit_UniqueNames 
			(UnitType, 							UniqueName,											GreatWorkType)
VALUES		('UNIT_DECISIONS_JFD_ANDERS_ZORN', 	'TXT_KEY_GREAT_PERSON_DECISIONS_JFD_ANDERS_ZORN',	'GREAT_WORK_DECISIONS_JFD_OSCAR_II');
--==========================================================================================================================
-- Sukritact's Events
--==========================================================================================================================
-- EventsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('JFD_SwedenNorway_Events.lua');
--==========================================================================================================================
--==========================================================================================================================