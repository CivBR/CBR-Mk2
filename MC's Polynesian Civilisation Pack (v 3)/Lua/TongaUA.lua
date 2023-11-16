--TongaUA	
--Author: JFD
    function GetRandom(lower, upper)
        return Game.Rand((upper + 1) - lower, "") + lower
    end
     
    function JFD_Tonga(playerMetID, playerID)
            local player = Players[playerID]
            local playerMet = Players[playerMetID]
            local majorsMet = Teams[playerMet:GetTeam()]:GetHasMetCivCount(true)
            local reward
            if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_MC_TONGA"] then
                    if playerMet:IsMinorCiv() then reward = 15 else reward = 30 end
                    if majorsMet == 1 then reward = reward * 2 end
           
                    local random = GetRandom(1, 4)
                    if random == 1 then
                            player:ChangeFaith(reward)
                            if player:IsHuman() then
                                    Events.GameplayAlertMessage(Locale.ConvertTextKey("You receive {1_Num} [ICON_PEACE] Faith from meeting {2_CivName}", reward, playerMet:GetName()))
                            end
                    elseif random == 2 then
                            player:ChangeJONSCulture(reward)
                            if player:IsHuman() then
                                    Events.GameplayAlertMessage(Locale.ConvertTextKey("You receive {1_Num} [ICON_CULTURE] Culture from meeting {2_CivName}", reward, playerMet:GetName()))
                            end
                    elseif random == 3 then
                            Teams[player:GetTeam()]:GetTeamTechs():ChangeResearchProgress(player:GetCurrentResearch(), reward, playerID)
                            if player:IsHuman() then
                                    Events.GameplayAlertMessage(Locale.ConvertTextKey("You receive {1_Num} [ICON_RESEARCH] Science from meeting {2_CivName}", reward, playerMet:GetName()))
                            end
                    else
                            player:ChangeGold(reward)
                            if player:IsHuman() then
                                    Events.GameplayAlertMessage(Locale.ConvertTextKey("You receive {1_Num} [ICON_GOLD] Gold from meeting {2_CivName}", reward, playerMet:GetName()))
                            end
                    end
            end
    end
    GameEvents.TeamMeet.Add(JFD_Tonga)

function InitTonga(player)
	for playerID, player in pairs(Players) do
		local player = Players[playerID];
		 if player:GetCivilizationType() == GameInfoTypes["POLICY_TONGA_UA"] then
			if not player:HasPolicy(GameInfoTypes["POLICY_TONGA_UA"]) then
				player:SetNumFreePolicies(1)
				player:SetNumFreePolicies(0)
				player:SetHasPolicy(GameInfoTypes["POLICY_TONGA_UA"], true)	
			end
			
		end
	end 
end


	Events.LoadScreenClose.Add(InitTonga)
