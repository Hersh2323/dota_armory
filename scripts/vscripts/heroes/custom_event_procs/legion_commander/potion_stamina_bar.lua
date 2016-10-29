-- sets up stamina bar for use with items or abilities
function stamina_init(event)
	local caster = event.caster
	local ability = event.ability

	local max_stamina_stacks = ability:GetLevelSpecialValueFor("max_stamina_stacks", 0)

	if IsValidEntity(caster) then
		local staminaModifier = caster:FindModifierByName("modifier_legion_commander_stamina_bar_datadriven")
		if staminaModifier ~= nil then
			local stackCount = staminaModifier:GetStackCount()
			if stackCount > 0 then
			else
				staminaModifier:SetStackCount(max_stamina_stacks)
			end
		else
		end
	else
	end
end

-- called to regenerate stamina
function stamina_regen(event)
	local caster = event.caster
	local ability = event.ability

	local max_stamina_stacks = ability:GetLevelSpecialValueFor("max_stamina_stacks", 0)
	local stamina_per_interval = ability:GetLevelSpecialValueFor("stamina_per_interval", 0)

	if IsValidEntity(caster) then
		local staminaModifier = caster:FindModifierByName("modifier_legion_commander_stamina_bar_datadriven")
		if staminaModifier then
			local stackCount = staminaModifier:GetStackCount()
			if stackCount > max_stamina_stacks then
			else
				if stackCount > 0 then
					staminaModifier:SetStackCount(stackCount+stamina_per_interval)
				else
				end
			end
		else
			print("This should print of staminaModifier is nil ")
		end
	else
		print("This should print of caster is nil ")
	end
end



