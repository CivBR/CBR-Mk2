/*-**************-*\
Colonialist Legacies' Australia
Support for Yet (not) Another Earth Maps Pack
Civitar
\*-**************-*/

--Australia civilization
--Earth Giant
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition (Type,							X,		Y) VALUES
											 ('CIVILIZATION_CL_AUSTRALIA',	103,	11);
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource (Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource (Type,							Req1,				Yield1,	Req2,			Yield2,	Req3,				Yield3,	Req4,				Yield4) VALUES
												 ('CIVILIZATION_CL_AUSTRALIA',	'RESOURCE_GOLD',	1,		'RESOURCE_COW',	1,		'RESOURCE_FISH',	1,		'RESOURCE_COAL',	6);
--Earth Huge
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition (Type,							X,		Y) VALUES
											 ('CIVILIZATION_CL_AUSTRALIA',	119,	13);
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource (Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource (Type,							Req1,				Yield1,	Req2,			Yield2,	Req3,				Yield3,	Req4,				Yield4) VALUES
												 ('CIVILIZATION_CL_AUSTRALIA',	'RESOURCE_GOLD',	1,		'RESOURCE_COW',	1,		'RESOURCE_FISH',	1,		'RESOURCE_COAL',	6);
--Cordiform Earth
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition (Type,							X,	Y) VALUES
												 ('CIVILIZATION_CL_AUSTRALIA',	75,	9);
CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource (Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource (Type,							Req1,				Yield1,	Req2,			Yield2,	Req3,				Yield3,	Req4,				Yield4) VALUES
													 ('CIVILIZATION_CL_AUSTRALIA',	'RESOURCE_GOLD',	1,		'RESOURCE_COW',	1,		'RESOURCE_FISH',	1,		'RESOURCE_COAL',	6);
--Greatest Earth
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition (Type,							X,		Y) VALUES
													 ('CIVILIZATION_CL_AUSTRALIA',	102,	12);
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource (Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource (Type,							Req1,				Yield1,	Req2,			Yield2,	Req3,				Yield3,	Req4,				Yield4) VALUES
														 ('CIVILIZATION_CL_AUSTRALIA',	'RESOURCE_GOLD',	1,		'RESOURCE_COW',	1,		'RESOURCE_FISH',	1,		'RESOURCE_COAL',	6);
--Pacific
CREATE TABLE IF NOT EXISTS Civilizations_PacificStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_PacificStartPosition (Type,							X,	Y) VALUES
											   ('CIVILIZATION_CL_AUSTRALIA',	50,	7);

--Replacement city-states
--Earth Giant
CREATE TABLE IF NOT EXISTS MinorCiv_YagemStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_YagemStartPosition (Type,						X,		Y) VALUES
										('MINOR_CIV_CL_KINGSTON',	153,	46),
										('MINOR_CIV_CL_LUXEMBOURG',	16,		67);
--Earth Huge
CREATE TABLE IF NOT EXISTS MinorCiv_YahemStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_YahemStartPosition (Type,						X,	Y) VALUES
										('MINOR_CIV_CL_KINGSTON',	29,	42),
										('MINOR_CIV_CL_LUXEMBOURG',	60,	61);
--Cordiform Earth
CREATE TABLE IF NOT EXISTS MinorCiv_CordiformStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_CordiformStartPosition (Type,						X,	Y) VALUES
											('MINOR_CIV_CL_KINGSTON',	10,	24),
											('MINOR_CIV_CL_LUXEMBOURG',	36,	30);
--Greatest Earth
CREATE TABLE IF NOT EXISTS MinorCiv_GreatestEarthStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_GreatestEarthStartPosition (Type,						X,	Y) VALUES
												('MINOR_CIV_CL_KINGSTON',	24,	32),
												('MINOR_CIV_CL_LUXEMBOURG',	44,	50);
--Americas
CREATE TABLE IF NOT EXISTS MinorCiv_AmericasStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_AmericasStartPosition (Type,						X,	Y) VALUES
										   ('MINOR_CIV_CL_KINGSTON',	45,	42);
--Caribbean
CREATE TABLE IF NOT EXISTS MinorCiv_CaribbeanStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_CaribbeanStartPosition (Type,						X,	Y) VALUES
											('MINOR_CIV_CL_KINGSTON',	55,	32);
--Large Eastern Mediterranean
CREATE TABLE IF NOT EXISTS MinorCiv_AmcEastMedLargeStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_AmcEastMedLargeStartPosition (Type,						X,	Y) VALUES
												  ('MINOR_CIV_CL_LUXEMBOURG',	13,	45);
--Giant Europe
CREATE TABLE IF NOT EXISTS MinorCiv_EuroGiantStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_EuroGiantStartPosition (Type,						X,	Y) VALUES
											('MINOR_CIV_CL_LUXEMBOURG',	54,	64);
--Large Europe
CREATE TABLE IF NOT EXISTS MinorCiv_EuroLargeStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_EuroLargeStartPosition (Type,						X,	Y) VALUES
											('MINOR_CIV_CL_LUXEMBOURG',	29,	42);
--Large Mediterranean
CREATE TABLE IF NOT EXISTS MinorCiv_AmcMedLargeStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_AmcMedLargeStartPosition (Type,						X,	Y) VALUES
											  ('MINOR_CIV_CL_LUXEMBOURG',	32,	45);
--North Atlantic
CREATE TABLE IF NOT EXISTS MinorCiv_NorthAtlanticStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_NorthAtlanticStartPosition (Type,						X,	Y) VALUES
												('MINOR_CIV_CL_LUXEMBOURG',	89,	29);
--Standard Northwest Europe
CREATE TABLE IF NOT EXISTS MinorCiv_NorthWestEuropeStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_NorthWestEuropeStartPosition (Type,						X,	Y) VALUES
												  ('MINOR_CIV_CL_LUXEMBOURG',	31,	10);
--Standard Western Mediterranean
CREATE TABLE IF NOT EXISTS MinorCiv_AmcWestMedStandardStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_AmcWestMedStandardStartPosition (Type,							X,	Y) VALUES
													 ('MINOR_CIV_CL_LUXEMBOURG',	30,	43);