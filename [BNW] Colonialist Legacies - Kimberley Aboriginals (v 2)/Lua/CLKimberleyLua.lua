 
include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "Colonialist Legacies Kimberley";
 
Luxes = {}
Luxes[0] = GameInfoTypes.RESOURCE_STONE
Luxes[1] = GameInfoTypes.RESOURCE_GOLD
Luxes[2] = GameInfoTypes.RESOURCE_SILVER
Luxes[3] = GameInfoTypes.RESOURCE_GEMS
Luxes[4] = GameInfoTypes.RESOURCE_MARBLE
Luxes[5] = GameInfoTypes.RESOURCE_IVORY
Luxes[6] = GameInfoTypes.RESOURCE_FUR
Luxes[7] = GameInfoTypes.RESOURCE_DYE
Luxes[8] = GameInfoTypes.RESOURCE_SPICES
Luxes[9] = GameInfoTypes.RESOURCE_SILK
Luxes[10] = GameInfoTypes.RESOURCE_SUGAR
Luxes[11] = GameInfoTypes.RESOURCE_COTTON
Luxes[12] = GameInfoTypes.RESOURCE_WINE
Luxes[13] = GameInfoTypes.RESOURCE_INCENSE
Luxes[14] = GameInfoTypes.RESOURCE_COPPER
Luxes[15] = GameInfoTypes.RESOURCE_SALT
Luxes[16] = GameInfoTypes.RESOURCE_TRUFFLES
Luxes[17] = GameInfoTypes.RESOURCE_COCOA
Luxes[18] = GameInfoTypes.RESOURCE_COFFEE
Luxes[19] = GameInfoTypes.RESOURCE_TEA
Luxes[20] = GameInfoTypes.RESOURCE_TOBACCO
Luxes[21] = GameInfoTypes.RESOURCE_AMBER
Luxes[22] = GameInfoTypes.RESOURCE_JADE
Luxes[23] = GameInfoTypes.RESOURCE_OLIVE
Luxes[24] = GameInfoTypes.RESOURCE_PERFUME
Luxes[25] = GameInfoTypes.RESOURCE_GLASS
Luxes[26] = GameInfoTypes.RESOURCE_LAPIS
Luxes[27] = GameInfoTypes.RESOURCE_WHALE
Luxes[28] = GameInfoTypes.RESOURCE_PEARLS
Luxes[29] = GameInfoTypes.RESOURCE_CRAB
Luxes[30] = GameInfoTypes.RESOURCE_JFD_MANUSCRIPTS
Luxes[31] = GameInfoTypes.RESOURCE_JFD_FEATHERS
Luxes[32] = GameInfoTypes.RESOURCE_JFD_GINGER
Luxes[33] = GameInfoTypes.RESOURCE_JFD_OBSIDIAN
Luxes[34] = GameInfoTypes.RESOURCE_JFD_OPIUM
Luxes[35] = GameInfoTypes.RESOURCE_JFD_SAFFRON
Luxes[36] = GameInfoTypes.RESOURCE_JFD_VANILLA
 
 
function KayuJawaHappiness(player)
    local pPlayer = Players[player]
    if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CLKIMBERLEY then
        for cCity in pPlayer:Cities() do
            local luxes = {}
            local luxhap = 0
            for i, lux in pairs(Luxes) do
                if lux ~= nil then
                        luxes[i] = false
                        if pPlayer:GetNumResourceTotal(lux, true) > 0 then
                            --do nothing
                        else
                            local iTrades = 0
                                                for i,v in ipairs(pPlayer:GetTradeRoutes()) do
                                                        local cOther = nil
                                                        if v.FromCity == cCity then
                                                                if v.ToCity:GetOwner() == pPlayer then
                                                                        --do nothing
                                                                else
                                                                        cOther = v.ToCity
                                                                end
                                                        elseif v.ToCity == cCity then
                                                                if v.FromCity:GetOwner() == pPlayer then
                                                                        --do nothing
                                                                else
                                                                        cOther = v.FromCity
                                                                end
                                                        end
                                                        if cOther ~= nil then
                                                                if cOther:IsHasResourceLocal(lux) then
                                                                        luxes[i] = true
                                                                end
                                                        end
                                                end
                                        end
                                end
                        end
            for i, lux in pairs(luxes) do
                if luxes[i] == true then
                    luxhap = luxhap + 1
                end
            end
            cCity:SetNumRealBuilding(GameInfoTypes.CLKIMBERLEYUAHAP, luxhap)
        end
    end
end
 
function KayuJawaSave(player, city, unit)
        local pPlayer = Players[player]
        if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CLKIMBERLEY then
                save(pPlayer:GetUnitByID(unit), 'KJstr', unit:GetBaseCombatStrength())
        end
end
 
function KayuJawaStrength(player)
    local pPlayer = Players[player]
    if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CLKIMBERLEY then
        for uUnit in pPlayer:Units() do
            local baseStrength = load(uUnit, 'KJstr')
            if baseStrength == nil then
                KayuJawaSave(player, 0, uUnit:GetID())
            local tradeCount = 0   --get the number of trade routes that you have, including enemy trade routes
            for i,v in ipairs(pPlayer:GetTradeRoutes()) do
                tradeCount = tradeCount + 1
            end
            local newStrength = math.floor(baseStrength * (1 + (tradeCount / 100)))
            uUnit:SetBaseCombatStrength(newStrength)
        end
    end
end
 
function TrepangerCamp(player)
    local pPlayer = Players[player]
    if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CLKIMBERLEY then
        for cCity in pPlayer:Cities() do
            if cCity:GetNumRealBuilding(GameInfoTypes.BUILDING_CLTREPANGER) > 0 then
                local notMyTradeShip = 0
                for i,v in ipairs(pPlayer:GetTradeRoutes()) do
                        if v.ToCity == cCity and v.FromCity:GetOwner() ~= pPlayer then
                                if v.Domain == DomainTypes.DOMAIN_SEA then
                                        notMyTradeShip = notMyTradeShip + 1
                                end
                        end
                end
                cCity:SetNumRealBuilding(GameInfoTypes.BUILDING_CLTERPANGERBUFF, notMyTradeShip)
            else
                cCity:SetNumRealBuilding(GameInfoTypes.BUILDING_CLTERPANGERBUFF, 0)
            end
        end
    end
end
 
function TrackerSetTrail(playerID, unitID)
        local pPlayer = Players[playerID]
        local uTracker = pPlayer:GetUnitByID(unitID)
        local mPlot = uTracker:GetPlot()
        if mPlot ~= nil then
                save(mPlot, 'TrackerTrail', playerID .. 4)
        end
end
 
function TrackerTrailDecay(player)
        for plotLoop = Map.GetNumPlots() - 1, 0, -1 do
                local mPlot = Map.GetPlotByIndex(plotLoop)
                if mPlot ~= nil then
                        local iTracker = load(mPlot, 'TrackerTrail')
                        if iTracker ~= nil then
                                for i=1,4,1 do --do this over and over again from 1 to 4
                                        if iTracker == player .. i then
                                                save(mPlot, 'TrackerTrail', player .. (i - 1))
                                        end
                                end
                        end
                end
        end
end
 
function TrackerTrailTag(playerID, unitID)
        local pTarget = Players[playerID]
        local uTarget = pTarget:GetUnitByID(unitID)
        local mPlot = uTarget:GetPlot()
        if mPlot ~= nil then
                local iTracker = load(mPlot, 'TrackerTrail')
                if iTracker ~= nil then
                        for i=1,4,1 do
                                if iTracker ~= playerID .. i then -- don't tag your own bros!
                                        save(uTarget, 'TrackedBy' .. playerID, true)
                                end
                        end
                end
        end
end
 
function TrackerTrailProc(player)
        local pTracker = Players[player]
        if pTracker:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CLKIMBERLEY then
                for i, pTracked in pairs(Players) do
                        for uTracked in pTracked:Units() do
                                local bTracked = load(uTracked, 'TrackedBy' .. player)
                                if bTracked ~= nil then
                                        if bTracked == true then
                                                local mPlot = uTracked:GetPlot()
                                                if mPlot ~= nil then
                                                        local x = mPlot:GetX()
                                                        local y = mPlot:GetY()
                                                        local range = 1
                                            for dx = -range, range do
                                                        for dy = -range, range do
                                                                        local plot = Map.PlotXYWithRangeCheck(x, y, dx, dy, range)
                                                                        if plot then
                                                                                plot:SetRevealed(Teams[pTracker:GetTeam()], true)
                                                                        end
                                                                end
                                                        end
                                                end
                                        end
                                end
                        end
                end    
        end
end
 
function TrackerScan(playerID, mPlot)
        local x = mPlot:GetX()
        local y = mPlot:GetY()
        local range = 1
        for dx = -range, range do
                for dy = -range, range do
                        local plot = Map.PlotXYWithRangeCheck(x, y, dx, dy, range)
                        if plot then
                                for i = 1, plot:GetNumUnits(), 1 do
                                        uTarget = plot:GetUnit(i)
                                        local bTarget = load(uTarget, 'TrackedBy' .. playerID)
                                        if bTarget ~= nil then
                                                if bTarget == true then
                                                        return true
                                                end
                                        end
                                end
                        end
                end
        end
        return false
end
 
function TrackerPowerBuff(playerID, unitID)
        local pPlayer = Players[playerID]
        if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CLKIMBERLEY then
                local uTracker = pPlayer:GetUnitByID(unitID)
                if uTracker:IsHasPromotion(GameInfoTypes.PROMOTION_CLTRACKER) then
                        local mPlot = uTracker:GetPlot()
                        if mPlot ~= nil then
                                local bAura = TrackerScan(playerID, mPlot)
                                uTracker:SetHasPromotion(GameInfoTypes.PROMOTION_CLTRACKERAURA, bAura)
                        end
                end
        end
end
 
 
for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
        local pPlayer = Players[i]
        if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CLKIMBERLEY then
                print("Kimberley lua loaded!")
                GameEvents.PlayerDoTurn.Add(KayuJawaHappiness)
                GameEvents.CityTrained.Add(KayuJawaSave)
                GameEvents.PlayerDoTurn.Add(KayuJawaStrength)
                GameEvents.PlayerDoTurn.Add(TrepangerCamp)
                GameEvents.UnitSetXY.Add(TrackerSetTrail)
                GameEvents.PlayerDoTurn.Add(TrackerTrailDecay)
                GameEvents.UnitSetXY.Add(TrackerTrailTag)
                GameEvents.PlayerDoTurn.Add(TrackerTrailProc)
                GameEvents.UnitSetXY.Add(TrackerPowerBuff)
                break
		end
	end
end