 -- OutriggerEmbarkation
-- Author: JFD	

function JFD_OutriggerEmbarkation(playerID)
	local player = Players[playerID]
	for unit in player:Units() do
		if unit:IsEmbarked() then
			local sameTile = false
			local plot = unit:GetPlot()
			for iVal = 0,(plot:GetNumUnits() - 1) do
				local outrigger = plot:GetUnit(iVal)
				if outrigger:IsHasPromotion(GameInfoTypes["PROMOTION_MC_OUTRIGGER"]) then
					sameTile = true
				end
			end
			
			if sameTile then
				if not unit:IsHasPromotion(GameInfoTypes["PROMOTION_MC_ALLWATER_EMBARKATION"]) then
					unit:SetHasPromotion(GameInfoTypes["PROMOTION_MC_ALLWATER_EMBARKATION"], true)
				end
			else
				if unit:IsHasPromotion(GameInfoTypes["PROMOTION_MC_ALLWATER_EMBARKATION"]) then
					unit:SetHasPromotion(GameInfoTypes["PROMOTION_MC_ALLWATER_EMBARKATION"], false)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_OutriggerEmbarkation)