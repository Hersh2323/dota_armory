function cleaveDictator(event)
	local ability = event.ability
	local caster = event.caster

	local cooldownRemaining = ability:GetCooldownTimeRemaining()
	print(cooldownRemaining)
	if cooldownRemaining == 0 then
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_lc_cleave_possible_datadriven", {})
	else
	end
end


function cleaveCooldown(event)
	local ability = event.ability
	local caster = event.caster

	local coolDown = ability:GetLevelSpecialValueFor("ability_cooldown", (ability:GetLevel() - 1) )

	ability:StartCooldown(coolDown)
end


