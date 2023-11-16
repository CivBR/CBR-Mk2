-- TibetChorten
-- Author: Sukritact
--=======================================================================================================================

print("loaded")
include("IconSupport")
include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "TibetChorten";

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
-- JFD_SendNotification
------------------------------------------------------------------------------------------------------------------------
function JFD_SendNotification(playerID, notificationType, description, descriptionShort, global, iX, iY)
	local player = Players[playerID]
	if global then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
	else
		if player:IsHuman() then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_GetStateReligion
------------------------------------------------------------------------------------------------------------------------
function JFD_GetStateReligion(playerID)
	local JFD_StateReligion = "JFD_StateReligionOf" .. playerID
	return GetPersistentProperty(JFD_StateReligion)
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
--=======================================================================================================================
-- Initial Defines
--=======================================================================================================================
bCityScreenOpen = false
g_ChortenTipControls = {}
TTManager:GetTypeControlTable("ChortenTooltip", g_ChortenTipControls)

local iBaseChorten = GameInfoTypes.BUILDING_MC_TIBET_CHORTEN
local iClassChorten = GameInfoTypes[GameInfo.Buildings[iBaseChorten].BuildingClass]

local sSection = "----------------"

local tChorten = {
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_0] = GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_1,
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_1] = GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_2,
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_2] = GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_3,
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_3] = GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_4,
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_4] = GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_5,
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_5] = GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_6,
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_6] = GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_7,
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_7] = false,
	}

local iMod = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GreatPeoplePercent)/100)
	
local tChortenThreshold = {
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_0] = math.ceil(iMod * 75),
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_1] = math.ceil(iMod * 150),
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_2] = math.ceil(iMod * 200),
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_3] = math.ceil(iMod * 300),
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_4] = math.ceil(iMod * 400),
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_5] = math.ceil(iMod * 500),
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_6] = math.ceil(iMod * 600),
	}
	
local tChortenMonk = {
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_0] = 'TXT_KEY_BUILDING_MC_TIBET_CHORTEN_MONK',
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_1] = 'TXT_KEY_BUILDING_MC_TIBET_CHORTEN_MONK',
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_2] = 'TXT_KEY_BUILDING_MC_TIBET_CHORTEN_MONK',
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_3] = 'TXT_KEY_BUILDING_MC_TIBET_CHORTEN_LAMA',
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_4] = 'TXT_KEY_BUILDING_MC_TIBET_CHORTEN_LAMA',
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_5] = 'TXT_KEY_BUILDING_MC_TIBET_CHORTEN_LAMA',
	[GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_6] = 'TXT_KEY_BUILDING_MC_TIBET_CHORTEN_DALAI_LAMA',
	}
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "MC_TibetChorten", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(sKey, pInstance)
	if sKey ~= "MC_TibetChorten" then return end
	ProcessCityScreen(pInstance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)
--=======================================================================================================================
-- Core Functions: Tibetan Chorten
--=======================================================================================================================
-- ReturnChorten
-------------------------------------------------------------------------------------------------------------------------
function ReturnChorten(pCity)
	local iCityChorten = nil
	for iChorten, iNextChorten in pairs(tChorten) do
		if pCity:GetNumRealBuilding(iChorten) > 0 then
			iCityChorten = iChorten
			break
		end
	end
	return iCityChorten
end
-------------------------------------------------------------------------------------------------------------------------
-- GetNumWorkedMountains
-------------------------------------------------------------------------------------------------------------------------
function GetNumWorkedMountains(pCity)

	local iNumMountains = 0

	for iPlot = 0, pCity:GetNumCityPlots() - 1, 1 do
		local pAdjacentPlot = pCity:GetCityIndexPlot(iPlot)
		if (pAdjacentPlot:IsMountain()) and (pAdjacentPlot:IsBeingWorked()) then
			iNumMountains = iNumMountains + 1
		end
	end
	
	return iNumMountains
end
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
function ProcessCityScreen(pInstance)

	-- Ensure City Selected
	local pCity = UI.GetHeadSelectedCity()
	if not(pCity) then
		pInstance.IconFrame:SetHide(true)
		return
	end
	
	-- Ensure City has Chorten
	local iChorten = ReturnChorten(pCity)
	if not(iChorten) then
		pInstance.IconFrame:SetHide(true)
		return
	end
	
	local tCurrentChorten = GameInfo.Buildings[iChorten]
	
	--Ensure Chorten upgradable
	local iNextChorten = tChorten[iChorten]
	if not(iNextChorten) then
		pInstance.IconFrame:SetToolTipType()
		pInstance.IconFrame:LocalizeAndSetToolTip("TXT_KEY_BUILDING_MC_TIBET_CHORTEN_NO_UPGRADE", tCurrentChorten.Description)
		IconHookup(tCurrentChorten.PortraitIndex, 64, tCurrentChorten.IconAtlas, pInstance.IconImage)
		pInstance.IconFrame:SetHide(false)
		return
	end	
	
	pInstance.IconFrame:SetToolTipType("ChortenTooltip")
	
	local tNextChorten = GameInfo.Buildings[iNextChorten]
	
	IconHookup(tCurrentChorten.PortraitIndex, 64, tCurrentChorten.IconAtlas, pInstance.IconImage)
	IconHookup(tNextChorten.PortraitIndex, 64, tNextChorten.IconAtlas, g_ChortenTipControls.ChortenImage)
	
	local iCurrentProgress = load(Players[pCity:GetOwner()], pCity:GetID())
	if not(iCurrentProgress) then iCurrentProgress = 0 end
	local iThreshold = tChortenThreshold[iChorten]
	local iRemaining = iThreshold - iCurrentProgress
	
	local iFollowerPoints = 0
	local iReligion = GetReligion(Players[pCity:GetOwner()])
	if iReligion then
		iFollowerPoints = pCity:GetNumFollowers(iReligion)
	end
	
	local iMountainPoints = GetNumWorkedMountains(pCity) * 5
	local iGWPoints = pCity:GetNumGreatWorksInBuilding(iClassChorten) * 3
	local iPPT = iFollowerPoints + iMountainPoints + iGWPoints
	local iTurnsRemaining = math.ceil(iRemaining/iPPT)
	
	if iTurnsRemaining == math.huge then iTurnsRemaining = "???" end
	
	sYields = ""
	
	for tYield in GameInfo.Yields() do
		iDelta = Game.GetBuildingYieldChange(iNextChorten, tYield.ID)
		if iDelta > 0 then
			sYields = sYields .. " +" .. iDelta .. tYield.IconString .. ","
		end
	end
	
	local sHeading = "[COLOR_MAGENTA]" .. string.upper(Locale.ConvertTextKey(tNextChorten.Description) .. ":") .. "[ENDCOLOR]"
	local sSubheading = string.upper(Locale.ConvertTextKey("TXT_KEY_BUILDING_MC_TIBET_CHORTEN_SUBHEADING", iTurnsRemaining, iCurrentProgress, iThreshold))
	local sBody = 	(
					Locale.ConvertTextKey("TXT_KEY_BUILDING_MC_TIBET_CHORTEN_DATA", tNextChorten.Description, sYields, tCurrentChorten.Description) ..
					sSection .. "[NEWLINE]" ..
					Locale.ConvertTextKey("TXT_KEY_BUILDING_MC_TIBET_CHORTEN_POINTS_EXPLANATION") ..
					Locale.ConvertTextKey("TXT_KEY_BUILDING_MC_TIBET_CHORTEN_TOOLTIP", iFollowerPoints, iMountainPoints, iGWPoints) ..
					sSection ..
					Locale.ConvertTextKey("TXT_KEY_BUILDING_MC_TIBET_CHORTEN_SUMMARY", iPPT)
					)
					
	g_ChortenTipControls.ChortenMeter:SetPercent(iCurrentProgress/iThreshold)
	g_ChortenTipControls.Heading:SetText(sHeading)
	g_ChortenTipControls.Subheading:SetText(sSubheading)
	g_ChortenTipControls.Body:SetText(sBody)
	g_ChortenTipControls.Box:DoAutoSize()
	pInstance.IconFrame:SetHide(false)
end
-------------------------------------------------------------------------------------------------------------------------
-- ChortenBuilt
-------------------------------------------------------------------------------------------------------------------------
function ChortenBuilt(iPlayer, iCity, iUpdateType)

	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	
	local bHasChorten = pCity:IsHasBuilding(iBaseChorten)
	local iCurrentChorten = ReturnChorten(pCity)
	
	if bHasChorten and not(iCurrentChorten) then
		pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_MC_TIBET_CHORTEN_0, 1)
		save(pPlayer, iCity, 0)
	elseif not(bHasChorten) and iCurrentChorten then
		for iChorten, iNextChorten in pairs(tChorten) do
			pCity:SetNumRealBuilding(iChorten, 0)
		end
		save(pPlayer, iCity, nil)
	end
end
Events.SpecificCityInfoDirty.Add(ChortenBuilt)
-------------------------------------------------------------------------------------------------------------------------
-- ChortenProgress
-------------------------------------------------------------------------------------------------------------------------
function ChortenProgress(iPlayer)
	local pPlayer = Players[iPlayer]
	for pCity in pPlayer:Cities() do
	
		local iCurrentChorten = ReturnChorten(pCity)
		if iCurrentChorten then
			local iNextChorten = tChorten[iCurrentChorten]
			if iNextChorten then
			
				local iCurrentProgress = load(pPlayer, pCity:GetID())
				if not(iCurrentProgress) then iCurrentProgress = 0 end
			
				local iMountainPoints = GetNumWorkedMountains(pCity) * 5
				local iGWPoints = pCity:GetNumGreatWorksInBuilding(iClassChorten) * 3
				local iFollowerPoints = 0
				local iReligion = GetReligion(Players[pCity:GetOwner()])
				if iReligion then
					iFollowerPoints = pCity:GetNumFollowers(iReligion)
				end
				
				local iPPT = iFollowerPoints + iMountainPoints + iGWPoints
				local iNewProgress = iCurrentProgress + iPPT
				
				local iThreshold = tChortenThreshold[iCurrentChorten]
				print(pCity:GetName(), iNewProgress, iThreshold)
				
				if iNewProgress < iThreshold then
					save(pPlayer, pCity:GetID(), iNewProgress)
				else
					pCity:SetNumRealBuilding(iCurrentChorten, 0)
					pCity:SetNumRealBuilding(iNextChorten, 1)
					save(pPlayer, pCity:GetID(), 0)
					
					JFD_SendNotification(pCity:GetOwner(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_BUILDING_MC_TIBET_CHORTEN_NOTIFICATION", tChortenMonk[iCurrentChorten], GameInfo.Buildings[iNextChorten].Description, pCity:GetName()), Locale.ConvertTextKey("TXT_KEY_BUILDING_MC_TIBET_CHORTEN_NOTIFICATION_TITLE"))
				end
			end
		end
		
	end
end
GameEvents.PlayerDoTurn.Add(ChortenProgress)
--=======================================================================================================================
--=======================================================================================================================