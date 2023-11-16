/*-**************-*\
Colonialist Legacies' Australia
Support for Civ IV Leader Traits
Civitar
\*-**************-*/

CREATE TABLE IF NOT EXISTS Leader_SharedTraits (LeaderType, TraitOne, TraitTwo);
INSERT OR REPLACE INTO Leader_SharedTraits (LeaderType,					TraitOne,				TraitTwo) VALUES
										   ('LEADER_CL_HENRY_PARKES',	'POLICY_INDUSTRIOUS_X',	'POLICY_CHARISMATIC_X');
UPDATE Leaders SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' ) THEN 'Henry Parkes [ICON_PRODUCTION][ICON_HAPPINESS_1]' ELSE 'TXT_KEY_LEADER_CL_HENRY_PARKES' END) WHERE Type = 'LEADER_CL_HENRY_PARKES';