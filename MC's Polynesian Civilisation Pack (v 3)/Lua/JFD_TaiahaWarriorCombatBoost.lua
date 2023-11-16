	-- Taiaha Warrior Combat boost
	-- Author: JFD	
  

function JFD_TaiahaWarrior(playerID)
	local player = Players[playerID]
	if player:IsAlive() and not player:IsBarbarian() and not player:IsMinorCiv() then
		for unit in player:Units() do
			local taiahaPromotion = GameInfoTypes["PROMOTION_MC_TAIAHA_COMBAT_BONUS"]
			if unit and unit:IsCombatUnit() then
				local taiahaWarriorNearby = false
				for taiahaWarrior in player:Units() do
					if taiahaWarrior:IsHasPromotion(GameInfoTypes["PROMOTION_MC_TAIAHA_WARRIOR"]) and taiahaWarrior ~= unit then
						if Map.PlotDistance(unit:GetX(), unit:GetY(), taiahaWarrior:GetX(), taiahaWarrior:GetY()) < 2 then
							taiahaWarriorNearby = true
						end
					end
				end
				
				if taiahaWarriorNearby then
					if not unit:IsHasPromotion(taiahaPromotion) then
						unit:SetHasPromotion(taiahaPromotion, true)
					end
				else
					if unit:IsHasPromotion(taiahaPromotion) then
						unit:SetHasPromotion(taiahaPromotion, false)
					end
				end
				
			else
				if unit:IsHasPromotion(taiahaPromotion) then
					unit:SetHasPromotion(taiahaPromotion, false)
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(JFD_TaiahaWarrior) 
GameEvents.PlayerDoTurn.Add(JFD_TaiahaWarrior)
	
