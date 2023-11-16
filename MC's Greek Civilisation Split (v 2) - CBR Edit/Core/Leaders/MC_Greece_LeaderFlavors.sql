--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT OR REPLACE INTO Leader_MajorCivApproachBiases 
			(LeaderType,			MajorCivApproachType, 				Bias)
VALUES		('LEADER_MC_LEONIDAS', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_MC_LEONIDAS', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
			('LEADER_MC_LEONIDAS', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
			('LEADER_MC_LEONIDAS', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_MC_LEONIDAS', 	'MAJOR_CIV_APPROACH_AFRAID', 		1),
			('LEADER_MC_LEONIDAS', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_MC_LEONIDAS', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		8);
--------------------------------	
-- Leader_MinorCivApproachBiases
--------------------------------							
INSERT OR REPLACE INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		-- Leonidas
			('LEADER_MC_LEONIDAS', 	'MINOR_CIV_APPROACH_IGNORE', 		6),
			('LEADER_MC_LEONIDAS', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_MC_LEONIDAS', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	3),
			('LEADER_MC_LEONIDAS', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_MC_LEONIDAS', 	'MINOR_CIV_APPROACH_BULLY', 		9);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT OR REPLACE INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_MC_LEONIDAS', 	'FLAVOR_OFFENSE', 					10),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_MILITARY_TRAINING', 		9),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_RECON', 					6),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_RANGED', 					6),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_MOBILE', 					7),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_NAVAL', 					4),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_AIR', 						7),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_EXPANSION', 				6),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_GROWTH', 					7),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_GOLD', 						6),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_SCIENCE', 					5),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_CULTURE', 					5),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_HAPPINESS', 				5),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_WONDER', 					3),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_RELIGION', 					4),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_DIPLOMACY', 				4),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_WATER_CONNECTION', 			4),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_NUKE', 						8),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_AIRLIFT', 					4),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_MC_LEONIDAS', 	'FLAVOR_AIR_CARRIER', 				6);
--==========================================================================================================================