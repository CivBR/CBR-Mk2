--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES		('HYPEREON_FINLAND_ATLAS', 					256, 		'Hypereon_FinlandIconAtlas256.dds',				4, 				4),
			('HYPEREON_FINLAND_ATLAS', 					128, 		'Hypereon_FinlandIconAtlas128.dds',				4, 				4),
			('HYPEREON_FINLAND_ATLAS', 					80, 		'Hypereon_FinlandIconAtlas80.dds',				4, 				4),
			('HYPEREON_FINLAND_ATLAS', 					64, 		'Hypereon_FinlandIconAtlas64.dds',				4, 				4),
			('HYPEREON_FINLAND_ATLAS', 					45, 		'Hypereon_FinlandIconAtlas45.dds',				4, 				4),
			('HYPEREON_FINLAND_ATLAS', 					32, 		'Hypereon_FinlandIconAtlas32.dds',				4, 				4),
			('HYPEREON_FINLAND_ALPHA_ATLAS', 		128, 		'Hypereon_FinlandAlphaAtlas_128.dds',		2, 				2),
			('HYPEREON_FINLAND_ALPHA_ATLAS', 		80, 		'Hypereon_FinlandAlphaAtlas_80.dds',		1, 				1),
			('HYPEREON_FINLAND_ALPHA_ATLAS', 		64, 		'Hypereon_FinlandAlphaAtlas_64.dds',		1, 				1),
			('HYPEREON_FINLAND_ALPHA_ATLAS', 		48, 		'Hypereon_FinlandAlphaAtlas_48.dds',		1, 				1),
			('HYPEREON_FINLAND_ALPHA_ATLAS', 		45, 		'Hypereon_FinlandAlphaAtlas_45.dds',		1, 				1),
			('HYPEREON_FINLAND_ALPHA_ATLAS', 		32, 		'Hypereon_FinlandAlphaAtlas_32.dds',		1, 				1),
			('HYPEREON_FINLAND_ALPHA_ATLAS', 		24, 		'Hypereon_FinlandAlphaAtlas_24.dds',		1, 				1),
			('HYPEREON_FINLAND_ALPHA_ATLAS', 		16, 		'Hypereon_FinlandAlphaAtlas_16.dds',		1, 				1),
			('HYPEREON_UNIT_FLAG_JAAKARI_ATLAS', 		32, 		'flag_Jaakari_32.dds',				1, 				1);
--==========================================================================================================================
-- ArtDefine_StrategicView
--==========================================================================================================================
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 					TileType,	Asset)
VALUES		('ART_DEF_UNIT_HYP_FINLAND_JAAKARI', 	'Unit', 	'sv_Jaakari.dds');

--
--==========================================================================================================================
--==========================================================================================================================
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitInfos 
			(Type,								DamageStates, Formation)
SELECT		('ART_DEF_UNIT_HYP_FINLAND_JAAKARI'),		DamageStates, Formation
FROM "ArtDefine_UnitInfos" WHERE (Type = 'ART_DEF_UNIT_RIFLEMAN');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitInfoMemberInfos 
			(UnitInfoType,					UnitMemberInfoType,					NumMembers)
SELECT		('ART_DEF_UNIT_HYP_FINLAND_JAAKARI'), ('ART_DEF_UNIT_MEMBER_HYP_FINLAND_JAAKARI'), 14
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_RIFLEMAN');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombats
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_HYP_FINLAND_JAAKARI'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombatWeapons
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_HYP_FINLAND_JAAKARI'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');
--==========================================================================================================================
-- ArtDefine_UnitMemberInfos
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 									Scale, ZOffset, Domain, Model, 						MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_HYP_FINLAND_JAAKARI'),	Scale, ZOffset, Domain, ('jaakari.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');