--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
        (CivType,                                           CultureType,            CultureEra)
VALUES  ('CIVILIZATION_CLBLACKFOOT',    'TP_CANADIAN',        'ANY');
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
VALUES  ('CIVILIZATION_CLBLACKFOOT',        'JFD_TribalAmerican',    'JFD_TribalAmerican',    'JFD_TribalAmerican',    'AS2D_SOUND_JFD_NATIVE_AMERICAN');
 
 
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
VALUES          ('CIVILIZATION_CLBLACKFOOT',                       NULL,                                                                   'JFD_NorthAmerican');
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
VALUES  ('LEADER_CLCROWFOOT', 'FLAVOR_JFD_MERCENARY',         7);
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
VALUES  ('LEADER_CLCROWFOOT', 'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',             7);
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
VALUES  ('LEADER_JFD_JAMES',    'FLAVOR_JFD_REFORM_GOVERNMENT',         4),
                ('LEADER_CLCROWFOOT', 'FLAVOR_JFD_REFORM_CULTURE',            3),
                ('LEADER_CLCROWFOOT', 'FLAVOR_JFD_REFORM_ECONOMIC',           3),
                ('LEADER_CLCROWFOOT', 'FLAVOR_JFD_REFORM_FOREIGN',            8),
                ('LEADER_CLCROWFOOT', 'FLAVOR_JFD_REFORM_INDUSTRY',           3),
                ('LEADER_CLCROWFOOT', 'FLAVOR_JFD_REFORM_RELIGION',           7);
--==========================================================================================================================          
--==========================================================================================================================
-- Historical Religions
--==========================================================================================================================
 
INSERT INTO Civilization_Religions
                (CivilizationType,                      ReligionType)
VALUES          ('CIVILIZATION_CLBLACKFOOT',            'RELIGION_PROTESTANTISM');
 
UPDATE Civilization_Religions SET ReligionType =
        ( CASE WHEN EXISTS(SELECT TYPE FROM Religions WHERE TYPE="RELIGION_WAKAN_TANKA" )
                THEN "RELIGION_WAKAN_TANKA"
                ELSE "RELIGION_PROTESTANTISM" END
        ) WHERE CivilizationType = "CIVILIZATION_CLBLACKFOOT";
 
CREATE TRIGGER ColonialistLegaciesCrowyReligion
AFTER INSERT ON Religions WHEN 'RELIGION_WAKAN_TANKA' = NEW.TYPE
BEGIN
        UPDATE Civilization_Religions
        SET ReligionType = 'RELIGION_WAKAN_TANKA'
        WHERE CivilizationType IN ('CIVILIZATION_CLBLACKFOOT');
END;