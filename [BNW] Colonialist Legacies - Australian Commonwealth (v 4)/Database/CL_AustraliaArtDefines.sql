/*-**************-*\
Colonialist Legacies' Australia
Art Defines
Civitar
\*-**************-*/

INSERT INTO ArtDefine_UnitInfos (Type,												DamageStates,	Formation) VALUES
								('ART_DEF_UNIT_CL_AUSTRALIA_DIGGER',				1,				'UnFormed'),
								('ART_DEF_UNIT_CL_AUSTRALIA_PRIME_MINISTER',		1,				'EarlyGreatArtist');
INSERT INTO ArtDefine_UnitMemberInfos (Type,												Scale,					Model,									MaterialTypeTag,	MaterialTypeSoundOverrideTag) VALUES
									  ('ART_DEF_UNIT_MEMBER_CL_AUSTRALIA_DIGGER',			0.14000000059604645,	'u_australian_digger.fxsxml',			'CLOTH',			'FLESH'),
									  ('ART_DEF_UNIT_MEMBER_CL_AUSTRALIA_PRIME_MINISTER',	0.11999999731779099,	'u_australian_prime_minister.fxsxml',	'CLOTH',			'FLESH');
INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,									UnitMemberInfoType,									NumMembers) VALUES
										  ('ART_DEF_UNIT_CL_AUSTRALIA_DIGGER',				'ART_DEF_UNIT_MEMBER_CL_AUSTRALIA_DIGGER',			14),
										  ('ART_DEF_UNIT_CL_AUSTRALIA_PRIME_MINISTER',		'ART_DEF_UNIT_MEMBER_CL_AUSTRALIA_PRIME_MINISTER',	1),
										  ('ART_DEF_UNIT_CL_AUSTRALIA_PRIME_MINISTER',		'ART_DEF_UNIT_MEMBER_GREAT_WRITER_F1',				1),
										  ('ART_DEF_UNIT_CL_AUSTRALIA_PRIME_MINISTER',		'ART_DEF_UNIT_MEMBER_GREAT_WRITER_F2',				1);
INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType,									EnableActions,																								ShortMoveRadius,	ShortMoveRate,		TargetHeight,	HasShortRangedAttack,	HasRefaceAfterCombat,	ReformBeforeCombat) VALUES
										('ART_DEF_UNIT_MEMBER_CL_AUSTRALIA_DIGGER',			'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady Walk AttackCharge',	12,					0.3499999940395355,	8,				1,						1,						1),
										('ART_DEF_UNIT_MEMBER_CL_AUSTRALIA_PRIME_MINISTER',	'Idle Death BombardDefend Run',																				NULL,				NULL,				NULL,			NULL,					1,						NULL);
INSERT INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType,								"Index",	SubIndex,	WeaponTypeTag,	WeaponTypeSoundOverrideTag) VALUES
											  ('ART_DEF_UNIT_MEMBER_CL_AUSTRALIA_DIGGER',	0,			0,			'BULLET',		'BULLET');
INSERT INTO ArtDefine_StrategicView (StrategicViewType,									TileType,	Asset) VALUES
									('ART_DEF_UNIT_MEMBER_CL_AUSTRALIA_DIGGER',			'Unit',		'sv_digger.dds'),
									('ART_DEF_UNIT_MEMBER_CL_AUSTRALIA_PRIME_MINISTER',	'Unit',		'sv_prime_minister.dds');