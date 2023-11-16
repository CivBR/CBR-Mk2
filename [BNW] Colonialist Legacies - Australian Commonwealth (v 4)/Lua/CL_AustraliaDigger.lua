--------------------
--Colonialist Legacies' Australia
--Digger
--Civitar
--------------------

local iDiggerUnit = GameInfoTypes.UNIT_CL_AUSTRALIA_DIGGER;
local iCoastBonus = GameInfoTypes.PROMOTION_CL_AUSTRALIA_DIGGER_COAST_BONUS;

--+15% combat on coastal tiles
function CL_AussieDiggerCoastBonus(iPlayer, iUnit, iX, iY)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() then
		local pUnit = pPlayer:GetUnitByID(iUnit);
		if pUnit:GetUnitType() == iDiggerUnit then
			local pPlot = Map.GetPlot(iX, iY);
			if pPlot:IsCoastalLand() then
				if not pUnit:IsHasPromotion(iCoastBonus) then
					pUnit:SetHasPromotion(iCoastBonus, true);
				end
			else
				if pUnit:IsHasPromotion(iCoastBonus) then
					pUnit:SetHasPromotion(iCoastBonus, false);
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(CL_AussieDiggerCoastBonus);