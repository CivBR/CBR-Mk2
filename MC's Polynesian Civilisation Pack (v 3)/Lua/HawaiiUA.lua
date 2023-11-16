-- Hawaii_UA
-- Author: Sukritact
--=======================================================================================================================

print("Loaded")

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
-- GetRandom
-------------------------------------------------------------------------------------------------------------------------
function GetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end
--=======================================================================================================================
-- Hawaii UA: Kahuna Mastery
--=======================================================================================================================
-- Kahuna Mastery: Main Code
-------------------------------------------------------------------------------------------------------------------------
local tSpecialists = {
	GameInfoTypes.SPECIALIST_ARTIST,
	GameInfoTypes.SPECIALIST_ENGINEER,
	GameInfoTypes.SPECIALIST_MERCHANT,
	GameInfoTypes.SPECIALIST_MUSICIAN,
	GameInfoTypes.SPECIALIST_SCIENTIST,
	GameInfoTypes.SPECIALIST_WRITER,	
}

local iMod = 50
local iCiv = GameInfoTypes.CIVILIZATION_POLYNESIA

function GetTargetCity(pPlayer, iType)
	local pTargetCity = pPlayer:GetCapitalCity()
	if not(pTargetCity) then return end
	local iProgress = pTargetCity:GetSpecialistGreatPersonProgress(iType)
	
	iGuild = nil
	if iType == GameInfoTypes.SPECIALIST_WRITER then
		iGuild = GameInfoTypes.BUILDING_WRITERS_GUILD
	elseif iType == GameInfoTypes.SPECIALIST_ARTIST then
		iGuild = GameInfoTypes.BUILDING_ARTISTS_GUILD
	elseif iType == GameInfoTypes.SPECIALIST_MUSICIAN then
		iGuild = GameInfoTypes.BUILDING_MUSICIANS_GUILD
	end

	for pCity in pPlayer:Cities() do
		--if Guilded GP, identify city with Guild
		if iGuild then
			if pCity:IsHasBuilding(iGuild) then
				pTargetCity = pCity
			end
		-- Else find city with greatest progress
		else
			if iProgress < pCity:GetSpecialistGreatPersonProgress(iType) then
				iProgress = pCity:GetSpecialistGreatPersonProgress(iType)
				pTargetCity = pCity
			end
		end
	end
	
	return pTargetCity
end

function HawaiiUA(iPlayer, iKilled, iUnitType)
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() ~= iCiv) then return end
	
	local iType = tSpecialists[GetRandom(1, #tSpecialists)]
	local pCity = GetTargetCity(pPlayer, iType)
	
	if not(pCity) then return end
	
	local iStrength = GameInfo.Units[iUnitType].Combat
	local iDelta = math.ceil(iStrength * iMod)
	
	pCity:ChangeSpecialistGreatPersonProgressTimes100(iType, iDelta)
	--print("Gained " .. iDelta/100 .. " Great " .. Locale.ConvertTextKey(GameInfo.Specialists[iType].Description) .. " Points in " .. pCity:GetName() .. " from killing a " .. Locale.ConvertTextKey(GameInfo.Units[iUnitType].Description)) 
end

if JFD_IsCivilisationActive(iCiv) then
	GameEvents.UnitKilledInCombat.Add(HawaiiUA)
end
--=======================================================================================================================
--=======================================================================================================================