-- Tibet_UA
-- Author: Sukritact
--=======================================================================================================================

print("loaded")
include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "Tibet_UA";
include("PlotIterators.lua")

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
-- JFD_GetStateReligion
------------------------------------------------------------------------------------------------------------------------
function JFD_GetStateReligion(playerID)
	local JFD_StateReligion = "JFD_StateReligionOf" .. playerID
	return GetPersistentProperty(JFD_StateReligion)
end	
-------------------------------------------------------------------------------------------------------------------------
-- SetPlotYield
-------------------------------------------------------------------------------------------------------------------------
function SetPlotYield(pPlot, iYield, iDelta)
	iOldDelta = load(pPlot, iYield)
	if iOldDelta == nil then
		Game.SetPlotExtraYield(pPlot:GetX(), pPlot:GetY(), iYield, iDelta)
	else
		Game.SetPlotExtraYield(pPlot:GetX(), pPlot:GetY(), iYield, iDelta - iOldDelta)
	end
	
	save(pPlot, iYield, iDelta)
end
-------------------------------------------------------------------------------------------------------------------------
-- GetReligion
-------------------------------------------------------------------------------------------------------------------------
function GetReligion(pPlayer)
	local iMajorityReligion = nil
	
	local iReligion = JFD_GetStateReligion(pPlayer:GetID())
	if iReligion and (iReligion ~= -1) then return iReligion end
	
	local iReligion = pPlayer:GetReligionCreatedByPlayer()
	if iReligion and (iReligion ~= -1) then return iReligion end
	
	for row in GameInfo.Religions() do
		local iReligion = row.ID
		if pPlayer:HasReligionInMostCities(iReligion) then
			iMajorityReligion = iReligion
			break
		end
	end
	
	return iMajorityReligion
end
-------------------------------------------------------------------------------------------------------------------------
-- GetNearestCity
-------------------------------------------------------------------------------------------------------------------------
function GetNearestCity(pPlot, pPlayer)

	local iX = pPlot:GetX()
	local iY = pPlot:GetY()
	
	local iDistance = 999999
	local pNearestCity = nil
	for pCity in pPlayer:Cities() do
		if iDistance > Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY()) then
		pNearestCity = pCity
		iDistance = Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY())
		end
	end
	
	return pNearestCity
end
--=======================================================================================================================
-- Initial Defines
--=======================================================================================================================
local iMaxMajor = (GameDefines.MAX_MAJOR_CIVS - 1)
local iMinMinor = iMaxMajor + 1

local tMountains = {}
local tIsValidMountain = {}

for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)
	if pPlot:IsMountain() then
		table.insert(tMountains, pPlot)
		tIsValidMountain[pPlot] = true
	end
end

local iFood			=	GameInfoTypes.YIELD_FOOD
local iFaith		=	GameInfoTypes.YIELD_FAITH
-- local iCulture		=	GameInfoTypes.YIELD_CULTURE
-- local iProduction	=	GameInfoTypes.YIELD_PRODUCTION
local iGold			=	GameInfoTypes.YIELD_GOLD
-- local iScience		=	GameInfoTypes.YIELD_SCIENCE

local iPressure		=	GameInfoTypes.BUILDING_MC_TIBET_RELIGIOUS_PRESSURE

local tReligion = {}
for iPlayer = 0, iMaxMajor do
	local pPlayer = Players[iPlayer]
	if	(pPlayer:IsEverAlive()) and (pPlayer:GetCivilizationType() == iCiv) then
		tReligion[iPlayer] = GetReligion(pPlayer)
	end
end

local tCities = {}
for iPlayer = 0, iMaxMajor do
	local pPlayer = Players[iPlayer]
	if	(pPlayer:IsEverAlive()) and (pPlayer:GetCivilizationType() == iCiv) then
		tCities[iPlayer] = {}
		for pCity in pPlayer:Cities() do
			tCities[iPlayer][pCity:GetID()] = (tReligion[iPlayer] and (tReligion[iPlayer] == pCity:GetReligiousMajority()))
		end
	end
end
--=======================================================================================================================
-- Core Functions: Dharma Kings
--=======================================================================================================================
-- Dharma Kings: Religion Tracking
-------------------------------------------------------------------------------------------------------------------------
function ReligionTrack(iPlayer)
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() == iCiv) then
		tReligion[iPlayer] = GetReligion(pPlayer)
	end
	
	CityMonitor(iPlayer, pPlayer)
	ReligiousPressure(iPlayer, pPlayer)
	
	MountainMonitor()
end

GameEvents.CityConvertsReligion.Add(ReligionTrack)
--GameEvents.PlayerDoTurn.Add(ReligionTrack)
GameEvents.PlayerCityFounded.Add(ReligionTrack)
LuaEvents.JFD_SetStateReligion.Add(ReligionTrack)
LuaEvents.DecisionEnacted.Add(
	function(iPlayer, sDecision)
		if sDecision == "Decisions_TibetanPotala" then
			ReligionTrack(iPlayer)
		end
	end
)
GameEvents.CityCaptureComplete.Add(
	function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
		ReligionTrack(iOldOwner)
		ReligionTrack(iNewOwner)
	end
)
-------------------------------------------------------------------------------------------------------------------------
-- Dharma Kings: City Monitor
-------------------------------------------------------------------------------------------------------------------------
function CityMonitor(iPlayer, pPlayer)
	if not(pPlayer:GetCivilizationType() == iCiv) then return end
	for pCity in pPlayer:Cities() do
		tCities[iPlayer][pCity:GetID()] = (tReligion[iPlayer] and (tReligion[iPlayer] == pCity:GetReligiousMajority()))
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Dharma Kings: +10% Religious Pressure
-------------------------------------------------------------------------------------------------------------------------
function ReligiousPressure(iPlayer, pPlayer)
	if not(pPlayer:GetCivilizationType() == iCiv) then return end
	for pCity in pPlayer:Cities() do
		if tCities[iPlayer][pCity:GetID()] then
			pCity:SetNumRealBuilding(iPressure, 1)
		else
			pCity:SetNumRealBuilding(iPressure, 0)
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Dharma Kings: Mountain Check
-------------------------------------------------------------------------------------------------------------------------
function MountainCheck(pPlot)
	local iPlayer = pPlot:GetOwner()
	local pPlayer = Players[iPlayer]
	
	if (iPlayer > -1) and (iPlayer < iMinMinor) then
		------------------------
		-- Non-Tibetans
		------------------------
		if not(pPlayer:GetCivilizationType() == iCiv) then
			SetPlotYield(pPlot, iFood, 	0)
			SetPlotYield(pPlot, iFaith, 0)
		------------------------
		-- Tibetans
		------------------------
		else
			if pPlayer:HasPolicy(GameInfoTypes.POLICY_DECISIONS_TIBETANPOTALA) then
				SetPlotYield(pPlot, iGold, 	2)
			else
				SetPlotYield(pPlot, iGold, 	0)
			end
			
			local pCity = pPlot:GetWorkingCity()
			if not(pCity) then
				pCity = GetNearestCity(pPlot, pPlayer)
			end
			------------------------
			-- Set Yields
			------------------------
			if tCities[iPlayer][pCity:GetID()] then
				SetPlotYield(pPlot, iFood, 	2)
				SetPlotYield(pPlot, iFaith, 2)
			else
				SetPlotYield(pPlot, iFood, 	1)
				SetPlotYield(pPlot, iFaith, 1)
			end
			------------------------
			------------------------
		end
	else
		SetPlotYield(pPlot, iFood, 	0)
		SetPlotYield(pPlot, iFaith, 0)
	end
end

Events.SerialEventHexCultureChanged.Add(
	function(iX, iY)
		local pPlot = Map.GetPlot(ToGridFromHex(iX, iY))
		if tIsValidMountain[pPlot] then
			MountainCheck(pPlot)
		end
	end
)
-------------------------------------------------------------------------------------------------------------------------
-- Dharma Kings: Mountain Monitor
-------------------------------------------------------------------------------------------------------------------------
function MountainMonitor()
	for iKey, pPlot in ipairs(tMountains) do
		MountainCheck(pPlot)
	end
end
--=======================================================================================================================
--=======================================================================================================================