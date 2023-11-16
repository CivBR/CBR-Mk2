-- HeiauSpecialist
-- Author: JFD	

function GetRandom(lower, upper)
	return Game.Rand((upper + 1) - lower, "") + lower
end
 
function JFD_Heiau(playerID)
	local player = Players[playerID]
	if player:IsAlive() then
		for city in player:Cities() do
			if city:IsHasBuilding(GameInfoTypes["BUILDING_MC_HAWAIIAN_HEIAU"]) then
				if not city:IsHasBuilding(GameInfoTypes["BUILDING_MC_HEIAU_MERCHANT"]) and not city:IsHasBuilding(GameInfoTypes["BUILDING_MC_HEIAU_ENGINEER"]) and not city:IsHasBuilding(GameInfoTypes["BUILDING_MC_HEIAU_ARTIST"] and not city:IsHasBuilding(GameInfoTypes["BUILDING_MC_HEIAU_MUSICIAN"]) and not city:IsHasBuilding(GameInfoTypes["BUILDING_MC_HEIAU_WRITER"]) and not city:IsHasBuilding(GameInfoTypes["BUILDING_MC_HEIAU_SCIENTIST"]))then
					local random = GetRandom(1, 14)
					local specialistType
					if random <= 4 then specialistType = "BUILDING_MC_HEIAU_MERCHANT"
					elseif random <= 7 then specialistType = "BUILDING_MC_HEIAU_ENGINEER"
					elseif random <= 9 then specialistType = "BUILDING_MC_HEIAU_ARTIST"
					elseif random <= 11 then specialistType = "BUILDING_MC_HEIAU_MUSICIAN"
					elseif random <= 13 then specialistType = "BUILDING_MC_HEIAU_WRITER"
					elseif random <= 14 then specialistType = "BUILDING_MC_HEIAU_SCIENTIST"
					end

					city:SetNumRealBuilding(GameInfoTypes[specialistType], 1)
					city:SetNumRealBuilding(GameInfoTypes["BUILDING_MC_HAWAIIAN_HEIAU"], 0)
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(JFD_Heiau)

function SpecificCityInfoDirty_Heiau(iPlayer, iCity, iUpdateType)

	if iUpdateType ~= CityUpdateTypes.CITY_UPDATE_TYPE_PRODUCTION then return end

	local iPlayer = Game.GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if not(pPlayer:IsTurnActive()) then	return end

	local pCity = pPlayer:GetCityByID(iCity)
	if pCity:IsHasBuilding(GameInfoTypes["BUILDING_MC_HAWAIIAN_HEIAU"]) then
		if not pCity:IsHasBuilding(GameInfoTypes["BUILDING_MC_HEIAU_MERCHANT"]) and not pCity:IsHasBuilding(GameInfoTypes["BUILDING_MC_HEIAU_ENGINEER"]) and not pCity:IsHasBuilding(GameInfoTypes["BUILDING_MC_HEIAU_ARTIST"] and not pCity:IsHasBuilding(GameInfoTypes["BUILDING_MC_HEIAU_MUSICIAN"]) and not pCity:IsHasBuilding(GameInfoTypes["BUILDING_MC_HEIAU_WRITER"]) and not pCity:IsHasBuilding(GameInfoTypes["BUILDING_MC_HEIAU_SCIENTIST"]))then
			local random = GetRandom(1, 14)
			local specialistType
			if random <= 4 then specialistType = "BUILDING_MC_HEIAU_MERCHANT"
			elseif random <= 7 then specialistType = "BUILDING_MC_HEIAU_ENGINEER"
			elseif random <= 9 then specialistType = "BUILDING_MC_HEIAU_ARTIST"
			elseif random <= 11 then specialistType = "BUILDING_MC_HEIAU_MUSICIAN"
			elseif random <= 13 then specialistType = "BUILDING_MC_HEIAU_WRITER"
			elseif random <= 14 then specialistType = "BUILDING_MC_HEIAU_SCIENTIST"
			end

			pCity:SetNumRealBuilding(GameInfoTypes[specialistType], 1)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_MC_HAWAIIAN_HEIAU"], 0)
			
		end
	end
end
Events.SpecificCityInfoDirty.Add(SpecificCityInfoDirty_Heiau)