WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "TarcisioCMMongolia";
include("PlotIterators")

function tcmSubmitToTheGreatKhan(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local player = Players[iNewOwner]
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_MONGOL"] then 
		local plot = Map.GetPlot(iX, iY)
		local city = plot:GetPlotCity()
		if player:GetGoldenAgeTurns() > 0 then
			if bIsCapital then
				player:ChangeGoldenAgeTurns(5)
			else
				player:ChangeGoldenAgeTurns(3)
			end
		end
	end
end
GameEvents.CityCaptureComplete.Add(tcmSubmitToTheGreatKhan)

function tcmOrDie(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_MONGOL"] then
		for unit in player:Units() do
			unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_MONGOL_BONUS_AGAINST_CITIES"], false)
			if player:GetGoldenAgeTurns() > 0 then
				unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_MONGOL_BONUS_AGAINST_CITIES"], true)
			end
		end

		local internalTraderRouteNum = 0
		local tradeRoutes = player:GetTradeRoutes()
		for tradeRouteID, tradeRoute in ipairs(tradeRoutes) do
			if tradeRoute.FromID == tradeRoute.ToID then
				internalTraderRouteNum = internalTraderRouteNum + 1
			end
		end
		if player:GetGoldenAgeTurns() > 0 then
			internalTraderRouteNum = internalTraderRouteNum * 2
		else
			internalTraderRouteNum = internalTraderRouteNum * 1
		end
		local capital = player:GetCapitalCity()
		capital:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_MONGOL_HAPPINESS"], internalTraderRouteNum)
	end
end
GameEvents.PlayerDoTurn.Add(tcmOrDie)

function tcmKhanIsBorn(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit:GetUnitType() == GameInfoTypes["UNIT_MONGOLIAN_KHAN"] then
		local oldNum = load(player, "tcmMongolNumberGreatGeneral")
		local currentNum = player:GetGreatGeneralsCreated()
		if not(oldNum) then
			oldNum = 0
		end
		if currentNum > oldNum then
			player:ChangeGoldenAgeTurns(8)
		end
		save(player, "tcmMongolNumberGreatGeneral", currentNum)
	end
end
Events.SerialEventUnitCreated.Add(tcmKhanIsBorn)
