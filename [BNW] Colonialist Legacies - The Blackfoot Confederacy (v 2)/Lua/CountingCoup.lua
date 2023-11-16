-- CountingCoup -- Author: Neirai -- DateCreated: 5/8/2014 1:40:33 PM
-- Allows Counting Coup to be a big part of playing the Blackfoot --
--------------------------------------------------------------------
function CheckBravery(pPlayer, pUnit)
	--local pPlayer = Players[player]
	--local pUnit = pPlayer:GetUnitByID(unit)
	local pPlot = pUnit:GetPlot()
	local x = pPlot:GetX()
	local y = pPlot:GetY()
	print(x .. ", " .. y)
	local range = 1
	for dx = -range, range do
		for dy = -range, range do
			local plot = Map.PlotXYWithRangeCheck(x, y, dx, dy, range)
			if plot then
				local pOther = plot:GetUnit()
				if pOther ~= nil then
					local pTeam = pPlayer:GetTeam()
					local oTeam = pOther:GetTeam()
					if Teams[pTeam]:IsAtWar(Teams[oTeam]) then
						print("We're at war")
						return true
					end
				end
			end
		end
	end
	return false
end

function CountSomeCoup(PlayerID)
	local pPlayer = Players[PlayerID]
	local pCiv = pPlayer:GetCivilizationType()
	if (pCiv == GameInfoTypes.CIVILIZATION_CLBLACKFOOT) then
		print ("I'm gonna count me some coup")
  		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_COUNTSCOUP1) then --has this unit triggered counting coup?
				if CheckBravery(pPlayer, pUnit) then
					local pExp = (pUnit:GetLevel() * 0.4)
					if pExp > 2 then
						print("Big Extra XP")
						pUnit:ChangeExperience(pExp, -1)
					else
						print("Little Extra XP")
						pUnit:ChangeExperience(2, -1)
					end
				end
				local pPlot = pUnit:GetPlot()
				if pPlot:GetResourceType(-1) == GameInfoTypes.RESOURCE_BISON or pPlot:GetResourceType(-1) == GameInfoTypes.RESOURCE_PRESERVEDBISON then
					local pExp = (pUnit:GetLevel() * 0.4)
                    if pExp > 2 then
                        print("Big Extra XP")
                        pUnit:ChangeExperience(pExp, -1)
                    else
                        print("Little Extra XP")
                        pUnit:ChangeExperience(2, -1)
                    end
					pUnit:ChangeDamage(15)
				end
			end
		end
	else
		for pUnit in pPlayer:Units() do
			local pPlot = pUnit:GetPlot()
			if pPlot ~= nil then
				local owner = pPlot:GetOwner()
                if owner ~= -1 then
                    local pOwner = Players[owner]
				    if pOwner:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CLBLACKFOOT then
					    if pPlot:GetResourceType(-1) == GameInfoTypes.RESOURCE_BISON or pPlot:GetResourceType(-1) == GameInfoTypes.RESOURCE_PRESERVEDBISON then
					       	print("Bison Damage!")
					       	local BisonDamage = pUnit:GetCurrHitPoints() - 25
					       	if BisonDamage > 0 then
					       		pUnit:ChangeDamage(25)
					       	else
					       		pUnit:Kill(true, -1)
					       	end
					    end
                    end
				end
			end
		end	
	end
end
GameEvents.PlayerDoTurn.Add(CountSomeCoup)