-- FutureLua
-- Author: user
-- DateCreated: 4/15/2015 9:16:51 AM
--------------------------------------------------------------

print("Future Worlds code loaded")

include("MischaIteratingPlotsFunctions")

local iImprovementAcademy = GameInfoTypes.IMPROVEMENT_ACADEMY
local iImprovementHERC = GameInfoTypes.IMPROVEMENT_FW_HERC
local iImprovementNode = GameInfoTypes.IMPROVEMENT_FW_NETWORK_NODE
local iImprovementCore = GameInfoTypes.IMPROVEMENT_FW_CORE
local iImprovementPreserve = GameInfoTypes.IMPROVEMENT_FW_PRESERVE
local iImprovementBiowell = GameInfoTypes.IMPROVEMENT_FW_BIOWELL
local iImprovementMutacology = GameInfoTypes.IMPROVEMENT_FW_MUTACOLOGY
local iImprovementGenerator = GameInfoTypes.IMPROVEMENT_FW_GENERATOR
local iImprovementCommArray = GameInfoTypes.IMPROVEMENT_FW_COMM_ARRAY
local iImprovementIndustrialComplex = GameInfoTypes.IMPROVEMENT_FW_INDUSTRIAL_COMPLEX
local iImprovementDome = GameInfoTypes.IMPROVEMENT_FW_HYDROPONICS_DOME

local iBuildingAccelerator = GameInfoTypes.BUILDING_FW_ACCELERATOR
local iBuildingAcceleratorClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_ACCELERATOR.ID
local iBuildingSkynetClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_SKYNET.ID
local iBuildingSanctuary = GameInfoTypes.BUILDING_FW_SANCTUARY
local iBuildingChimeralGarden = GameInfoTypes.BUILDING_FW_CHIMERAL_GARDEN
local iBuildingDroneHive = GameInfoTypes.BUILDING_FW_DRONE_HIVE
local iBuildingFeedsiteNode = GameInfoTypes.BUILDING_FW_FEEDSITE_NODE
local iBuildingFeedsiteHub = GameInfoTypes.BUILDING_FW_FEEDSITE_HUB
local iBuildingColosseum = GameInfoTypes.BUILDING_COLOSSEUM
local iBuildingTheatre = GameInfoTypes.BUILDING_THEATRE
local iBuildingStadium = GameInfoTypes.BUILDING_STADIUM
local iBuildingPholusMutagen = GameInfoTypes.BUILDING_FW_PHOLUS_MUTAGEN
local iBuildingPholusMutagenClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_PHOLUS_MUTAGEN.ID
local iBuildingGeneVault = GameInfoTypes.BUILDING_FW_GENE_VAULT
local iBuildingGeneVaultClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_GENE_VAULT.ID
local iBuildingLaunchFacilityClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_LAUNCH_FACILITY.ID
local iBuildingNephilimGeneTemplateClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_NEPHILIM_GENE_TEMPLATE.ID
local iBuildingNephilimGeneTemplateDummy = GameInfoTypes.BUILDING_FW_NEPHILIMGENETEMPLATE_DUMMY
local iBuildingAngelnetClass = GameInfo.BuildingClasses.BUILDINGCLASS_FW_ANGELNET.ID
local iBuildingUtilityFog = GameInfoTypes.BUILDING_UTILITY_FOG

local iPrereq1 = GameInfo.Technologies["TECH_NEURAL_INTERFACE"].ID

local iNodePromotion = GameInfoTypes.PROMOTION_FW_NETWORKED

function CityBuiltTest(iPlayer, iCity, iBuilding, bGold, bFaithOrCulture)
        if iBuilding == iBuildingAccelerator then
                local pPlayer = Players[iPlayer]
                local pCity = pPlayer:GetCityByID(iCity)
				local pPlot = pCity:Plot()
				local iCityX = pPlot:GetX()
				local iCityY = pPlot:GetY()
				for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					local iImprovement = pAdjacentPlot:GetImprovementType()
					local iOwner = pAdjacentPlot:GetOwner()
					if (iImprovement == iImprovementAcademy) and (iOwner == iPlayer) then
						pAdjacentPlot:SetImprovementType(iImprovementHERC)
					end
				end
        end
		if iBuilding == iBuildingPholusMutagen then
			local pPlayer = Players[iPlayer];
			for pCity in pPlayer:Cities() do
				local i;
				for i = 0, pCity:GetNumCityPlots() - 1, 1 do
					local pPlot = pCity:GetCityIndexPlot( i );
					if (pPlot ~= nil) then
						if ( pPlot:GetOwner() == pCity:GetOwner() ) then
							local ImpID = pPlot:GetImprovementType()
							if (ImpID == iImprovementBiowell) then
								pPlot:SetImprovementType(iImprovementMutacology)
							end
						end
					end
				end
			end
		end
end
GameEvents.CityConstructed.Add(CityBuiltTest)

function CheckImprovements (iHexX, iHexY, iContinent1, iContinent2)
	local pPlot = Map.GetPlot(ToGridFromHex(iHexX, iHexY))
	local ImpID = pPlot:GetImprovementType()
	local Owner = pPlot:GetOwner()
	local pPlayer = Players[Owner];
	if (pPlayer) then
		if (ImpID == iImprovementAcademy and (pPlayer:GetBuildingClassCount(iBuildingAcceleratorClass) > 0)) then
			pPlot:SetImprovementType(iImprovementHERC)
		end
		if (ImpID == iImprovementBiowell and (pPlayer:GetBuildingClassCount(iBuildingPholusMutagenClass) > 0)) then
			pPlot:SetImprovementType(iImprovementMutacology)
		end
	end
end
Events.SerialEventImprovementCreated.Add(CheckImprovements);


function OnUnitSetXY(iPlayer, iUnit, iX, iY)
	if Map.GetPlot(iX,iY) ~= nil then
		local pPlayer = Players[iPlayer];
		local teamID = pPlayer:GetTeam();
		local pTeam = Teams[teamID];
		if (pTeam:IsHasTech(iNodePrereq)) then
				local pPlot = Map.GetPlot(iX, iY);
				local pUnit = pPlayer:GetUnitByID(iUnit);
                local bNodePresent = false
				local iRadius = 2
				if (pPlayer:GetBuildingClassCount(iBuildingSkynetClass) > 0) then
					iRadius = 4
				end
				for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, iRadius, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					local iImprovement = pAdjacentPlot:GetImprovementType()
					local iOwner = pAdjacentPlot:GetOwner()
					if (iImprovement == iImprovementNode) and (iOwner == iPlayer) then
						bNodePresent = true
					end
				end
				if not (bNodePresent) then
					iRadius = iRadius + 2
					for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, iRadius, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						local iImprovement = pAdjacentPlot:GetImprovementType()
						local iOwner = pAdjacentPlot:GetOwner()
						if (iImprovement == iImprovementCore) and (iOwner == iPlayer) then
							bNodePresent = true
						end
					end
				end
                if bNodePresent then
                    pUnit:SetHasPromotion(iNodePromotion, true)
				else
					pUnit:SetHasPromotion(iNodePromotion, false)
                end
		end
	end
end
--GameEvents.UnitSetXY.Add(OnUnitSetXY)

function CheckNode (iHexX, iHexY, iContinent1, iContinent2)
	local pPlot = Map.GetPlot(ToGridFromHex(iHexX, iHexY))
	local ImpID = pPlot:GetImprovementType()
	local Owner = pPlot:GetOwner()
	local pPlayer = Players[Owner];
	if (ImpID == iImprovementNode) then
		
	end
end
Events.SerialEventImprovementCreated.Add(CheckNode);

function SanctuaryBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingSanctuary) then
			local iNumPreserves = 0
			local pPlot = pCity:Plot()
			for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				local iImprovement = pAdjacentPlot:GetImprovementType()
				local iOwner = pAdjacentPlot:GetOwner()
				if (iImprovement == iImprovementPreserve) and (iOwner == iPlayer) and (pCity:IsWorkingPlot(pAdjacentPlot)) then
					iNumPreserves = iNumPreserves + 1
				end
			end
			if iNumPreserves > 4 then
				iNumPreserves = 4
			end
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_SANCTUARY_DUMMY"], iNumPreserves)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_SANCTUARY_DUMMY"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(SanctuaryBonus)


function DroneHiveBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingDroneHive) then
			--print("Drone Hive found.")
			local iNumGenerators = 0
			local iNumCommArrays = 0
			local pPlot = pCity:Plot()
			for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				local iImprovement = pAdjacentPlot:GetImprovementType()
				local iOwner = pAdjacentPlot:GetOwner()
				if (iImprovement == iImprovementGenerator) and (iOwner == iPlayer) then
					iNumGenerators = iNumGenerators + 1
				end
				if ((iImprovement == iImprovementCommArray) or (iImprovement == iImprovementIndustrialComplex)) and (iOwner == iPlayer) then
					iNumCommArrays = iNumCommArrays + 1
				end
			end
			--print("Generators: " .. iNumGenerators)
			--print("Comm Arrays: " .. iNumCommArrays)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DRONE_HIVE_DUMMY_1"], iNumGenerators)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DRONE_HIVE_DUMMY_2"], iNumCommArrays)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DRONE_HIVE_DUMMY_1"], 0)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_DRONE_HIVE_DUMMY_2"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(DroneHiveBonus)

function FeedsiteHubBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	local pCapital = pPlayer:GetCapitalCity();
	local iNumHappiness = 0
	if (pCapital) then
		if pCapital:IsHasBuilding(iBuildingFeedsiteHub) then
			local iNumCulture = pCapital:GetNumGreatWorks()
			if pCapital:IsHasBuilding(iBuildingColosseum) then iNumHappiness = iNumHappiness + 1 end
			if pCapital:IsHasBuilding(iBuildingTheatre) then iNumHappiness = iNumHappiness + 1 end
			if pCapital:IsHasBuilding(iBuildingStadium) then iNumHappiness = iNumHappiness + 1 end
			pCapital:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_FEEDSITE_HUB_DUMMY_2"], iNumHappiness)
			pCapital:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_FEEDSITE_HUB_DUMMY_1"], iNumCulture)
		end
	end
end
GameEvents.PlayerDoTurn.Add(FeedsiteHubBonus)

function VivariumBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingVivarium) then
			local iNumDomes = 0
			local pPlot = pCity:Plot()
			for pAdjacentPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				local iImprovement = pAdjacentPlot:GetImprovementType()
				local iOwner = pAdjacentPlot:GetOwner()
				if (iImprovement == iImprovementDome) and (iOwner == iPlayer) and (pCity:IsWorkingPlot(pAdjacentPlot)) then
					iNumDomes = iNumDomes + 1
				end
			end
			if iNumDomes > 4 then
				iNumDomes = 4
			end
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_VIVARIUM_DUMMY"], iNumDomes)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_VIVARIUM_DUMMY"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(VivariumBonus)

function NephilimGeneTemplateBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if (pPlayer:GetBuildingClassCount(iBuildingNephilimGeneTemplateClass) > 0) then
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_NEPHILIMGENETEMPLATE_DUMMY"], 1)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_NEPHILIMGENETEMPLATE_DUMMY"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(NephilimGeneTemplateBonus)

function AngelnetBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iBuildingUtilityFog) and (pPlayer:GetBuildingClassCount(iBuildingAngelnetClass) > 0) then
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_ANGELNET_DUMMY"], 1)
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_FW_ANGELNET_DUMMY"], 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(AngelnetBonus)


function CityScreenBuildingBonuses()
	local iPlayer = Game.GetActivePlayer()
	SanctuaryBonus(iPlayer)
	DroneHiveBonus(iPlayer)
	FeedsiteHubBonus(iPlayer)
	VivariumBonus(iPlayer)
	NephilimGeneTemplateBonus(iPlayer)
end
Events.SerialEventExitCityScreen.Add(CityScreenBuildingBonuses)

function WonderPoliciesCheck(playerID)
	local player = Players[playerID]
	if player:IsAlive() and (player:GetBuildingClassCount(iBuildingGeneVaultClass) > 0) and not player:HasPolicy(GameInfoTypes["POLICY_GENE_VAULT"]) then
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(GameInfoTypes["POLICY_GENE_VAULT"], true)	
	end
	if player:IsAlive() and (player:GetBuildingClassCount(iBuildingGeneVaultClass) == 0) and player:HasPolicy(GameInfoTypes["POLICY_GENE_VAULT"]) then
		player:SetHasPolicy(GameInfoTypes["POLICY_GENE_VAULT"], false)
	end
end
GameEvents.PlayerDoTurn.Add(WonderPoliciesCheck)

function ConstructionCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == GameInfoTypes["BUILDING_GENE_VAULT"] then
		local pPlayer = Players[ownerId]
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes["POLICY_GENE_VAULT"], true)
	end
end
GameEvents.CityConstructed.Add(ConstructionCompleted)

function SpaceStationRequirement(playerID, buildingType)
  local player = Players[playerID];

  if(buildingType ~= GameInfoTypes["BUILDING_FW_SPACE_STATION"]) then
    return true;
  end

  if(player:GetBuildingClassCount(iBuildingLaunchFacilityClass) > 0) then
    return true;
  end

  return false;
end
GameEvents.PlayerCanConstruct.Add(SpaceStationRequirement);
