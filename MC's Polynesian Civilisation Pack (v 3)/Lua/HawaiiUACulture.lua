--=======================================================================================================================
-- Utility Functions
--=======================================================================================================================
-- JFD_IsCivilisationActive
-------------------------------------------------------------------------------------------------------------------------
function JFD_IsCivilisationActive(civilisationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end

	return false
end
-------------------------------------------------------------------------------------------------------------------------
-- JFD_CultureFromSpecialists
-------------------------------------------------------------------------------------------------------------------------
function JFD_CultureFromSpecialists(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POLYNESIA"] then
		for city in player:Cities() do
			local specialistCount = (city:GetSpecialistCount(GameInfoTypes["SPECIALIST_ARTIST"]) + city:GetSpecialistCount(GameInfoTypes["SPECIALIST_MUSICIAN"]) + city:GetSpecialistCount(GameInfoTypes["SPECIALIST_WRITER"])) * 3
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_MC_HAWAII_UA_CULTURE"], specialistCount)			
		end
	end
end

if JFD_IsCivilisationActive(GameInfoTypes["CIVILIZATION_POLYNESIA"]) then
	GameEvents.PlayerDoTurn.Add(JFD_CultureFromSpecialists)
end
--=======================================================================================================================
--=======================================================================================================================