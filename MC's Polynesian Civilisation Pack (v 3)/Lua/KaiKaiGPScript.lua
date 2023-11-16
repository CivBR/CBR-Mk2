-- Rapa Nui Culture GP from Faith per Turn
-- By Leugi


local ArtistSp = GameInfoTypes.SPECIALIST_ARTIST
local MusicianSp = GameInfoTypes.SPECIALIST_MUSICIAN
local WriterSp = GameInfoTypes.SPECIALIST_WRITER


function RapaNuiGrantGPPoints(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsEverAlive()) then
		 if pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_MC_RAPA_NUI"] then
			for pCity in pPlayer:Cities() do
				local iFaithPerTurn = pCity:GetFaithPerTurn();
				local CultureGPBoost = iFaithPerTurn * 10
				if CultureGPBoost > 0 then
					pCity:ChangeSpecialistGreatPersonProgressTimes100(ArtistSp, CultureGPBoost)
					pCity:ChangeSpecialistGreatPersonProgressTimes100(MusicianSp, CultureGPBoost)
					pCity:ChangeSpecialistGreatPersonProgressTimes100(WriterSp, CultureGPBoost)
				end
			end
		end
	end
end


GameEvents.PlayerDoTurn.Add(RapaNuiGrantGPPoints)