--------------------------------------------------------------------------------------------------------------------------
-- Hawaii: Establish the Pa Ku'ialua
--------------------------------------------------------------------------------------------------------------------------
local Decisions_HawaiiPaKuialua = {}
    Decisions_HawaiiPaKuialua.Name = "TXT_KEY_DECISIONS_HAWAIIPAKUIALUA"
	HookDecisionCivilizationIcon(Decisions_HawaiiPaKuialua, "CIVILIZATION_POLYNESIA")
	Decisions_HawaiiPaKuialua.Desc = "TXT_KEY_DECISIONS_HAWAIIPAKUIALUA_DESC"
	Decisions_HawaiiPaKuialua.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_POLYNESIA"]) then return false, false end
		if load(pPlayer, "Decisions_HawaiiPaKuialua") == true then
			Decisions_HawaiiPaKuialua.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HAWAIIPAKUIALUA_ENACTED_DESC")
			return false, false, true
		end
		
		local iCult = math.ceil(100 * iMod)
		local iGold = math.ceil(200 * iMod)

		Decisions_HawaiiPaKuialua.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HAWAIIPAKUIALUA_DESC", iCult, iGold)
		
		if (pPlayer:GetJONSCulture() < iCult) then return true, false end
		if (pPlayer:GetGold() < iGold) then	return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_EDUCATION)) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_HawaiiPaKuialua.DoFunc = (
	function(pPlayer)
		local iCult = math.ceil(100 * iMod)
		local iGold = math.ceil(200 * iMod)
		
		pPlayer:ChangeJONSCulture(-iCult)
		pPlayer:ChangeGold(-iGold)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		
		Decisions_HawaiiPaKuialua.Monitors[GameEvents.PlayerDoTurn](pPlayer:GetID())
		
		save(pPlayer, "Decisions_HawaiiPaKuialua", true)
	end
	)
	
	Decisions_HawaiiPaKuialua.Monitors = {}
	Decisions_HawaiiPaKuialua.Monitors[GameEvents.PlayerDoTurn] = (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if not(load(pPlayer, "Decisions_HawaiiPaKuialua") == true) then return end
		
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(GameInfoTypes.BUILDING_UNIVERSITY) then
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_HAWAIIPAKUIALUA, 1)
			else
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_HAWAIIPAKUIALUA, 0)
			end
		end
	end
	)
	
	Decisions_HawaiiPaKuialua.Monitors[Events.SerialEventCityInfoDirty] = (
	function()
		local iPlayer = Game.GetActivePlayer()
		local pPlayer = Players[iPlayer]
		if pPlayer:IsTurnActive() then
			Decisions_HawaiiPaKuialua.Monitors[GameEvents.PlayerDoTurn](iPlayer)
		end	
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_POLYNESIA"], "Decisions_HawaiiPaKuialua", Decisions_HawaiiPaKuialua)

--------------------------------------------------------------------------------------------------------------------------
-- Hawaii: Kanawai Mamalahoe
--------------------------------------------------------------------------------------------------------------------------
Decisions_PolynesiaPaddle = nil
tDecisions.Decisions_PolynesiaPaddle = nil

local Decisions_PolynesiaPaddle = {}
	Decisions_PolynesiaPaddle.Name = "TXT_KEY_DECISIONS_POLYNESIAPADDLE"
	Decisions_PolynesiaPaddle.Desc = "TXT_KEY_DECISIONS_POLYNESIAPADDLE_DESC"
	HookDecisionCivilizationIcon(Decisions_PolynesiaPaddle, "CIVILIZATION_POLYNESIA")
	Decisions_PolynesiaPaddle.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_POLYNESIA) then
			return false, false
		end
		if load(pPlayer, "Decisions_PolynesiaPaddle") == true then
			Decisions_PolynesiaPaddle.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_POLYNESIAPADDLE_ENACTED_DESC")
			return false, false, true
		end
		
		local iNumUnits = 0
		for pUnit in pPlayer:Units() do
			if pUnit:IsCombatUnit() then
				iNumUnits = iNumUnits + 1
			end
		end
		local iCost = math.ceil(100 * iMod)
		local iTurns = math.ceil(10 * iGAMod)
		if iNumUnits < 5 then
			Decisions_PolynesiaPaddle.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_POLYNESIAPADDLE_DESC", iCost, iTurns)
			return true, false
		end
		iCost = math.ceil(20 * iNumUnits * iMod)
		iTurns = math.ceil(iNumUnits * 2 * iGAMod)
		Decisions_PolynesiaPaddle.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_POLYNESIAPADDLE_DESC", iCost, iTurns)

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (pPlayer:GetGold() >= iCost) then
			return true, true
		else
			return true, false
		end
	end
	)
	
	Decisions_PolynesiaPaddle.DoFunc = (
	function(pPlayer)
		local iNumUnits = pPlayer:GetNumMilitaryUnits()
		local iCost = math.ceil(20 * iNumUnits * iMod)
		local iTurns = math.ceil(iNumUnits * 2 * iGAMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:ChangeGoldenAgeTurns(iTurns)
		save(pPlayer, "Decisions_PolynesiaPaddle", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_POLYNESIA, "Decisions_PolynesiaPaddle", Decisions_PolynesiaPaddle)

--------------------------------------------------------------------------------------------------------------------------
-- Maori: Revive the Runanga
--------------------------------------------------------------------------------------------------------------------------
Decisions_PolynesiaRunanga = nil
tDecisions.Decisions_PolynesiaRunanga = nil

local Decisions_PolynesiaRunanga = {}
	Decisions_PolynesiaRunanga.Name = "TXT_KEY_DECISIONS_POLYNESIARUNANGA"
	Decisions_PolynesiaRunanga.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_POLYNESIARUNANGA_DESC")
	HookDecisionCivilizationIcon(Decisions_PolynesiaRunanga, "CIVILIZATION_MC_MAORI")
	Decisions_PolynesiaRunanga.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_MAORI) then
			return false, false
		end
		if load(pPlayer, "Decisions_PolynesiaRunanga") == true then
			Decisions_PolynesiaRunanga.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_POLYNESIARUNANGA_ENACTED_DESC")
			return false, false, true
		end
		
		local iEra = pPlayer:GetCurrentEra()
		if not(iEra == GameInfoTypes.ERA_MODERN or iEra == GameInfoTypes.ERA_INDUSTRIAL) then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		
		local pCity = pPlayer:GetCapitalCity()
		if pCity == nil then return true, false end
		pMaoriUnit = nil
		local iPromotion = GameInfoTypes.PROMOTION_HAKA_WAR_DANCE
		local pPlot = pCity:Plot()
		local iNumUnits = pPlot:GetNumUnits()
		for iVal = 0,(iNumUnits - 1) do
			local pUnit = pPlot:GetUnit(iVal)
			if pUnit:IsHasPromotion(iPromotion) then
				pMaoriUnit = pUnit
				break
			end
		end
		
		if pMaoriUnit ~= nil then
			return true, true
		else
			return true, false
		end
	end
	)
	
	Decisions_PolynesiaRunanga.DoFunc = (
	function(pPlayer)
		pMaoriUnit:Kill()
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:ChangeNumFreePolicies(1)
		save(pPlayer, "Decisions_PolynesiaRunanga", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_MAORI, "Decisions_PolynesiaRunanga", Decisions_PolynesiaRunanga)


--------------------------------------------------------------------------------------------------------------------------
-- Maori: Gunfighter Pa
--------------------------------------------------------------------------------------------------------------------------
--------------------------Costs and Requirements
MC_GunfighterPa_RequiredPa = 3
MC_GunfighterPa_MagistrateCost = 1
------------------------------------------------


local Decisions_MC_Maori_Gunfighter_Pa = {}
	Decisions_MC_Maori_Gunfighter_Pa.Name = "TXT_KEY_DECISIONS_MAORI_GUNFIGHTER_PA"
	Decisions_MC_Maori_Gunfighter_Pa.Desc = "TXT_KEY_DECISIONS_MAORI_GUNFIGHTER_PA_DESC"
	HookDecisionCivilizationIcon(Decisions_MC_Maori_Gunfighter_Pa, "CIVILIZATION_MC_MAORI")
	Decisions_MC_Maori_Gunfighter_Pa.Weight = nil
	Decisions_MC_Maori_Gunfighter_Pa.CanFunc = (
		function(pPlayer)	
			-- Check Civ
			if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_MC_MAORI"]) then return false, false end
			-- Check if the decision has been enacted before
			if load(pPlayer, "Decisions_MC_Maori_Gunfighter_Pa") == true then
				Decisions_MC_Maori_Gunfighter_Pa.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAORI_GUNFIGHTER_PA_ENACTED_DESC")
				return false, false, true
			end	
			-- Requirements
			
			---- Science
			local iCost = math.ceil(pPlayer:GetResearchCost(GameInfoTypes.TECH_CONSTRUCTION) * iMod)
			-- Build the Description		
			Decisions_MC_Maori_Gunfighter_Pa.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAORI_GUNFIGHTER_PA_DESC", MC_GunfighterPa_RequiredPa, MC_GunfighterPa_MagistrateCost, iCost)
			
			if (pPlayer:GetResearchProgress(pPlayer:GetCurrentResearch()) < iCost) then return true, false end
			
			---- Is at War
			local isWar = 0;
			for oPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
				local oPlayer = Players[oPlayer];
				if oPlayer ~= pPlayer then
					if (oPlayer:IsAlive()) then
						local oTeam = oPlayer:GetTeam();
						if Teams[pPlayer:GetTeam()]:IsAtWar(oTeam) then
							isWar = isWar + 1;
							break
						end
					end
				end
			end
			if isWar <= 0 then return true, false end
			---- At least X Pa improvements
			nPa = 0
			for pCity in pPlayer:Cities() do
				local i;
				for i = 0, pCity:GetNumCityPlots() - 1, 1 do
					local plot = pCity:GetCityIndexPlot( i );
					if (plot ~= nil) then
						if ( plot:GetOwner() == pCity:GetOwner() ) then
							local ImpID = plot:GetImprovementType()
							if ImpID == GameInfoTypes.IMPROVEMENT_MC_MAORI_PA then
								nPa = nPa + 1
							end
						end
					end
				end
			end
			if nPa < MC_GunfighterPa_RequiredPa then return true, false end
			---- Gunpowder
			if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_GUNPOWDER)) then return true, false end
			-- Costs
			---- Magistrates
			if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < MC_GunfighterPa_MagistrateCost) then return true, false end	
			
			-- Allow the decision!
			return true, true
		end
	)
	
	Decisions_MC_Maori_Gunfighter_Pa.DoFunc = (
	function(pPlayer)
		-- Remove Magistrates
		pPlayer:ChangeNumResourceTotal(iMagistrate, -MC_GunfighterPa_MagistrateCost)
		-- Remove Science
		local iCost = math.ceil(pPlayer:GetResearchCost(GameInfoTypes.TECH_CONSTRUCTION) * iMod)
		local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
		pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), -iCost, pPlayer:GetID())
		-- Change the name of Pa
		ChangePaName()
		-- refresh UI texts
		Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type )
		-- Save the Decision
		save(pPlayer, "Decisions_MC_Maori_Gunfighter_Pa", true)
		-- Grant promotion if any unit is on top
		PaPromotion()
	end
	)
------------------------------------------------
-- Monitors
------------------------------------------------
	
	Decisions_MC_Maori_Gunfighter_Pa.Monitors = {}
	Decisions_MC_Maori_Gunfighter_Pa.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
	
		local iCivType = GameInfoTypes.CIVILIZATION_MC_MAORI
		local GunfighterPromo = GameInfoTypes.PROMOTION_MC_GUNFIGHTER
		local pPlayer = Players[iPlayer]
		
		if (pPlayer:IsAlive()) then
			if (pPlayer:GetCivilizationType() == iCivType) then
				if load(pPlayer, "Decisions_MC_Maori_Gunfighter_Pa") == true then
					for pUnit in pPlayer:Units() do
						local uPlot = pUnit:GetPlot();
						if uPlot ~= nil then
							if uPlot:GetImprovementType() == GameInfo.Improvements.IMPROVEMENT_MC_MAORI_PA.ID then
								if uPlot:IsImprovementPillaged() then
									pUnit:SetHasPromotion(GunfighterPromo,false);
								else
									pUnit:SetHasPromotion(GunfighterPromo,true);
								end
							else
								pUnit:SetHasPromotion(GunfighterPromo,false);
							end
						end
					end
				end
			end
		end	
		
	end
	)
	
	Decisions_MC_Maori_Gunfighter_Pa.Monitors[Events.LoadScreenClose] =  (
	function(arg0, currPlayer)
		for _, pPlayer in pairs(Players) do
			if (pPlayer:IsAlive()) then
				if load(pPlayer, "Decisions_MC_Maori_Gunfighter_Pa") == true then
			
					newDesc =  Locale.ConvertTextKey("TXT_KEY_MC_MAORI_GUNFIGHTER_PA");
					newBuild = Locale.ConvertTextKey("TXT_KEY_BUILD_MC_MAORI_GUNFIGHTER_PA")
					local tquery = {"UPDATE Language_en_US SET Text = '".. str .."' WHERE Tag = 'TXT_KEY_MC_MAORI_PA'",
					"UPDATE Language_en_US SET Text = '".. str .."' WHERE Tag = 'TXT_KEY_BUILD_MC_MAORI_PA'"}
					for i, iQuery in pairs(tquery) do
						for result in DB.Query(iQuery) do
						end
					end
			
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_MC_MAORI"], "Decisions_MC_Maori_Gunfighter_Pa", Decisions_MC_Maori_Gunfighter_Pa)

--------------------------------------------------------------------------------------------------------------------------
-- Rapa Nui: Huri-Moai
--------------------------------------------------------------------------------------------------------------------------
local Decisions_RapaNuiHuriMoai = {}
    Decisions_RapaNuiHuriMoai.Name = "TXT_KEY_DECISIONS_RAPANUIHURIMOAI"
	Decisions_RapaNuiHuriMoai.Desc = "TXT_KEY_DECISIONS_RAPANUIHURIMOAI_DESC"
	HookDecisionCivilizationIcon(Decisions_RapaNuiHuriMoai, "CIVILIZATION_MC_RAPA_NUI")
	Decisions_RapaNuiHuriMoai.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_RAPA_NUI then return false, false end
		if load(pPlayer, "Decisions_RapaNuiHuriMoai") == true then
			Decisions_RapaNuiHuriMoai.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RAPANUIHURIMOAI_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(400 * iMod)
		local iDiscount = math.ceil(30 * iMod)
		local iNumMoai = pPlayer:GetImprovementCount(GameInfoTypes.IMPROVEMENT_MOAI)
		
		iCost = iCost - (iNumMoai * iDiscount)
		if iCost < (150 * iMod) then iCost = (150 * iMod) end
		
		Decisions_RapaNuiHuriMoai.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RAPANUIHURIMOAI_DESC", iCost)
		
		if iNumMoai < 5 then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if not(pPlayer:GetCurrentEra() == GameInfoTypes.ERA_CLASSICAL or pPlayer:GetCurrentEra() == GameInfoTypes.ERA_MEDIEVAL) then return true, false end
		if (pPlayer:GetGold() < iCost) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_RapaNuiHuriMoai.DoFunc = (
	function(pPlayer)
	
		local iCost = math.ceil(400 * iMod)
		local iDiscount = math.ceil(30 * iMod)
		local iNumMoai = pPlayer:GetImprovementCount(GameInfoTypes.IMPROVEMENT_MOAI)
		
		iCost = iCost - (iNumMoai * iDiscount)
		if iCost < (150 * iMod) then iCost = (150 * iMod) end
	
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		
		local iNum = 0
		for pCity in pPlayer:Cities() do
			for iPlot = 0, pCity:GetNumCityPlots() - 1, 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				if pPlot:GetImprovementType() == GameInfoTypes.IMPROVEMENT_MOAI and pPlot:GetOwner() == pPlayer:GetID() then
					iNum = iNum + 1
					
					if iNum == 1 then
						Players[63]:InitUnit(GameInfoTypes.UNIT_MC_RAPA_NUI_MATATOA, pPlot:GetX(), pPlot:GetY())
					elseif iNum == 3 then
						iNum = 0
					end
				end
			end
		end
		
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_RAPANUIHURIMOAI, true)
		
		save(pPlayer, "Decisions_RapaNuiHuriMoai", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_RAPA_NUI, "Decisions_RapaNuiHuriMoai", Decisions_RapaNuiHuriMoai)

--------------------------------------------------------------------------------------------------------------------------
--  Rapa Nui: Construct Manavai
--------------------------------------------------------------------------------------------------------------------------
local Decisions_RapaNuiManavai = {}
    Decisions_RapaNuiManavai.Name = "TXT_KEY_DECISIONS_RAPANUIMANAVAI"
	Decisions_RapaNuiManavai.Desc = "TXT_KEY_DECISIONS_RAPANUIMANAVAI_DESC"
	HookDecisionCivilizationIcon(Decisions_RapaNuiManavai, "CIVILIZATION_MC_RAPA_NUI")
	Decisions_RapaNuiManavai.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_RAPA_NUI then return false, false end
		if load(pPlayer, "Decisions_RapaNuiManavai") == true then
			Decisions_RapaNuiManavai.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RAPANUIMANAVAI_ENACTED_DESC")
			return false, false, true
		end
		
		iCost = math.ceil(600 * iMod)
		Decisions_RapaNuiManavai.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RAPANUIMANAVAI_DESC", iCost)
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_STONE_WORKS) < 1) then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_CHEMISTRY)) then return true, false end
		if (pPlayer:GetResearchProgress(pPlayer:GetCurrentResearch()) < iCost) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_RapaNuiManavai.DoFunc = (
	function(pPlayer)
		iCost = math.ceil(600 * iMod)
		
		local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
		pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), -iCost, pPlayer:GetID())
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_RAPANUIMANAVAI, true)
		
		save(pPlayer, "Decisions_RapaNuiManavai", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_RAPA_NUI, "Decisions_RapaNuiManavai", Decisions_RapaNuiManavai)

--------------------------------------------------------------------------------------------------------------------------
--  Tonga: Promote the Tui Takalaua
--------------------------------------------------------------------------------------------------------------------------

local Decisions_TongaTakalaua = {}
    Decisions_TongaTakalaua.Name = "TXT_KEY_DECISIONS_TONGATAKALAUA"
	Decisions_TongaTakalaua.Desc = "TXT_KEY_DECISIONS_TONGATAKALAUA_DESC"
	HookDecisionCivilizationIcon(Decisions_TongaTakalaua, "CIVILIZATION_MC_TONGA")
	Decisions_TongaTakalaua.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_TONGA then return false, false end
		if load(pPlayer, "Decisions_TongaSupport") == "Decisions_TongaTakalaua" then
			Decisions_TongaTakalaua.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TONGATAKALAUA_ENACTED_DESC")
			return false, false, true
		end

		Decisions_TongaTakalaua.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TONGATAKALAUA_DESC")
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if pPlayer:GetNumPolicyBranchesFinished() < 1 then return true, false end
		
		return true, true
	end
	)
	
	Decisions_TongaTakalaua.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:GetCapitalCity():ChangeResistanceTurns(5)
		
		Decisions_TongaTakalaua.Monitors[GameEvents.PlayerDoTurn](pPlayer:GetID())
		
		save(pPlayer, "Decisions_TongaSupport", "Decisions_TongaTakalaua")
	end
	)
	
	Decisions_TongaTakalaua.Monitors = {}
	Decisions_TongaTakalaua.Monitors[GameEvents.PlayerDoTurn] = (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		
		local sSupported = load(pPlayer, "Decisions_TongaSupport")
		if not(sSupported) then return end
		local bDomestic = (sSupported == "Decisions_TongaTakalaua")

		local pPlayer = Players[iPlayer]
		local tTradeRoutes = pPlayer:GetTradeRoutes()
		
		local iBuildingA; local iBuildingB
		if bDomestic then
			iBuildingA = GameInfoTypes.BUILDING_DECISIONS_TONGATAKALAUA; iBuildingB = GameInfoTypes.BUILDING_DECISIONS_KANOKUPOLU
		else
			iBuildingA = GameInfoTypes.BUILDING_DECISIONS_KANOKUPOLU; iBuildingB = GameInfoTypes.BUILDING_DECISIONS_TONGATAKALAUA
		end
		
		local tCities = {}
		for iRoute, tRoute in pairs(tTradeRoutes) do
			if bDomestic then
				if tRoute.FromID == tRoute.ToID then tCities[tRoute.FromCity] = true end
			else
				if tRoute.FromID ~= tRoute.ToID then tCities[tRoute.FromCity] = true  end
			end
		end
		
		for pCity in pPlayer:Cities() do
			if tCities[pCity] then
				pCity:SetNumRealBuilding(iBuildingA, 1)
				pCity:SetNumRealBuilding(iBuildingB, 0)
			else
				pCity:SetNumRealBuilding(iBuildingA, 0)
				pCity:SetNumRealBuilding(iBuildingB, 0)
			end
		end
	end
	)
	
	Decisions_TongaTakalaua.Monitors[Events.SerialEventGameDataDirty] = (
	function()
		local iPlayer = Game.GetActivePlayer()
		local pPlayer = Players[iPlayer]
		if pPlayer:IsTurnActive() then
			Decisions_TongaTakalaua.Monitors[GameEvents.PlayerDoTurn](iPlayer)
		end	
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_TONGA, "Decisions_TongaTakalaua", Decisions_TongaTakalaua)


--------------------------------------------------------------------------------------------------------------------------
--  Tonga: Promote the Tui Kanokupolu
--------------------------------------------------------------------------------------------------------------------------

local Decisions_TongaKanokupolu = {}
    Decisions_TongaKanokupolu.Name = "TXT_KEY_DECISIONS_TONGAKANOKUPOLU"
	Decisions_TongaKanokupolu.Desc = "TXT_KEY_DECISIONS_TONGAKANOKUPOLU_DESC"
	HookDecisionCivilizationIcon(Decisions_TongaKanokupolu, "CIVILIZATION_MC_TONGA")
	Decisions_TongaKanokupolu.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_TONGA then return false, false end
		if load(pPlayer, "Decisions_TongaSupport") == "Decisions_TongaKanokupolu" then
			Decisions_TongaKanokupolu.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TONGAKANOKUPOLU_ENACTED_DESC")
			return false, false, true
		end
		
		Decisions_TongaKanokupolu.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TONGAKANOKUPOLU_DESC")
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if pPlayer:GetNumPolicyBranchesFinished() < 1 then return true, false end
		
		return true, true
	end
	)
	
	Decisions_TongaKanokupolu.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:GetCapitalCity():ChangeResistanceTurns(5)
		
		for eEvent, fFunc in pairs(Decisions_TongaTakalaua.Monitors) do
			eEvent.Remove(fFunc)
			eEvent.Add(fFunc)
		end		
		Decisions_TongaTakalaua.Monitors[GameEvents.PlayerDoTurn](pPlayer:GetID())
		
		load("GAME", "Decisions_TongaTakalaua" .. "_Monitors", true) 
		save(pPlayer, "Decisions_TongaSupport", "Decisions_TongaKanokupolu")
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_TONGA, "Decisions_TongaKanokupolu", Decisions_TongaKanokupolu)

--------------------------------------------------------------------------------------------------------------------------
-- Tonga: Write the Vava'u Code
--------------------------------------------------------------------------------------------------------------------------
local Decisions_TongaVavauCode = {}
    Decisions_TongaVavauCode.Name = "TXT_KEY_DECISIONS_TONGAVAVAUCODE"
        HookDecisionCivilizationIcon(Decisions_TongaVavauCode, "CIVILIZATION_MC_TONGA")
        Decisions_TongaVavauCode.Desc = "TXT_KEY_DECISIONS_TONGAVAVAUCODE_DESC"
        Decisions_TongaVavauCode.CanFunc = (
        function(pPlayer)
                if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_MC_TONGA"]) then return false, false end
                if load(pPlayer, "Decisions_TongaVavauCode") == true then
                        Decisions_TongaVavauCode.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TONGAVAVAUCODE_ENACTED_DESC")
                        return false, false, true
                end
               
                local iCult = math.ceil(100 * iMod)
                local iGold = math.ceil(100 * iMod)
 
                Decisions_TongaVavauCode.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TONGAVAVAUCODE_DESC", iCult, iGold)
               
                if (pPlayer:GetJONSCulture() < iCult) then return true, false end
                if (pPlayer:GetGold() < iGold) then return true, false end
		if (pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_COURTHOUSE) < 1) then return true, false end
                if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
                if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_MATHEMATICS)) then return true, false end
               
                return true, true
        end
        )
       
        Decisions_TongaVavauCode.DoFunc = (
        function(pPlayer)
                local iCult = math.ceil(100 * iMod)
                local iGold = math.ceil(100 * iMod)
               
                pPlayer:ChangeJONSCulture(-iCult)
                pPlayer:ChangeGold(-iGold)
                pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
               
                Decisions_TongaVavauCode.Monitors[GameEvents.PlayerDoTurn](pPlayer:GetID())
               
                save(pPlayer, "Decisions_TongaVavauCode", true)
        end
        )
       
        Decisions_TongaVavauCode.Monitors = {}
        Decisions_TongaVavauCode.Monitors[GameEvents.PlayerDoTurn] = (
        function(iPlayer)
                local pPlayer = Players[iPlayer]
                if not(load(pPlayer, "Decisions_TongaVavauCode") == true) then return end
               
                for pCity in pPlayer:Cities() do
                        if pCity:IsHasBuilding(GameInfoTypes.BUILDING_COURTHOUSE) then
                                pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_TONGAVAVAUCODE, 1)
                        else
                                pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_TONGAVAVAUCODE, 0)
                        end
                end
        end
        )
       
        Decisions_TongaVavauCode.Monitors[Events.SerialEventCityInfoDirty] = (
        function()
                local iPlayer = Game.GetActivePlayer()
                local pPlayer = Players[iPlayer]
                if pPlayer:IsTurnActive() then
                        Decisions_TongaVavauCode.Monitors[GameEvents.PlayerDoTurn](iPlayer)
                end    
        end
        )
       
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_MC_TONGA"], "Decisions_TongaVavauCode", Decisions_TongaVavauCode)