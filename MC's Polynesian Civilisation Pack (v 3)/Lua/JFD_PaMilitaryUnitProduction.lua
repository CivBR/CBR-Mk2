	-- Taiaha Warrior Combat boost
	-- Author: JFD	
		 
function JFD_GetNumberWorkedPas(playerID, city)
	local numWorkedPas = 0
	for cityPlot = 0, city:GetNumCityPlots() - 1, 1 do
		local plot = city:GetCityIndexPlot(cityPlot)
		if plot then
			if plot:GetOwner() == playerID then
				if city:IsWorkingPlot(plot) then	
					if plot:GetImprovementType() == GameInfoTypes["IMPROVEMENT_MC_MAORI_PA"] then 
						numWorkedPas = numWorkedPas + 1
					end
				end
			end
		end
	end
	
	return numWorkedPas
end
	
function JFD_PaMilitaryProduction(playerID)
	local player = Players[playerID]
	if player:IsAlive() then
		for city in player:Cities() do
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_PA_MILITARY_UNIT_PRODUCTION"], JFD_GetNumberWorkedPas(playerID, city))
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_PaMilitaryProduction)