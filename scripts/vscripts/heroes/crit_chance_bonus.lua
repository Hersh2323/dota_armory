function gainCriticalStrikeChance( event, caster, ability, additionalCritChance, critBonusStackModifierAbility, modifier_stack )

	local critical_strike_bonus_modifier = caster:FindModifierByName("modifier_crit_bonus_stack_datadriven")

	if critical_strike_bonus_modifier then 
		local currentStackSize = caster:GetModifierStackCount(modifier_stack, caster)
		if currentStackSize < 1 then

			caster:SetModifierStackCount(modifier_stack, caster, currentStackSize+additionalCritChance)
		else
			caster:SetModifierStackCount(modifier_stack, caster, additionalCritChance)
		end
	else
		critBonusStackModifierAbility:ApplyDataDrivenModifier(caster, caster, "modifier_crit_bonus_stack_datadriven", {}) 
		caster:SetModifierStackCount(modifier_stack, caster, additionalCritChance)
	end
end 

function removeCriticalStrikeChance( event, caster, ability, additionalCritChance, critBonusStackModifierAbility, modifier_stack )

	local critical_strike_bonus_modifier = caster:FindModifierByName("modifier_crit_bonus_stack_datadriven")

	if critical_strike_bonus_modifier then 
		local currentStackSize = caster:GetModifierStackCount(modifier_stack, caster)
		if currentStackSize > 0 then
			caster:SetModifierStackCount(modifier_stack, caster, currentStackSize-additionalCritChance)
		else
			--ability:SetModifierStackCount(critical_strike_bonus_modifier, caster, additionalCritChance)
		end
	else
		print("possible error: removeCriticalStrikeChance ; attempted to reduce critical strike chance modifier but none exists. modifier should be created OnEquip of item calling this function")
	end


end 

function lcD1WhiteRingEquip(event)
	local caster = event.caster
	local ability = event.ability
	local target = event.target

	local modifier_stack = event.modifier_stack

	local additionalCritChance = ability:GetLevelSpecialValueFor("crit_chance_bonus", 0)
	local critBonusStackModifierAbility = caster:FindAbilityByName("legion_commander_potion_pb")


	gainCriticalStrikeChance( event, caster, ability, additionalCritChance, critBonusStackModifierAbility, modifier_stack )

end

function lcD1WhiteRingUnequip(event)
	local caster = event.caster
	local ability = event.ability
	local target = event.target

	local modifier_stack = event.modifier_stack

	local additionalCritChance = ability:GetLevelSpecialValueFor("crit_chance_bonus", 0)
	local critBonusStackModifierAbility = caster:FindAbilityByName("legion_commander_potion_pb")

	removeCriticalStrikeChance( event, caster, ability, additionalCritChance, critBonusStackModifierAbility, modifier_stack )

end