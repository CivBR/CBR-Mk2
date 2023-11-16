include( "IconSupport" );
----------------------------------------------------------------
----------------------------------------------------------------
local m_PopulationTable = {};
local m_FoodTable = {};
local m_ProductionTable = {};
local m_GoldTable = {};
local m_LandTable = {};
local m_ArmyTable = {};
local m_ApprovalTable = {};
local m_LiteracyTable = {};

-- Top Cities / Wonders
local m_TopCitiesLimit = 5 -- More than 5 will need a scroll bar adding
local m_CityTable = {};
local m_WonderTable = {};

local m_bIsEndGame = (ContextPtr:GetID() == "EndGameDemographics");

-- Currently selected tab
local m_CurrentPanel = Controls.DemographicsPanel;

-- Sorting
local m_SortTable = {};
local ePop  = 0;
local eFood = 1;
local eProd = 2;
local eGold = 3;
local eLand = 4;
local eArmy = 5;
local eApproval = 6;
local eLiteracy = 7;
local m_SortMode = ePop;
local m_bSortReverse = true;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnDemographics()
	-- Set Tabs
	Controls.DemographicsSelectHighlight:SetHide(false);
	Controls.TablesSelectHighlight:SetHide(true);
	Controls.WondersSelectHighlight:SetHide(true);

	-- Set Panels
    Controls.DemographicsPanel:SetHide(false);
	Controls.TablesPanel:SetHide(true);
	Controls.WondersPanel:SetHide(true);
    m_CurrentPanel = Controls.DemographicsPanel;
end
Controls.DemographicsButton:RegisterCallback(Mouse.eLClick, OnDemographics);

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnTables()
	-- Set Tabs
	Controls.DemographicsSelectHighlight:SetHide(true);
	Controls.TablesSelectHighlight:SetHide(false);
	Controls.WondersSelectHighlight:SetHide(true);

	-- Set Panels
    Controls.DemographicsPanel:SetHide(true);
	Controls.TablesPanel:SetHide(false);
	Controls.WondersPanel:SetHide(true);
    m_CurrentPanel = Controls.TablesPanel;
end
Controls.TablesButton:RegisterCallback(Mouse.eLClick, OnTables);

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnWonders()
	-- Set Tabs
	Controls.DemographicsSelectHighlight:SetHide(true);
	Controls.TablesSelectHighlight:SetHide(true);
	Controls.WondersSelectHighlight:SetHide(false);

	-- Set Panels
    Controls.DemographicsPanel:SetHide(true);
	Controls.TablesPanel:SetHide(true);
	Controls.WondersPanel:SetHide(false);
    m_CurrentPanel = Controls.WondersPanel;
end
Controls.WondersButton:RegisterCallback(Mouse.eLClick, OnWonders);

-------------------------------------------------
-------------------------------------------------
function OnWonderRClick(buildingID)
	local building = GameInfo.Buildings[buildingID];
	Events.SearchForPediaEntry(Locale.ConvertTextKey(building.Description));
end

----------------------------------------------------------------
----------------------------------------------------------------
function BuildTables()
	for i = 0, GameDefines.MAX_MAJOR_CIVS do
        m_PopulationTable[ i ] = 0;
        m_FoodTable[ i ] = 0;
        m_ProductionTable[ i ] = 0;
        m_GoldTable[ i ] = 0;
        m_LandTable[ i ] = 0;
        m_ArmyTable[ i ] = 0;
        m_ApprovalTable[ i ] = 0;
        m_LiteracyTable[ i ] = 0;
        
        m_PopulationTable[ i ] = GetPopulationValue( i );
        m_FoodTable[ i ] = GetFoodValue( i );
        m_ProductionTable[ i ] = GetProductionValue( i );
        m_GoldTable[ i ] = GetGoldValue( i );
        m_LandTable[ i ] = GetLandValue( i );
        m_ArmyTable[ i ] = GetArmyValue( i );
        m_ApprovalTable[ i ] = GetApprovalValue( i );
        m_LiteracyTable[ i ] = GetLiteracyValue( i );
    end

	-- Build a table with all wonders
	m_WonderTable = {};
	for building in GameInfo.Buildings() do
		if (GameInfo.BuildingClasses[building.BuildingClass].MaxGlobalInstances == 1) then
			table.insert(m_WonderTable, {buildingID = building.ID, playerID = -1, playerCityID = -1});
		end
	end

	-- Build a table with all cities and their score
	-- Also add cities to the table of wonders
	m_CityTable = {};
	for playerID, pPlayer in ipairs(Players) do

		if (pPlayer:IsAlive() and not pPlayer:IsMinorCiv()) then
			for pCity in pPlayer:Cities() do
				table.insert(m_CityTable, {playerID = playerID, playerCityID = pCity:GetID(), score = GetCityScore(pCity)});

				-- Add city to wondertable if applicable
				if (pCity:GetNumWorldWonders() > 0) then
					for i, wonder in ipairs(m_WonderTable) do
						if (pCity:IsHasBuilding(wonder.buildingID)) then
							wonder.playerID = playerID;
							wonder.playerCityID = pCity:GetID();
						end
					end
				end	

			end
		end

	end

end

----------------------------------------------------------------
----------------------------------------------------------------
function GetCityScore(pCity)
	local score = 0;

	score = score + pCity:GetNumWorldWonders() * GameDefines.SCORE_WONDER_MULTIPLIER;
	score = score + pCity:GetPopulation() * GameDefines.SCORE_POPULATION_MULTIPLIER;
	score = score + pCity:GetNumCityPlots() * GameDefines.SCORE_LAND_MULTIPLIER;

	return score;
end

----------------------------------------------------------------
----------------------------------------------------------------
function GetBest( table, iPlayer )
    local highest = nil;
    local highestID = iPlayer;
    for i = 0, GameDefines.MAX_MAJOR_CIVS do
		local pPlayer = Players[i];
        if(pPlayer:IsAlive() and not pPlayer:IsMinorCiv()) then
            if( highest == nil or table[i] > highest ) then
                highest = table[i];
                highestID = i;
            end
       end
    end
    
    return { highest, highestID };
end


----------------------------------------------------------------
----------------------------------------------------------------
function GetAverage( table, iPlayer )
    local accum = 0;
    local count = 0;
    
    for i = 0, GameDefines.MAX_MAJOR_CIVS do
       	local pPlayer = Players[i];
        if(pPlayer:IsAlive() and not pPlayer:IsMinorCiv()) then
            count = count + 1;
            accum = accum + table[i];
        end
    end
    
    return accum / count;
end


----------------------------------------------------------------
----------------------------------------------------------------
function GetWorst( table, iPlayer )
    local lowest = nil;
    local lowestID = iPlayer;
    for i = 0, GameDefines.MAX_MAJOR_CIVS do
        local pPlayer = Players[i];
		if(pPlayer:IsAlive() and not pPlayer:IsMinorCiv()) then
            if( lowest == nil or table[i] <= lowest ) then
                lowest = table[i];
                lowestID = i;
            end
       end
    end
    
    return { lowest, lowestID };
end


----------------------------------------------------------------
----------------------------------------------------------------
function GetRank( table, iPlayer )
    local playerVal = table[iPlayer];
    local rank = 1;
    
    for i = 0, GameDefines.MAX_MAJOR_CIVS do
        local pPlayer = Players[i];
		if(pPlayer:IsAlive() and not pPlayer:IsMinorCiv()) then
            if( table[i] > playerVal ) then
                rank = rank + 1;
            end
        end
    end
    
    return rank;
end


----------------------------------------------------------------
----------------------------------------------------------------
function GetPopulationValue( iPlayer )
    return Players[iPlayer]:GetRealPopulation();
end


----------------------------------------------------------------
----------------------------------------------------------------
function BuildPopulationEntry( iPlayer )
    local instance = {};
    ContextPtr:BuildInstanceForControl( "Entry", instance, Controls.MainStack );
    
    instance.Name:LocalizeAndSetText( "TXT_KEY_DEMOGRAPHICS_POPULATION" );
    
    instance.Value:SetText( Locale.ToNumber(m_PopulationTable[ iPlayer ], "#,###,###,###" ));
    instance.ValueTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_POPULATION_MEASURE") );
   
    local best = GetBest( m_PopulationTable, iPlayer );
    SetCivIcon(best[2], 32, instance.BestIcon, instance.BestIconBG, instance.BestIconShadow);
    instance.Best:SetText( Locale.ToNumber(best[1], "#,###,###,###") );
    instance.BestTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_POPULATION_MEASURE") );
	
    instance.Average:SetText( Locale.ToNumber( GetAverage( m_PopulationTable, iPlayer ), "#,###,###,###" ) );
    instance.AverageTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_POPULATION_MEASURE") );
    
    local worst = GetWorst( m_PopulationTable, iPlayer );
    SetCivIcon(worst[2], 32, instance.WorstIcon, instance.WorstIconBG, instance.WorstIconShadow);
    instance.Worst:LocalizeAndSetText( Locale.ToNumber(worst[1], "#,###,###,###" ) );
    instance.WorstTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_POPULATION_MEASURE") );
    
    instance.Rank:SetText( Locale.ToNumber(GetRank( m_PopulationTable, iPlayer ), "#") );
end


----------------------------------------------------------------
----------------------------------------------------------------
function GetFoodValue( iPlayer )
    return Players[iPlayer]:CalculateTotalYield(YieldTypes.YIELD_FOOD);
end


----------------------------------------------------------------
----------------------------------------------------------------
function BuildFoodEntry( iPlayer )
    local instance = {};
    ContextPtr:BuildInstanceForControl( "Entry", instance, Controls.MainStack );
    
    instance.Name:LocalizeAndSetText( "TXT_KEY_DEMOGRAPHICS_FOOD" );
    
    instance.Value:SetText( Locale.ToNumber(m_FoodTable[ iPlayer ], "#,###,###,###" ));
    instance.ValueTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_FOOD_MEASURE") );
   
    local best = GetBest( m_FoodTable, iPlayer );
    SetCivIcon(best[2], 32, instance.BestIcon, instance.BestIconBG, instance.BestIconShadow);
    instance.Best:SetText( Locale.ToNumber(best[1], "#,###,###,###") );
    instance.BestTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_FOOD_MEASURE") );
	
    instance.Average:SetText( Locale.ToNumber( GetAverage( m_FoodTable, iPlayer ), "#,###,###,###" ) );
    instance.AverageTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_FOOD_MEASURE") );
    
    local worst = GetWorst( m_FoodTable, iPlayer );
    SetCivIcon(worst[2], 32, instance.WorstIcon, instance.WorstIconBG, instance.WorstIconShadow);
    instance.Worst:LocalizeAndSetText( Locale.ToNumber(worst[1], "#,###,###,###" ) );
    instance.WorstTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_FOOD_MEASURE") );
    
    instance.Rank:SetText( Locale.ToNumber(GetRank( m_FoodTable, iPlayer ), "#") );
end


----------------------------------------------------------------
----------------------------------------------------------------
function GetProductionValue( iPlayer )
    return Players[iPlayer]:CalculateTotalYield(YieldTypes.YIELD_PRODUCTION);
end


----------------------------------------------------------------
----------------------------------------------------------------
function BuildProductionEntry( iPlayer )
    local instance = {};
    ContextPtr:BuildInstanceForControl( "Entry", instance, Controls.MainStack );
    
    instance.Name:LocalizeAndSetText( "TXT_KEY_DEMOGRAPHICS_PRODUCTION" );
    
    instance.Value:SetText( Locale.ToNumber(m_ProductionTable[ iPlayer ], "#,###,###,###" ));
    instance.ValueTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_PRODUCTION_MEASURE") );
   
    local best = GetBest( m_ProductionTable, iPlayer );
    SetCivIcon(best[2], 32, instance.BestIcon, instance.BestIconBG, instance.BestIconShadow);
    instance.Best:SetText( Locale.ToNumber(best[1], "#,###,###,###") );
    instance.BestTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_PRODUCTION_MEASURE") );
	
    instance.Average:SetText( Locale.ToNumber( GetAverage( m_ProductionTable, iPlayer ), "#,###,###,###" ) );
    instance.AverageTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_PRODUCTION_MEASURE") );
    
    local worst = GetWorst( m_ProductionTable, iPlayer );
    SetCivIcon(worst[2], 32, instance.WorstIcon, instance.WorstIconBG, instance.WorstIconShadow);
    instance.Worst:LocalizeAndSetText( Locale.ToNumber(worst[1], "#,###,###,###" ) );
    instance.WorstTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_PRODUCTION_MEASURE") );
    
    instance.Rank:SetText( Locale.ToNumber(GetRank( m_ProductionTable, iPlayer ), "#") );
    
end


----------------------------------------------------------------
----------------------------------------------------------------
function GetGoldValue( iPlayer )
    return Players[iPlayer]:CalculateGrossGold();
end


----------------------------------------------------------------
----------------------------------------------------------------
function BuildGoldEntry( iPlayer )
    local instance = {};
    ContextPtr:BuildInstanceForControl( "Entry", instance, Controls.MainStack );
    
    instance.Name:LocalizeAndSetText( "TXT_KEY_DEMOGRAPHICS_GOLD" );
    
    instance.Value:SetText( Locale.ToNumber(m_GoldTable[ iPlayer ], "#,###,###,###" ));
    instance.ValueTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_GOLD_MEASURE") );
   
    local best = GetBest( m_GoldTable, iPlayer );
    SetCivIcon(best[2], 32, instance.BestIcon, instance.BestIconBG, instance.BestIconShadow);
    instance.Best:SetText( Locale.ToNumber(best[1], "#,###,###,###") );
    instance.BestTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_GOLD_MEASURE") );
	
    instance.Average:SetText( Locale.ToNumber( GetAverage( m_GoldTable, iPlayer ), "#,###,###,###" ) );
    instance.AverageTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_GOLD_MEASURE") );
    
    local worst = GetWorst( m_GoldTable, iPlayer );
    SetCivIcon(worst[2], 32, instance.WorstIcon, instance.WorstIconBG, instance.WorstIconShadow);
    instance.Worst:LocalizeAndSetText( Locale.ToNumber(worst[1], "#,###,###,###" ) );
    instance.WorstTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_GOLD_MEASURE") );
    
    instance.Rank:SetText( Locale.ToNumber(GetRank( m_GoldTable, iPlayer ), "#") );
end


----------------------------------------------------------------
----------------------------------------------------------------
function GetLandValue( iPlayer )
    return Players[iPlayer]:GetNumPlots() * 10000;
end


----------------------------------------------------------------
----------------------------------------------------------------
function BuildLandEntry( iPlayer )
    local instance = {};
    ContextPtr:BuildInstanceForControl( "Entry", instance, Controls.MainStack );
    
    instance.Name:LocalizeAndSetText( "TXT_KEY_DEMOGRAPHICS_LAND" );
    
    instance.Value:SetText( Locale.ToNumber(m_LandTable[ iPlayer ], "#,###,###,###" ));
    instance.ValueTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_LAND_MEASURE") );
   
    local best = GetBest( m_LandTable, iPlayer );
    SetCivIcon(best[2], 32, instance.BestIcon, instance.BestIconBG, instance.BestIconShadow);
    instance.Best:SetText( Locale.ToNumber(best[1], "#,###,###,###") );
    instance.BestTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_LAND_MEASURE") );
	
    instance.Average:SetText( Locale.ToNumber( GetAverage( m_LandTable, iPlayer ), "#,###,###,###" ) );
    instance.AverageTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_LAND_MEASURE") );
    
    local worst = GetWorst( m_LandTable, iPlayer );
    SetCivIcon(worst[2], 32, instance.WorstIcon, instance.WorstIconBG, instance.WorstIconShadow);
    instance.Worst:LocalizeAndSetText( Locale.ToNumber(worst[1], "#,###,###,###" ) );
    instance.WorstTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_LAND_MEASURE") );
    
    instance.Rank:SetText( Locale.ToNumber(GetRank( m_LandTable, iPlayer ), "#") );
end


----------------------------------------------------------------
----------------------------------------------------------------
function GetArmyValue( iPlayer )
    return math.sqrt( Players[iPlayer]:GetMilitaryMight() ) * 2000;
end


----------------------------------------------------------------
----------------------------------------------------------------
function BuildArmyEntry( iPlayer )
    local instance = {};
    ContextPtr:BuildInstanceForControl( "Entry", instance, Controls.MainStack );
    
    instance.Name:LocalizeAndSetText( "TXT_KEY_DEMOGRAPHICS_ARMY" );
    
    instance.Value:SetText( Locale.ToNumber(m_ArmyTable[ iPlayer ], "#,###,###,###" ));
    instance.ValueTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_ARMY_MEASURE") );
   
    local best = GetBest( m_ArmyTable, iPlayer );
    SetCivIcon(best[2], 32, instance.BestIcon, instance.BestIconBG, instance.BestIconShadow);
    instance.Best:SetText( Locale.ToNumber(best[1], "#,###,###,###") );
    instance.BestTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_ARMY_MEASURE") );
	
    instance.Average:SetText( Locale.ToNumber( GetAverage( m_ArmyTable, iPlayer ), "#,###,###,###" ) );
    instance.AverageTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_ARMY_MEASURE") );
    
    local worst = GetWorst( m_ArmyTable, iPlayer );
    SetCivIcon(worst[2], 32, instance.WorstIcon, instance.WorstIconBG, instance.WorstIconShadow);
    instance.Worst:LocalizeAndSetText( Locale.ToNumber(worst[1], "#,###,###,###") );
    instance.WorstTT:SetToolTipString( Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_ARMY_MEASURE") );
    
    instance.Rank:SetText( Locale.ToNumber(GetRank( m_ArmyTable, iPlayer ), "#") );
end


function SetCivIcon(iPlayerID, size, control, controlBG, controlShadow)
	local pPlayer = Players[iPlayerID];
	local iTeam = pPlayer:GetTeam();
	local pTeam = Teams[iTeam];

    -- Active player
	if (pPlayer:GetID() == Game.GetActivePlayer()) then
		CivIconHookup( iPlayerID, size, control, controlBG, controlShadow, false, true);  
	-- Haven't yet met this player
	elseif (not pTeam:IsHasMet(Game.GetActiveTeam())) then
		CivIconHookup( -1, size, control, controlBG, controlShadow, false, true); 
	-- Met players
	else
		CivIconHookup( iPlayerID, size, control, controlBG, controlShadow, false, true);  
	end  
end

----------------------------------------------------------------
----------------------------------------------------------------
function GetApprovalValue( iPlayer )
    local value = 60 + (Players[iPlayer]:GetExcessHappiness() * 3);
    if( value < 0 ) then
        return 0;
    elseif( value > 100 ) then
        return 100;
    end
    return value;
end


----------------------------------------------------------------
----------------------------------------------------------------
function BuildApprovalEntry( iPlayer )
    local instance = {};
    ContextPtr:BuildInstanceForControl( "Entry", instance, Controls.MainStack );
        
    instance.Name:LocalizeAndSetText( "TXT_KEY_DEMOGRAPHICS_APPROVAL" );
    
    instance.Value:SetText( Locale.ToNumber(m_ApprovalTable[ iPlayer ], "#'%'" ));
   
    local best = GetBest( m_ApprovalTable, iPlayer );
    SetCivIcon(best[2], 32, instance.BestIcon, instance.BestIconBG, instance.BestIconShadow);
    instance.Best:SetText( Locale.ToNumber(best[1], "#'%'") );
	
    instance.Average:SetText( Locale.ToNumber( GetAverage( m_ApprovalTable, iPlayer ), "#'%'" ) );
    
    local worst = GetWorst( m_ApprovalTable, iPlayer );
    SetCivIcon(worst[2], 32, instance.WorstIcon, instance.WorstIconBG, instance.WorstIconShadow);
    instance.Worst:LocalizeAndSetText( Locale.ToNumber(worst[1], "#'%'" ) );
    
    instance.Rank:SetText( Locale.ToNumber(GetRank( m_ApprovalTable, iPlayer ), "#") );
end


----------------------------------------------------------------
----------------------------------------------------------------
function GetLiteracyValue( iPlayer )

    local pTeamTechs = Teams[ Players[ iPlayer ]:GetTeam() ]:GetTeamTechs();
    
    local iWriting = GameInfoTypes[ "TECH_WRITING" ];
    if( iWriting ~= nil and 
        not pTeamTechs:HasTech( iWriting ) ) then
        return 0;
    end
    
    local iCount = 0;
	for row in GameInfo.Technologies() do
	    if( pTeamTechs:HasTech( row.ID ) ) then
	        iCount = iCount + 1;
	    end
	end
	
	return 100 * iCount / #GameInfo.Technologies;
end


----------------------------------------------------------------
----------------------------------------------------------------
function BuildLiteracyEntry( iPlayer )
    local instance = {};
    ContextPtr:BuildInstanceForControl( "Entry", instance, Controls.MainStack );
    
    instance.Name:LocalizeAndSetText( "TXT_KEY_DEMOGRAPHICS_LITERACY" );
    
    instance.Value:SetText( Locale.ToNumber(m_LiteracyTable[ iPlayer ], "#'%'" ));
   
    local best = GetBest( m_LiteracyTable, iPlayer );
    SetCivIcon(best[2], 32, instance.BestIcon, instance.BestIconBG, instance.BestIconShadow);
    instance.Best:SetText( Locale.ToNumber(best[1], "#'%'") );
	
    instance.Average:SetText( Locale.ToNumber( GetAverage( m_LiteracyTable, iPlayer ), "#'%'" ) );
    
    local worst = GetWorst( m_LiteracyTable, iPlayer );
    SetCivIcon(worst[2], 32, instance.WorstIcon, instance.WorstIconBG, instance.WorstIconShadow);
    instance.Worst:LocalizeAndSetText( Locale.ToNumber(worst[1], "#'%'" ) );
    
    instance.Rank:SetText( Locale.ToNumber(GetRank( m_LiteracyTable, iPlayer ), "#") );
end

-------------------------------------------------
-------------------------------------------------
function SortTableFunction(a, b)
    local valueA, valueB;
    local iA = m_SortTable[tostring(a)];
    local iB = m_SortTable[tostring(b)];

    if (iA == nil) or (iB == nil) then 
		if iA and (iB == nil) then
			return false;
		elseif (iA == nil) and iB then
			return true;
		else
			if (m_bSortReverse) then
				return tostring(a) > tostring(b);
			else
				return tostring(a) < tostring(b);
			end
        end
    else
		if (m_SortMode == ePop) then
			valueA = m_PopulationTable[iA];
			valueB = m_PopulationTable[iB];
		elseif (m_SortMode == eFood) then
			valueA = m_FoodTable[iA];
			valueB = m_FoodTable[iB];
		elseif (m_SortMode == eProd) then
			valueA = m_ProductionTable[iA];
			valueB = m_ProductionTable[iB];
		elseif (m_SortMode == eGold) then
			valueA = m_GoldTable[iA];
			valueB = m_GoldTable[iB];
		elseif (m_SortMode == eLand) then
			valueA = m_LandTable[iA];
			valueB = m_LandTable[iB];
		elseif (m_SortMode == eArmy) then
			valueA = m_ArmyTable[iA];
			valueB = m_ArmyTable[iB];
		elseif (m_SortMode == eApproval) then
			valueA = m_ApprovalTable[iA];
			valueB = m_ApprovalTable[iB];
		else -- Sort Literacy
			valueA = m_LiteracyTable[iA];
			valueB = m_LiteracyTable[iB];
		end
	    
		if (valueA == valueB) then
			return iA < iB;
		end
		if (m_bSortReverse) then
			return valueA > valueB;
		else
			return valueA < valueB;
		end
	end
end

-------------------------------------------------
-------------------------------------------------
function OnSortTable(type)
    if(m_SortMode == type) then
        m_bSortReverse = not m_bSortReverse;
    else
        m_bSortReverse = true;
    end

    m_SortMode = type;
    Controls.TableStack:SortChildren(SortTableFunction);
end
Controls.SortTablePop:RegisterCallback(Mouse.eLClick, OnSortTable);
Controls.SortTableFood:RegisterCallback(Mouse.eLClick, OnSortTable);
Controls.SortTableProd:RegisterCallback(Mouse.eLClick, OnSortTable);
Controls.SortTableGold:RegisterCallback(Mouse.eLClick, OnSortTable);
Controls.SortTableLand:RegisterCallback(Mouse.eLClick, OnSortTable);
Controls.SortTableArmy:RegisterCallback(Mouse.eLClick, OnSortTable);
Controls.SortTableApproval:RegisterCallback(Mouse.eLClick, OnSortTable);
Controls.SortTableLiteracy:RegisterCallback(Mouse.eLClick, OnSortTable);
Controls.SortTablePop:SetVoid1(ePop);
Controls.SortTableFood:SetVoid1(eFood);
Controls.SortTableProd:SetVoid1(eProd);
Controls.SortTableGold:SetVoid1(eGold);
Controls.SortTableLand:SetVoid1(eLand);
Controls.SortTableArmy:SetVoid1(eArmy);
Controls.SortTableApproval:SetVoid1(eApproval);
Controls.SortTableLiteracy:SetVoid1(eLiteracy);

----------------------------------------------------------------
----------------------------------------------------------------
function BuildList( iPlayer )
    Controls.MainStack:DestroyAllChildren();

    BuildPopulationEntry( iPlayer );
    BuildFoodEntry( iPlayer );
    BuildProductionEntry( iPlayer );
    BuildGoldEntry( iPlayer );
    BuildLandEntry( iPlayer );
    BuildArmyEntry( iPlayer );
    BuildApprovalEntry( iPlayer );
    BuildLiteracyEntry( iPlayer );

    Controls.MainStack:CalculateSize();
    Controls.MainStack:ReprocessAnchoring();
    Controls.BigStack:ReprocessAnchoring();
    
end

----------------------------------------------------------------
----------------------------------------------------------------
function BuildTablePanel(iPlayer)
    Controls.TableStack:DestroyAllChildren();
	m_SortTable = {};	
	
    for i = 0, GameDefines.MAX_MAJOR_CIVS do

		local pPlayer = Players[i];
        if(pPlayer:IsAlive() and not pPlayer:IsMinorCiv()) then
			local instance = {};
			ContextPtr:BuildInstanceForControl("TableEntry", instance, Controls.TableStack);

			SetCivIcon(i, 32, instance.TableCivIcon, instance.TableCivIconBG, instance.TableCivIconShadow);

			instance.TablePop:SetText(Locale.ToNumber(m_PopulationTable[i], "#,###,###,###"));
			instance.TablePopTT:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_POPULATION_MEASURE"));

			instance.TableFood:SetText(Locale.ToNumber(m_FoodTable[i], "#,###,###,###"));
			instance.TableFoodTT:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_FOOD_MEASURE"));

			instance.TableProd:SetText(Locale.ToNumber(m_ProductionTable[i], "#,###,###,###"));
			instance.TableProdTT:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_PRODUCTION_MEASURE"));

		    instance.TableGold:SetText(Locale.ToNumber(m_GoldTable[i], "#,###,###,###"));
			instance.TableGoldTT:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_GOLD_MEASURE"));

			instance.TableLand:SetText(Locale.ToNumber(m_LandTable[i], "#,###,###,###"));
			instance.TableLandTT:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_LAND_MEASURE"));

		    instance.TableArmy:SetText(Locale.ToNumber(m_ArmyTable[i], "#,###,###,###"));
		    instance.TableArmyTT:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_ARMY_MEASURE"));

			instance.TableApproval:SetText(Locale.ToNumber(m_ApprovalTable[i], "#'%'"));

			instance.TableLiteracy:SetText(Locale.ToNumber(m_LiteracyTable[i], "#'%'"));
			
			local techId = Players[i]:GetCurrentResearch();
			if (techId > 0) then
				instance.TableResearch:SetText(Locale.ConvertTextKey(GameInfo.Technologies[techId].Description));
			end
			
			m_SortTable[tostring(instance.Root)] = i;
		end

	end	

	Controls.TableStack:CalculateSize();
  Controls.TableStack:ReprocessAnchoring();
  Controls.TableScrollPanel:CalculateInternalSize();
  Controls.TablePanelStack:ReprocessAnchoring();	
end

----------------------------------------------------------------
----------------------------------------------------------------
function BuildWondersPanel(iPlayer)
    Controls.TopCitiesStack:DestroyAllChildren();
	Controls.WonderStack:DestroyAllChildren();

	table.sort(m_CityTable, function(a, b) return b.score < a.score end);
	
	-- Populate stack of top cities
	for i, city in ipairs(m_CityTable) do
		local instance = {};
		local playerID = city.playerID;
		local pPlayer = Players[playerID];
		local pCity = pPlayer:GetCityByID(city.playerCityID);
		local pTeam = Teams[pPlayer:GetTeam()];

		ContextPtr:BuildInstanceForControl("TopCitiesEntry", instance, Controls.TopCitiesStack);

		SetCivIcon(playerID, 64, instance.TopCitiesCivIcon, instance.TopCitiesCivIconBG, instance.TopCitiesCivIconShadow);

		if (pTeam:IsHasMet(Game.GetActiveTeam())) then
			instance.TopCitiesName:SetText(Locale.ConvertTextKey(pCity:GetNameKey()));
		else
			instance.TopCitiesName:SetText(Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_UNKNOWN_CITY"));
		end

		instance.TopCitiesPop:SetText(Locale.ToNumber(pCity:GetPopulation(), "#,###,###,###"));

		-- Populate list of wonder icons for city
		if (pCity:GetNumWorldWonders() > 0) then
			for j, wonder in ipairs(m_WonderTable) do
				if ((wonder.playerID == playerID) and (wonder.playerCityID == city.playerCityID)) then
					local wonderInstance = {};
					local building = GameInfo.Buildings[wonder.buildingID];
			
					ContextPtr:BuildInstanceForControl("TopCitiesWonderEntry", wonderInstance, instance.TopCitiesWonderStack);
					IconHookup(building.PortraitIndex, 45, building.IconAtlas, wonderInstance.TopCitiesWonderIcon);
					wonderInstance.TopCitiesWonderButton:RegisterCallback(Mouse.eRClick, OnWonderRClick);
					wonderInstance.TopCitiesWonderButton:SetVoid1(wonder.buildingID);
					wonderInstance.TopCitiesWonderButton:SetToolTipString(Locale.ConvertTextKey(building.Description));
				end
			end
		end

		if (i >= m_TopCitiesLimit) then
			break;
		end
	end

	-- Populate stack of wonders
	for i, wonder in ipairs(m_WonderTable) do
		local playerID = wonder.playerID;
		if (playerID >= 0) then -- Add only built wonders to stack
			local instance = {};
			local building = GameInfo.Buildings[wonder.buildingID];
			local pPlayer = Players[playerID];
			local pTeam = Teams[pPlayer:GetTeam()];
			local pCity = pPlayer:GetCityByID(wonder.playerCityID);

			ContextPtr:BuildInstanceForControl("WonderEntry", instance, Controls.WonderStack);

			IconHookup(building.PortraitIndex, 64, building.IconAtlas, instance.WonderIcon);
			SetCivIcon(playerID, 32, instance.WonderCivIcon, instance.WonderCivIconBG, instance.WonderCivIconShadow);
			instance.WonderName:SetText(Locale.ConvertTextKey(building.Description));
			if (pTeam:IsHasMet(Game.GetActiveTeam())) then
				instance.WonderCity:SetText(Locale.ConvertTextKey(pCity:GetNameKey()));
			else
				instance.WonderCity:SetText(Locale.ConvertTextKey("TXT_KEY_DEMOGRAPHICS_UNKNOWN_CITY"));
			end
			
			instance.WonderButton:RegisterCallback(Mouse.eRClick, OnWonderRClick);
			instance.WonderButton:SetVoid1(wonder.buildingID);
		end
	end

	Controls.TopCitiesStack:CalculateSize();
    Controls.TopCitiesStack:ReprocessAnchoring();
	Controls.WonderStack:CalculateSize();
	Controls.WonderScrollPanel:CalculateInternalSize();
    Controls.WonderStack:ReprocessAnchoring();
end

----------------------------------------------------------------
----------------------------------------------------------------
function BuildPanels(iPlayer)
    CivIconHookup(iPlayer, 64, Controls.Icon, Controls.CivIconBG, Controls.CivIconShadow, false, true);  

	BuildList(iPlayer);
	BuildTablePanel(iPlayer);
	BuildWondersPanel(iPlayer);
end

----------------------------------------------------------------
----------------------------------------------------------------
function OnPlayerPulldown( iPlayerID )
    BuildPanels(iPlayerID);
end
-- Controls.PlayerPulldown:RegisterSelectionCallback( OnPlayerPulldown );


----------------------------------------------------------------
----------------------------------------------------------------
function ShowHideHandler( bIsHide, bIsInit )

    if( not bIsInit ) then
        if( not bIsHide ) then
            BuildTables();
            BuildPanels( Game.GetActivePlayer() );
            m_CurrentPanel:SetHide( false );

            if( not m_bIsEndGame ) then
	            UI.incTurnTimerSemaphore();
	            Events.SerialEventGameMessagePopupShown(m_PopupInfo);				
            end
        else
			Events.SerialEventGameMessagePopupProcessed.CallImmediate(ButtonPopupTypes.BUTTONPOPUP_DEMOGRAPHICS, 0);
            if( not m_bIsEndGame ) then
	            UI.decTurnTimerSemaphore();
            end
        end
    end

end
ContextPtr:SetShowHideHandler( ShowHideHandler );

BuildTables();
BuildPanels( Game.GetActivePlayer() );

if( m_bIsEndGame ) then
    Controls.BGBlock:SetHide( true );
    Controls.InGameSet:SetHide( true );
end
    

-------------------------------------------------
-- On Popup
-------------------------------------------------
function OnPopup( popupInfo )
	
	-- End game is its own deal that shouldn't come up when we hit a hotkey or something
	if (m_bIsEndGame) then
		return
	end
	
	if( popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_DEMOGRAPHICS ) then
		m_PopupInfo = popupInfo;
		if( m_PopupInfo.Data1 == 1 ) then
        	if( ContextPtr:IsHidden() == false ) then
        	    OnBack();
            else
            	UIManager:QueuePopup( ContextPtr, PopupPriority.InGameUtmost );
        	end
    	else
        	UIManager:QueuePopup( ContextPtr, PopupPriority.Demographics );
    	end
	end
end
Events.SerialEventGameMessagePopup.Add( OnPopup );

----------------------------------------------------------------
----------------------------------------------------------------
function OnBack()
	print("Dequeuing demographics");
	UIManager:DequeuePopup( ContextPtr );
end
Controls.BackButton:RegisterCallback( Mouse.eLClick, OnBack );
    

----------------------------------------------------------------
-- Key Down Processing
----------------------------------------------------------------
function InputHandler( uiMsg, wParam, lParam )
    if( uiMsg == KeyEvents.KeyDown ) then
        if( wParam == Keys.VK_RETURN or wParam == Keys.VK_ESCAPE ) then
			OnBack();
            return true;
        end
    end
end
if( not m_bIsEndGame ) then
	ContextPtr:SetInputHandler( InputHandler );
end
