-- JFD_SwedenNorway_Functions
-- Author: JFD
-- DateCreated: 4/13/2014 4:19:30 PM
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
local civilisationID  = GameInfoTypes["CIVILIZATION_JFD_SWEDEN_NORWAY"]
local isCivActive	  = JFD_IsCivilisationActive(civilisationID)
local mathMin 		  = math.min

if isCivActive then
	print("King Oscar II is in this game")
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_RoyalAcademyConstruction
----------------------------------------------------------------------------------------------------------------------------
local buildingRoyalAcademy		 = GameInfoTypes["BUILDING_JFD_ROYAL_ACADEMY"]
local buildingRoyalAcademyArtist = GameInfoTypes["BUILDING_JFD_ROYAL_ACADEMY_ARTIST"]
local buildingRoyalAcademyWriter = GameInfoTypes["BUILDING_JFD_ROYAL_ACADEMY_WRITER"]

function JFD_RoyalAcademyConstruction(playerID, cityID, buildingID)
	local player = Players[playerID]
	if (player:IsAlive() and player:GetCivilizationType() == civilisationID) then
		if buildingID == buildingRoyalAcademy then
			local city = player:GetCityByID(cityID)
			city:SetNumRealBuilding(buildingRoyalAcademyArtist, 1)
			city:SetNumRealBuilding(buildingRoyalAcademyWriter, 1)
		end
	end
end

function JFD_RoyalAcademySale(playerID, cityID, buildingID)
	local player = Players[playerID]
	if (player:IsAlive() and player:GetCivilizationType() == civilisationID) then
		if buildingID == buildingRoyalAcademy then
			local city = player:GetCityByID(cityID)
			city:SetNumRealBuilding(buildingRoyalAcademyArtist, 0)
			city:SetNumRealBuilding(buildingRoyalAcademyWriter, 0)
		end
	end
end

if isCivActive then
	GameEvents.CityConstructed.Add(JFD_RoyalAcademyConstruction)
	GameEvents.CitySoldBuilding.Add(JFD_RoyalAcademySale)
end

--==========================================================================================================================
--==========================================================================================================================