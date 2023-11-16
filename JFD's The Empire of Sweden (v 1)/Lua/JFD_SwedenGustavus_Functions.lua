-- JFD_SwedenGustavus_Functions
-- Author: JFD
-- DateCreated: 6/14/2015 1:54:45 AM
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCommunityPatchDLLActive
function JFD_IsCommunityPatchDLLActive()
	local communityPatchDLLID = "d1b6328c-ff44-4b0d-aad7-c657f83610cd"
	local isUsingCPDLL = false
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == communityPatchDLLID) then
			isUsingCPDLL = true
			break
		end
	end
	return isUsingCPDLL
end
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local isUsingCPDLL = JFD_IsCommunityPatchDLLActive()
if (not isUsingCPDLL) then
	include("PlotIterators.lua")
end
--==========================================================================================================================
-- UU FUNCTIONS
--==========================================================================================================================
-- REGAL SHIP
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SwedenGustavusRegalShipHealing
local unitClassFrigateID  = GameInfoTypes["UNITCLASS_FRIGATE"]
local domainLandID		  = GameInfoTypes["DOMAIN_LAND"]
function JFD_SwedenGustavusRegalShipHealing(playerID)
	local player = Players[playerID]
	if (player:IsAlive() and (not player:IsMinorCiv()) and (not player:IsBarbarian())) then 
		for unit in player:Units() do
			if (unit:GetDamage() > 0 and unit:GetDomainType() == domainLandID) then
				if isUsingCPDLL then
					if unit:IsWithinDistanceOfUnitClass(unitClassFrigateID, 2, true, false) then
						unit:ChangeDamage(-10)
					end
				else
					local unitPlot = unit:GetPlot()
					local isRegalShipNearby = false
					if unitPlot then
						for loopPlot in PlotAreaSpiralIterator(unitPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
							local loopUnit = player:GetUnitByID(loopPlot:GetUnit())
							if loopUnit then
								if (loopUnit:GetOwner() == playerID and loopUnit:GetUnitClassType() == unitClassFrigateID) then
									isRegalShipNearby = true
									break
								end
							end
						end
					end 
					if isRegalShipNearby then
						unit:ChangeDamage(-10)	
					end	
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_SwedenGustavusRegalShipHealing)
--==========================================================================================================================
--==========================================================================================================================