function legion_commander_whirlwind_damage_event( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	if IsValidEntity(caster) and IsValidEntity(target) and ability then
		local casterHeroName = caster:GetUnitName()
		local abilityName = ability:GetAbilityName()
		local playerID = caster:GetPlayerID()

		local targetHeroName = target:GetUnitName()
		local abilityName = ability:GetAbilityName()

		if target:IsRealHero() then
			local targetplayerID = target:GetPlayerID()
			print("[EVENT PROCS][WHIRLWIND DAMAGE EVENT] [" .. casterHeroName .. "]" .. "[PID: " .. playerID .. " ] Damage proc event via " .. abilityName .. " to target:[ " .. targetHeroName .. " ][ " .. targetplayerID .." ]" )

		else
			print("[EVENT PROCS][WHIRLWIND DAMAGE EVENT] [" .. casterHeroName .. "]" .. "[PID: " .. playerID .. " ] Damage proc event via " .. abilityName .. " to target:[ " .. targetHeroName .. " ]")
		end


	else
	end


end
