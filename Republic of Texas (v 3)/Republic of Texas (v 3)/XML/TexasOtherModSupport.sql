--==========================================================================================================================	
-- Flavors
--==========================================================================================================================			
INSERT OR REPLACE INTO Flavors 
			(Type)
VALUES		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');

INSERT INTO Leader_Flavors
			(LeaderType,			FlavorType,								Flavor)
VALUES		('LEADER_HOUSTON',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',				5);
--==========================================================================================================================		
--==========================================================================================================================		
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
            (CivilizationType,                      ColonyName,                             LinguisticType)
VALUES      ('CIVILIZATION_TEXAS',             null,                                   'JFD_Germanic'),
            ('CIVILIZATION_TEXAS',             null,                                   'JFD_Latinate'),
            ('CIVILIZATION_TEXAS',             'TXT_KEY_COLONY_NAME_JFD_AMERICA_01',    null),
            ('CIVILIZATION_TEXAS',             'TXT_KEY_COLONY_NAME_JFD_AMERICA_02',    null),
            ('CIVILIZATION_TEXAS',             'TXT_KEY_COLONY_NAME_JFD_AMERICA_03',    null),
            ('CIVILIZATION_TEXAS',             'TXT_KEY_COLONY_NAME_JFD_AMERICA_04',    null),
            ('CIVILIZATION_TEXAS',             'TXT_KEY_COLONY_NAME_JFD_AMERICA_05',    null);
------------------------------		
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,						RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_AMERICA',					'CIVILIZATION_TEXAS'),
			('CIVILIZATION_TEXAS',	'CIVILIZATION_AMERICA');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,						RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_TEXAS'),	('CIVILIZATION_CSA')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_CSA');