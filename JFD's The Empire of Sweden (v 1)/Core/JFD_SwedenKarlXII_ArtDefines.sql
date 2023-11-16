--==========================================================================================================================
-- ARTDEFINES
--==========================================================================================================================	
-- IconTextureAtlasesa
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 							IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_SWEDEN_KARL_ATLAS', 			256, 		'JFD_SwedenKarlAtlas_256.dds',			2, 				2),
		('JFD_SWEDEN_KARL_ATLAS', 			128, 		'JFD_SwedenKarlAtlas_128.dds',			2, 				2),
		('JFD_SWEDEN_KARL_ATLAS', 			80, 		'JFD_SwedenKarlAtlas_80.dds',			2, 				2),
		('JFD_SWEDEN_KARL_ATLAS', 			64, 		'JFD_SwedenKarlAtlas_64.dds',			2, 				2),
		('JFD_SWEDEN_KARL_ATLAS', 			45, 		'JFD_SwedenKarlAtlas_45.dds',			2, 				2),
		('JFD_SWEDEN_KARL_ATLAS', 			32, 		'JFD_SwedenKarlAtlas_32.dds',			2, 				2),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	128, 		'JFD_SwedenKarlAlphaAtlas_128.dds',		1,				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	80, 		'JFD_SwedenKarlAlphaAtlas_80.dds',		1, 				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	64, 		'JFD_SwedenKarlAlphaAtlas_64.dds',		1, 				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	48, 		'JFD_SwedenKarlAlphaAtlas_48.dds',		1, 				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	45, 		'JFD_SwedenKarlAlphaAtlas_45.dds',		1, 				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	32, 		'JFD_SwedenKarlAlphaAtlas_32.dds',		1, 				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	24, 		'JFD_SwedenKarlAlphaAtlas_24.dds',		1, 				1),
		('JFD_SWEDEN_KARL_ALPHA_ATLAS', 	16, 		'JFD_SwedenKarlAlphaAtlas_16.dds',		1, 				1),
		('JFD_SWEDEN_KARL_RESERVE_ATLAS', 	64, 		'JFD_SwedenKarlReserveAtlas_64.dds',	1, 				1),
		('JFD_UNIT_FLAG_REGAL_SHIP_ATLAS', 	32, 		'UnitFlag_Regalskapp_32.dds',			1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 											Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_JFD_SWEDEN_GUSTAV_ICON', 		0.078,	0.129,	0.364,	1),
		('COLOR_PLAYER_JFD_SWEDEN_GUSTAV_BACKGROUND',	0.784,	0.713,	0.235,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 								PrimaryColor, 							SecondaryColor, 								TextColor)
VALUES	('PLAYERCOLOR_JFD_SWEDEN_GUSTAV',	'COLOR_PLAYER_JFD_SWEDEN_GUSTAV_ICON', 	'COLOR_PLAYER_JFD_SWEDEN_GUSTAV_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 								Filename, 			LoadType)
VALUES	('SND_LEADER_MUSIC_JFD_KARL_PEACE', 	'KarlXII_Peace',	'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_KARL_WAR', 		'KarlXII_War', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 								SoundID, 								SoundType, 		MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_JFD_KARL_PEACE', 	'SND_LEADER_MUSIC_JFD_KARL_PEACE',		'GAME_MUSIC', 	60, 		60, 		1, 		 0),
		('AS2D_LEADER_MUSIC_JFD_KARL_WAR', 		'SND_LEADER_MUSIC_JFD_KARL_WAR', 		'GAME_MUSIC', 	60, 		60, 		1,		 0);
--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 				TileType,	Asset)
VALUES	('ART_DEF_UNIT_JFD_REGAL_SHIP', 	'Unit', 	'sv_Regalskapp.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------	
INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_JFD_REGAL_SHIP'),	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_FRIGATE');
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT	('ART_DEF_UNIT_JFD_REGAL_SHIP'),	('ART_DEF_UNIT_MEMBER_JFD_REGAL_SHIP'),		NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_FRIGATE');
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_JFD_REGAL_SHIP'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_FRIGATE');
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_JFD_REGAL_SHIP'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_FRIGATE');
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model, 						MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_JFD_REGAL_SHIP'),	Scale,	ZOffset, Domain, ('swedish_galleon.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_FRIGATE');
--==========================================================================================================================	
--==========================================================================================================================	
