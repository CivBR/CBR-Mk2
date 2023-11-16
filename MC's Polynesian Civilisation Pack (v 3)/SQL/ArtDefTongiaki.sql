INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
    SELECT  ('ART_DEF_UNIT_MC_TONGAN_TONGIAKI'), 3, Formation
    FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_TRIREME');
     
INSERT INTO ArtDefine_UnitInfoMemberInfos VALUES    ('ART_DEF_UNIT_MC_TONGAN_TONGIAKI', 'ART_DEF_UNIT_MEMBER_U_POLYNESIAN_WAR_CANOE', "1");