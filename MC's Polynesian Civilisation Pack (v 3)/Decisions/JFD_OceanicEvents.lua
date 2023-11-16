-- JFD_OceanicEvents
-- Author: JFD
--=======================================================================================================================
-- Civ Specific Events
--=======================================================================================================================
-- Wayfinders
--------------------------------------------------------------------------------------------------------------------------
local Event_JFDOceanicWayfinders = {}
	Event_JFDOceanicWayfinders.Name = "TXT_KEY_EVENT_JFD_OCEANIC_WAYFINDERS"
	Event_JFDOceanicWayfinders.Desc = "TXT_KEY_EVENT_JFD_OCEANIC_WAYFINDERS_DESC"
	Event_JFDOceanicWayfinders.tValidCivs = 
		{
		["CIVILIZATION_POLYNESIA"]		= true,
		["CIVILIZATION_MC_TONGA"]		= true,
		["CIVILIZATION_MC_MAORI"]		= true,
		["CIVILIZATION_MC_RAPA_NUI"]	= true,
		}
	Event_JFDOceanicWayfinders.Weight = 10
	Event_JFDOceanicWayfinders.CanFunc = (
		function(pPlayer)			
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_JFDOceanicWayfinders.tValidCivs[sCivType]
		end
		)
	Event_JFDOceanicWayfinders.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFDOceanicWayfinders.Outcomes[1] = {}
	Event_JFDOceanicWayfinders.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_OCEANIC_WAYFINDERS_OUTCOME_1"
	Event_JFDOceanicWayfinders.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_OCEANIC_WAYFINDERS_OUTCOME_RESULT_1"
	Event_JFDOceanicWayfinders.Outcomes[1].CanFunc = (
		function(pPlayer)	
			Event_JFDOceanicWayfinders.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_OCEANIC_WAYFINDERS_OUTCOME_RESULT_1")
			return true
		end
		)
	Event_JFDOceanicWayfinders.Outcomes[1].DoFunc = (
		function(pPlayer) 
			pPlayer:InitUnit(GameInfoTypes["UNIT_JFD_SETTLER_OCEANIC"], pPlayer:GetCapitalCity():GetX(), pPlayer:GetCapitalCity():GetY())
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_OCEANIC_WAYFINDERS_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_OCEANIC_WAYFINDERS"))
		end)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_JFDOceanicWayfinders.tValidCivs[sCiv] then
			tEvents.Event_JFDOceanicWayfinders = Event_JFDOceanicWayfinders
			break
		end
	end
end
--=======================================================================================================================
--=======================================================================================================================


