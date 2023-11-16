/*-**************-*\
Colonialist Legacies' Australia
Support for Historical Religions
Civitar
\*-**************-*/

UPDATE Civilization_Religions SET ReligionType = (CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_CHRISTIAN_ANGLICANISM' ) THEN 'RELIGION_CHRISTIAN_ANGLICANISM' ELSE 'RELIGION_CHRISTIANITY' END) WHERE CivilizationType = 'CIVILIZATION_CL_AUSTRALIA';