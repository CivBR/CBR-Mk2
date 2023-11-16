-- Hyp_FinlandDynamicTopPanelSupport
-- Author: Hypereon based on JFD's code
--=======================================================================================================================
-- CORE FUNCTIONS
--=======================================================================================================================
  --Hyp_GetCultureFromFriends
--------------------------------------------------------------------------------------------------------------------------
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

function Hyp_GetCultureFromFriends(playerID)
	local player = Players[playerID]
	local Hyp_FinlandCultureFromFriends = 0
	local ideology = Hyp_GetIdeology(player)
	if player:GetCivilizationType() == civilizationID then
		for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
			local otherPlayer = Players[iPlayer]
			if otherPlayer:IsAlive() and otherPlayer ~= player then
				if Teams[player:GetTeam()]:IsHasMet(otherPlayer:GetTeam()) then
					if otherPlayer:IsDoF(playerID) then						 
						local otherPlayerHappy = otherPlayer:GetExcessHappiness()
						Hyp_FinlandCultureFromFriends = Hyp_FinlandCultureFromFriends + math.floor(otherPlayerHappy * 1/5)			
						if (ideology ~= Hyp_GetIdeology(otherPlayer)) then						 
							local otherPlayerHappy = otherPlayer:GetExcessHappiness()
							Hyp_FinlandCultureFromFriends = Hyp_FinlandCultureFromFriends + math.floor(otherPlayerHappy * 1/5)	
						end	
					end
				end
			end
		end
	end
	return math.floor(Hyp_FinlandCultureFromFriends)
end

GameEvents.PlayerDoTurn.Add(Hyp_IsCivilizationActive)
--=======================================================================================================================
--=======================================================================================================================


