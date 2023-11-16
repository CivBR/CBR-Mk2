/*-**************-*\
Colonialist Legacies' Australia
Support for Ethnic Units
Civitar
\*-**************-*/

UPDATE Civilizations SET ArtStyleSuffix = (CASE WHEN EXISTS (SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ENGLAND' ) THEN '_ENGLAND' ELSE '_EURO' END) WHERE Type = 'CIVILIZATION_CL_AUSTRALIA';