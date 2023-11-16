--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 							Civilopedia, 									CivilopediaTag, 									ArtDefineTag, 				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES		('LEADER_MC_SONGTSAN_GAMPO', 	'TXT_KEY_LEADER_MC_SONGTSAN_GAMPO', 	'TXT_KEY_LEADER_MC_SONGTSAN_GAMPO', 			'TXT_KEY_CIVILOPEDIA_LEADERS_MC_SONGTSAN_GAMPO', 	'Tibet_Leaderhead.xml',		4, 						3, 						9, 							4, 			6, 				6, 				5, 						7, 				7, 			5, 			6, 				5, 			4, 			'MC_TIBET_ATLAS', 		1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 					MajorCivApproachType, 				Bias)
VALUES		('LEADER_MC_SONGTSAN_GAMPO', 	'MAJOR_CIV_APPROACH_WAR', 			4),
			('LEADER_MC_SONGTSAN_GAMPO', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
			('LEADER_MC_SONGTSAN_GAMPO', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	5),
			('LEADER_MC_SONGTSAN_GAMPO', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_MC_SONGTSAN_GAMPO', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_MC_SONGTSAN_GAMPO', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_MC_SONGTSAN_GAMPO', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 					MinorCivApproachType, 				Bias)
VALUES		('LEADER_MC_SONGTSAN_GAMPO', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
			('LEADER_MC_SONGTSAN_GAMPO', 	'MINOR_CIV_APPROACH_FRIENDLY', 		9),
			('LEADER_MC_SONGTSAN_GAMPO', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	9),
			('LEADER_MC_SONGTSAN_GAMPO', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_MC_SONGTSAN_GAMPO', 	'MINOR_CIV_APPROACH_BULLY', 		4);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 					FlavorType, 						Flavor)
VALUES		('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_OFFENSE', 					4),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_RECON', 					4),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_RANGED', 					5),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_MOBILE', 					7),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_NAVAL', 					3),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_NAVAL_GROWTH', 				3),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_AIR', 						4),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_EXPANSION', 				4),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_GROWTH', 					7),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_GOLD', 						4),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_CULTURE', 					7),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_GREAT_PEOPLE', 				6),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_WONDER', 					6),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_RELIGION', 					9),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_DIPLOMACY', 				6),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_WATER_CONNECTION', 			4),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_NUKE', 						2),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_AIRLIFT', 					2),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_MC_SONGTSAN_GAMPO', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------    
-- Piety and Prestige Support
--------------------------------            
INSERT OR REPLACE INTO Flavors 
            (Type)
VALUES      ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
 
INSERT INTO Leader_Flavors
            (LeaderType,           				FlavorType,                           	Flavor)
VALUES      ('LEADER_MC_SONGTSAN_GAMPO',    	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     6);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 					TraitType)
VALUES		('LEADER_MC_SONGTSAN_GAMPO', 	'TRAIT_MC_TIBET');
--==========================================================================================================================				
--==========================================================================================================================		