INSERT INTO DecisionsAddin_Support
                        (FileName)
VALUES          ('TexasDecisions.lua');
 
INSERT INTO Policies
                        (TYPE,                                                  Description)
VALUES          ('POLICY_TEXASOIL',    'TXT_KEY_DECISIONS_TEXAS_OIL_INDUSTRY_DESC');

INSERT INTO Policy_ImprovementYieldChanges
                        (PolicyType,               ImprovementType,                      YieldType,                 Yield)
        VALUES          ('POLICY_TEXASOIL',    'IMPROVEMENT_WELL',             'YIELD_PRODUCTION',        2);
 
INSERT INTO BuildingClasses    
                        (TYPE,                                                                  DefaultBuilding,                                        Description,                                                            MaxPlayerInstances)
VALUES          ('BUILDINGCLASS_DECISIONS_TEXASWRITING','BUILDING_DECISIONS_TEXASWRITING',      'TXT_KEY_BUILDING_OUTLAW_GREATWORK',      1),
				('BUILDINGCLASS_DECISIONS_TEXASART','BUILDING_DECISIONS_TEXASART',      'TXT_KEY_BUILDING_OUTLAW_GREATWORK',      1),
				('BUILDINGCLASS_DECISIONS_TEXASMUSIC','BUILDING_DECISIONS_TEXASMUSIC',      'TXT_KEY_BUILDING_OUTLAW_GREATWORK',      1);
 
 
INSERT INTO Buildings  
                        (TYPE,                                                                  BuildingClass,                                                  Description,                                                            Civilopedia,                                                                                    Help,                                                                                   Strategy,                       Cost,   PrereqTech,     ConquestProb,   IconAtlas,                              PortraitIndex,          GreatWorkSlotType,                              GreatWorkCount,         FreeGreatWork)
VALUES          ('BUILDING_DECISIONS_TEXASWRITING',     'BUILDINGCLASS_DECISIONS_TEXASWRITING', 'TXT_KEY_BUILDING_OUTLAW_GREATWORK',      'TXT_KEY_DECISIONS_BUILDING_OUTLAW_GREATWORK_CIVILOPEDIA',  'TXT_KEY_DECISIONS_BUILDING_OUTLAW_GREATWORK_HELP', NULL,        -1,     NULL,                   100,                    'CIVIL_WAR_UNIT_ATLAS', 3,                                      'GREAT_WORK_SLOT_LITERATURE',		1,                                      'GREAT_WORK_DECISIONS_TEXASWRITING'),
				('BUILDING_DECISIONS_TEXASART',     'BUILDINGCLASS_DECISIONS_TEXASART', 'TXT_KEY_BUILDING_OUTLAW_GREATWORK',      'TXT_KEY_DECISIONS_BUILDING_OUTLAW_GREATWORK_CIVILOPEDIA',  'TXT_KEY_DECISIONS_BUILDING_OUTLAW_GREATWORK_HELP', NULL,        -1,     NULL,                   100,                    'CIVIL_WAR_UNIT_ATLAS', 3,                                      'GREAT_WORK_SLOT_ART_ARTIFACT',	 1,                                      'GREAT_WORK_DECISIONS_TEXASART'),
				('BUILDING_DECISIONS_TEXASMUSIC',     'BUILDINGCLASS_DECISIONS_TEXASMUSIC', 'TXT_KEY_BUILDING_OUTLAW_GREATWORK',      'TXT_KEY_DECISIONS_BUILDING_OUTLAW_GREATWORK_CIVILOPEDIA',  'TXT_KEY_DECISIONS_BUILDING_OUTLAW_GREATWORK_HELP', NULL,        -1,     NULL,                   100,                    'CIVIL_WAR_UNIT_ATLAS', 3,                                      'GREAT_WORK_SLOT_MUSIC',		 1,                                      'GREAT_WORK_DECISIONS_TEXASMUSIC');