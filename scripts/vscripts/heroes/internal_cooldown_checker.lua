function custom_function_internal_cooldown_checker(event, ability, caster, target, proc_effect_modifier, icd_debuff_modifier, internal_cooldown)

	if caster:HasModifier(icd_debuff_modifier) then
	else
		ability:ApplyDataDrivenModifier(caster, caster, proc_effect_modifier, {})
		ability:ApplyDataDrivenModifier(caster, caster, icd_debuff_modifier, {})
		ability:StartCooldown(internal_cooldown)
	end

end

function lc_d1_white_trinket_icd_checker(event)
	local ability = event.ability
	local caster = event.caster
	local target = event.target

	local internal_cooldown = ability:GetLevelSpecialValueFor("proc_internal_cooldown", 0)

	local proc_effect_modifier = "modifier_lc_d1_white_trinket_proc_datadriven"
	local icd_debuff_modifier = "modifier_lc_d1_white_trinket_internal_cooldown_datadriven"

	custom_function_internal_cooldown_checker(event, ability, caster, target, proc_effect_modifier, icd_debuff_modifier, internal_cooldown)

end