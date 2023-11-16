--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------ 
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
        (CivType,					    CultureType,            CultureEra)
VALUES  ('CIVILIZATION_CLKIMBERLEY',    'TP_AUSTRALIAN',        'ANY');
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
     
INSERT INTO Leader_SharedTraits
       (LeaderType,                             TraitOne,                               TraitTwo)
VALUES ('LEADER_CLJANDAMARRA',  'POLICY_SPIRITUAL_X',   'POLICY_SEAFARING_X');
------------------------------ 
-- Leaders
------------------------------ 
UPDATE Leaders
SET Description = (CASE WHEN EXISTS(SELECT TYPE FROM Policies WHERE TYPE = 'POLICY_PHILOSOPHICAL_X')
        THEN 'Jandamarra [ICON_GREAT_EXPLORER][ICON_PEACE]'
        ELSE 'TXT_KEY_LEADER_CLJANDAMARRA' END)
WHERE TYPE = 'LEADER_CLJANDAMARRA';
 
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
                        (TYPE,                                                                          X,              Y,              AltX,   AltY)
VALUES          ('CIVILIZATION_CLKIMBERLEY',                            88,             21,             NULL,   NULL);
 
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
                (TYPE,                                                  X,              Y)
VALUES  ('CIVILIZATION_CLKIMBERLEY',            110,            22);
 
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
                (TYPE,                                                  X,              Y)
VALUES  ('CIVILIZATION_CLKIMBERLEY',            68,             11);
 
CREATE TABLE IF NOT EXISTS Civilizations_PacificStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
                (TYPE,                                                  X,              Y)
VALUES  ('CIVILIZATION_CLKIMBERLEY',            37,             18);
-------------------------------------
-- Civilizations_YagemRequestedResource (Earth Giant)
-------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(TYPE, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
                (TYPE,                                                  Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_CLKIMBERLEY'),   Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE TYPE = 'CIVILIZATION_INDONESIA';
--==========================================================================================================================
-- JFD's CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
-------------------------------------  
CREATE TABLE IF NOT EXISTS
Civilization_JFD_CultureTypes(
        CivilizationType                                                        text    REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
        CultureType                                                             text                                                                                    DEFAULT NULL,
        ArtDefineTag                                                            text                                                                                    DEFAULT NULL,
        SplashScreenTag                                                         text                                                                                    DEFAULT NULL,
        SoundtrackTag                                                           text                                                                                    DEFAULT NULL,
        UnitDialogueTag                                                         text                                                                                    DEFAULT NULL);
 
INSERT INTO Civilization_JFD_CultureTypes
                (CivilizationType,                                              CultureType,                    SplashScreenTag,                SoundtrackTag,          UnitDialogueTag)
VALUES  ('CIVILIZATION_CLKIMBERLEY',        'JFD_Sahul',    'JFD_Sahul',    'JFD_Sahul',    'AS2D_SOUND_JFD_NATIVE_AMERICAN');
 
 
--==========================================================================================================================
-- JFD's EXPLORATION CONTINUED EXPANDED
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------   
CREATE TABLE IF NOT EXISTS
Civilization_JFD_ColonialCityNames (
        CivilizationType                                                        text    REFERENCES Civilizations(TYPE)          DEFAULT NULL,
        ColonyName                                                                      text                                                                            DEFAULT NULL,
        LinguisticType                                                          text                                                                            DEFAULT NULL,
        CultureType                                                                     text                                                                            DEFAULT NULL);
 
INSERT INTO Civilization_JFD_ColonialCityNames
                (CivilizationType,                                              ColonyName,                                                             LinguisticType)
VALUES          ('CIVILIZATION_CL_KULIN',                       NULL,                                                                   'JFD_Austronesian');
 
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
                (CivilizationType,                                              RevolutionaryCivilizationType)
SELECT  ('CIVILIZATION_CL_KULIN'),      ('CIVILIZATION_CL_AUSTRALIA')
WHERE EXISTS (SELECT TYPE FROM Civilizations WHERE TYPE = 'CIVILIZATION_CL_AUSTRALIA')
 
INSERT INTO Unit_FreePromotions
                (UnitType,                              PromotionType)
SELECT  ('UNIT_CLKIMTRACKER'),  ('PROMOTION_JFD_DESERT_IMMUNITY')
WHERE EXISTS (SELECT TYPE FROM UnitPromotions WHERE TYPE = 'PROMOTION_JFD_DESERT_IMMUNITY');
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
INSERT INTO Leader_Flavors
                (LeaderType,                            FlavorType,                                     Flavor)
VALUES  ('LEADER_CLJANDAMARRA', 'FLAVOR_JFD_MERCENARY',         6);
--==========================================================================================================================   
-- JFD's PIETY
--==========================================================================================================================   
-- Flavors
------------------------------------------------------------   
INSERT OR REPLACE INTO Flavors
                (TYPE)
VALUES  ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------------------------------------
-- Leader_Flavors
 
INSERT INTO Leader_Flavors
                (LeaderType,                    FlavorType,                                                             Flavor)
VALUES  ('LEADER_CLJANDAMARRA', 'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',             6);
--==========================================================================================================================   
-- JFD's SOVEREIGNTY
--==========================================================================================================================
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
INSERT INTO Leader_Flavors
                (LeaderType,                    FlavorType,                                                     Flavor)
VALUES  ('LEADER_JFD_JAMES',    'FLAVOR_JFD_REFORM_GOVERNMENT',         2),
                ('LEADER_CLJANDAMARRA', 'FLAVOR_JFD_REFORM_CULTURE',            5),
                ('LEADER_CLJANDAMARRA', 'FLAVOR_JFD_REFORM_ECONOMIC',           2),
                ('LEADER_CLJANDAMARRA', 'FLAVOR_JFD_REFORM_FOREIGN',            5),
                ('LEADER_CLJANDAMARRA', 'FLAVOR_JFD_REFORM_INDUSTRY',           5),
                ('LEADER_CLJANDAMARRA', 'FLAVOR_JFD_REFORM_RELIGION',           8);
--==========================================================================================================================           
--==========================================================================================================================
-- Historical Religions
--==========================================================================================================================
 
INSERT INTO Civilization_Religions
                (CivilizationType,                      ReligionType)
VALUES          ('CIVILIZATION_CLKIMBERLEY',            'RELIGION_BUDDHISM');
 
UPDATE Civilization_Religions SET ReligionType =
        ( CASE WHEN EXISTS(SELECT TYPE FROM Religions WHERE TYPE="RELIGION_TJUKURPA" )
                THEN "RELIGION_TJUKURPA"
                ELSE "RELIGION_BUDDHISM" END
        ) WHERE CivilizationType = "CIVILIZATION_CLKIMBERLEY";
 
CREATE TRIGGER ColonialistLegaciesKimberReligion
AFTER INSERT ON Religions WHEN 'RELIGION_TJUKURPA' = NEW.TYPE
BEGIN
        UPDATE Civilization_Religions
        SET ReligionType = 'RELIGION_TJUKURPA'
        WHERE CivilizationType IN ('CIVILIZATION_CLKIMBERLEY');
END;
--==========================================================================================================================

UPDATE Units 
SET Class = 'UNITCLASS_EE_LINE_INFANTRY'
WHERE Type = 'UNIT_CLKIMTRACKER'
AND EXISTS (SELECT * FROM Units WHERE Type = 'UNIT_EE_LINE_INFANTRY');

UPDATE Civilization_UnitClassOverrides 
SET UnitClassType = 'UNITCLASS_EE_LINE_INFANTRY'
WHERE UnitType = 'UNIT_CLKIMTRACKER'
AND EXISTS (SELECT * FROM Units WHERE Type = 'UNIT_EE_LINE_INFANTRY');