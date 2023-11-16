-- Tibetan Mountain Start
-- Author: Sukritact
--=======================================================================================================================

print("loaded")
include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "TibetanMountainStart";
include("PlotIterators.lua")

--=======================================================================================================================
-- Run only at start
--=======================================================================================================================
if load("Game", "TibetanMountainStart") then return end
save("Game", "TibetanMountainStart", true)
--=======================================================================================================================
-- Utility Functions	
--=======================================================================================================================
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
local iCiv = GameInfoTypes.CIVILIZATION_MC_TIBET

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

if not(JFD_IsCivilisationActive(iCiv)) then return end
------------------------------------------------------------------------------------------------------------------------
-- MoveStartToPlot
------------------------------------------------------------------------------------------------------------------------
function MoveStartToPlot(pPlayer, pPlot)
	
	local iTeam = pPlayer:GetTeam()
	for pAdjacentPlot in PlotAreaSweepIterator(pPlayer:GetStartingPlot(), 5, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
		pAdjacentPlot:SetRevealed(iTeam, false)
	end
	
	pPlayer:SetStartingPlot(pPlot)
	
	local iSettler = GameInfoTypes.UNIT_SETTLER
	local tUnits = {}
	
	for pUnit in pPlayer:Units() do
		tUnits[pUnit] = pUnit:GetUnitType()
	end
	
	local iX = pPlot:GetX()
	local iY = pPlot:GetY()
	pPlayer:InitUnit(iSettler, iX, iY)
	bIsNewSettler = false
	for pUnit, iType in pairs(tUnits) do
		if bIsNewSettler or (iType ~= iSettler) then
			local pNewUnit = pPlayer:InitUnit(iType, iX, iY)
			pNewUnit:JumpToNearestValidPlot()
		else
			bIsNewSettler = true
		end
		pUnit:Kill()
	end
	tUnits = nil
end
--=======================================================================================================================
-- Initial Defines
--=======================================================================================================================
local tValidResources = {}
for tResource in GameInfo.Resources() do
	if (tResource.PlacementOrder > 0) or (tResource.Type == "RESOURCE_IRON") then --Yeah, it's weird, but Iron doesn't have a placement order
		local sType = tResource.ResourceClassType
		if sType == "RESOURCECLASS_LUXURY" then
			tValidResources[tResource.ID] = "Luxury"
		elseif (sType == "RESOURCECLASS_RUSH") or (sType == "RESOURCECLASS_MODERN") then
			tValidResources[tResource.ID] = "Strategic"
		else
			tValidResources[tResource.ID] = "Bonus"
		end
	end
end
--=======================================================================================================================
-- Core Functions: Tibetan Mountain Start
--=======================================================================================================================
-- EvaluateArea
-------------------------------------------------------------------------------------------------------------------------
function EvaluateArea(pPlot, bStartingPlot)
			
	local tLocation = {}
	
	if not(bStartingPlot) then
	
		tLocation.bNearOther = false
		for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 6, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
			local iNumUnits = pAdjacentPlot:GetNumUnits()
			for iVal = 0,(iNumUnits - 1) do
				local pUnit = pAdjacentPlot:GetUnit(iVal)
				if pUnit:GetOwner()  ~= -63 then
					tLocation.bNearOther = true
				end
			end		
		end
		if tLocation.bNearOther then return tLocation end
		
		tLocation.FirstRingResources = 0
		for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
			local iType = pAdjacentPlot:GetResourceType()
			if tValidResources[iType] == "Luxury" then
				tLocation.FirstRingResources = tLocation.FirstRingResources + 1
			end
		end	
		if tLocation.FirstRingResources < 2 then return tLocation end
		
	end
	
	tLocation.bRiver = pPlot:IsRiver()
	tLocation.bCoast = pPlot:IsCoastalLand()
	tLocation.bNaturalWonder = false
	tLocation.ResourceKey = {}
	tLocation.Resources = {
	["Luxury"] = {},
	["Strategic"] = {},
	["Bonus"] = {},
	}
	
	tLocation.NumMountains = 0
	tLocation.NumWater = 0
	tLocation.NumLand = 0

	for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
	
		if pAdjacentPlot:GetFeatureType() ~= -1 then
			if GameInfo.Features[pAdjacentPlot:GetFeatureType()].NaturalWonder then tLocation.bNaturalWonder = true end
		end
	
		if pAdjacentPlot:IsMountain() then tLocation.NumMountains = tLocation.NumMountains + 1
		elseif pAdjacentPlot:IsWater() then tLocation.NumWater = tLocation.NumWater + 1
		else
			tLocation.NumLand = tLocation.NumLand + 1
			
			local iType = pAdjacentPlot:GetResourceType()
			if (tValidResources[iType]) then
				if not(tLocation.ResourceKey[iType]) then
					table.insert(tLocation.Resources[tValidResources[iType]], pAdjacentPlot:GetNumResource())
					tLocation.ResourceKey[iType] = #tLocation.Resources[tValidResources[iType]]
				else
					local iKey = tLocation.ResourceKey[iType]
					tLocation.Resources[tValidResources[iType]][iKey] = tLocation.Resources[tValidResources[iType]][iKey] + pAdjacentPlot:GetNumResource()
				end
			end
			
		end
	end
	
	return tLocation
end
-------------------------------------------------------------------------------------------------------------------------
-- EvaluateDesirability
-------------------------------------------------------------------------------------------------------------------------
function EvaluateDesirability(tLocation)
	local iDesirability = 0
	
	if tLocation.bNaturalWonder then iDesirability = iDesirability + 8 end
	if tLocation.bRiver then iDesirability = iDesirability + 12 end
	if tLocation.bCoast then iDesirability = iDesirability + 8 end
	
	iDesirability = iDesirability + tLocation.NumMountains
	
	for iKey, iAmount in ipairs(tLocation.Resources.Luxury) do
		iDesirability = iDesirability + (iAmount * 4) + 4
	end
	for iKey, iAmount in ipairs(tLocation.Resources.Strategic) do
		iDesirability = iDesirability + iAmount
	end
	for iKey, iAmount in ipairs(tLocation.Resources.Bonus) do
		iDesirability = iDesirability + iAmount
	end
	
	if tLocation.NumMountains < 1 then iDesirability = 0 end
	
	return iDesirability
end
-------------------------------------------------------------------------------------------------------------------------
-- Find Civs that need relocation
-------------------------------------------------------------------------------------------------------------------------
local tToRelocate = {}
local bDoRelocate = false
local iMaxMajor = (GameDefines.MAX_MAJOR_CIVS - 1)

for iPlayer = 0, iMaxMajor do
	local pPlayer = Players[iPlayer]
	if	(pPlayer:IsEverAlive()) and (pPlayer:GetCivilizationType() == iCiv) and not(pPlayer:GetCapitalCity()) then
	
		local pPlot = pPlayer:GetStartingPlot()
		local bRelocate = true
	
		for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
			if pAdjacentPlot:IsMountain() then bRelocate = false end
		end
		
		if bRelocate then
			
			bDoRelocate = true
			
			tToRelocate[iPlayer] = EvaluateArea(pPlot, true)
			
			--[[
			tToRelocate[iPlayer].Units = {}
			for pUnit in pPlayer:Units() do
				table.insert(tToRelocate[iPlayer].Units , pUnit)
			end
			]]--
		end
	end
end

if not(bDoRelocate) then return end
-------------------------------------------------------------------------------------------------------------------------
-- Find valid starting locations
-------------------------------------------------------------------------------------------------------------------------
tLocations = {}

for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)
	if pPlot:IsMountain() then
		for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
			if not(pAdjacentPlot:IsMountain() or pAdjacentPlot:IsWater()) and (pAdjacentPlot:GetResourceType() == -1) then
				if pAdjacentPlot:GetFeatureType() ~= -1 then
					if not(GameInfo.Features[pAdjacentPlot:GetFeatureType()].NaturalWonder) then
						table.insert(tLocations, pAdjacentPlot)
					end
				else
					table.insert(tLocations, pAdjacentPlot)
				end
			end
		end	
	end
end

local tStartingLocations = {}
for iKey, pPlot in ipairs(tLocations) do
	local tLocation = EvaluateArea(pPlot)
	if not(tLocation.bNearOther) then
		if not(tLocation.FirstRingResources < 2) then
			if tLocation.NumLand > 12 then
				tStartingLocations[pPlot] = tLocation
			end
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Move where able
-------------------------------------------------------------------------------------------------------------------------
for iPlayer, tStart in pairs(tToRelocate) do

	local iDesirabilityA = EvaluateDesirability(tStart)
	local pPlayer = Players[iPlayer]
	
	local tStartsCache = {}
	for pPlot, tLocation in pairs(tStartingLocations) do
		tLocation.Plot = pPlot
		table.insert(tStartsCache, tLocation)
	end
	table.sort(tStartsCache, function(a,b) return EvaluateDesirability(a) > EvaluateDesirability(b) end)
	
	for iKey, tLocation in ipairs(tStartsCache) do
		local iDesirabilityB = EvaluateDesirability(tLocation)
		if not(iDesirabilityB < iDesirabilityA) then
			
			print("Moving Player " .. iPlayer)
			
			local pPlot = tLocation.Plot
			
			MoveStartToPlot(pPlayer, pPlot)
			
			for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 5, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				tStartingLocations[pAdjacentPlot] = nil
			end	
			
			break
		end
	end
end
--=======================================================================================================================
--=======================================================================================================================