/*-**************-*\
Colonialist Legacies' Australia
Support for Map Labels
Civitar
\*-**************-*/

CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures (CivType,						CultureType) VALUES
						   ('CIVILIZATION_CL_AUSTRALIA',	'MOD_TP_AUSTRALIAN');