/*-**************-*\
Colonialist Legacies' Australia
Support for Events & Decisions
FramedArchitect
\*-**************-*/

ALTER TABLE Policies ADD COLUMN 'ShowInPedia' INTEGER DEFAULT 1;
INSERT INTO Policies (Type,											GreatWriterRateModifier,	GreatArtistRateModifier,	GreatMusicianRateModifier,	GoldenAgeTurns,	IncludesOneShotFreeUnits,	ShowInPedia) VALUES
					 ('POLICY_DECISIONS_CL_AUSTRALIA_MOVE_CAPITAL',	25,							25,							25,							10,				10,							0),
					 ('POLICY_DECISIONS_CL_AUSTRALIA_DINGO_FENCE',	NULL,						NULL,						NULL,						NULL,			NULL,						0);
INSERT INTO Policy_FreeUnitClasses (PolicyType,										UnitClassType,		Count) VALUES
								   ('POLICY_DECISIONS_CL_AUSTRALIA_MOVE_CAPITAL',	'UNITCLASS_WRITER',	1);
INSERT INTO Policy_ImprovementYieldChanges (PolicyType,										ImprovementType,		YieldType,		Yield) VALUES
										   ('POLICY_DECISIONS_CL_AUSTRALIA_DINGO_FENCE',	'IMPROVEMENT_PASTURE',	'YIELD_FOOD',	1);
INSERT INTO BuildingClasses (Type,											Description,		DefaultBuilding) VALUES
							('BUILDINGCLASS_CL_AUSTRALIA_TEMP_ART_HOLDER',	'TempArtHolder',	'BUILDING_CL_AUSTRALIA_TEMP_ART_HOLDER');
INSERT INTO Buildings (Type,									BuildingClass,									Description,		Cost,	GreatWorkSlotType,				GreatWorkCount,	ShowInPedia) VALUES
					  ('BUILDING_CL_AUSTRALIA_TEMP_ART_HOLDER',	'BUILDINGCLASS_CL_AUSTRALIA_TEMP_ART_HOLDER',	'TempArtHolder',	-1,		'GREAT_WORK_SLOT_ART_ARTIFACT',	1,				0);
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('CL_AustraliaDecisions.lua');