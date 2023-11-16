-- Texas Decisions
-- Author: Vicevirtuoso
--------------------------------------------------------------
 
local tOutlawSpawnTable = {
        [GameInfoTypes.ERA_CLASSICAL] = {
                ["OutlawUnitType"] = GameInfoTypes.UNIT_TEXASOUTLAWCLASSICAL,
                ["PlayerUnitType"] = GameInfoTypes.UNIT_HORSEMAN
        },
        [GameInfoTypes.ERA_MEDIEVAL] = {
                ["OutlawUnitType"] = GameInfoTypes.UNIT_TEXASOUTLAWMEDIEVAL,
                ["PlayerUnitType"] = GameInfoTypes.UNIT_KNIGHT
        },
        [GameInfoTypes.ERA_RENAISSANCE] = {
                ["OutlawUnitType"] = GameInfoTypes.UNIT_TEXASOUTLAWRENAISSANCE,
                ["PlayerUnitType"] = GameInfoTypes.UNIT_LANCER
        },
        [GameInfoTypes.ERA_INDUSTRIAL] = {
                ["OutlawUnitType"] = GameInfoTypes.UNIT_TEXASOUTLAWINDUSTRIAL,
                ["PlayerUnitType"] = GameInfoTypes.UNIT_TEXASRANGER
        },
        [GameInfoTypes.ERA_MODERN] = {
                ["OutlawUnitType"] = GameInfoTypes.UNIT_TEXASOUTLAWMODERN,
                ["PlayerUnitType"] = GameInfoTypes.UNIT_TEXASRANGER
        },
        [GameInfoTypes.ERA_POSTMODERN] = {
                ["OutlawUnitType"] = GameInfoTypes.UNIT_TEXASOUTLAWPOSTMODERN,
                ["PlayerUnitType"] = GameInfoTypes.UNIT_TEXASRANGER
        },
        [GameInfoTypes.ERA_FUTURE] = {
                ["OutlawUnitType"] = GameInfoTypes.UNIT_TEXASOUTLAWFUTURE,
                ["PlayerUnitType"] = GameInfoTypes.UNIT_TEXASRANGER
        }
}
 
local tOutlawRewardTable = {
        [GameInfoTypes.UNIT_TEXASOUTLAWCLASSICAL] = {
                ["CultureTurns"] = 3,
                ["GoldenAge"] = 0,
                ["FreeBuilding"] = nil,
        },
        [GameInfoTypes.UNIT_TEXASOUTLAWMEDIEVAL] = {
                ["CultureTurns"] = 3,
                ["GoldenAge"] = 0,
                ["FreeBuilding"] = nil
        },
        [GameInfoTypes.UNIT_TEXASOUTLAWRENAISSANCE] = {
                ["CultureTurns"] = 3,
                ["GoldenAge"] = 150,
                ["FreeBuilding"] = nil
        },
        [GameInfoTypes.UNIT_TEXASOUTLAWINDUSTRIAL] = {
                ["CultureTurns"] = 4,
                ["GoldenAge"] = 150,
                ["FreeBuilding"] = nil
        },
        [GameInfoTypes.UNIT_TEXASOUTLAWMODERN] = {
                ["CultureTurns"] = 4,
                ["GoldenAge"] = 250,
                ["FreeBuilding"] = GameInfoTypes.BUILDING_TEXASWRITING
        },
        [GameInfoTypes.UNIT_TEXASOUTLAWPOSTMODERN] = {
                ["CultureTurns"] = 4,
                ["GoldenAge"] = 500,
                ["FreeBuilding"] = GameInfoTypes.BUILDING_TEXASART
        },
        [GameInfoTypes.UNIT_TEXASOUTLAWFUTURE] = {
                ["CultureTurns"] = 4,
                ["GoldenAge"] = 500,
                ["FreeBuilding"] = GameInfoTypes.BUILDING_TEXASMUSIC
        }
}
 
--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1
--------------------------------------------------------------------------------------------------------------------------------------------
 
local Decisions_TexasBounty = {}
        Decisions_TexasBounty.Name = "TXT_KEY_DECISIONS_TEXAS_BOUNTY"
        Decisions_TexasBounty.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TEXAS_BOUNTY_DESC")
        HookDecisionCivilizationIcon(Decisions_TexasBounty, "CIVILIZATION_TEXAS")
        Decisions_TexasBounty.CanFunc = (
        function(pPlayer)
                if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TEXAS) then
                        return false, false
                end
                if load(pPlayer, "Decisions_TexasBounty") and load(pPlayer, "Decisions_TexasBounty") >= pPlayer:GetCurrentEra() then
                        Decisions_TexasBounty.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TEXAS_BOUNTY_ENACTED_DESC")
                        return false, false, true
                end
               
                local iCost = math.ceil(200 + (pPlayer:GetCurrentEra() * 100) * iMod)
                Decisions_TexasBounty.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TEXAS_BOUNTY_DESC", iCost)
               
                if pPlayer:GetGold() < iCost then
                        return true, false
                else
                        return true, true
                end
        end
        )
       
        Decisions_TexasBounty.DoFunc = (
        function(pPlayer)
                local iEra = pPlayer:GetCurrentEra()
                if tOutlawSpawnTable[iEra] then
                        local iCost = math.ceil(200 + (iEra * 100) * iMod)
                        pPlayer:ChangeGold(-iCost)
               
                        local pMounted = pPlayer:InitUnit(tOutlawSpawnTable[iEra].PlayerUnitType, pPlayer:GetCapitalCity():GetX(), pPlayer:GetCapitalCity():GetY(), UNITAI_FAST_ATTACK)
                        pMounted:JumpToNearestValidPlot()
 
                        --Pass 1: Attempt to spawn the unit in owned territory with a distance of 3 or more tiles from a City
                        local tValidPlots = {}
                        local iPlayer = pPlayer:GetID()
                        for pCity in pPlayer:Cities() do
                                local iX = pCity:GetX()
                                local iY = pCity:GetY()
                                local cityArea = pCity:GetNumCityPlots() - 1
                                for cityPlotIndex = 0, cityArea do
                                        local plot = pCity:GetCityIndexPlot( cityPlotIndex )
                                        if plot and plot:GetOwner() == iPlayer and not plot:IsWater() and not plot:IsMountain() and not plot:IsCity() and not plot:IsImpassable() and Map.PlotDistance(iX, iY, plot:GetX(), plot:GetY()) >= 3 then
                                                tValidPlots[#tValidPlots + 1] = plot
                                        end
                                end
                        end
                       
                        --Pass 2: Spawn anywhere in owned territory if there were no valid locations 3 tiles away
                        if #tValidPlots == 0 then
                                for pCity in pPlayer:Cities() do
                                        local iX = pCity:GetX()
                                        local iY = pCity:GetY()
                                        local cityArea = pCity:GetNumCityPlots() - 1
                                        for cityPlotIndex = 0, cityArea do
                                                local plot = pCity:GetCityIndexPlot( cityPlotIndex )
                                                if plot and plot:GetOwner() == iPlayer and not plot:IsWater() and not plot:IsMountain() and not plot:IsCity() and not plot:IsImpassable() then
                                                        tValidPlots[#tValidPlots + 1] = plot
                                                end
                                        end
                                end
                        end
                       
                        if #tValidPlots == 0 then
                                print("Error: Unable to find a suitable spawn plot for the Texas Outlaw!")
                                return
                        end
                       
                        local iBarbID = GameDefines.MAX_CIV_PLAYERS
                        local pChosenPlot = tValidPlots[Game.Rand(#tValidPlots, "Texas Decisions Outlaw Spawn Plot Roll") + 1]
                        local pOutlaw = Players[iBarbID]:InitUnit(tOutlawSpawnTable[iEra].OutlawUnitType, pChosenPlot:GetX(), pChosenPlot:GetY(), UNITAI_FAST_ATTACK)
 
                        save(pPlayer, "Decisions_TexasBounty", iEra)
                end
        end
        )
 
        Decisions_TexasBounty.Monitors = {}
        Decisions_TexasBounty.Monitors[GameEvents.UnitKilledInCombat] =  (
        function(iPlayer, iVictim, iUnitType)
                if tOutlawRewardTable[iUnitType] and iVictim == GameDefines.MAX_CIV_PLAYERS then
                        local pPlayer = Players[iPlayer]
                        local iRewardCulture = 0
                        local iRewardGAPoints = 0
                        if tOutlawRewardTable[iUnitType].CultureTurns then
                                local iCulturePerTurn = pPlayer:GetTotalJONSCulturePerTurn()
                                iRewardCulture = iCulturePerTurn * tOutlawRewardTable[iUnitType].CultureTurns
                                pPlayer:ChangeJONSCulture(iRewardCulture)
                        end
                        if tOutlawRewardTable[iUnitType].GoldenAge then
                                iRewardGAPoints = tOutlawRewardTable[iUnitType].GoldenAge
                                pPlayer:ChangeGoldenAgeProgressMeter(tOutlawRewardTable[iUnitType].GoldenAge)
                        end
                        if tOutlawRewardTable[iUnitType].FreeBuilding and pPlayer:GetCapitalCity() then
                                pPlayer:GetCapitalCity():SetNumRealBuilding(tOutlawRewardTable[iUnitType].FreeBuilding, 1)
                        end
                       
                        if iPlayer == Game:GetActivePlayer() then
                                local popupInfo = {
                                        Data1 = 500,
                                        Type = ButtonPopupTypes.BUTTONPOPUP_TEXT,
                                }
                               
                                local sPopupText = Locale.ConvertTextKey("TXT_KEY_POPUP_DECISIONS_TEXAS_BOUNTY", iRewardCulture, iRewardGAPoints)
                                if tOutlawRewardTable[iUnitType].FreeBuilding then
                                        sPopupText = sPopupText.."[NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_POPUP_DECISIONS_TEXAS_BOUNTY_BUILDING", GameInfo.Buildings[tOutlawRewardTable[iUnitType].FreeBuilding].Description)
                                end
                                popupInfo.Text = sPopupText;
                                UI.AddPopup(popupInfo);
                                Events.AudioPlay2DSound("AS2D_TEXASBOUNTYCLAIMED")
                        end
                end
        end
        )
 
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TEXAS, "Decisions_TexasBounty", Decisions_TexasBounty)
 
 
 
--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_TexasOilIndustry = {}
        Decisions_TexasOilIndustry.Name = "TXT_KEY_DECISIONS_TEXAS_OIL_INDUSTRY"
        Decisions_TexasOilIndustry.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TEXAS_OIL_INDUSTRY_DESC")
        HookDecisionCivilizationIcon(Decisions_TexasOilIndustry, "CIVILIZATION_TEXAS")
        Decisions_TexasOilIndustry.CanFunc = (
        function(pPlayer)
                if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TEXAS) then
                        return false, false
                end
                if load(pPlayer, "Decisions_TexasOilIndustry") == true then
                        Decisions_TexasOilIndustry.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TEXAS_OIL_INDUSTRY_ENACTED_DESC")
                        return false, false, true
                end
 
                local iGoldCost = math.ceil(1000 * iMod)
                local iCultureCost = math.ceil(100 * iMod)
                Decisions_TexasOilIndustry.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TEXAS_OIL_INDUSTRY_DESC", iGoldCost, iCultureCost)
               
                if pPlayer:GetGold() < iGoldCost then return true, false end
                if pPlayer:GetJONSCulture() < iCultureCost then return true, false end
                if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
 
                local pTeam = Teams[pPlayer:GetTeam()]
                local pTeamTechs = pTeam:GetTeamTechs()
                if pTeamTechs:HasTech(GameInfoTypes.TECH_BIOLOGY) then
                        return true, true
                else
                        return true, false
                end
        end
        )
       
        Decisions_TexasOilIndustry.DoFunc = (
        function(pPlayer)
                local iGoldCost = math.ceil(1000 * iMod)
                local iCultureCost = math.ceil(100 * iMod)
                pPlayer:ChangeGold(-iGoldCost)
                pPlayer:ChangeJONSCulture(-iCultureCost)
                pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
                pPlayer:SetNumFreePolicies(1)
                pPlayer:SetNumFreePolicies(0)
                pPlayer:SetHasPolicy(GameInfoTypes.POLICY_TEXASOIL, true)
               
                local iPlayer = pPlayer:GetID()
                local iOil = GameInfoTypes.RESOURCE_OIL
                for pCity in pPlayer:Cities() do
                        local iNumPlots = pCity:GetNumCityPlots();
                        for iPlot = 0, iNumPlots - 1 do
                                local pPlot = pCity:GetCityIndexPlot(iPlot)
                                if pPlot and pPlot:GetOwner() == iPlayer and pPlot:GetResourceType() == iOil and not pPlot:IsWater() then
                                        pPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_WELL)
                                end
                        end
                end
               
                save(pPlayer, "Decisions_TexasOilIndustry", true)
        end
        )
 
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TEXAS, "Decisions_TexasOilIndustry", Decisions_TexasOilIndustry)