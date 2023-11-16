-- Maori_UA
-- Author: Sukritact
--=======================================================================================================================

print("Loaded")
include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "Maori_UA";

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
-- InitUnitFromCity
-------------------------------------------------------------------------------------------------------------------------
function InitUnitFromCity(pCity, iUnitType, iNum)
	local tUnits = {}
	pPlayer = Players[pCity:GetOwner()]
	for i = 1, iNum do
		pUnit = pPlayer:InitUnit(iUnitType, pCity:GetX(), pCity:GetY())
		if not(pUnit:JumpToNearestValidPlot()) then return tUnits end
		
		table.insert(tUnits, pUnit)
		
		pUnit:SetExperience(pCity:GetDomainFreeExperience(pUnit:GetDomainType()))
		for promotion in GameInfo.UnitPromotions() do
			iPromotion = promotion.ID
				if (pCity:GetFreePromotionCount(iPromotion) > 0 and pUnit:IsPromotionValid(iPromotion)) then
				pUnit:SetHasPromotion(iPromotion, true)
			end
		end
		
	end
	return tUnits
end
-------------------------------------------------------------------------------------------------------------------------
-- GetRandom
-------------------------------------------------------------------------------------------------------------------------
function GetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end
--=======================================================================================================================
-- Maori UA: Mana of Tumatauenga
--=======================================================================================================================
-- Mana of Tumatauenga: Main Code
-------------------------------------------------------------------------------------------------------------------------
local iMod = 0.25
local iCiv = GameInfoTypes.CIVILIZATION_MC_MAORI

local tBarbUnits = {
	[GameInfoTypes.UNIT_BARBARIAN_WARRIOR] 	= GameInfoTypes.UNIT_WARRIOR,
	[GameInfoTypes.UNIT_BARBARIAN_ARCHER] 	= GameInfoTypes.UNIT_ARCHER,
	[GameInfoTypes.UNIT_BARBARIAN_SPEARMAN]	= GameInfoTypes.UNIT_SPEARMAN,
	[GameInfoTypes.UNIT_BARBARIAN_SWORDSMAN] = GameInfoTypes.UNIT_SWORDSMAN,
	[GameInfoTypes.UNIT_BARBARIAN_HORSEMAN]	= GameInfoTypes.UNIT_HORSEMAN,
}

local tStoredUnits = {}
for iPlayer, pPlayer in pairs(Players) do

	tStoredUnits[iPlayer] = {}
	
	for tUnit in GameInfo.Units() do
		local iStored = load(pPlayer, tUnit.ID)
		if iStored and iStored > 0 then
			tStoredUnits[iPlayer][tUnit.ID] = true
		end
	end
end

function UnitKilledInCombat_MaoriUA(iPlayer, iKilled, iUnitType)
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() ~= iCiv) then return end
	
	local pCity = pPlayer:GetCapitalCity()
	if not(pCity) then return end
	
	-- Certain Barbarian units must be converted to regular units
	if tBarbUnits[iUnitType] then iUnitType = tBarbUnits[iUnitType] end
	
	local tUnit = GameInfo.Units[iUnitType]
	
	-- Must be a Combat unit
	if tUnit.CombatLimit < 1 then return end
	
	-- Must be a unit that can be built
	local iCost = pCity:GetUnitProductionNeeded(iUnitType)
	if iCost < 1 then return end
	
	-- Define iDelta
	local iDelta = math.ceil(iMod * iCost)
	if iDelta < 1 then return end
	-- Check if it is not trainable by the player
	local bStore = pCity:CanTrain(iUnitType, 1)
	print(bStore)
	
	local sStr
	local sTitle = Locale.ConvertTextKey("TXT_KEY_TRAIT_MANA_OF_TUMATAUENGA_SHORT")
	
	-----------------------------------------
	-- For units you can train
	-----------------------------------------
	if bStore then	
		-- If you happen to have some production stored from before
		local iStored = load(pPlayer, iUnitType)
		if iStored and iStored > 0 then
			iDelta = iDelta + iStored
			tStoredUnits[iPlayer][iUnitType] = nil
			save(pPlayer, iUnitType, 0)
		end
	
		pCity:ChangeUnitProduction(iUnitType, iDelta)
		local iRemainder = (iCost - pCity:GetUnitProduction(iUnitType))
		if iRemainder < 1 then
			InitUnitFromCity(pCity, iUnitType, 1)
			pCity:SetUnitProduction(iUnitType, 0)
			sStr = Locale.ConvertTextKey("TXT_KEY_MAORI_UA_NOTIFICATION_2", Locale.ConvertTextKey(tUnit.Description))
		else
			sStr = Locale.ConvertTextKey("TXT_KEY_MAORI_UA_NOTIFICATION", Locale.ConvertTextKey(tUnit.Description), iDelta, iRemainder)
		end
	-----------------------------------------
	-- For units you can't train
	-----------------------------------------
	else
		tStoredUnits[iPlayer][iUnitType] = true
	
		local iStored = load(pPlayer, iUnitType)
		if not(iStored) then iStored = 0 end
		
		-- If you happen to have some production stored from before
		local iOldStored = pCity:GetUnitProduction(iUnitType)
		if iOldStored > 0 then iStored = iStored + iOldStored; pCity:SetUnitProduction(iUnitType, 0) end
		
		iStored = iDelta + iStored
		
		iRemainder = iCost - iStored
		if iRemainder < 1 then
			InitUnitFromCity(pCity, iUnitType, 1)
			save(pPlayer, iUnitType, 0)
			sStr = Locale.ConvertTextKey("TXT_KEY_MAORI_UA_NOTIFICATION_2", Locale.ConvertTextKey(tUnit.Description))
		else
			save(pPlayer, iUnitType, iStored)
			sStr = Locale.ConvertTextKey("TXT_KEY_MAORI_UA_NOTIFICATION", Locale.ConvertTextKey(tUnit.Description), iDelta, iRemainder)
		end
	end

	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER, sStr, sTitle, pCity:GetX(), pCity:GetY(), iUnitType)
end

function SpecificCityInfoDirty_MaoriUA(iPlayer, iCity, iUpdateType)

	if iUpdateType ~= CityUpdateTypes.CITY_UPDATE_TYPE_PRODUCTION then return end

	local iPlayer = Game.GetActivePlayer()
	local pPlayer = Players[iPlayer]

	if (pPlayer:GetCivilizationType() ~= iCiv) then return end
	if not(pPlayer:IsTurnActive()) then	return end

	local pCity = pPlayer:GetCityByID(iCity)
	
	if pCity:IsCapital() then
		for iUnitType, _ in pairs(tStoredUnits[iPlayer]) do
			if pCity:CanTrain(iUnitType, 1) then
				-- If you happen to have some production stored from before
				local iStored = load(pPlayer, iUnitType)
				if iStored and iStored > 0 then
					tStoredUnits[iPlayer][iUnitType] = nil
					save(pPlayer, iUnitType, 0)
				end
			
				pCity:ChangeUnitProduction(iUnitType, iStored)
				tStoredUnits[iPlayer][iUnitType] = nil
			end
		end
	end
	
end

if JFD_IsCivilisationActive(iCiv) then
	GameEvents.UnitKilledInCombat.Add(UnitKilledInCombat_MaoriUA)
	Events.SpecificCityInfoDirty.Add(SpecificCityInfoDirty_MaoriUA)
end
--=======================================================================================================================
--=======================================================================================================================