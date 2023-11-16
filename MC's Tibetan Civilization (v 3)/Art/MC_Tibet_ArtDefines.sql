--==========================================================================================================================
-- ArtDefine_StrategicView
--==========================================================================================================================	
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 					TileType,	Asset)
VALUES		('ART_DEF_UNIT_MC_HIMALAYAN_CAVALRY', 	'Unit', 	'sv_himalayan_cavalry.dds');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================			
INSERT INTO ArtDefine_UnitInfos 
			(Type, 									DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_MC_HIMALAYAN_CAVALRY'), 	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_LANCER');
--==========================================================================================================================
-- ArtDefine_UnitInfoMemberInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,							UnitMemberInfoType,							NumMembers)
SELECT		('ART_DEF_UNIT_MC_HIMALAYAN_CAVALRY'), 	('ART_DEF_UNIT_MEMBER_MC_HIMALAYAN_CAVALRY'), 	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_LANCER');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombats
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,								EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_MC_HIMALAYAN_CAVALRY'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_LANCER');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombatWeapons
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,								"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_MC_HIMALAYAN_CAVALRY'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_LANCER');
--==========================================================================================================================
-- ArtDefine_UnitMemberInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 											Scale,  ZOffset, Domain, Model, 							MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_MC_HIMALAYAN_CAVALRY'),	Scale,	ZOffset, Domain, ('HimalayanCavalry.fxsxml'),		MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_LANCER');
--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES		('MC_TIBET_ATLAS', 						256, 		'MC_TibetAtlas_256.dds',				4, 				1),
			('MC_TIBET_ATLAS', 						128, 		'MC_TibetAtlas_128.dds',				4, 				1),
			('MC_TIBET_ATLAS', 						80, 		'MC_TibetAtlas_80.dds',					4, 				1),
			('MC_TIBET_ATLAS', 						64, 		'MC_TibetAtlas_64.dds',					4, 				1),
			('MC_TIBET_ATLAS', 						45, 		'MC_TibetAtlas_45.dds',					4, 				1),
			('MC_TIBET_ATLAS', 						32, 		'MC_TibetAtlas_32.dds',					4, 				1),
			('MC_TIBET_ALPHA_ATLAS', 				128, 		'MC_TibetAlphaAtlas_128.dds',			1, 				1),
			('MC_TIBET_ALPHA_ATLAS', 				80, 		'MC_TibetAlphaAtlas_80.dds',			1, 				1),
			('MC_TIBET_ALPHA_ATLAS', 				64, 		'MC_TibetAlphaAtlas_64.dds',			1, 				1),
			('MC_TIBET_ALPHA_ATLAS', 				48, 		'MC_TibetAlphaAtlas_48.dds',			1, 				1),
			('MC_TIBET_ALPHA_ATLAS', 				45, 		'MC_TibetAlphaAtlas_45.dds',			1, 				1),
			('MC_TIBET_ALPHA_ATLAS', 				32, 		'MC_TibetAlphaAtlas_32.dds',			1, 				1),
			('MC_TIBET_ALPHA_ATLAS', 				24, 		'MC_TibetAlphaAtlas_24.dds',			1, 				1),
			('MC_TIBET_ALPHA_ATLAS', 				16, 		'MC_TibetAlphaAtlas_16.dds',			1, 				1),
			('MC_HIMALAYAN_CAVALRY_FLAG_ATLAS', 	32, 		'HimalayanCavalryFlag.dds',				1, 				1);
--==========================================================================================================================
--==========================================================================================================================