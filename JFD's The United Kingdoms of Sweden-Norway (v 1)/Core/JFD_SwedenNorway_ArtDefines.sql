--==========================================================================================================================
-- ARTDEFINES
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 				TileType,	Asset)
VALUES		('ART_DEF_UNIT_JFD_TORDENSKJOLD', 	'Unit', 	'sv_Tordenskjold.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------	
INSERT INTO ArtDefine_UnitInfos 
			(Type, 								DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_JFD_TORDENSKJOLD'),	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_BATTLESHIP');
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT		('ART_DEF_UNIT_JFD_TORDENSKJOLD'),	('ART_DEF_UNIT_MEMBER_JFD_TORDENSKJOLD'),	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_BATTLESHIP');
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_TORDENSKJOLD'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_BATTLESHIP');
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_TORDENSKJOLD'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_BATTLESHIP');
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 										Scale,  ZOffset, Domain, Model, 					 MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_TORDENSKJOLD'),	Scale,	ZOffset, Domain, ('Braunschweig_BB.fxsxml'), MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_BATTLESHIP');
------------------------------
-- IconTextureAtlasesa
------------------------------
INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES		('JFD_SWEDEN_NORWAY_ATLAS', 			256, 		'JFD_SwdenOscarIconAtlas_256.dds',			2, 				2),
			('JFD_SWEDEN_NORWAY_ATLAS', 			128, 		'JFD_SwdenOscarIconAtlas_128.dds',			2, 				2),
			('JFD_SWEDEN_NORWAY_ATLAS', 			80, 		'JFD_SwdenOscarIconAtlas_80.dds',			2, 				2),
			('JFD_SWEDEN_NORWAY_ATLAS', 			64, 		'JFD_SwdenOscarIconAtlas_64.dds',			2, 				2),
			('JFD_SWEDEN_NORWAY_ATLAS', 			45, 		'JFD_SwdenOscarIconAtlas_45.dds',			2, 				2),
			('JFD_SWEDEN_NORWAY_ATLAS', 			32, 		'JFD_SwdenOscarIconAtlas_32.dds',			2, 				2),
			('JFD_SWEDEN_NORWAY_ALPHA_ATLAS', 		128, 		'JFD_SwdenOscarIconAlphaAtlas_128.dds',		1,				1),
			('JFD_SWEDEN_NORWAY_ALPHA_ATLAS', 		80, 		'JFD_SwdenOscarIconAlphaAtlas_80.dds',		1, 				1),
			('JFD_SWEDEN_NORWAY_ALPHA_ATLAS', 		64, 		'JFD_SwdenOscarIconAlphaAtlas_64.dds',		1, 				1),
			('JFD_SWEDEN_NORWAY_ALPHA_ATLAS', 		48, 		'JFD_SwdenOscarIconAlphaAtlas_48.dds',		1, 				1),
			('JFD_SWEDEN_NORWAY_ALPHA_ATLAS', 		45, 		'JFD_SwdenOscarIconAlphaAtlas_45.dds',		1, 				1),
			('JFD_SWEDEN_NORWAY_ALPHA_ATLAS', 		32, 		'JFD_SwdenOscarIconAlphaAtlas_32.dds',		1, 				1),
			('JFD_SWEDEN_NORWAY_ALPHA_ATLAS', 		24, 		'JFD_SwdenOscarIconAlphaAtlas_24.dds',		1, 				1),
			('JFD_SWEDEN_NORWAY_ALPHA_ATLAS', 		16, 		'JFD_SwdenOscarIconAlphaAtlas_16.dds',		1, 				1),
			('JFD_UNIT_FLAG_TORDENSKJOLD_ATLAS',	32, 		'JFD_TordenskjoldUnitFlag_32.dds',			1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
			(Type, 											Red, 	Green, 	Blue, 	Alpha)
VALUES		('COLOR_PLAYER_JFD_SWEDEN_NORWAY_ICON', 		0.870,	0.658,	0.125,	1),
			('COLOR_PLAYER_JFD_SWEDEN_NORWAY_BACKGROUND',	0.121,	0.074,	0.345,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
			(Type, 								PrimaryColor, 							SecondaryColor, 								TextColor)
VALUES		('PLAYERCOLOR_JFD_SWEDEN_NORWAY',	'COLOR_PLAYER_JFD_SWEDEN_NORWAY_ICON', 	'COLOR_PLAYER_JFD_SWEDEN_NORWAY_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
			(SoundID, 								Filename, 			LoadType)
VALUES		('SND_LEADER_MUSIC_JFD_OSCAR_PEACE', 	'Oscar_Peace',		'DynamicResident'),
			('SND_LEADER_MUSIC_JFD_OSCAR_WAR', 		'Oscar_War', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
			(ScriptID, 								SoundID, 								SoundType, 		MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES		('AS2D_LEADER_MUSIC_JFD_OSCAR_PEACE', 	'SND_LEADER_MUSIC_JFD_OSCAR_PEACE',		'GAME_MUSIC', 	60, 		60, 		1, 		 0),
			('AS2D_LEADER_MUSIC_JFD_OSCAR_WAR', 	'SND_LEADER_MUSIC_JFD_OSCAR_WAR', 		'GAME_MUSIC', 	60, 		60, 		1,		 0);
--==========================================================================================================================	
--==========================================================================================================================	
