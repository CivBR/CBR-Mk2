--------------------------------	
-- Ethnic Units Support
--------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_POLYNESIA')
	THEN '_POLYNESIA'
	ELSE '_MED' END) 
WHERE Type IN ('CIVILIZATION_MC_TONGA', 'CIVILIZATION_MC_MAORI', 'CIVILIZATION_MC_RAPA_NUI');

--------------------------------	
-- Map Labels
--------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,						CultureType,	CultureEra)
VALUES		('CIVILIZATION_MC_MAORI',		'PACIFIC',		'ANY'),
			('CIVILIZATION_MC_MAORI',		'BRITISH',		'MODERN'),
			('CIVILIZATION_MC_RAPA_NUI',	'PACIFIC',		'ANY'),
			('CIVILIZATION_MC_TONGA',		'PACIFIC',		'ANY');

--------------------------------	
-- Piety & Prestige
--------------------------------	
INSERT OR REPLACE INTO Flavors
            (Type)
VALUES      ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
 
INSERT INTO Leader_Flavors
            (LeaderType,                  FlavorType,                             Flavor)
VALUES      ('LEADER_MC_TE_RAUPARAHA',    'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     3),
            ('LEADER_MC_AHO_EITU',        'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     3),
            ('LEADER_MC_HOTU_MATUA',      'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     6);

--------------------------------	
-- Events & Decisions
--------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MC_Polynesia_Decisions.lua');


--------------------------------
-- Cultural Diversity
--------------------------------
CREATE TABLE IF NOT EXISTS Civilization_JFD_CultureTypes(CivilizationType, CultureType, SplashScreenTag, SoundtrackTag);
 
INSERT INTO Civilization_JFD_CultureTypes
            (CivilizationType,              CultureType,    SplashScreenTag,    SoundtrackTag)
VALUES      ('CIVILIZATION_MC_MAORI',       'JFD_Oceanic',  'JFD_Oceanic',      'JFD_Oceanic'),
            ('CIVILIZATION_MC_TONGA',       'JFD_Oceanic',  'JFD_Oceanic',      'JFD_Oceanic'),
            ('CIVILIZATION_MC_RAPA_NUI',    'JFD_Oceanic',  'JFD_Oceanic',      'JFD_Oceanic');


--------------------------------
-- ExCE
--------------------------------
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
    CivilizationType                            text    REFERENCES Civilizations(Type)      default null,
    ColonyName                                  text                                        default null,
    LinguisticType                              text                                        default null,
    CultureType                                 text                                        default null);

INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
            (CivilizationType,                      ColonyName,                             LinguisticType)
VALUES      ('CIVILIZATION_MC_TONGA',	            null,                                   'JFD_Austronesian'),
            ('CIVILIZATION_MC_MAORI',               null,                                   'JFD_Austronesian'),
            ('CIVILIZATION_MC_RAPA_NUI',            null,				                    'JFD_Austronesian');

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
    CivilizationType                            text    REFERENCES Civilizations(Type)      default null,
    RevolutionaryCivilizationType               text    REFERENCES Civilizations(Type)      default null);
     
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
            (CivilizationType,              RevolutionaryCivilizationType)
VALUES      ('CIVILIZATION_AMERICA',        'CIVILIZATION_POLYNESIA');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
            (CivilizationType,                      RevolutionaryCivilizationType)
SELECT      ('CIVILIZATION_JFD_NEW_ZEALAND'),       ('CIVILIZATION_MC_MAORI')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_NEW_ZEALAND');

INSERT INTO Unit_FreePromotions
            (UnitType,					  PromotionType)
SELECT      ('UNIT_MC_TONGAN_TONGIAKI'),  ('PROMOTION_JFD_SCURVY_IMMUNITY')
WHERE EXISTS (SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_SCURVY_IMMUNITY');

--------------------------------
--Civ IV Traits
--------------------------------
CREATE TABLE IF NOT EXISTS
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        DEFAULT null,
    TraitOne            text    REFERENCES Policies(Type)       DEFAULT null,
    TraitTwo            text    REFERENCES Policies(Type)       DEFAULT null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
        (LeaderType,                    TraitOne,                       TraitTwo)
VALUES  ('LEADER_MC_HOTU_MATUA',        'POLICY_CREATIVE_X',            'POLICY_SPIRITUAL_X'),
        ('LEADER_MC_AHO_EITU',          'POLICY_SEAFARING_X',           'POLICY_DIPLOMATIC_X'),
        ('LEADER_MC_TE_RAUPARAHA',      'POLICY_AGGRESSIVE_X',          'POLICY_PROTECTIVE_X'),
        ('LEADER_KAMEHAMEHA',           'POLICY_PHILOSOPHICAL_X',       'POLICY_INDUSTRIOUS_X');
 
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

--------------------------------
-- YnAEMP
--------------------------------
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
            (Type,                          X,      Y)
VALUES      ('CIVILIZATION_MC_MAORI',       111,    9),
            ('CIVILIZATION_MC_RAPA_NUI',    135,    17),
            ('CIVILIZATION_MC_TONGA',       117,    23);
--==========================================================================================================================
-- Civilizations_YahemStartPosition (Earth Huge)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
            (Type,                          X,      Y)
VALUES      ('CIVILIZATION_MC_MAORI',       1,      9),
            ('CIVILIZATION_MC_RAPA_NUI',    22,     18),
            ('CIVILIZATION_MC_TONGA',       7,      21);
--==========================================================================================================================
-- Civilizations_CordiformStartPosition (Earth Standard)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
            (Type,                          X,      Y)
VALUES      ('CIVILIZATION_MC_MAORI',       3,      5),
            ('CIVILIZATION_MC_RAPA_NUI',    9,      8),
            ('CIVILIZATION_MC_TONGA',       75,     40);
--==========================================================================================================================
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
            (Type,                          X,      Y)
VALUES      ('CIVILIZATION_MC_MAORI',       2,      9),
            --('CIVILIZATION_MC_RAPA_NUI',  74,     35),
            ('CIVILIZATION_MC_TONGA',       2,      21);
--==========================================================================================================================
-- Civilizations_PacificStartPosition (Pacific)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_PacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_PacificStartPosition
            (Type,                          X,      Y)
VALUES      ('CIVILIZATION_MC_MAORI',       61,     5),
            --('CIVILIZATION_MC_RAPA_NUI',  74,     35),
            ('CIVILIZATION_MC_TONGA',       69,     18);
--==========================================================================================================================
-- Civilizations_SouthPacificStartPosition (South Pacific)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthPacificStartPosition
            (Type,                          X,      Y)
VALUES      ('CIVILIZATION_MC_MAORI',       19,     14),
            ('CIVILIZATION_MC_RAPA_NUI',    96,     29),
            ('CIVILIZATION_MC_TONGA',       31,     38);
--==========================================================================================================================
-- Civilizations_AmericasStartPosition (Americas)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
            (Type,                          X,      Y)
            ('CIVILIZATION_MC_RAPA_NUI',    21,     12);
--==========================================================================================================================
--==========================================================================================================================