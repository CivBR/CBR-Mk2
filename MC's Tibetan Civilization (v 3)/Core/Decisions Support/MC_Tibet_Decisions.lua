-- Tibetan Decisions
-- Author: Sukritact
--=======================================================================================================================

print("More Civs' Tibetan Decisions: loaded")

--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Tibet: Encourage Yak Breeding
-------------------------------------------------------------------------------------------------------------------------
local Decisions_TibetanYaks = {}
    Decisions_TibetanYaks.Name = "TXT_KEY_DECISIONS_TIBETANYAKS"
	Decisions_TibetanYaks.Desc = "TXT_KEY_DECISIONS_TIBETANYAKS_DESC"
	HookDecisionCivilizationIcon(Decisions_TibetanYaks, "CIVILIZATION_MC_TIBET")
	Decisions_TibetanYaks.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_TIBET then return false, false end
		if load(pPlayer, "Decisions_TibetanYaks") == true then
			Decisions_TibetanYaks.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TIBETANYAKS_ENACTED_DESC")
			return false, false, true
		end
		
		local iImprovement = pPlayer:GetImprovementCount(GameInfoTypes.IMPROVEMENT_PASTURE)
		local iMountain = 0
		local iPlayer = pPlayer:GetID()
		for pCity in pPlayer:Cities() do
			for iPlot = 0, pCity:GetNumCityPlots() - 1, 1 do
				local pAdjacentPlot = pCity:GetCityIndexPlot(iPlot)
				if ((pAdjacentPlot:IsMountain()) and (pAdjacentPlot:GetOwner() == iPlayer)) then iMountain = iMountain + 1 end
			end
		end
		iTotal = iMountain + iImprovement
		
		local iFood = math.ceil(30 * iMod * iTotal)
		local iProd = math.ceil(20 * iMod * iTotal)
		
		Decisions_TibetanYaks.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TIBETANYAKS_DESC", iFood, iProd)
		
		if (pPlayer:GetCurrentEra() >= GameInfoTypes.ERA_INDUSTRIAL) then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end		
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_ANIMAL_HUSBANDRY)) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_TibetanYaks.DoFunc = (
	function(pPlayer)
	
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
	
		local iImprovement = pPlayer:GetImprovementCount(GameInfoTypes.IMPROVEMENT_PASTURE)
		local iMountain = 0
		local iPlayer = pPlayer:GetID()
		for pCity in pPlayer:Cities() do
			for iPlot = 0, pCity:GetNumCityPlots() - 1, 1 do
				local pAdjacentPlot = pCity:GetCityIndexPlot(iPlot)
				if ((pAdjacentPlot:IsMountain()) and (pAdjacentPlot:GetOwner() == iPlayer)) then iMountain = iMountain + 1 end
			end
		end
		iTotal = iMountain + iImprovement
		
		local iFood = math.ceil(8 * iMod * iTotal)
		local iProd = math.ceil(5 * iMod * iTotal)
		
		for pCity in pPlayer:Cities() do
			pCity:ChangeFood(iFood)
			pCity:SetOverflowProduction(pCity:GetOverflowProduction() + iProd)
		end	
		
		save(pPlayer, "Decisions_TibetanYaks", true)
	end
	)
	
	Decisions_TibetanYaks.Monitors = {}
	Decisions_TibetanYaks.Monitors[LuaEvents.PlayerEnteredNewEra] =  (
	function(iPlayer)
		local pPlayer = Players[iPlayer]

		if (pPlayer:GetCurrentEra() >= GameInfoTypes.ERA_INDUSTRIAL) then return end		
		if load(pPlayer, "Decisions_TibetanYaks") then
			save(pPlayer, "Decisions_TibetanYaks", false)
		end
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_TIBET, "Decisions_TibetanYaks", Decisions_TibetanYaks)
-------------------------------------------------------------------------------------------------------------------------
-- Tibet: Construct the Potala Palace
-------------------------------------------------------------------------------------------------------------------------
local Decisions_TibetanPotala = {}
    Decisions_TibetanPotala.Name = "TXT_KEY_DECISIONS_TIBETANPOTALA"
	Decisions_TibetanPotala.Desc = "TXT_KEY_DECISIONS_TIBETANPOTALA_DESC"
	HookDecisionCivilizationIcon(Decisions_TibetanPotala, "CIVILIZATION_MC_TIBET")
	Decisions_TibetanPotala.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_TIBET then return false, false end
		if load(pPlayer, "Decisions_TibetanPotala") == true then
			Decisions_TibetanPotala.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TIBETANPOTALA_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(800 * iMod)
		Decisions_TibetanPotala.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TIBETANPOTALA_DESC", iCost)
		
		if (pPlayer:GetGold() < iCost) then	return true, false end		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetNumCities() > pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_MC_TIBET_CHORTEN)) then return true, false end
		if (pPlayer:GetCurrentEra() < GameInfoTypes.ERA_MEDIEVAL) then return true, false end
		if not(GetPlayerMajorityReligion(pPlayer)) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_TibetanPotala.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(800 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_TIBETANPOTALA, true)		
		
		save(pPlayer, "Decisions_TibetanPotala", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_TIBET, "Decisions_TibetanPotala", Decisions_TibetanPotala)
--=======================================================================================================================
--=======================================================================================================================