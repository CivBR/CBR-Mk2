-- RapaNuiFaith
-- Author: JFD

local ArtistSp = GameInfoTypes.SPECIALIST_ARTIST
local MusicianSp = GameInfoTypes.SPECIALIST_MUSICIAN
local WriterSp = GameInfoTypes.SPECIALIST_WRITER

function JFD_GetRandom(lower, upper)
	return Game.Rand((upper + 1) - lower, "") + lower
end

function JFD_RapaNuiFaith(iX, iY, oldPopulation, newPopulation)
        local city = Map.GetPlot(iX, iY):GetPlotCity()
        local player = Players[city:GetOwner()]
        if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_MC_RAPA_NUI"] then
                local faithBoost = (newPopulation - 1)*5
                player:ChangeFaith(faithBoost)
 		local CultureGPBoost = ( faithBoost / 10 ) * 100
		if CultureGPBoost > 0 then
			if JFD_GetRandom(1, 3) == 1 then city:ChangeSpecialistGreatPersonProgressTimes100(ArtistSp, CultureGPBoost)
			elseif JFD_GetRandom(1, 3) == 2 then city:ChangeSpecialistGreatPersonProgressTimes100(MusicianSp, CultureGPBoost)
			else city:ChangeSpecialistGreatPersonProgressTimes100(WriterSp, CultureGPBoost) end
		end


                if player:IsHuman() and faithBoost > 0 then
                        local alertmessage = Locale.ConvertTextKey("TXT_KEY_MC_RAPA_NUI_FAITH", faithBoost, city:GetName())
                        Events.GameplayAlertMessage(alertmessage)
                end
        end
end
GameEvents.SetPopulation.Add(JFD_RapaNuiFaith)