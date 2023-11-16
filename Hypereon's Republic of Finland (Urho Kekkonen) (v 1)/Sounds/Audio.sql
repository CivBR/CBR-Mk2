-- Insert SQL Rules Here --==========================================================================================================================
-- Audio_Sounds
--==========================================================================================================================	
INSERT INTO Audio_Sounds 
			(SoundID, 									Filename, 			LoadType)
VALUES		('SND_LEADER_MUSIC_HYP_KEKKONEN_PEACE', 		'Hypereon_KekkonenPeace', 	'DynamicResident'),
			('SND_LEADER_MUSIC_HYP_KEKKONEN_WAR', 		'Hypereon_KekkonenWar', 		'DynamicResident');
--==========================================================================================================================
-- Audio_2DSounds
--==========================================================================================================================	
INSERT INTO Audio_2DSounds 
			(ScriptID, 									SoundID, 								SoundType, 		MinVolume, 	MaxVolume,	IsMusic, Looping)
VALUES		('AS2D_LEADER_MUSIC_HYP_KEKKONEN_PEACE', 	'SND_LEADER_MUSIC_HYP_KEKKONEN_PEACE',	'GAME_MUSIC', 	100, 		100, 		1, 		0),
			('AS2D_LEADER_MUSIC_HYP_KEKKONEN_WAR', 		'SND_LEADER_MUSIC_HYP_KEKKONEN_WAR', 	'GAME_MUSIC', 	100, 		100, 		1,		0);
--==========================================================================================================================	
--==========================================================================================================================	
