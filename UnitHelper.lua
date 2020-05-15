function UnitsChangeDamage(playerID, plotX, plotY, delta)
	local units = Units.GetUnitsInPlotLayerID(plotX, plotY, MapLayers.ANY)
	if units == nil then
		print('units nil')
		return
	end

	for _, unit in pairs(units) do
		if unit:GetOwner() == playerID and unit:GetCombat() > 0 then
			-- it's a combat unit
			print(GameInfo.Units[unit:GetType()].UnitType, 'damage', delta)
			if ((unit:GetDamage() + delta) >= 100) then
				unit:SetDamage(100);
				UnitManager.Kill(unit); -- a false parameter appears in FireTuner, its effect is unknown.
			else
				unit:ChangeDamage(delta);
			end
		end
	end
end


Events.LoadScreenClose.Add(function()
	ExposedMembers.gqqnbig = ExposedMembers.gqqnbig or {}
	ExposedMembers.gqqnbig.KillUnitIn0HPCity = ExposedMembers.gqqnbig.KillUnitIn0HPCity or {}
	ExposedMembers.gqqnbig.KillUnitIn0HPCity.UnitsChangeDamage = UnitsChangeDamage
end)
