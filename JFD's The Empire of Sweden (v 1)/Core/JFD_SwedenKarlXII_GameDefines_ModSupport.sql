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
VALUES  ('LEADER_JFD_KARL',		'POLICY_AGGRESSIVE_X',		'POLICY_EXPANSIVE_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Karl XII [ICON_WAR][ICON_FOOD]'
	ELSE 'TXT_KEY_LEADER_JFD_KARL' END) 
WHERE Type = 'LEADER_JFD_KARL';
--==========================================================================================================================
-- Gazebo's Community Balance Patch
--==========================================================================================================================
-- COMMUNITY
------------------------------	
CREATE TABLE IF NOT EXISTS COMMUNITY (Type text, Value variant default 0);
------------------------------
-- Buildings
------------------------------	
UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_JFD_WAR_ACADEMY_HELP_CBP'
WHERE Type = 'BUILDING_JFD_WAR_ACADEMY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );
--==========================================================================================================================
-- JFD's Exploration Continued Expanded
--==========================================================================================================================
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
		(CivilizationType,						RevolutionaryCivilizationType)
VALUES	('CIVILIZATION_SWEDEN',					'CIVILIZATION_JFD_SWEDEN_GUSTAV'),
		('CIVILIZATION_JFD_SWEDEN_GUSTAV',		'CIVILIZATION_SWEDEN');
--==========================================================================================================================	
-- JFD's Piety & Prestige
--==========================================================================================================================			
-- Flavors
------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------
-- Leader_Flavors
------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,								Flavor)
VALUES	('LEADER_JFD_KARL',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		3);
--==========================================================================================================================
-- Sukritact's Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_SwedenKarlXII_Decisions.lua');
------------------------------
-- Policies
------------------------------
INSERT INTO Policies
		(Type,													Description,														UnitSupplyMod,	BaseFreeUnits)
VALUES	('POLICY_DECISIONS_JFD_SWEDEN_MILITARY_SCIENCE',		'TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_ENCOURAGE_MILITARY_SCIENCE',		0,				0),
		('POLICY_DECISIONS_JFD_SWEDEN_ESTABLISH_OCTAL_SYSTEM',	'TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_ESTABLISH_OCTAL_SYSTEM',			25,				5);
------------------------------
-- Policy_BuildingClassYieldChanges
------------------------------
INSERT INTO Policy_BuildingClassYieldChanges
		(PolicyType,										BuildingClassType,					YieldType,			YieldChange)
VALUES	('POLICY_DECISIONS_JFD_SWEDEN_MILITARY_SCIENCE',	'BUILDINGCLASS_BARRACKS',			'YIELD_SCIENCE',	2),
		('POLICY_DECISIONS_JFD_SWEDEN_MILITARY_SCIENCE',	'BUILDINGCLASS_ARMORY',				'YIELD_SCIENCE',	2),
		('POLICY_DECISIONS_JFD_SWEDEN_MILITARY_SCIENCE',	'BUILDINGCLASS_MILITARY_ACADEMY',	'YIELD_SCIENCE',	2);
--==========================================================================================================================
-- Sukritact's Events
--==========================================================================================================================
-- EventsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('JFD_SwedenKarlXII_Events.lua');
--==========================================================================================================================
--==========================================================================================================================