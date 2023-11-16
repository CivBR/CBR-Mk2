--------------------
--Colonialist Legacies' Australia
--Prime Minister
--Civitar


-- Changes made by Kurouma. 22/09/15
-- Not playtested for bugs yet.


--------------------

local iAussieCiv = GameInfoTypes.CIVILIZATION_CL_AUSTRALIA;
local iPrimeMinister = GameInfoTypes.UNIT_CL_AUSTRALIA_PRIME_MINISTER;
local iAussiePMTourismBuilding = GameInfoTypes.BUILDING_CL_AUSTRALIA_PM_TOURISM;
local tAussiePMTourismTimer = {};
local iTourismTurns = 0;
local tAussiePMTourism = {};
tAussiePMTourism[1] = GameInfoTypes.BUILDING_CL_AUSTRALIA_PM_TOURISM_64;
tAussiePMTourism[2] = GameInfoTypes.BUILDING_CL_AUSTRALIA_PM_TOURISM_32;
tAussiePMTourism[3] = GameInfoTypes.BUILDING_CL_AUSTRALIA_PM_TOURISM_16;
tAussiePMTourism[4] = GameInfoTypes.BUILDING_CL_AUSTRALIA_PM_TOURISM_8;
tAussiePMTourism[5] = GameInfoTypes.BUILDING_CL_AUSTRALIA_PM_TOURISM_4;
tAussiePMTourism[6] = GameInfoTypes.BUILDING_CL_AUSTRALIA_PM_TOURISM_2;
tAussiePMTourism[7] = GameInfoTypes.BUILDING_CL_AUSTRALIA_PM_TOURISM_1;

--all annexed coastal cities receive +1 tourism for every claimed land tile outside workable city limits for 10 turns upon creation
function CL_GetNumTilesOutsideCityRadius(pCity)
	local iNumTiles = 0;
	for i = 0, pCity:GetNumCityPlots() - 1, 1 do
		local pPlot = Map.GetPlotByIndex(i);
		local iPlotX = pPlot:GetX();
		local iPlotY = pPlot:GetY();
		if not pPlot:IsWater() then
			local pCityPlot = pCity:Plot();
			local iCityX = pCityPlot:GetX();
			local iCityY = pCityPlot:GetY();
			if Map.PlotDistance(iPlotX, iPlotY, iCityX, iCityY) > 3 then
				iNumTiles = iNumTiles + 1;
			end
		end
	end
	return iNumTiles;
end


-- KUROUMA Find the number of land tiles outside workable radius. !!!THIS WORKS, BUT COUNTS TILES TWICE IF TWO CITIES ARE AT RANGE 4 OR 5!! IT ALSO COUNTS TILES THAT ARE WITHIN 3 TILES OF *ANOTHER* CITY!!!
function KUROUMA_GetNumTilesOutsideCityRadius(pCity)
	local iNumTiles = 0;
	local iCityOwner = pCity:GetOwner();
	
	-- Rings 4 and 5 distance
	for i = 37, 90 do
		local pPlot = pCity:GetCityIndexPlot(i);
		
		-- Protect against off-map 'tile' references
		if (type(pPlot) ~= 'nil') then
		
			-- Only tiles you own
			if (pPlot:GetOwner() == iCityOwner) and (pPlot:IsWater == false) then
				iNumTiles = iNumTiles + 1;
				end
			end
		end
	end
	return iNumTiles;
end

-- KUROUMA As above, but more sophisticated: does not count tiles that are close to *another* of pPlayer's cities, and does not double-count tiles at the right distance from more than one city.
function KUROUMA_GetUniqueTilesOutsideCityRadius(pCity, tTiles)
	local iCityOwner = pCity:GetOwner();
	local pPlayer = Players[iCityOwner];

	-- For the rings 4 and 5,
	for i = 37, 90 do

		-- Grab the next plot
		local pPlot = pCity:GetCityIndexPlot(i);	
		
		-- If the plot is a real one,
		if (type(pPlot) ~= 'nil') then
		
			-- Get its info and set its validity to true (haven't disqualified it yet).
			local iPlotX = pPlot:GetX();
			local iPlotY = pPlot:GetY();
			local bValid = true;
			
			-- The plot is invalid if it's not Australia's or if it's not land.
			if (pPlot:GetOwner() ~= iCityOwner) or (pPlot:IsWater() == true) then
				bValid = false;
			end

			-- Invalid if it has already been added from another city. (The next(tTiles) term just avoids the issue of trying to loop through an empty array)
			if bValid and (next(tTiles) ~= nil) then
				for j = 1, #tTiles do
					local tOtherPlot = tTiles[j];
					if (iPlotX == tOtherPlot[1]) and (iPlotY == tOtherPlot[2]) then
						bValid = false;
					end
				end
			end
			
			-- Invalid if it's too close to another city.
			if bValid then
				for pOtherCity in pPlayer:Cities() do
					pOtherCityPlot = pOtherCity:Plot();
					iOtherCityPlotX = pOtherCityPlot:GetX();
					iOtherCityPlotY = pOtherCityPlot:GetY();

					if (Map.PlotDistance(iPlotX, iPlotY, iOtherCityPlotX, iOtherCityPlotY) < 4) then
						bValid = false;
					end
				end
			end
			
			-- Finally if it's still valid then we can add it on to the list.
			if bValid then
				tNewPlot = {};
				tNewPlot[1] = iPlotX;
				tNewPlot[2] = iPlotY;

				tTiles[#tTiles + 1] = tNewPlot;
			
			end
		end
	end
	return tTiles;
end

function CL_AussiePMTourism(iPlayer, iUnit)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() then
		local pUnit = pPlayer:GetUnitByID(iUnit);
		if pUnit:GetUnitType() == iPrimeMinister then
			for pCity in pPlayer:Cities() do
				if not pCity:IsPuppet() then
					if pCity:IsCoastal(10) then
						local iNumTiles = CL_GetNumTilesOutsideCityRadius(pCity);
						
					end
				end
			end
		end
	end
end

-- KUROUMA On PM creation, add tourism to coastal annexed cities. !!*Adds* 10 turns to the timer, rather than just setting it to 10!!
function KUROUMA_AussiePMTourism(iPlayer, iUnit)
	local pPlayer = Players[iPlayer];
	local tTileTable = {};
	local iPreviousTileCount = 0;
	local iCurrentTileCount = 0;
	local iTourismToAdd = 0;
	
	-- Alive,
	if pPlayer:IsAlive() then
	
		-- Is the PM,
		local pUnit = pPlayer:GetUnitByID(iUnit);
		if pUnit:GetUnitType() == iPrimeMinister then
		
			-- Every city,
			for pCity in pPlayer:Cities() do
				
				-- Not puppet,
				if not pCity:IsPuppet() then
					
					-- Is coastal, 
					if pCity:IsCoastal() then
					
						-- Look for new land tiles at the right radius and work out how many there are for this city.
						iPreviousTileCount = iCurrentTileCount;
						KUROUMA_GetUniqueTilesOutsideCityRadius(pCity, tTileTable);
						iCurrentTileCount = #tTileTable;
						iTourismToAdd = iCurrentTileCount - iPreviousTileCount;
						
						-- Add in the buildings as needed
						for	i = 1, 7 do
							pCity:SetNumRealBuilding(tAussiePMTourism[8 - i], iTourismToAdd % 2);
							iTourismToAdd = iTourismToAdd / 2;
						end
					end
				end
			end	
		end
	end
	
	-- Lol don't forget this
	iTourismTurns = iTourismTurns + 10;
end

function CL_AussiePMTourismCountdown(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iAussieCiv then
		for pCity in pPlayer:Cities() do
			for k, v in pairs(tAussiePMTourismTimer) do
				if k == pCity:GetID() then
					if v > 0 then
						v = v - 1;
					else
						for j, w in pairs(tAussiePMTourism) do
							pCity:SetNumRealBuilding(w, 0);
						end
					end
				end
			end
		end
	end
end

-- KUROUMA At the moment, there is a global counter that will run out after 10 turns. Getting another PM extends this time by 10 turns, and could possibly change the tourism amount if your borders have changed in this time.
function KUROUMA_AussiePMTourismCountdown(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iAussieCiv then
		if iTourismTurns > 0 then
			iTourismTurns = iTourismTurns - 1;
		end
		else
			for pCity in pPlayer:Cities() do
				for	k, v in pairs(tAussiePMTourism) do
					pCity:SetNumRealBuilding(v, 0);
				end
			end
		end
	end
end

function CL_AussieCityCaptured(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:GetCivilizationType() == iAussieCiv then
		for k, v in pairs(tAussiePMTourism) do
			pCity:SetNumRealBuilding(v, 0);
		end
	end
end

-- My modifications.
Events.SerialEventUnitCreated.Add(KUROUMA_AussiePMTourism);
GameEvents.PlayerDoTurn.Add(KUROUMA_AussiePMTourismCountdown);

--Events.SerialEventUnitCreated.Add(CL_AussiePMTourism);
--GameEvents.PlayerDoTurn.Add(CL_AussiePMTourismCountdown);
GameEvents.CityCaptureComplete.Add(CL_AussieCityCaptured);