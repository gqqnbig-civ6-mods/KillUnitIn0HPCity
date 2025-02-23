---@param damageType DefenseType
function OnDistrictDamageChanged(playerID, districtID, damageType, newDamage, oldDamage)
	if damageType == DefenseTypes.DISTRICT_OUTER then
		return
	end

	print('OnDistrictDamageChanged', playerID, districtID, damageType, newDamage, oldDamage)

	local player = Players[playerID];
	if (player == nil) then
		return
	end
	local district = player:GetDistricts():FindID(districtID);
	if district == nil then
		return
	end

	local hitToUnitPercent = district:GetDamage(DefenseTypes.DISTRICT_OUTER) / district:GetMaxDamage(DefenseTypes.DISTRICT_OUTER)
	print(hitToUnitPercent .. ' to the unit')
	local damage = newDamage - oldDamage
	local damageToUnit = hitToUnitPercent * damage

	-- If the city has 0 HP, make at least 50 damage to the unit inside.
	if damageToUnit < 50 and district:GetDamage(DefenseTypes.DISTRICT_GARRISON) == district:GetMaxDamage(DefenseTypes.DISTRICT_GARRISON) then
		damageToUnit = 50
	end

	if damageToUnit > 1 then
		ExposedMembers.gqqnbig.KillUnitIn0HPCity.UnitsChangeDamage(playerID, district:GetX(), district:GetY(), damageToUnit)
	end

end

Events.LoadScreenClose.Add(function()
	Events.DistrictDamageChanged.Add(OnDistrictDamageChanged);
end)
