-- JFD_SwedenKarlXIIDecisions
-- Author: JFD
--=======================================================================================================================
print("JFD's Sweden (Karl XII) Decisions: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- UTILITIES
-------------------------------------------------------------------------------------------------------------------------
-- JFD_SendWorldEvent
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
local civilizationSwedenKarlXIIID 	= GameInfoTypes["CIVILIZATION_SWEDEN"]
local techMilitaryScienceID			= GameInfoTypes["TECH_MILITARY_SCIENCE"]
local mathCeil 						= math.ceil
-------------------------------------------------------------------------------------------------------------------------
-- Sweden (Karl XII): Encourage Military Science
-------------------------------------------------------------------------------------------------------------------------
local policySwedenKarlEncourageMilitaryScienceID = GameInfoTypes["POLICY_DECISIONS_JFD_SWEDEN_MILITARY_SCIENCE"]
local Decisions_SwedenKarlEncourageMilitaryScience = {}
	Decisions_SwedenKarlEncourageMilitaryScience.Name = "TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_ENCOURAGE_MILITARY_SCIENCE"
	Decisions_SwedenKarlEncourageMilitaryScience.Desc = "TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_ENCOURAGE_MILITARY_SCIENCE_DESC"
	HookDecisionCivilizationIcon(Decisions_SwedenKarlEncourageMilitaryScience, "CIVILIZATION_SWEDEN")
	Decisions_SwedenKarlEncourageMilitaryScience.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationSwedenKarlXIIID then return false, false end
		if load(player, "Decisions_SwedenKarlEncourageMilitaryScience") == true then
			Decisions_SwedenKarlEncourageMilitaryScience.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SWEDEN_KARL_ENCOURAGE_MILITARY_SCIENCE_ENACTED_DESC")
			return false, false, true
		end
		local goldCost = mathCeil(900 * iMod)
		Decisions_SwedenKarlEncourageMilitaryScience.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_ENCOURAGE_MILITARY_SCIENCE_DESC", goldCost)
		if player:GetGold() < goldCost then	return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		if (not Teams[player:GetTeam()]:IsHasTech(techMilitaryScienceID)) then return true, false end
		return true, true
	end
	)
	
	Decisions_SwedenKarlEncourageMilitaryScience.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local goldCost = mathCeil(900 * iMod)
		player:ChangeGold(-goldCost)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policySwedenKarlEncourageMilitaryScienceID, true)
		save(player, "Decisions_SwedenKarlEncourageMilitaryScience", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationSwedenKarlXIIID, "Decisions_SwedenKarlEncourageMilitaryScience", Decisions_SwedenKarlEncourageMilitaryScience)
-------------------------------------------------------------------------------------------------------------------------
-- Sweden (Karl XII): Establish Octal System
-------------------------------------------------------------------------------------------------------------------------
local policySwedenKarlOctalSystemID = GameInfoTypes["POLICY_DECISION_JFD_SWEDEN_ESTABLISH_OCTAL_SYSTEM"]
local DecisionsSwedenKarlOctalSystem = {}
	DecisionsSwedenKarlOctalSystem.Name = "TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_ESTABLISH_OCTAL_SYSTEM"
	DecisionsSwedenKarlOctalSystem.Desc = "TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_ESTABLISH_OCTAL_SYSTEM_DESC"
	HookDecisionCivilizationIcon(DecisionsSwedenKarlOctalSystem, "CIVILIZATION_SWEDEN")
	DecisionsSwedenKarlOctalSystem.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationSwedenKarlXIIID then return false, false end
		if load(player, "DecisionsSwedenKarlOctalSystem") == true then
			DecisionsSwedenKarlOctalSystem.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_ESTABLISH_OCTAL_SYSTEM_ENACTED_DESC")
			return false, false, true
		end
		local scienceCost = mathCeil(400 * iMod)
		DecisionsSwedenKarlOctalSystem.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_ESTABLISH_OCTAL_SYSTEM_DESC", scienceCost)
		local currentResearchID = player:GetCurrentResearch()
		if currentResearchID <= -1 then return true, false end
		if (not Teams[player:GetTeam()]:IsHasTech(techMilitaryScienceID)) then return true, false end
		if player:GetResearchProgress(currentResearchID) < scienceCost then return false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		return true, true
	end
	)
	
	DecisionsSwedenKarlOctalSystem.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local scienceCost = mathCeil(400 * iMod)
		LuaEvents.Sukritact_ChangeResearchProgress(playerID, -scienceCost)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policySwedenKarlOctalSystemID, true)
		save(player, "DecisionsSwedenKarlOctalSystem", true)
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_JFD_WORLD_EVENTS_SWEDEN_KARL_ESTABLISH_OCTAL_SYSTEM"))
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationSwedenKarlXIIID, "DecisionsSwedenKarlOctalSystem", DecisionsSwedenKarlOctalSystem)
--=======================================================================================================================
--=======================================================================================================================
