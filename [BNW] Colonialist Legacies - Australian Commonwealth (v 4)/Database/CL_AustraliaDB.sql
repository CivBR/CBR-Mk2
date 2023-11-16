/*-**************-*\
Colonialist Legacies' Australia
New Database Columns
Civitar
\*-**************-*/

ALTER TABLE UnitPromotions ADD COLUMN 'ShowInPedia' INTEGER DEFAULT 1;
ALTER TABLE UnitPromotions ADD COLUMN 'ShowInUnitPanel' INTEGER DEFAULT 1;
ALTER TABLE Buildings ADD COLUMN 'ShowInPedia' INTEGER DEFAULT 1;