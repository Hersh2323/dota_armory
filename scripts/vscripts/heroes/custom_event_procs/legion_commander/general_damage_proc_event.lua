function legion_commander_general_damage_proc_event( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	if IsValidEntity(caster) and IsValidEntity(target) and ability then
		local casterHeroName = caster:GetUnitName()
		local abilityName = ability:GetAbilityName()
		local playerID = caster:GetPlayerID()

		local targetHeroName = target:GetUnitName()
		local abilityName = ability:GetAbilityName()
		local targetplayerID = target:GetPlayerID()


		print("[EVENT PROCS][DAMAGE PROC] [" .. casterHeroName .. "]" .. "[PID: " .. playerID .. " ] Damage proc event via " .. abilityName .. " to target:[ " .. targetHeroName .. " ][ " .. targetplayerID .." ]" )

	else
	end


end
