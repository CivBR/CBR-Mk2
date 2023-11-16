
INSERT INTO ArtDefine_LandmarkTypes(Type, LandmarkType, FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_MC_MAORI_PA', 'Improvement', 'MC_MAORI_PA';

INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 0.22,  'ART_DEF_IMPROVEMENT_MC_MAORI_PA', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'pa_hb.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 0.22,  'ART_DEF_IMPROVEMENT_MC_MAORI_PA', 'RANDOM', 'ART_DEF_RESOURCE_ALL', 'pa_01.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 0.22,  'ART_DEF_IMPROVEMENT_MC_MAORI_PA', 'RANDOM', 'ART_DEF_RESOURCE_ALL', 'pa_02.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 0.22,  'ART_DEF_IMPROVEMENT_MC_MAORI_PA', 'RANDOM', 'ART_DEF_RESOURCE_ALL', 'pa_03.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged', 0.22,  'ART_DEF_IMPROVEMENT_MC_MAORI_PA', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'pa_pl.fxsxml', 1;


INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
SELECT 'ART_DEF_IMPROVEMENT_MC_MAORI_PA', 'Improvement', 'sv_pa.dds';