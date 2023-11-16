/*-**************-*\
Colonialist Legacies' Australia
City-States
Civitar
\*-**************-*/

UPDATE MinorCivilizations SET Type = 'MINOR_CIV_CL_KINGSTON', Description = 'TXT_KEY_MINOR_CIV_CL_KINGSTON', ShortDescription = Description, Adjective = 'TXT_KEY_MINOR_CIV_CL_KINGSTON_ADJ', Civilopedia = 'TXT_KEY_MINOR_CIV_CL_KINGSTON_PEDIA', ArtStyleType = 'ARTSTYLE_SOUTH_AMERICA', ArtStylePrefix = 'AMERICAN', ArtStyleSuffix = '_AMER' WHERE Type = 'MINOR_CIV_SYDNEY';
UPDATE MinorCivilizations SET Type = 'MINOR_CIV_CL_LUXEMBOURG', Description = 'TXT_KEY_MINOR_CIV_CL_LUXEMBOURG', ShortDescription = Description, Adjective = 'TXT_KEY_MINOR_CIV_CL_LUXEMBOURG_ADJ', Civilopedia = 'TXT_KEY_MINOR_CIV_CL_LUXEMBOURG_PEDIA' WHERE Type = 'MINOR_CIV_MELBOURNE';
UPDATE MinorCivilization_CityNames SET MinorCivType = 'MINOR_CIV_CL_KINGSTON', CityName = 'TXT_KEY_MINOR_CIV_CL_KINGSTON' WHERE MinorCivType = 'MINOR_CIV_SYDNEY';
UPDATE MinorCivilization_CityNames SET MinorCivType = 'MINOR_CIV_CL_LUXEMBOURG', CityName = 'TXT_KEY_MINOR_CIV_CL_LUXEMBOURG' WHERE MinorCivType = 'MINOR_CIV_MELBOURNE';
UPDATE MinorCivilization_Flavors SET MinorCivType = 'MINOR_CIV_CL_KINGSTON' WHERE MinorCivType = 'MINOR_CIV_SYDNEY';
UPDATE MinorCivilization_Flavors SET MinorCivType = 'MINOR_CIV_CL_LUXEMBOURG' WHERE MinorCivType = 'MINOR_CIV_MELBOURNE';