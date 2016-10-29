function legion_commander_potion_potion_cast( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	if IsValidEntity(caster) and IsValidEntity(target) and ability then
		local casterHeroName = caster:GetUnitName()
		local abilityName = ability:GetAbilityName()
		local playerID = caster:GetPlayerID()

		print("[EVENT PROCS][ABILITY MODIFIER APPLICATION] [" .. casterHeroName .. "]" .. "[PID: " .. playerID .. " ] casts (OnSpellStart) " .. abilityName)

	else
	end




end

function legion_commander_potion_potion_fade( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	if IsValidEntity(caster) and IsValidEntity(target) and ability then
		local casterHeroName = caster:GetUnitName()
		local abilityName = ability:GetAbilityName()
		local playerID = caster:GetPlayerID()

		print("[EVENT PROCS][ABILITY MODIFIER FADES] [" .. casterHeroName .. "]" .. "[PID: " .. playerID .. " ] casts (OnSpellStart) " .. abilityName)

	else
	end


end