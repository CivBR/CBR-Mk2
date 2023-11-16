-- JFD_SwedenNorway_Events
-- Author: JFD
--=======================================================================================================================
print("JFD's Sweden-Norway Events: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- JFD_GetRandom
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_IsUsingExCE
--------------------------------------------------------------------------------------------------------------------------
function JFD_IsUsingExCE()
	local eXCEModID = "6676902b-b907-45f1-8db5-32dcb2135eee"
	local isUsingExCE = false
	
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == eXCEModID) then
			isUsingExCE = true
			break
		end
	end

	return isUsingExCE
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_IsUsingPrestige
--------------------------------------------------------------------------------------------------------------------------
function JFD_IsUsingPrestige()
	local prestigeModID = "d99bf7aa-51ac-4bef-bd88-d765b28e260e"
	local isUsingPrestige = false
	
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == prestigeModID) then
			isUsingPrestige = true
			break
		end
	end

	return isUsingPrestige
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_SendWorldEvent
------------------------------------------------------------------------------------------------------------------------
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
--=======================================================================================================================
-- Civ Specific Events
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilisationID 	= GameInfoTypes["CIVILIZATION_JFD_SWEDEN_NORWAY"]
local isUsingExCE		= JFD_IsUsingExCE()
local isUsingPrestige	= JFD_IsUsingPrestige()
local mathCeil 			= math.ceil
--------------------------------------------------------------------------------------------------------------------------
-- Sweden-Norway: Prize-winning Poetry
--------------------------------------------------------------------------------------------------------------------------
local buildingAkademinID = GameInfoTypes["BUILDING_JFD_AKADEMIN"]

local Event_JFDSwedenNorwayPrizeWinningPoetry = {}
	Event_JFDSwedenNorwayPrizeWinningPoetry.Name = "TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_PRIZE_WINNING_POETRY"
	Event_JFDSwedenNorwayPrizeWinningPoetry.Desc = "TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_PRIZE_WINNING_POETRY_DESC"
	Event_JFDSwedenNorwayPrizeWinningPoetry.Weight = 10
	Event_JFDSwedenNorwayPrizeWinningPoetry.CanFunc = (
		function(player)			
			if player:GetCivilizationType() ~= civilisationID 					then return false end
			if (not player:GetCapitalCity())									then return false end
			if (not player:GetCapitalCity():IsHasBuilding(buildingAkademinID))	then return false end
			
			Event_JFDSwedenNorwayPrizeWinningPoetry.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_PRIZE_WINNING_POETRY_DESC", player:GetCapitalCity():GetName())
			return true
		end
		)
	Event_JFDSwedenNorwayPrizeWinningPoetry.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFDSwedenNorwayPrizeWinningPoetry.Outcomes[1] = {}
	Event_JFDSwedenNorwayPrizeWinningPoetry.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_PRIZE_WINNING_POETRY_OUTCOME_1"
	Event_JFDSwedenNorwayPrizeWinningPoetry.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_PRIZE_WINNING_POETRY_OUTCOME_RESULT_1"
	Event_JFDSwedenNorwayPrizeWinningPoetry.Outcomes[1].Weight = 5
	Event_JFDSwedenNorwayPrizeWinningPoetry.Outcomes[1].CanFunc = (
		function(player)			
			local yieldReward = mathCeil(150 * iMod)
			local yieldRewardType = "[ICON_GOLD] Gold"
			if isUsingPrestige then
				yieldReward = mathCeil(50 * iMod)
				yieldRewardType = "[ICON_JFD_PRESTIGE] Prestige"
			end
			Event_JFDSwedenNorwayPrizeWinningPoetry.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_PRIZE_WINNING_POETRY_OUTCOME_RESULT_1", yieldReward, yieldRewardType)
			return true
		end
		)
	Event_JFDSwedenNorwayPrizeWinningPoetry.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local yieldReward = mathCeil(150 * iMod)
			if isUsingPrestige then
				yieldReward = mathCeil(50 * iMod)
				JFD_ChangePrestige(playerID, yieldReward)
			else
				player:ChangeGold(yieldReward)
			end
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_PRIZE_WINNING_POETRY_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_PRIZE_WINNING_POETRY"))
		end)

Events_AddCivilisationSpecific(civilisationID, "Event_JFDSwedenNorwayPrizeWinningPoetry", Event_JFDSwedenNorwayPrizeWinningPoetry)
--------------------------------------------------------------------------------------------------------------------------
--  Sweden-Norway: Arctic Expedition
--------------------------------------------------------------------------------------------------------------------------
local eraIndustrialID 	   	 = GameInfoTypes["ERA_INDUSTRIAL"]
local eraRenaissanceID 	   	 = GameInfoTypes["ERA_RENAISSANCE"]
local unitGreatAdventurerID  = GameInfoTypes["UNIT_JFD_GREAT_ADVENTURER"]
local unitGreatAdmiralID     = GameInfoTypes["UNIT_GREAT_ADMIRAL"]
local unitGreatExplorerID    = GameInfoTypes["UNIT_JFD_GREAT_EXPLORER"]

local Event_JFDSwedenNorwayArcticExpedition = {}
	Event_JFDSwedenNorwayArcticExpedition.Name = "TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPEDITION"
	Event_JFDSwedenNorwayArcticExpedition.Desc = "TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPEDITION_DESC"
	Event_JFDSwedenNorwayArcticExpedition.Weight = 10
	Event_JFDSwedenNorwayArcticExpedition.CanFunc = (
		function(player)			
			if player:GetCivilizationType() ~= civilisationID 	then return false end
			if player:GetCurrentEra() < eraRenaissanceID 		then return false end
			
			local goldCost = mathCeil(300 * iMod)
			if player:GetGold() < goldCost then return false end
			return true
		end
		)
	Event_JFDSwedenNorwayArcticExpedition.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFDSwedenNorwayArcticExpedition.Outcomes[1] = {}
	Event_JFDSwedenNorwayArcticExpedition.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPEDITION_OUTCOME_1"
	Event_JFDSwedenNorwayArcticExpedition.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPEDITION_OUTCOME_RESULT_1"
	Event_JFDSwedenNorwayArcticExpedition.Outcomes[1].Weight = 5
	Event_JFDSwedenNorwayArcticExpedition.Outcomes[1].CanFunc = (
		function(player)			
			local goldCost = mathCeil(300 * iMod)
			local unitReward = "Great Admiral"
			if isUsingExCE then
				goldCost = mathCeil(400 * iMod)
				unitReward = "Great Explorer"
				if player:GetCurrentEra() >= eraIndustrialID then
					goldCost = mathCeil(600 * iMod)
					unitReward = "Great Adventurer"
				end
			end
			if player:GetGold() < goldCost then return false end
			Event_JFDSwedenNorwayArcticExpedition.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPEDITION_OUTCOME_RESULT_1", goldCost, unitReward)
			return true
		end
		)
	Event_JFDSwedenNorwayArcticExpedition.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local goldCost = mathCeil(300 * iMod)
			local unitID = unitGreatAdmiralID
			if isUsingExCE then
				goldCost = mathCeil(400 * iMod)
				unitID = unitGreatExplorerID
				if player:GetCurrentEra() >= eraIndustrialID then
					goldCost = mathCeil(600 * iMod)
					unitID = unitGreatAdventurerID
				end
			end
			player:ChangeGold(-goldCost)
			player:InitUnit(unitID, player:GetCapitalCity():GetX(), player:GetCapitalCity():GetY()):JumpToNearestValidPlot()
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPEDITION_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPEDITION"))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPLORATION"))
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFDSwedenNorwayArcticExpedition.Outcomes[2] = {}
	Event_JFDSwedenNorwayArcticExpedition.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPEDITION_OUTCOME_2"
	Event_JFDSwedenNorwayArcticExpedition.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPEDITION_OUTCOME_RESULT_2"
	Event_JFDSwedenNorwayArcticExpedition.Outcomes[2].Weight = 2
	Event_JFDSwedenNorwayArcticExpedition.Outcomes[2].CanFunc = (
		function(player)			
			Event_JFDSwedenNorwayArcticExpedition.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPEDITION_OUTCOME_RESULT_2")
			return true
		end
		)
	Event_JFDSwedenNorwayArcticExpedition.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPLORATION_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_NORWAY_ARCTIC_EXPEDITION"))
		end)	
Events_AddCivilisationSpecific(civilisationID, "Event_JFDSwedenNorwayArcticExpedition", Event_JFDSwedenNorwayArcticExpedition)	
--=======================================================================================================================
--=======================================================================================================================


