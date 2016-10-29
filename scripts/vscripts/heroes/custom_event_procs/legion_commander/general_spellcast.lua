function legion_commander_general_spellcast( event )
	local caster = event.caster
	local ability = event.ability

	if IsValidEntity(caster) and ability then
		local casterHeroName = caster:GetUnitName()
		local abilityName = ability:GetAbilityName()
		local playerID = caster:GetPlayerID()


		print("[EVENT PROCS][GENERAL SPELLCAST] [" .. casterHeroName .. "]" .. "[PID: " .. playerID .. " ] casts (OnSpellStart) " .. abilityName)

	else
	end


end
