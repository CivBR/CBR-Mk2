-- JFD_Sweden_Functions
-- Author: JFD
-- DateCreated: 4/13/2014 4:19:30 PM
--=======================================================================================================================
-- Includes
--=======================================================================================================================
include("PlotIterators.lua")
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
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
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID	= Game.GetActivePlayer()
local activePlayer		= Players[activePlayerID]
local civilisationID 	= GameInfoTypes["CIVILIZATION_SWEDEN"]
local isCivActive		= JFD_IsCivilisationActive(civilisationID)
local mathMin 			= math.min
local unitSwedishGreatGeneralID = GameInfoTypes["UNIT_JFD_SWEDISH_GREAT_GENERAL"]

if isCivActive then
	print("King Gustavus Adolphus is in this game")
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_BlockSwedishGreatGenerals
----------------------------------------------------------------------------------------------------------------------------
function JFD_BlockSwedishGreatGenerals(playerID, unitID)
	if unitID == unitSwedishGreatGeneralID then return false end
	return true
end
GameEvents.PlayerCanTrain.Add(JFD_BlockNaziGGs)
----------------------------------------------------------------------------------------------------------------------------
-- JFD_CreateSwedishGreatGenerals
----------------------------------------------------------------------------------------------------------------------------
local unitGreatGeneralID = GameInfoTypes["UNIT_GREAT_GENERAL"]

function JFD_CreateSwedishGreatGenerals(playerID, unitID)
    local player = Players[playerID]
    if (player:IsAlive() and player:GetCivilizationType() == civilisationID) then 
		local unit = player:GetUnitByID(unitID)
	   	if (unit and unit:GetUnitType() == unitGreatGeneralID) then 
			local newUnit = player:InitUnit(unitSwedishGreatGeneralID, unit:GetX(), unit:GetY())
			newUnit:Convert(unit)
		end
    end
end

if isCivActive then
	Events.SerialEventUnitCreated.Add(JFD_CreateSwedishGreatGenerals)
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SwedishGreatGeneralSiegeMovement
----------------------------------------------------------------------------------------------------------------------------
local unitCombatSiegeID	= GameInfoTypes["UNITCOMBAT_SIEGE"]

function JFD_SwedishGreatGeneralSiegeMovement(playerID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if (player:IsAlive() and player:GetCivilizationType() == civilisationID) then 
		for unit in player:Units() do
			local swedishGreatGeneralNearby = false
			if (unit and unit:GetUnitCombatType() == unitCombatSiegeID) then
				local unitPlot = unit:GetPlot()
				if unitPlot then
					for loopPlot in PlotAreaSpiralIterator(unitPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
						for adjacentUnitID = 0, loopPlot:GetNumUnits() - 1, 1 do
							local adjacentUnit = loopPlot:GetUnit(adjacentUnitID)
							if (adjacentUnit and adjacentUnit:GetOwner() == playerID) then
								if adjacentUnit:GetUnitType() == unitSwedishGreatGeneralID then
									swedishGreatGeneralNearby = true
									break
								end
							end
						end
					end
				end
				
				if swedishGreatGeneralNearby then
					unit:ChangeMoves(60)
				end
			end
		end
	end
end

if isCivActive then
	GameEvents.PlayerDoTurn.Add(JFD_SwedishGreatGeneralSiegeMovement)
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SwedishMeleeMountedBonus
----------------------------------------------------------------------------------------------------------------------------
local unitPromotionSpawnsGeneralsID	= GameInfoTypes["PROMOTION_SPAWN_GENERALS_II"]
local unitCombatGunID				= GameInfoTypes["UNITCOMBAT_GUN"]
local unitCombatMeleeID				= GameInfoTypes["UNITCOMBAT_MELEE"]
local unitCombatMountedID			= GameInfoTypes["UNITCOMBAT_MOUNTED"]

function JFD_SwedishMeleeMountedBonus(playerID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if (player:IsAlive() and player:GetCivilizationType() == civilisationID) then 
		for unit in player:Units() do
			local mountedUnitNearby = false
			if (unit and (unit:GetUnitCombatType() == unitCombatMeleeID or unit:GetUnitCombatType() == unitCombatGunID)) then
				local unitPlot = unit:GetPlot()
				for loopPlot in PlotAreaSpiralIterator(unitPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					print(loopPlot:GetX(), loopPlot:GetY())
					for adjacentUnitID = 0, loopPlot:GetNumUnits() - 1, 1 do
						local adjacentUnit = loopPlot:GetUnit(adjacentUnitID)
						print(adjacentUnit:GetName())
						if (adjacentUnit and adjacentUnit:GetUnitCombatType() == unitCombatMountedID and adjacentUnit:GetOwner() == playerID) then
							mountedUnitNearby = true
							break
						end
					end
				end
				
				if mountedUnitNearby then
					if (not unit:IsHasPromotion(unitPromotionSpawnsGeneralsID)) then
						unit:SetHasPromotion(unitPromotionSpawnsGeneralsID, true)
					end
				else
					if unit:IsHasPromotion(unitPromotionSpawnsGeneralsID) then
						unit:SetHasPromotion(unitPromotionSpawnsGeneralsID, false)
					end
				end
				
			end
		end
	end
end

if isCivActive then
	GameEvents.PlayerDoTurn.Add(JFD_SwedishMeleeMountedBonus)
end
--==========================================================================================================================
--==========================================================================================================================