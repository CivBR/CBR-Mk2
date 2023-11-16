-- JFD_SwedenNorway_Decisions
-- Author: JFD
--=======================================================================================================================
print("JFD's Sweden-Norway Decisions: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- JFD_SendWorldEvent
--------------------------------------------------------------------------------------------------------------------------
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilisationID 	= GameInfoTypes["CIVILIZATION_JFD_SWEDEN_NORWAY"]
local eraRenaissanceID 	= GameInfoTypes["ERA_RENAISSANCE"]
local mathCeil 			= math.ceil
-------------------------------------------------------------------------------------------------------------------------
-- Sweden-Norway: Commission Self-Portrait
-------------------------------------------------------------------------------------------------------------------------
local greatWorkSlotArtID			= GameInfoTypes["GREAT_WORK_SLOT_ART_ARTIFACT"]
local unitAndersZornID				= GameInfoTypes["UNIT_DECISIONS_JFD_ANDERS_ZORN"]
local unitMissionCreateGreatWorkID	= GameInfoTypes["MISSION_CREATE_GREAT_WORK"]

local Decisions_SwedenNorwayCommissionSelfPortrait = {}
	Decisions_SwedenNorwayCommissionSelfPortrait.Name = "TXT_KEY_DECISIONS_JFD_SWEDEN_NORWAY_COMMISSION_SELFPORTRAIT"
	Decisions_SwedenNorwayCommissionSelfPortrait.Desc = "TXT_KEY_DECISIONS_JFD_SWEDEN_NORWAY_COMMISSION_SELFPORTRAIT_DESC"
	HookDecisionCivilizationIcon(Decisions_SwedenNorwayCommissionSelfPortrait, "CIVILIZATION_JFD_SWEDEN_NORWAY")
	Decisions_SwedenNorwayCommissionSelfPortrait.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilisationID then return false, false end
		if load(player, "Decisions_SwedenNorwayCommissionSelfPortrait") == true then
			Decisions_SwedenNorwayCommissionSelfPortrait.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_SWEDEN_NORWAY_COMMISSION_SELFPORTRAIT_ENACTED_DESC")
			return false, false, true
		end
		
		local goldCost = mathCeil(500 * iMod)
		Decisions_SwedenNorwayCommissionSelfPortrait.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_SWEDEN_NORWAY_COMMISSION_SELFPORTRAIT_DESC", goldCost)
		
		if (not player:HasAvailableGreatWorkSlot(greatWorkSlotArtID)) 	then return true, false end
		if player:GetGold() < goldCost 									then return true, false end
		if player:GetCurrentEra() < eraRenaissanceID 					then return true, false	end
		return true, true
	end
	)
	
	Decisions_SwedenNorwayCommissionSelfPortrait.DoFunc = (
	function(player)
		local goldCost = mathCeil(500 * iMod)
		player:ChangeGold(-goldCost)
		
		local capitalX = player:GetCapitalCity():GetX()
		local capitalY = player:GetCapitalCity():GetY()
		player:InitUnit(unitAndersZornID, capitalX, capitalY):PushMission(unitMissionCreateGreatWorkID)
		save(player, "Decisions_SwedenNorwayCommissionSelfPortrait", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilisationID, "Decisions_SwedenNorwayCommissionSelfPortrait", Decisions_SwedenNorwayCommissionSelfPortrait)
-------------------------------------------------------------------------------------------------------------------------
-- Sweden-Norway: Innovate Open-Air Museums
-------------------------------------------------------------------------------------------------------------------------
local policyOpenAirMuseumID = GameInfoTypes["POLICY_DECISIONS_JFD_INNOVATE_OPEN_AIR_MUSEUMS"]

local Decisions_SwedenNorwayInnovateOpenAirMuseums = {}
	Decisions_SwedenNorwayInnovateOpenAirMuseums.Name = "TXT_KEY_DECISIONS_JFD_SWEDEN_NORWAY_INNOVATE_OPEN_AIR_MUSEUMS"
	Decisions_SwedenNorwayInnovateOpenAirMuseums.Desc = "TXT_KEY_DECISIONS_JFD_SWEDEN_NORWAY_INNOVATE_OPEN_AIR_MUSEUMS_DESC"
	HookDecisionCivilizationIcon(Decisions_SwedenNorwayInnovateOpenAirMuseums, "CIVILIZATION_JFD_SWEDEN_NORWAY")
	Decisions_SwedenNorwayInnovateOpenAirMuseums.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilisationID then return false, false end
		if load(player, "Decisions_SwedenNorwayInnovateOpenAirMuseums") == true then
			Decisions_SwedenNorwayInnovateOpenAirMuseums.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_SWEDEN_NORWAY_INNOVATE_OPEN_AIR_MUSEUMS_ENACTED_DESC")
			return false, false, true
		end
		
		local goldCost = mathCeil(1200 * iMod)
		Decisions_SwedenNorwayInnovateOpenAirMuseums.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_SWEDEN_NORWAY_INNOVATE_OPEN_AIR_MUSEUMS_DESC", goldCost)
		
		if player:GetGold() < goldCost 									then return true, false end
		if player:GetCurrentEra() < eraRenaissanceID 					then return true, false	end
		return true, true
	end
	)
	
	Decisions_SwedenNorwayInnovateOpenAirMuseums.DoFunc = (
	function(player)
		local goldCost = mathCeil(1200 * iMod)
		player:ChangeGold(-goldCost)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policyOpenAirMuseumID, true)
		save(player, "Decisions_SwedenNorwayInnovateOpenAirMuseums", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilisationID, "Decisions_SwedenNorwayInnovateOpenAirMuseums", Decisions_SwedenNorwayInnovateOpenAirMuseums)
--=======================================================================================================================
--=======================================================================================================================
