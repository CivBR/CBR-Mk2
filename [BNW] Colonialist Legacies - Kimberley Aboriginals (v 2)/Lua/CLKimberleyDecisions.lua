-- Decisions Support
-- Author: John -- template by JFD
-- DateCreated: 11/8/2014 7:56:32 PM
--------------------------------------------------------------
--=======================================================================================================================
print("Loading the Kimberley Decisions")
--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Kimberley: Keep the Wandjina Fresh
-------------------------------------------------------------------------------------------------------------------------
function KimberleyDecisionsTurn(player)
    local pPlayer = Players[player]
    if load(pPlayer, "Decisions_CLWandjina") == true then
        local iGAP = (pPlayer:GetNumResourceAvailable(GameInfoTypes.RESOURCE_PEARLS, false) + pPlayer:GetNumResourceAvailable(GameInfoTypes.RESOURCE_CORAL, false) + pPlayer:GetNumResourceAvailable(GameInfoTypes.RESOURCE_WHALE, false) + pPlayer:GetNumResourceAvailable(GameInfoTypes.RESOURCE_CRAB, false) + pPlayer:GetNumResourceAvailable(GameInfoTypes.RESOURCE_FISH, false))
        pPlayer:ChangeGoldenAgeProgressMeter(iGAP)
    end
end
GameEvents.PlayerDoTurn.Add(KimberleyDecisionsTurn)
 
function KimberleyDecisionsEra(iTeam)
    for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
        local pPlayer = Players[iPlayer]
        if (pPlayer:GetTeam() == iTeam) then
            if load(pPlayer, "Decisions_CLWandjina") == true then
                save(pPlayer, "Decisions_CLWandjina", nil)
            end
            if load(pPlayer, "Decisions_CLMemorializeDivers") == true then
                local NumCoastalCities = 0
                for cCity in pPlayer:Cities() do
                    if cCity:IsCoastal() then
                        NumCoastalCities = NumCoastalCities + 1
                    end
                end
                local CityFaith = 30 + (NumCoastalCities * 20)
                Events.GameplayAlertMessage('As we look back on the changes wrought in recent times, we gain '..CityFaith..' [ICON_PEACE] Faith from the memory of those who gave of themselves as divers so that we could prosper!')
                pPlayer:ChangeFaith(CityFaith)
            end
        end
    end
end
GameEvents.TeamSetEra.Add(KimberleyDecisionsEra)
 
local Decisions_CLWandjina = {}
    Decisions_CLWandjina.Name = "TXT_KEY_DECISIONS_CLKIMBERLEY_1"
    Decisions_CLWandjina.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLKIMBERLEY_1_DESC")
    HookDecisionCivilizationIcon(Decisions_CLWandjina, "CIVILIZATION_CLKIMBERLEY")
    Decisions_CLWandjina.CanFunc = (
    function(pPlayer)
        if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_CLKIMBERLEY then return false, false end
        if load(pPlayer, "Decisions_CLWandjina") == true then
                Decisions_CLWandjina.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLKIMBERLEY_1_ENACTED_DESC")
                return false, false, true
        end
        if pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
        if pPlayer:HasCreatedPantheon() == false then return true, false end
        if pPlayer:GetTotalFaithPerTurn() < 5 then return true, false end
        if pPlayer:GetCapitalCity() == nil then return true, false end
        if pPlayer:GetJONSCulture() < 35 then return true, false end
        return true, true
    end
    )
        Decisions_CLWandjina.DoFunc = (
    function(pPlayer)
        pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
        pPlayer:ChangeJONSCulture(-35)
        for cCity in pPlayer:Cities() do
            if cCity:GetWeLoveTheKingDayCounter() > 0 then
                cCity:SetWeLoveTheKingDayCounter(5)
            else
                cCity:ChangeWeLoveTheKingDayCounter(5)
            end
        end
        save(pPlayer, "Decisions_CLWandjina", true)
    end
    )
 
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_CLKIMBERLEY"], "Decisions_CLWandjina", Decisions_CLWandjina)
 
local Decisions_CLMemorializeDivers = {}
    Decisions_CLMemorializeDivers.Name = "TXT_KEY_DECISIONS_CLKIMBERLEY_2"
    HookDecisionCivilizationIcon(Decisions_CLMemorializeDivers, "CIVILIZATION_CLKIMBERLEY")
    Decisions_CLMemorializeDivers.CanFunc = (
    function(pPlayer)
        if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_CLKIMBERLEY then return false, false end
        if load(pPlayer, "Decisions_CLMemorializeDivers") == true then
            Decisions_CLMemorializeDivers.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLKIMBERLEY_2_ENACTED_DESC")
            return false, false, true
        end
        local NumCoastalCities = 0
        for cCity in pPlayer:Cities() do
            if cCity:IsCoastal() then
                NumCoastalCities = NumCoastalCities + 1
            end
        end
        if NumCoastalCities == 0 then return true, false end
        if pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
        if pPlayer:GetCapitalCity() == nil then return true, false end
        if pPlayer:GetJONSCulture() < 50 then return true, false end
        local CityFaith = 30 + (NumCoastalCities * 20)
        Decisions_CLMemorializeDivers.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLKIMBERLEY_2_DESC")
        return true, true
    end
    )
 
    Decisions_CLMemorializeDivers.DoFunc = (
    function(pPlayer)
        pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
        pPlayer:ChangeJONSCulture(-50)
        save(pPlayer, "Decisions_CLMemorializeDivers", true)
    end
    )
 
 
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_CLKIMBERLEY, "Decisions_CLMemorializeDivers", Decisions_CLMemorializeDivers)