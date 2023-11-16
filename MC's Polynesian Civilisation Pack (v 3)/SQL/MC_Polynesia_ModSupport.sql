--=======================================================================================================================
-- BINGLES CIV IV TRAITS
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------  
CREATE TABLE IF NOT EXISTS
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(TYPE)        DEFAULT NULL,
    TraitOne            text    REFERENCES Policies(TYPE)       DEFAULT NULL,
    TraitTwo            text    REFERENCES Policies(TYPE)       DEFAULT NULL);
     
INSERT OR REPLACE INTO Leader_SharedTraits
        (LeaderType,                    TraitOne,                       TraitTwo)
VALUES  ('LEADER_MC_HOTU_MATUA',        'POLICY_CREATIVE_X',            'POLICY_SPIRITUAL_X'),
        ('LEADER_MC_AHO_EITU',          'POLICY_SEAFARING_X',           'POLICY_DIPLOMATIC_X'),
        ('LEADER_MC_TE_RAUPARAHA',      'POLICY_AGGRESSIVE_X',          'POLICY_PROTECTIVE_X'),
        ('LEADER_KAMEHAMEHA',           'POLICY_PHILOSOPHICAL_X',       'POLICY_INDUSTRIOUS_X');
 
------------------------------  
-- Leaders
------------------------------  
UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
THEN 'Hotu Matua [ICON_CULTURE][ICON_PEACE]'
ELSE 'TXT_KEY_LEADER_MC_HOTU_MATUA_DESC' END)
WHERE Type = 'LEADER_MC_HOTU_MATUA';

UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
THEN 'Aho Eitu [ICON_MOVES][ICON_INFLUENCE]'
ELSE 'TXT_KEY_LEADER_MC_AHO_EITU_DESC' END)
WHERE Type = 'LEADER_MC_AHO_EITU';

UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
THEN 'Te Rauparaha [ICON_WAR][ICON_STRENGTH]'
ELSE 'TXT_KEY_LEADER_MC_TE_RAUPARAHA_DESC' END)
WHERE Type = 'LEADER_MC_TE_RAUPARAHA';

UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
THEN 'Kamehameha [ICON_GREAT_PEOPLE][ICON_PRODUCTION]'
ELSE 'TXT_KEY_LEADER_KAMEHAMEHA' END)
WHERE Type = 'LEADER_KAMEHAMEHA';
--==========================================================================================================================
-- ENLIGHTENMENT ERA
--==========================================================================================================================
-- Unit
------------------------------
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_CARRACK'
WHERE UnitType ='UNIT_MC_TONGAN_TONGIAKI'
AND EXISTS (SELECT * FROM Units WHERE Class = 'UNITCLASS_EE_CARRACK');

--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 											text 										default null,
	Value 											integer 									default 1);
--==========================================================================================================================
-- Events & Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MC_Polynesia_Decisions.lua');
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------  
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	ArtDefineTag								text											default	null,
	DefeatScreenEarlyTag						text											default	null,
	DefeatScreenMidTag							text											default	null,
	DefeatScreenLateTag							text											default	null,
	IdealsTag									text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);
     
INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType,			  ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  'CIVILIZATION_MC_TONGA',	  ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
		'CIVILIZATION_MC_MAORI',	  ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
		'CIVILIZATION_MC_RAPA_NUI',   ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_POLYNESIA';
------------------------------  
-- Civilizations
------------------------------  
UPDATE Civilizations
SET SoundtrackTag = 'JFD_Oceanic'
WHERE TYPE = 'CIVILIZATION_MC_TONGA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Oceanic')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE TYPE = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND VALUE = 1);

UPDATE Civilizations
SET SoundtrackTag = 'JFD_Oceanic'
WHERE TYPE = 'CIVILIZATION_MC_MAORI'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Oceanic')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE TYPE = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND VALUE = 1);

UPDATE Civilizations
SET SoundtrackTag = 'JFD_Oceanic'
WHERE TYPE = 'CIVILIZATION_MC_RAPA_NUI'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Oceanic')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE TYPE = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND VALUE = 1);
--==========================================================================================================================
-- JFD's Cities in Development
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------  
CREATE TABLE IF NOT EXISTS
Civilization_JFD_ColonialCityNames (
    CivilizationType                            text    REFERENCES Civilizations(TYPE)      DEFAULT NULL,
    ColonyName                                  text                                        DEFAULT NULL,
    LinguisticType                              text                                        DEFAULT NULL,
    CultureType                                 text                                        DEFAULT NULL);
 
INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
            (CivilizationType,                      ColonyName,                             LinguisticType)
VALUES      ('CIVILIZATION_MC_TONGA',	            null,                                   'JFD_Austronesian'),
            ('CIVILIZATION_MC_MAORI',               null,                                   'JFD_Austronesian'),
            ('CIVILIZATION_MC_RAPA_NUI',            null,				                    'JFD_Austronesian');
--==========================================================  
-- JFD's CiD: Slavery
--==========================================================    
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_SLAVERY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 0-10 may be set. This value determines the proclivity a civ has toward enslaving a captured city and toward spending Slavery on Units.
INSERT INTO Leader_Flavors
        (LeaderType,            FlavorType,                 Flavor)
VALUES  ('LEADER_MC_AHO_EITU',		'FLAVOR_JFD_SLAVERY',   4),
		('LEADER_MC_TE_RAUPARAHA',	'FLAVOR_JFD_SLAVERY',	6),
		('LEADER_MC_HOTU_MATUA',	'FLAVOR_JFD_SLAVERY',	6);
--==========================================================================================================================
-- TOMATEKH HISTORICAL RELIGIONS
--==========================================================================================================================
-- Civilization_Religions (Historical Religions support is within HR itself) 
------------------------------
--UPDATE Civilization_Religions
--SET ReligionType = 'RELIGION_SLAVINISM'
--WHERE CivilizationType = 'CIVILIZATION_MC_SERBIA'
--AND EXISTS (SELECT * FROM Religions WHERE Type = 'RELIGION_SLAVINISM');
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------  
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,						CultureType,	CultureEra)
VALUES		('CIVILIZATION_MC_MAORI',		'PACIFIC',		'ANY'),
			('CIVILIZATION_MC_MAORI',		'BRITISH',		'MODERN'),
			('CIVILIZATION_MC_RAPA_NUI',	'PACIFIC',		'ANY'),
			('CIVILIZATION_MC_TONGA',		'PACIFIC',		'ANY');
--==========================================================================================================================  
-- JFD's and Pouakai's MERCENARIES
--==========================================================================================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 1-10 may be set. This value determines the likelihood that a leader will take out Mercenary Contracts (provided they have the funds).
--A value of 10 means this civilization will always take a Contract if available. A value of 0 means this civilization will never take out a contract.
INSERT OR REPLACE INTO Leader_Flavors
        (LeaderType,					FlavorType,                 Flavor)
VALUES  ('LEADER_MC_TE_RAUPARAHA',		'FLAVOR_JFD_MERCENARY',     5),
		('LEADER_MC_AHO_EITU',			'FLAVOR_JFD_MERCENARY',     3),
		('LEADER_MC_HOTU_MATUA',		'FLAVOR_JFD_MERCENARY',     3);
--==========================================================================================================================    
-- JFD's Rise to Power
--==========================================================================================================================
--==========================================================  
-- JFD's RtP: Piety
--==========================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 1-12 may be set. This value determines the diplomatic penalty/bonus with civilizations of a different/same state religion
--A value higher than 9 means this civilization will never secularise. A value of 0 means this civilization has no interest in State Religion.
INSERT INTO Leader_Flavors
            (LeaderType,                  FlavorType,                             Flavor)
VALUES      ('LEADER_MC_TE_RAUPARAHA',    'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     3),
            ('LEADER_MC_AHO_EITU',        'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     3),
            ('LEADER_MC_HOTU_MATUA',      'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     6);
--==========================================================  
-- JFD's RtP: Prosperity
--==========================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
--CREATE TABLE IF NOT EXISTS
--    Civilization_JFD_Currencies (
--    CivilizationType                text        REFERENCES Civilizations(TYPE)  DEFAULT NULL,
--    CurrencyType                    text                                        DEFAULT NULL);
-- 
--INSERT INTO Civilization_JFD_Currencies
--        (CivilizationType,                  CurrencyType)
--VALUES	( 'CIVILIZATION_MC_SERBIA',         'CURRENCY_JFD_DINAR');
--==========================================================  
-- JFD's RtP: Sovereignty
--==========================================================
------------------------------------------------------------    
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Governments (
    CivilizationType                text        REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
    CultureType                     text                                                        DEFAULT NULL,
    LegislatureName                 text                                                        DEFAULT NULL,
    OfficeTitle                     text                                                        DEFAULT NULL,
    GovernmentType                  text                                                        DEFAULT NULL,
    Weight                          INTEGER                                                     DEFAULT 0);
 
INSERT INTO Civilization_JFD_Governments
        (CivilizationType,        LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT  'CIVILIZATION_MC_MAORI', LegislatureName, OfficeTitle, GovernmentType, Weight
		'CIVILIZATION_MC_TONGA', LegislatureName, OfficeTitle, GovernmentType, Weight
		'CIVILIZATION_MC_RAPA_NUI', LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_POLYNESIA';
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Politics (
    CivilizationType                    text        REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
    PoliticsType                        text                                                        DEFAULT NULL,
    UniqueName                          text                                                        DEFAULT NULL);
 
INSERT INTO Civilization_JFD_Politics
        (CivilizationType,          PoliticsType, UniqueName)
SELECT  ('CIVILIZATION_MC_MAORI'), PoliticsType, UniqueName
		('CIVILIZATION_MC_TONGA'), PoliticsType, UniqueName
		('CIVILIZATION_MC_RAPA_NUI'), PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_POLYNESIA';
------------------------------------------------------------
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_REFORM_GOVERNMENT'),
        ('FLAVOR_JFD_REFORM_CULTURE'),
        ('FLAVOR_JFD_REFORM_ECONOMIC'),
        ('FLAVOR_JFD_REFORM_FOREIGN'),
        ('FLAVOR_JFD_REFORM_INDUSTRY'),
        ('FLAVOR_JFD_REFORM_MILITARY'),
        ('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--Each flavour corresponds to one of the seven Reform Categories, and how likely a civ is to take a reform in either the Right, Centre, or Left column.
--A value of 1-3 will favour Left Reforms. A value of 4-6 will value Centre Reforms. A value of 7-10 will value Right Reforms. The strength of the value will determine how soon a Leader will implement that Reform.
INSERT OR REPLACE INTO Leader_Flavors
        (LeaderType,         	 FlavorType,                         Flavor)
VALUES  ('LEADER_MC_AHO_EITU',    'FLAVOR_JFD_REFORM_GOVERNMENT',     6),
        ('LEADER_MC_AHO_EITU',    'FLAVOR_JFD_REFORM_CULTURE',        5),
        ('LEADER_MC_AHO_EITU',    'FLAVOR_JFD_REFORM_ECONOMIC',       4),
        ('LEADER_MC_AHO_EITU',    'FLAVOR_JFD_REFORM_FOREIGN',        5),
        ('LEADER_MC_AHO_EITU',    'FLAVOR_JFD_REFORM_INDUSTRY',       5),
        ('LEADER_MC_AHO_EITU',    'FLAVOR_JFD_REFORM_LEGAL',       	  5),
        ('LEADER_MC_AHO_EITU',    'FLAVOR_JFD_REFORM_MILITARY',       7),
        ('LEADER_MC_AHO_EITU',    'FLAVOR_JFD_REFORM_RELIGION',       6),
		('LEADER_MC_TE_RAUPARAHA',    'FLAVOR_JFD_REFORM_GOVERNMENT',     6),
        ('LEADER_MC_TE_RAUPARAHA',    'FLAVOR_JFD_REFORM_CULTURE',        5),
        ('LEADER_MC_TE_RAUPARAHA',    'FLAVOR_JFD_REFORM_ECONOMIC',       4),
        ('LEADER_MC_TE_RAUPARAHA',    'FLAVOR_JFD_REFORM_FOREIGN',        5),
        ('LEADER_MC_TE_RAUPARAHA',    'FLAVOR_JFD_REFORM_INDUSTRY',       5),
        ('LEADER_MC_TE_RAUPARAHA',    'FLAVOR_JFD_REFORM_LEGAL',       	 5),
        ('LEADER_MC_TE_RAUPARAHA',    'FLAVOR_JFD_REFORM_MILITARY',       7),
        ('LEADER_MC_TE_RAUPARAHA',    'FLAVOR_JFD_REFORM_RELIGION',       6),
		('LEADER_MC_HOTU_MATUA',    'FLAVOR_JFD_REFORM_GOVERNMENT',     6),
        ('LEADER_MC_HOTU_MATUA',    'FLAVOR_JFD_REFORM_CULTURE',        5),
        ('LEADER_MC_HOTU_MATUA',    'FLAVOR_JFD_REFORM_ECONOMIC',       4),
        ('LEADER_MC_HOTU_MATUA',    'FLAVOR_JFD_REFORM_FOREIGN',        5),
        ('LEADER_MC_HOTU_MATUA',    'FLAVOR_JFD_REFORM_INDUSTRY',       5),
        ('LEADER_MC_HOTU_MATUA',    'FLAVOR_JFD_REFORM_LEGAL',       	 5),
        ('LEADER_MC_HOTU_MATUA',    'FLAVOR_JFD_REFORM_MILITARY',       7),
        ('LEADER_MC_HOTU_MATUA',    'FLAVOR_JFD_REFORM_RELIGION',       6);
--==========================================================================================================================
-- R.E.D. / Ethnic Units
--==========================================================================================================================
-- Civilizations
------------------------------  
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_POLYNESIA')
	THEN '_POLYNESIA'
	ELSE '_MED' END) 
WHERE Type IN ('CIVILIZATION_MC_TONGA', 'CIVILIZATION_MC_MAORI', 'CIVILIZATION_MC_RAPA_NUI');
--==========================================================================================================================
-- YnAEMP v24
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
            (Type,                          X,      Y)
VALUES      ('CIVILIZATION_MC_MAORI',       111,    9),
            ('CIVILIZATION_MC_RAPA_NUI',    135,    17),
            ('CIVILIZATION_MC_TONGA',       117,    23);
------------------------------------------------------------    
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
            (Type,                          X,      Y)
VALUES      ('CIVILIZATION_MC_MAORI',       1,      9),
            ('CIVILIZATION_MC_RAPA_NUI',    22,     18),
            ('CIVILIZATION_MC_TONGA',       7,      21);
------------------------------------------------------------    
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
            (Type,                          X,      Y)
VALUES      ('CIVILIZATION_MC_MAORI',       3,      5),
            ('CIVILIZATION_MC_RAPA_NUI',    9,      8),
            ('CIVILIZATION_MC_TONGA',       75,     40);
------------------------------------------------------------    
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
            (Type,                          X,      Y)
VALUES      ('CIVILIZATION_MC_MAORI',       2,      9),
            --('CIVILIZATION_MC_RAPA_NUI',  74,     35),
            ('CIVILIZATION_MC_TONGA',       2,      21);
------------------------------------------------------------    
-- Civilizations_PacificStartPosition (Pacific)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_PacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_PacificStartPosition
            (Type,                          X,      Y)
VALUES      ('CIVILIZATION_MC_MAORI',       61,     5),
            --('CIVILIZATION_MC_RAPA_NUI',  74,     35),
            ('CIVILIZATION_MC_TONGA',       69,     18);
------------------------------------------------------------    
-- Civilizations_SouthPacificStartPosition (South Pacific)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthPacificStartPosition
            (Type,                          X,      Y)
VALUES      ('CIVILIZATION_MC_MAORI',       19,     14),
            ('CIVILIZATION_MC_RAPA_NUI',    96,     29),
            ('CIVILIZATION_MC_TONGA',       31,     38);
------------------------------------------------------------    
-- Civilizations_AmericasStartPosition (Americas)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
            (Type,                          X,      Y)
            ('CIVILIZATION_MC_RAPA_NUI',    21,     12);
------------------------------------------------------------    
-- Civilizations_AustralasiaGiantStartPosition (Australasia Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AustralasiaGiantStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_AustralasiaGiantStartPosition
        (TYPE,                          X,   Y)
VALUES  ('CIVILIZATION_MC_MAORI',       131, 23);
------------------------------------------------------------    
-- Civilizations_SouthPacificGiantStartPosition (South Pacific Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificGiantStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthPacificGiantStartPosition
        (TYPE,                          X,  Y)
VALUES  ('CIVILIZATION_MC_MAORI',       60, 13),
        ('CIVILIZATION_MC_TONGA',       82, 38);
--==========================================================================================================================
--==========================================================================================================================