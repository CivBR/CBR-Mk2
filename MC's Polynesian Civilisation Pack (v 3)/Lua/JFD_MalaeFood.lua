-- JFD_MalaeFood
-- Author: JFD

	local direction_types = {
            DirectionTypes["DIRECTION_NORTHEAST"],
            DirectionTypes["DIRECTION_NORTHWEST"],
            DirectionTypes["DIRECTION_EAST"],
            DirectionTypes["DIRECTION_SOUTHEAST"],
            DirectionTypes["DIRECTION_SOUTHWEST"],
            DirectionTypes["DIRECTION_WEST"]
            }
     
    function JFD_GetNumAdjacentSeaTiles(city)
            local numAdjacentSeaTiles = 0
            if Map.GetPlot(city:GetX(), city:GetY()) then
                    for loop, direction in ipairs(direction_types) do
                            local adjPlot = Map.PlotDirection(city:GetX(), city:GetY(), direction)
                            if adjPlot:GetTerrainType() == GameInfoTypes["TERRAIN_COAST"] then     
                                    numAdjacentSeaTiles = numAdjacentSeaTiles + 1
                            end
                    end
            end
           
            return numAdjacentSeaTiles     
    end
     
    function JFD_MalaeFood(playerID, unitID, unitX, unitY)
            local player = Players[playerID]
            if player:IsAlive() then
                    for city in player:Cities() do
                            if city:IsHasBuilding(GameInfoTypes["BUILDING_MC_TONGAN_MALAE"]) and JFD_GetNumAdjacentSeaTiles(city) >= 2 then
                                    city:SetNumRealBuilding(GameInfoTypes["BUILDING_MC_MALAE_FOOD"], 1)
                            end
                    end
            end
    end
    GameEvents.PlayerDoTurn.Add(JFD_MalaeFood)