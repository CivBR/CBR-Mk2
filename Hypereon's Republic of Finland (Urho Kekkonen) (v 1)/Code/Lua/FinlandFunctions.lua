local civilizationID = GameInfoTypes["CIVILIZATION_HYP_FINLAND"]

function Hyp_IsCivilizationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end

	return false
end

if Hyp_IsCivilizationActive(civilizationID) then
	print("President Urho Kaleva Kekkonen is in this game")
end
----------------------------------------------------------------------------------

function Hyp_GetIdeology(player)
	print("GetIdeology working")
	if player:IsPolicyBranchUnlocked(GameInfoTypes["POLICY_BRANCH_AUTOCRACY"]) then
		return "AUTOCRACY"
	elseif player:IsPolicyBranchUnlocked(GameInfoTypes["POLICY_BRANCH_FREEDOM"]) then
		return "FREEDOM"	
	elseif player:IsPolicyBranchUnlocked(GameInfoTypes["POLICY_BRANCH_ORDER"]) then
		return "ORDER"
	else return "NO IDEOLOGY"
	end
end

function Hyp_FinlandCalculateGoldenAgeBoost(playerID)	
	local player = Players[playerID]
	local Hyp_FinlandGoldenAgeBonus = 0
	local ideology = Hyp_GetIdeology(player)
	if player:GetCivilizationType() == civilizationID then
		for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
			local otherPlayer = Players[iPlayer]
			if otherPlayer:IsAlive() and otherPlayer ~= player then
				if Teams[player:GetTeam()]:IsHasMet(otherPlayer:GetTeam()) then
					if otherPlayer:IsDoF(playerID) then						 
						local otherPlayerHappy = otherPlayer:GetExcessHappiness()
						Hyp_FinlandGoldenAgeBonus = Hyp_FinlandGoldenAgeBonus + math.floor(otherPlayerHappy * 1/5)	
						print("DoF bonus calculated")		
						if (ideology ~= Hyp_GetIdeology(otherPlayer)) then						 
							local otherPlayerHappy = otherPlayer:GetExcessHappiness()
							Hyp_FinlandGoldenAgeBonus = Hyp_FinlandGoldenAgeBonus + math.floor(otherPlayerHappy * 1/5)
							print("DoF and ideology bonus calculated")		
						end	
					end
				end
			end
		end
	end
	return Hyp_FinlandGoldenAgeBonus
end
function Hyp_FinlandGetGoldenAgeBoost(playerID)
	local player = Players[playerID]
	if player:IsAlive() and player:GetCivilizationType() == civilizationID then
		local Hyp_FinlandGoldenAgeBonus = Hyp_FinlandCalculateGoldenAgeBoost(playerID)
		if Hyp_FinlandGoldenAgeBonus > 0 then
			player:ChangeGoldenAgeProgressMeter(Hyp_FinlandGoldenAgeBonus)
			player:ChangeJONSCulture(Hyp_FinlandGoldenAgeBonus)
			print("DoF and ideology bonus acquired" ..Hyp_FinlandGoldenAgeBonus)	
		end
	end
end

local unitPromotionForeignTrainingID = GameInfoTypes["PROMOTION_FOREIGN_TRAINING"]
function Hyp_ForeignTrain(playerID)
	local player = Players[playerID]
	if (player:IsEverAlive() and not (player:IsMinorCiv()) and not (player:IsBarbarian())) then
		for unit in player:Units() do
			if unit:IsHasPromotion(unitPromotionForeignTrainingID) then
				if unit:GetPlot() then
					local plot = unit:GetPlot()
					local plotOwnerID = plot:GetOwner()
					if plotOwnerID > -1 then
                                                 if (plotOwnerID ~= playerID and player:IsDoF(plotOwnerID)) then
						     unit:ChangeExperience(4)
                                                 end
					end
				end
			end
		end
	end

end
GameEvents.PlayerDoTurn.Add(Hyp_ForeignTrain)


------------------------------------------------------------------------------------

print("Jaegers work in the game")

--Thank JFD for this brilliant one

GameEvents.PlayerDoTurn.Add(Hyp_IsCivilizationActive)
GameEvents.PlayerDoTurn.Add(Hyp_FinlandCalculateGoldenAgeBoost)
GameEvents.PlayerDoTurn.Add(Hyp_FinlandGetGoldenAgeBoost)

