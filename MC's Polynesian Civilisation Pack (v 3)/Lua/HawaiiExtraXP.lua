----------------------------
-- XP Promotion Script
-- Author: Leugi
------------------------
local XPPromo = GameInfoTypes.PROMOTION_MC_KOA_XP;
local XPDone = GameInfoTypes.PROMOTION_MC_KOA_XP_CONSUMED;
local XP = 10;

function MoreXP(iPlayer, iUnit)
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
        for pUnit in pPlayer:Units() do
            if (pUnit:IsHasPromotion(XPPromo)) then
                local CurrXP = pUnit:GetExperience();
                local XPbonus = (CurrXP + XP);
                pUnit:SetExperience(XPbonus)
                pUnit:SetHasPromotion(XPDone,true);
                pUnit:SetHasPromotion(XPPromo,false);
            end
        end
    end
end


Events.SerialEventUnitCreated.Add(MoreXP)