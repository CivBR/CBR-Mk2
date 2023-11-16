--=============================================================
--==========================================================================================================================
-- TOMATEKH HISTORICAL RELIGIONS
--==========================================================================================================================
-- Civilization_Religions
------------------------------
UPDATE Civilization_Religions
SET ReligionType = 'RELIGION_HELLENISM'
WHERE CivilizationType = 'CIVILIZATION_MC_ATHENS'
AND EXISTS (SELECT * FROM Religions WHERE Type = 'RELIGION_HELLENISM');

UPDATE Civilization_Religions
SET ReligionType = 'RELIGION_HELLENISM'
WHERE CivilizationType = 'CIVILIZATION_MC_SPARTA'
AND EXISTS (SELECT * FROM Religions WHERE Type = 'RELIGION_HELLENISM');

UPDATE Civilization_Religions
SET ReligionType = 'RELIGION_HELLENISM'
WHERE CivilizationType = 'CIVILIZATION_MC_PERGAMON'
AND EXISTS (SELECT * FROM Religions WHERE Type = 'RELIGION_HELLENISM');

UPDATE Civilization_Religions
SET ReligionType = 'RELIGION_HELLENISM'
WHERE CivilizationType = 'CIVILIZATION_MC_MACEDON'
AND EXISTS (SELECT * FROM Religions WHERE Type = 'RELIGION_HELLENISM');