--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
		(Type, 								 Description, 								Help, 											Sound, 				CannotBeChosen, PortraitIndex,  IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_REGAL_SHIP',		'TXT_KEY_PROMOTION_JFD_REGAL_SHIP',			'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_HELP',		'AS2D_IF_LEVELUP',	1, 				32, 			'PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_REGAL_SHIP'),
		('PROMOTION_JFD_REGAL_SHIP_COAST',	'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_COAST',	'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_COAST_HELP',	'AS2D_IF_LEVELUP',	1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_REGAL_SHIP_COAST');
--------------------------------	
-- UnitPromotion_Terrains
--------------------------------	
INSERT INTO UnitPromotions_Terrains
		(PromotionType,				 TerrainType,		Attack, Defense)
VALUES	('PROMOTION_JFD_REGAL_SHIP', 'TERRAIN_COAST',	20,		20);
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT OR REPLACE INTO Units 	
		(Type, 						Class, 	PrereqTech, RangedCombat, Range, Special, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 					   Civilopedia, 						Strategy, 									Help, 									Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, 					 UnitFlagIconOffset, UnitFlagAtlas,							PortraitIndex, 	IconAtlas,					MoveRate)
SELECT	('UNIT_JFD_REGAL_SHIP'),	Class,	PrereqTech, RangedCombat, Range, Special, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_JFD_REGAL_SHIP'), ('TXT_KEY_CIV5_JFD_REGAL_SHIP_TEXT'), ('TXT_KEY_UNIT_JFD_REGAL_SHIP_STRATEGY'),   ('TXT_KEY_UNIT_HELP_JFD_REGAL_SHIP'), 	Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, ('ART_DEF_UNIT_JFD_REGAL_SHIP'), 0,					 ('JFD_UNIT_FLAG_REGAL_SHIP_ATLAS'),	2, 				('JFD_SWEDEN_KARL_ATLAS'),	MoveRate
FROM Units WHERE (Type = 'UNIT_FRIGATE');
--------------------------------	
-- UnitGameplay2DScripts
--------------------------------		
INSERT OR REPLACE INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	('UNIT_JFD_REGAL_SHIP'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_FRIGATE');
--------------------------------		
-- Unit_AITypes
--------------------------------		
INSERT OR REPLACE INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	('UNIT_JFD_REGAL_SHIP'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_FRIGATE');
--------------------------------	
-- Unit_ClassUpgrades
--------------------------------	
INSERT OR REPLACE INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	('UNIT_JFD_REGAL_SHIP'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_FRIGATE');	
--------------------------------	
-- Unit_Flavors
--------------------------------		
INSERT OR REPLACE INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	('UNIT_JFD_REGAL_SHIP'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_FRIGATE');
--------------------------------	
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
SELECT	('UNIT_JFD_REGAL_SHIP'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_FRIGATE');	

INSERT INTO Unit_FreePromotions
		(UnitType, 					PromotionType)
VALUES	('UNIT_JFD_REGAL_SHIP', 	'PROMOTION_JFD_REGAL_SHIP_COAST'),
		('UNIT_JFD_REGAL_SHIP', 	'PROMOTION_JFD_REGAL_SHIP');
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 	
		(Type, 								Description, ShortDescription, 	Adjective, 	Civilopedia, CivilopediaTag, DefaultPlayerColor,				ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 	MapImage, 					DawnOfManQuote,						DawnOfManImage,		DawnOfManAudio)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	Description, ShortDescription, 	Adjective, 	Civilopedia, CivilopediaTag, ('PLAYERCOLOR_JFD_SWEDEN_GUSTAV'),	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('JFD_SWEDEN_KARL_ATLAS'), 	0, 				('JFD_SWEDEN_KARL_ALPHA_ATLAS'), 	('Sweden'), 	('MapSwedenGustav512.dds'),	('TXT_KEY_CIV5_DAWN_SWEDEN_TEXT'),	('DOM_Gustav.dds'), ('AS2D_DOM_SPEECH_SWEDEN')
FROM Civilizations WHERE (Type = 'CIVILIZATION_SWEDEN');
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames
		(CivilizationType,					CityName)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	CityName
FROM Civilization_CityNames WHERE (CivilizationType = 'CIVILIZATION_SWEDEN');
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 					BuildingClassType)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'), BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_SWEDEN');
--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 						TechType)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_SWEDEN');
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 						UnitClassType, Count, UnitAIType)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_SWEDEN');
--------------------------------	
-- Civilization_Leaders
--------------------------------	
INSERT INTO Civilization_Leaders 
		(CivilizationType, 						LeaderheadType)
VALUES	('CIVILIZATION_JFD_SWEDEN_GUSTAV',		'LEADER_GUSTAVUS_ADOLPHUS');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 						UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_JFD_SWEDEN_GUSTAV', 		'UNITCLASS_LANCER',		'UNIT_SWEDISH_HAKKAPELIITTA'),
		('CIVILIZATION_JFD_SWEDEN_GUSTAV', 		'UNITCLASS_FRIGATE',	'UNIT_JFD_REGAL_SHIP');
--------------------------------	
-- Civilization_Religions
--------------------------------			
INSERT INTO Civilization_Religions 
		(CivilizationType, 						ReligionType)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'), 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_SWEDEN');
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 						SpyName)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'), 	SpyName
FROM Civilization_SpyNames WHERE (CivilizationType = 'CIVILIZATION_SWEDEN');
--------------------------------	
-- Civilization_Start_Along_Ocean 
--------------------------------		
INSERT INTO Civilization_Start_Along_Ocean
		(CivilizationType, 					StartAlongOcean)
VALUES	('CIVILIZATION_JFD_SWEDEN_GUSTAV', 	1);
--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_SWEDEN' )
	THEN '_SWEDEN'
	ELSE '_EURO' END) 
WHERE Type = 'CIVILIZATION_JFD_SWEDEN_GUSTAV';
--==========================================================================================================================
-- Gedemon's YnAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,								X,	Y)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	X,	Y
FROM Civilizations_YagemStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,								X,	Y)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,								X,	Y)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,								X,	Y)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_EuroGiantStartPosition (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
		(Type,								X,	Y)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	X,	Y
FROM Civilizations_EuroGiantStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_EuroLargeStartPosition (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
		(Type,								X,	Y)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	X,	Y
FROM Civilizations_EuroLargeStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_NorthAtlanticStartPosition (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
		(Type,								X,	Y)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_AmericasStartPosition (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
		(Type,								X,	Y)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_NorthWestEuropeStartPosition (North-West Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthWestEuropeStartPosition
		(Type,								X,	Y)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	X,	Y
FROM Civilizations_NorthWestEuropeStartPosition WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroGiantRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroGiantRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_AmericasRequestedResource (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_NorthAtlanticRequestedResource (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAtlanticRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
------------------------------------------------------------	
-- Civilizations_NorthWestEuropeRequestedResource (North-West Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthWestEuropeRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_JFD_SWEDEN_GUSTAV'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthWestEuropeRequestedResource WHERE (Type = 'CIVILIZATION_SWEDEN');
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,							CultureType,	CultureEra)
VALUES	('CIVILIZATION_JFD_SWEDEN_GUSTAV',	'GERMANIC',		'ANY');
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

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,					CultureType,		SplashScreenTag,	SoundtrackTag)
VALUES	('CIVILIZATION_JFD_SWEDEN_GUSTAV',	'JFD_Western',		'JFD_Western',		'JFD_Western');
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = (CASE WHEN EXISTS(SELECT SoundtrackTag FROM Civilizations WHERE SoundtrackTag = 'JFD_Western' )
	THEN 'JFD_Western'
	ELSE 'Sweden' END) 
WHERE Type = 'CIVILIZATION_JFD_SWEDEN_GUSTAV';
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

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 					ColonyName,									LinguisticType)
VALUES	('CIVILIZATION_JFD_SWEDEN_GUSTAV',	null,										'JFD_FinnoUgric'),
		('CIVILIZATION_JFD_SWEDEN_GUSTAV',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_KARL_01',	null),
		('CIVILIZATION_JFD_SWEDEN_GUSTAV',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_KARL_02',	null),
		('CIVILIZATION_JFD_SWEDEN_GUSTAV',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_KARL_03',	null),
		('CIVILIZATION_JFD_SWEDEN_GUSTAV',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_KARL_04',	null),
		('CIVILIZATION_JFD_SWEDEN_GUSTAV',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_KARL_05',	null),
		('CIVILIZATION_JFD_SWEDEN_GUSTAV',	'TXT_KEY_COLONY_NAME_JFD_SWEDEN_KARL_06',	null);
--==========================================================================================================================
-- Sukritact's Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_SwedenGustavus_Decisions.lua');
------------------------------
-- Policies
------------------------------
INSERT INTO Policies
		(Type,											Description)
VALUES	('POLICY_DECISIONS_JFD_SWEDEN_ORDINANCE_ALSNO',	'TXT_KEY_DECISIONS_SWEDENINDELNINGSVERKET');
------------------------------
-- Policy_UnitCombatProductionModifiers
------------------------------
INSERT INTO Policy_UnitCombatProductionModifiers
		(PolicyType,									UnitCombatType,			ProductionModifier)
VALUES	('POLICY_DECISIONS_JFD_SWEDEN_ORDINANCE_ALSNO', 'UNITCOMBAT_MOUNTED',	15);
--==========================================================================================================================
--==========================================================================================================================