--------------------
--Colonialist Legacies' Australia
--Support for Events & Decisions
--FramedArchitecture
--------------------

--------------------------------------------------------------------------------------------------------------------------
-- Australia: Move Capital (Text strings  not included; civ Key may be incorrect.)
--------------------------------------------------------------------------------------------------------------------------
local Decisions_AustraliaMoveCapital = {}
    Decisions_AustraliaMoveCapital.Name = "TXT_KEY_DECISIONS_CL_AUSTRALIA_MOVE_CAPITAL"
	Decisions_AustraliaMoveCapital.Desc = "TXT_KEY_DECISIONS_CL_AUSTRALIA_MOVE_CAPITAL_DESC"
	HookDecisionCivilizationIcon(Decisions_AustraliaMoveCapital, "CIVILIZATION_CL_AUSTRALIA")
	
	Decisions_AustraliaMoveCapital.CanFunc = (
	function(pPlayer)
		
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_CL_AUSTRALIA then return false, false end
	
		if load(pPlayer, "Decisions_AustraliaMoveCapital") == true then
			Decisions_AustraliaMoveCapital.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CL_AUSTRALIA_MOVE_CAPITAL_ENACTED_DESC")
			return false, false, true
		end

		local iGoldCost = math.ceil(1000 * iMod)
		local iCultureCost = math.ceil(500 * iMod)

		Decisions_AustraliaMoveCapital.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_AUSTRALIA_MOVE_CAPITAL_DESC", iGoldCost, iCultureCost)
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetGold() < iGoldCost) then	return true, false end
		if (pPlayer:GetJONSCulture() < iCultureCost) then return true, false end

		local iFoundedCities = 0
		local playerID = pPlayer:GetID()
		for city in pPlayer:Cities() do
			if city:IsPuppet() then
				 return true, false
			elseif (city:GetOriginalOwner() == playerID) then
				iFoundedCities = iFoundedCities + 1
			end
		end
		if (iFoundedCities < 4) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_AustraliaMoveCapital.DoFunc = (
	function(pPlayer)
		
		local cities = {}
		local playerID = pPlayer:GetID()
		for city in pPlayer:Cities() do
			if city:GetOriginalOwner() == playerID then
				table.insert(cities, {city=city, founded=city:GetGameTurnFounded()})
			end
		end

		if #cities > 3 then
			table.sort(cities, function(x, y) return (x.founded < y.founded) end)

			local target = cities[4]
			for i = #cities, 1, -1 do
				if target.founded ~= cities[i].founded then
					table.remove(cities, i)
				end
			end

			local targetcity = target.city
			if #cities > 1 then
				targetcity = cities[math.random(#cities)].city
			end

			local capital = pPlayer:GetCapitalCity()
			local targetcityID = targetcity:GetID()

			local bSwap = false
			local greatWorkIndex = capital:GetBuildingGreatWork(GameInfoTypes.BUILDINGCLASS_PALACE, 0);
			if (greatWorkIndex >= 0) then
				targetcity:SetNumRealBuilding(GameInfoTypes.BUILDING_CL_AUSTRALIA_TEMP_ART_HOLDER, 1)
				Network.SendMoveGreatWorks(playerID, capital:GetID(), GameInfoTypes.BUILDINGCLASS_PALACE, 0, targetcityID, GameInfoTypes.BUILDINGCLASS_TEMP_ART_HOLDER, 0)
				bSwap = true
			end
			
			
			capital:SetNumRealBuilding(GameInfoTypes.BUILDING_PALACE, 0)
			targetcity:SetNumRealBuilding(GameInfoTypes.BUILDING_PALACE, 1)

			if bSwap then
				Network.SendMoveGreatWorks(playerID, targetcityID, GameInfoTypes.BUILDINGCLASS_TEMP_ART_HOLDER, 0, targetcityID, GameInfoTypes.BUILDINGCLASS_PALACE, 0)
				targetcity:SetNumRealBuilding(GameInfoTypes.BUILDING_CL_AUSTRALIA_TEMP_ART_HOLDER, 0)
			end
		end

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_CL_AUSTRALIA_MOVE_CAPITAL, true)

		local iGoldCost = math.ceil(1000 * iMod)
		local iCultureCost = math.ceil(500 * iMod)

		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		save(pPlayer, "Decisions_AustraliaMoveCapital", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_CL_AUSTRALIA, "Decisions_AustraliaMoveCapital", Decisions_AustraliaMoveCapital)


--------------------------------------------------------------------------------------------------------------------------
-- Australia: Dingo Fence (Text strings  not included; civ Key may be incorrect.)
--------------------------------------------------------------------------------------------------------------------------
local Decisions_AustraliaDingoFence = {}
    Decisions_AustraliaDingoFence.Name = "TXT_KEY_DECISIONS_CL_AUSTRALIA_DINGO_FENCE"
	Decisions_AustraliaDingoFence.Desc = "TXT_KEY_DECISIONS_CL_AUSTRALIA_DINGO_FENCE_DESC"
	HookDecisionCivilizationIcon(Decisions_AustraliaDingoFence, "CIVILIZATION_CL_AUSTRALIA")
	
	Decisions_AustraliaDingoFence.CanFunc = (
	function(pPlayer)
		
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_CL_AUSTRALIA then return false, false end
	
		if load(pPlayer, "Decisions_AustraliaDingoFence") == true then
			Decisions_AustraliaDingoFence.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CL_AUSTRALIA_DINGO_FENCE_ENACTED_DESC")
			return false, false, true
		end

		local iGoldCost = math.ceil(200 * iMod)
		
		Decisions_AustraliaDingoFence.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CL_AUSTRALIA_DINGO_FENCE_DESC", iGoldCost)
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (pPlayer:GetGold() < iGoldCost) then	return true, false end
		if (pPlayer:GetImprovementCount(GameInfoTypes.IMPROVEMENT_PASTURE) < 5) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_AustraliaDingoFence.DoFunc = (
	function(pPlayer)
		
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_CL_AUSTRALIA_DINGO_FENCE, true)

		local iGoldCost = math.ceil(1000 * iMod)
	
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		save(pPlayer, "Decisions_AustraliaDingoFence", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_CL_AUSTRALIA, "Decisions_AustraliaDingoFence", Decisions_AustraliaDingoFence)