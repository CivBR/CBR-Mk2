-- =====================
-- Sparta: Citizens from City Capture. By JFD
-- =====================
local civilizationSpartaID = GameInfoTypes["CIVILIZATION_MC_SPARTA"]
function MC_SpartanPopulationFromConquest(oldOwnerID, capital, plotX, plotY, newOwnerID, isConquest)
	if isConquest then
		local player = Players[newOwnerID]
		if (player:IsAlive() and player:GetCivilizationType() == civilizationSpartaID) then
			player:GetCapitalCity():ChangePopulation(1,true)
		end
	end
end
GameEvents.CityCaptureComplete.Add(MC_SpartanPopulationFromConquest)

-- =====================
-- Sparta: Hoplite Promotions. By JFD
-- =====================
include("PlotIterators")

local civilizationSpartaID = GameInfoTypes["CIVILIZATION_MC_SPARTA"]
local unitPromotionSpartanEmoID = GameInfoTypes["PROMOTION_MC_MOLON_LABE"]
local unitPromotionSpartanFriendsID = GameInfoTypes["PROMOTION_MC_ADD_A_STEP_FORWARD"]
function MC_SpartanHoplite(playerID, unitID, plotX, plotY)
    local player = Players[playerID]
    if (player:IsAlive() and player:GetCivilizationType() == civilizationSpartaID) then
        local unit = player:GetUnitByID(unitID)
        if unit == nil then return end
        if (unit:GetPlot() and (unit:IsHasPromotion(unitPromotionSpartanEmoID) or unit:IsHasPromotion(unitPromotionSpartanFriendsID))) then
            local plot = unit:GetPlot()
            local adjOther = false
            for loopPlot in PlotAreaSpiralIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
                if (loopPlot:IsUnit() and loopPlot:GetUnit():GetOwner() == playerID) then
                    adjOther = true
                    break
                end
            end
                                
            if adjOther then
                if (not unit:IsHasPromotion(unitPromotionSpartanFriendsID)) then
                    unit:SetHasPromotion(unitPromotionSpartanFriendsID, true)
                    unit:SetHasPromotion(unitPromotionSpartanEmoID, false)
                end
            else
                if unit:IsHasPromotion(unitPromotionSpartanFriendsID) then
                    unit:SetHasPromotion(unitPromotionSpartanFriendsID, false)
                    unit:SetHasPromotion(unitPromotionSpartanEmoID, true)
                end
            end
        end
    end
end
GameEvents.UnitSetXY.Add(MC_SpartanHoplite)
-- =====================
-- Sparta: Infantry units from pop growth. By JFD
-- =====================
print( "Loaded." )
 
local civilizationSpartaID = GameInfoTypes["CIVILIZATION_MC_SPARTA"]
--[[-----------------------------------------
Name:            GetCivSpecificUnit
Purpose:         Get the UnitType for a specific
civ from a UnitClassType.
-------------------------------------------]]
function fnGetCivSpecificUnit( pPly, sUnitClass ) -- Thanks whoward69
 
        -- BEGIN DEFINES
        local sUnitType = nil
        local sCivType  = GameInfo.Civilizations[ pPly:GetCivilizationType() ].Type
        -- END DEFINES
 
        --[[ Loop through civilization-specific UnitClass overrides, id est their unique units, and
        yield to be returned the proper UnitType. --]]
        for pOverride in GameInfo.Civilization_UnitClassOverrides{ CivilizationType = sCivType,
        UnitClassType = GameInfo.UnitClasses[ sUnitClass ].Type } do
 
                sUnitType = pOverride.UnitType
                break
 
        end
 
        -- If we didn't get anything, yield to be returned the default UnitType for the UnitClass.
        if sUnitType == nil then
 
                sUnitType = GameInfo.UnitClasses[ sUnitClass ].DefaultUnit
 
        end
 
        -- Give whatever function called this the UnitType we yielded.
        return GameInfo.Units[ sUnitType ].ID
 
end
 
--[[-----------------------------------------
Name:           GetStrongestMilitaryUnit
Purpose:        Return the best land melee unit
that a city can build.  
-------------------------------------------]]

function C15_General_Born(playerID, unitID)
	local pPlayer = Players[playerID]
	local pUnit = pPlayer:GetUnitByID(unitID)
	if pPlayer:GetCivilizationType() == civilizationSpartaID and pUnit:GetUnitClassType() == GameInfoTypes["UNITCLASS_GREAT_GENERAL"] then
		print("General has been born/moved")
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes["POLICY_C15_SPARTA_GENERAL"], true)
		GameEvents.UnitSetXY.Remove(C15_General_Born)
	end
end

GameEvents.UnitSetXY.Add(C15_General_Born)

function GetStrongestMilitaryUnit(pPlayer, bIgnoreResources, ...)
	local tUnit = {["ID"] = GameInfoTypes.UNIT_WARRIOR, ["Combat"] = -1}
	for iKey, sCombatType in pairs({...}) do
		for row in GameInfo.Units("CombatClass = \'" .. sCombatType .. "\'") do
			if pPlayer:CanTrain(row.ID, bIgnoreResources) and row.Combat > tUnit.Combat then
				tUnit = row
			end
		end
	end
	return tUnit.ID
end
 
GameEvents.SetPopulation.Add(
 
function( xOffset, yOffset, fOldPop, fNewPop )
 
        -- BEGIN DEFINES
        local pPlot                     = Map.GetPlot( xOffset, yOffset )
        local pCity                     = pPlot:GetPlotCity()
        local iPlyID                    = pCity:GetOwner()
        local pPly                      = Players[ iPlyID ] -- Dat Datatype Mismatch, son
        local iUnitMostCurrent  = nil
        if pPly:GetCivilizationType() ~= civilizationSpartaID then return end
 
        local nTrait                    = 1
        local nZenith                   = math.floor( pCity:GetHighestPopulation() )
        -- END DEFINES
 
        --[[ On every growth of every city, run through the following list of conditions:
        1:  Does the city's owner have the trait, and is its population evenly divisible
        by the trait?
        2:  Is the city a capital?
        3:  Has the city grown instead of shrinking, and is this the city's highest
        population?
 
        If all of the above are true, get the best land infantry unit we can, and
        spawn it at the city. --]]
 
        if ( ( nTrait > 0 ) and ( math.floor( fNewPop ) % nTrait ) == 0 ) then
 
                if pCity:IsCapital() and pPly:HasPolicy(GameInfoTypes["POLICY_C15_SPARTA_GENERAL"]) then
 
                        if ( ( fNewPop > fOldPop ) and ( fNewPop >= nZenith ) ) then
 
                                iUnitMostCurrent = GetStrongestMilitaryUnit(pPly, false, "UNITCOMBAT_MELEE", "UNITCOMBAT_GUN")
 
                                pPly:AddFreeUnit( iUnitMostCurrent )
 
                        end
                end
 
        end
 
end )