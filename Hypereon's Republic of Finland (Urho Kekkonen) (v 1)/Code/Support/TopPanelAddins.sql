--==========================================================================================================================	
-- JFD_TopPanelIncludes
--==========================================================================================================================			
CREATE TABLE IF NOT EXISTS 
	JFD_TopPanelIncludes (
	FileName				text		default null);
	
INSERT OR REPLACE INTO JFD_TopPanelIncludes
		(FileName)
VALUES	('Hyp_FinlandDynamicTopPanelSupport.lua');
--==========================================================================================================================		
-- JFD_TopPanelAdditions
--==========================================================================================================================		
CREATE TABLE IF NOT EXISTS 
	JFD_TopPanelAdditions (
	CivilizationType		text		REFERENCES Civilizations(Type) 	default null,
	YieldType  				text 										default null,
	YieldSourceFunction 	text										default null,
	YieldSourceToolTip		text										default	null,
	MiscToolTipFunction		text										default	null);
	
INSERT OR REPLACE INTO JFD_TopPanelAdditions
		(CivilizationType,				YieldType,				YieldSourcefunction,			YieldSourceToolTip)
VALUES	('CIVILIZATION_HYP_FINLAND',	'YIELD_CULTURE',		'Hyp_GetCultureFromFriends',		'TXT_KEY_HYP_CULTURE_FROM_FRIENDS'),
		('CIVILIZATION_HYP_FINLAND',	'YIELD_GOLDEN_AGE',		'Hyp_GetCultureFromFriends',	'TXT_KEY_HYP_GOLDEN_AGE_FROM_FRIENDS');
--==========================================================================================================================		
--==========================================================================================================================		
