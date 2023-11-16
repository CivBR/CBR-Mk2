	

    -- ManutaraScripts
    -- Author: Leugi
    --------------------------------------------------------------
     
    --Change the following, the first is for the original unit, the second for the Tangata Manu version:
    -----------------------------------------------------------------------------------
    local iUnitID = GameInfo.Units.UNIT_MC_RAPA_NUI_MATATOA.ID
    local iTangataID = GameInfo.Units.UNIT_MC_RAPA_NUI_TANGATA_MANU.ID
    local iManuID = GameInfoTypes["RESOURCE_MANUTARA_EGG"]
     local iCivType = GameInfo.Civilizations["CIVILIZATION_MC_RAPA_NUI"].ID


function TangataManify(iPlayer)
	local pPlayer = Players[iPlayer];
	for unit in pPlayer:Units() do
               	if (unit:GetUnitType() == iUnitID) then
			local plot = unit:GetPlot();
			local ImpID = plot:GetImprovementType()
                        if ImpID == GameInfoTypes.IMPROVEMENT_MANUTARA_SITE then
 				if (plot:GetNumResource() > 1) then
					 if (pPlayer:IsHuman()) then
 						local title =  Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_NOEGG_TITLE");
						local descr =  Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_NOEGG");
						pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, plot:GetX(), plot:GetY());
					end
 					plot:SetImprovementType(-1);
				else
					local newUnit = pPlayer:InitUnit(iTangataID, unit:GetX(), unit:GetY())
                                        newUnit:Convert(unit);
                                        plot:SetImprovementType(-1);
                                        plot:SetResourceType(iManuID, 1);
	           			if pPlayer:IsHuman() then
						local alertmessage = Locale.ConvertTextKey("TXT_KEY_MC_TANGATAMANU_ALERT")
                       				Events.GameplayAlertMessage(alertmessage)
					end
                                end
                         end
                end
         end
end


GameEvents.PlayerDoTurn.Add(TangataManify);



function DestroyEggs(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:GetCivilizationType() ~= iCivType) then
		for pCity in pPlayer:Cities() do
			local i;
			for i = 0, pCity:GetNumCityPlots() - 1, 1 do
				local plot = pCity:GetCityIndexPlot( i );
				if (plot ~= nil) then
  					if ( plot:GetOwner() == pCity:GetOwner() ) then
						if (plot:GetResourceType() == iManuID) then
							plot:SetResourceType(-1);
						end
					end
				end
			end
		end
	end
end


GameEvents.PlayerDoTurn.Add(DestroyEggs);