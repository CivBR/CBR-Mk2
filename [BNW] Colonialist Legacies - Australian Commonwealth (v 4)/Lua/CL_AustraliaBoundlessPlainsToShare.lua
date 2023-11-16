--------------------
--Colonialist Legacies' Australia
--Boundless Plains To Share
--Civitar, Neirai, bane_
--------------------

local iAussieCiv = GameInfoTypes.CIVILIZATION_CL_AUSTRALIA;
local iAussiePuppetTourismBuilding = GameInfoTypes.BUILDING_CL_AUSTRALIA_PUPPET_TOURISM; --hidden building, gives +1 Tourism
local iAussieTradeTourismBuilding = GameInfoTypes.BUILDING_CL_AUSTRALIA_TRADE_TOURISM; --ditto
local tAussieTradeTourism = {};
tAussieTradeTourism[1] = GameInfoTypes.BUILDING_CL_AUSTRALIA_TRADE_TOURISM_16;
tAussieTradeTourism[2] = GameInfoTypes.BUILDING_CL_AUSTRALIA_TRADE_TOURISM_8;
tAussieTradeTourism[3] = GameInfoTypes.BUILDING_CL_AUSTRALIA_TRADE_TOURISM_4;
tAussieTradeTourism[4] = GameInfoTypes.BUILDING_CL_AUSTRALIA_TRADE_TOURISM_2;
tAussieTradeTourism[5] = GameInfoTypes.BUILDING_CL_AUSTRALIA_TRADE_TOURISM_1;

--Founded cities are puppets and generate +1 Tourism
function CL_AussieFoundPuppetCities(iPlayer, iCityX, iCityY)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iAussieCiv then
		local pPlot = Map.GetPlot(iCityX, iCityY);
		local pCity = pPlot:GetPlotCity();
		if not pCity:IsCapital() then
			pCity:SetPuppet(true);
			pCity:SetProductionAutomated(true);
			pCity:SetNumRealBuilding(iAussiePuppetTourismBuilding, 1);
		end
	end
end

function CL_AussiePuppetCheck(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iAussieCiv then
		for pCity in pPlayer:Cities() do
			if not pCity:IsPuppet() then
				pCity:SetNumRealBuilding(iAussiePuppetTourismBuilding, 0);
			end
		end
	end
end

--+1 Tourism per sea-based Trade Route
function CL_GetNumOutgoingSeaTradeRoutes(pPlayer, pCity)
	local TradeRoutes = pPlayer:GetTradeRoutes();
	local iNumOutgoingSeaTradeRoutes = 0;
	for k, v in pairs(TradeRoutes) do
		if v.FromCity == pCity then
			if v.Domain == GameInfoTypes.DOMAIN_SEA then
				iNumOutgoingSeaTradeRoutes = iNumOutgoingSeaTradeRoutes + 1;
			end
		end
	end
	return iNumOutgoingSeaTradeRoutes;
end

function CL_AussieTourismFromSeaTrade(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iAussieCiv then
		for pCity in pPlayer:Cities() do
			local iNumOutgoingSeaTradeRoutes = CL_GetNumOutgoingSeaTradeRoutes(pPlayer, pCity);
			for i = 1, 5 do
				if iNumOutgoingSeaTradeRoutes > 0 then
					if iNumOutgoingSeaTradeRoutes >= math.pow(2, 5 - i) then
						pCity:SetNumRealBuilding(tAussieTradeTourism[i], 1);
						iNumOutgoingSeaTradeRoutes = iNumOutgoingSeaTradeRoutes - math.pow(2, 5 - i);
					else
						pCity:SetNumRealBuilding(tAussieTradeTourism[i], 0);
					end
				else
					pCity:SetNumRealBuilding(tAussieTradeTourism[i], 0);
				end
			end
		end
	end
end

--Cities with +2 Tourism expand 100% faster
function CL_AussieCityExpandWithTourism(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iAussieCiv then
		for pCity in pPlayer:Cities() do
			if pCity:GetBaseTourism() >= 2 then
				local iCultureStored = pCity:GetJONSCultureStored();
				local iCityCultureOutput = pCity:GetJONSCulturePerTurn();
				pCity:SetJONSCultureStored(iCultureStored + iCityCultureOutput);
			end
		end
	end
end

GameEvents.PlayerCityFounded.Add(CL_AussieFoundPuppetCities);
GameEvents.PlayerDoTurn.Add(CL_AussiePuppetCheck);
GameEvents.PlayerDoTurn.Add(CL_AussieTourismFromSeaTrade);
GameEvents.PlayerDoTurn.Add(CL_AussieCityExpandWithTourism);