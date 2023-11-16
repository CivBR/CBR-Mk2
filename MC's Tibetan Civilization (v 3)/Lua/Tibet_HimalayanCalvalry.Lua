

-- -- Tibet_HimalayanCalvalry
-- -- Author: Sukritact
-- --=======================================================================================================================

-- print("loaded")
-- include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "Tibet_HimalayanCalvalry";
-- include("PlotIterators.lua")

-- --=======================================================================================================================
-- -- Utility Functions	
-- --=======================================================================================================================
-- -- SetPlotYield
-- -------------------------------------------------------------------------------------------------------------------------
-- function SetPlotYield(pPlot, iYield, iDelta)
	-- iOldDelta = load(pPlot, iYield)
	-- if iOldDelta == nil then
		-- Game.SetPlotExtraYield(pPlot:GetX(), pPlot:GetY(), iYield, iDelta)
	-- else
		-- Game.SetPlotExtraYield(pPlot:GetX(), pPlot:GetY(), iYield, iDelta - iOldDelta)
	-- end
	
	-- save(pPlot, iYield, iDelta)
-- end
-- --=======================================================================================================================
-- -- Initial Defines
-- --=======================================================================================================================
-- local tMountains = {}

-- for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    -- local pPlot = Map.GetPlotByIndex(iPlot)
	-- if pPlot:IsMountain() then
		-- tMountains[pPlot] = 0
	-- end
-- end

-- local iCulture		=	GameInfoTypes.YIELD_CULTURE
-- local iMod = 1

-- local tStoredTiles = {}
-- local iPromotion = GameInfoTypes.PROMOTION_MC_TIBET_HIMALAYAN_CAVALRY

-- for iPlayer, pPlayer in pairs(Players) do
	-- for pUnit in pPlayer:Units() do
		-- if pUnit:IsHasPromotion(iPromotion) then
			
			-- local iUnit = pUnit:GetID()
			-- tStoredTiles[iPlayer .. iUnit] = {}
			
			-- local pPlot = pUnit:GetPlot()
			-- for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				-- if tMountains[pAdjacentPlot] then
					-- tMountains[pAdjacentPlot] = tMountains[pAdjacentPlot] + 1
					-- table.insert(tStoredTiles[iPlayer .. iUnit], pAdjacentPlot)
				-- end
			-- end
			
		-- end
	-- end
-- end
-- --=======================================================================================================================
-- -- Core Functions: Himalayan Cavalry
-- --=======================================================================================================================
-- -- Himalayan Cavalry: Mountain Monitor
-- -------------------------------------------------------------------------------------------------------------------------
-- function MountainMonitor(pPlot)
	-- if tMountains[pPlot] < 1 then
		-- SetPlotYield(pPlot, iCulture, 0)
	-- else
		-- SetPlotYield(pPlot, iCulture, iMod)
	-- end
-- end
-- -------------------------------------------------------------------------------------------------------------------------
-- -- Himalayan Cavalry: MonitorUnit
-- -------------------------------------------------------------------------------------------------------------------------
-- -- function MonitorUnit(iPlayer, iUnit, iX, iY)
	
	-- -- local pPlayer = Players[iPlayer]
	-- -- local pUnit = pPlayer:GetUnitByID(iUnit)
	-- -- if not pUnit:IsHasPromotion(iPromotion) then return end

	-- -- if not(tStoredTiles[iPlayer .. iUnit]) then tStoredTiles[iPlayer .. iUnit] = {} end
	
	-- -- local tPlotsToMonitor = {}
	
	-- -- for iKey, pPlot in pairs(tStoredTiles[iPlayer .. iUnit]) do
		-- -- tMountains[pPlot] = tMountains[pPlot] - 1
		-- -- tPlotsToMonitor[pPlot] = true
	-- -- end
	
	-- -- local tNewStoredTiles = {}
	
	-- -- local pPlot = Map.GetPlot(iX, iY)
	-- -- for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		-- -- if tMountains[pAdjacentPlot] and pAdjacentPlot:GetOwner() == iPlayer then
			-- -- tMountains[pAdjacentPlot] = tMountains[pAdjacentPlot] + 1
			-- -- table.insert(tNewStoredTiles, pAdjacentPlot)
			-- -- tPlotsToMonitor[pAdjacentPlot] = true
		-- -- end
	-- -- end
	
	-- -- for pMountain, _ in pairs(tPlotsToMonitor) do
		-- -- MountainMonitor(pMountain)
	-- -- end
	
	-- -- tStoredTiles[iPlayer .. iUnit] = tNewStoredTiles
-- -- end
-- -- GameEvents.UnitSetXY.Add(MonitorUnit)

-- Events.SerialEventUnitCreated.Add(
	-- function(iPlayer, iUnit)
		-- local pPlayer = Players[iPlayer]
		-- local pUnit = pPlayer:GetUnitByID(iUnit)
		-- if not pUnit:IsHasPromotion(iPromotion) then return end

		-- MonitorUnit(pUnit:GetOwner(), pUnit:GetID(), pUnit:GetX(), pUnit:GetY())
	-- end
-- )

-- Events.SerialEventHexCultureChanged.Add(
	-- function(iX, iY)
		-- local pPlot = Map.GetPlot(ToGridFromHex(iX, iY))
		-- if tMountains[pPlot] then
		
			-- for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				-- local iNumUnits = pAdjacentPlot:GetNumUnits()
				-- for iVal = 0,(iNumUnits - 1) do
					-- local pUnit = pAdjacentPlot:GetUnit(iVal)
					-- if pUnit:IsHasPromotion(iPromotion) then
						-- MonitorUnit(pUnit:GetOwner(), pUnit:GetID(), pUnit:GetX(), pUnit:GetY())
					-- end
				-- end
			-- end
			
		-- end
	-- end
-- )
-- -------------------------------------------------------------------------------------------------------------------------
-- -- Himalayan Cavalry: Culture (SerialEventUnitDestroyed)
-- -------------------------------------------------------------------------------------------------------------------------
-- function UnitDestroyed_HimalayanCavalryCulture(iPlayer, iUnit)

	-- local pPlayer = Players[iPlayer]
	-- local pUnit = pPlayer:GetUnitByID(iUnit)
	-- if pUnit ~= nil then
		-- return
	-- end
	
	-- if tStoredTiles[iPlayer .. iUnit] then
		-- for iKey, pPlot in pairs(tStoredTiles[iPlayer .. iUnit]) do
			-- bChanged = true
			-- tMountains[pPlot] = tMountains[pPlot] - 1
			-- MountainMonitor(pPlot)
		-- end
	-- end
	
	-- tStoredTiles[iPlayer .. iUnit] = nil
-- end
-- Events.SerialEventUnitDestroyed.Add(UnitDestroyed_HimalayanCavalryCulture)
-- -------------------------------------------------------------------------------------------------------------------------
-- -- Himalayan Cavalry: Movement
-- -------------------------------------------------------------------------------------------------------------------------
-- function HimalayanCavalryMovement(iPlayer)
	-- local pPlayer = Players[iPlayer]
	-- for pUnit in pPlayer:Units() do
		-- if pUnit:IsHasPromotion(iPromotion) then
		
			-- local pPlot = pUnit:GetPlot()
			-- if pPlot:IsHills() then
				-- if pPlot:GetOwner() == iPlayer then
					-- local iMovement = pUnit:GetMoves() + 120
					-- pUnit:SetMoves(iMovement)				
				-- else
					-- local iMovement = pUnit:GetMoves() + 60
					-- pUnit:SetMoves(iMovement)
				-- end
			-- end
		-- end
	-- end
-- end
-- GameEvents.PlayerDoTurn.Add(HimalayanCavalryMovement)
-- --=======================================================================================================================
-- --=======================================================================================================================