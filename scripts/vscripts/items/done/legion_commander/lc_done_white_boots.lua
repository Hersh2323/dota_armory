

function swap_to_active_item(keys)
	local caster = keys.caster
	local ability = keys.ability

	local swap_cooldown = ability:GetLevelSpecialValueFor("swap_cooldown", 0)

	for i=0, 5, 1 do  --Fill all empty slots in the player's inventory with "dummy" items.
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item == nil then
			caster:AddItem(CreateItem("item_dummy_for_swapping_items_datadriven", caster, caster))
		end
	end

	for i=0, 5, 1 do  --Remove all dummy items from the player's inventory.
		local inactiveBootsToRemove = caster:GetItemInSlot(i)
		if inactiveBootsToRemove ~= nil then
			if inactiveBootsToRemove:GetName() == "item_lc_d1_white_boots_datadriven" then
				caster:RemoveItem(inactiveBootsToRemove)
			end
		end
	end


	--caster:RemoveItem("item_lc_d1_white_boots_datadriven")
	caster:AddItem(CreateItem("item_lc_d1_white_boots_active_datadriven", caster, caster))  --This should be put into the same slot that the removed item was in.

	for i=0, 5, 1 do  
		local cd_item = caster:GetItemInSlot(i)
		if cd_item ~= nil then
			if cd_item:GetName() == "item_lc_d1_white_boots_active_datadriven" then
				--cd_item:StartCooldown(swap_cooldown)


				
			end
		end
	end

	for i=0, 5, 1 do  --Remove all dummy items from the player's inventory.
		local current_item = caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_dummy_for_swapping_items_datadriven" then
				caster:RemoveItem(current_item)

			end
		end
	end

end


function swap_to_inactive_item(keys)
	local caster = keys.caster
	local ability = keys.ability

	local swap_cooldown = ability:GetLevelSpecialValueFor("swap_cooldown", 0)

	for i=0, 5, 1 do  --Fill all empty slots in the player's inventory with "dummy" items.
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item == nil then
			caster:AddItem(CreateItem("item_dummy_for_swapping_items_datadriven", caster, caster))

		end
	end


	for i=0, 5, 1 do  --Remove all dummy items from the player's inventory.
		local inactiveBootsToRemove = caster:GetItemInSlot(i)
		if inactiveBootsToRemove ~= nil then
			if inactiveBootsToRemove:GetName() == "item_lc_d1_white_boots_active_datadriven" then
				caster:RemoveItem(inactiveBootsToRemove)
			end
		end
	end


	--caster:RemoveItem("item_lc_d1_white_boots_datadriven")
	caster:AddItem(CreateItem("item_lc_d1_white_boots_datadriven", caster, caster))  --This should be put into the same slot that the removed item was in.


	
	for i=0, 5, 1 do  --Remove all dummy items from the player's inventory.
		local cd_item = caster:GetItemInSlot(i)
		if cd_item ~= nil then
			if cd_item:GetName() == "item_lc_d1_white_boots_datadriven" then
				--cd_item:StartCooldown(swap_cooldown)


				
			end
		end
	end

	
	for i=0, 5, 1 do  --Remove all dummy items from the player's inventory.
		local current_item = caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_dummy_for_swapping_items_datadriven" then
				caster:RemoveItem(current_item)
			end
		end
	end





end








-- checks if the caster has the required stamina to grant short duration movement speed effect
function stamina_check(event)

	local caster = event.caster
	local staminaAbility = caster:FindAbilityByName("legion_commander_potion_pb")
	local ability = event.ability

	local max_stamina_stacks = staminaAbility:GetLevelSpecialValueFor("max_stamina_stacks", 0)
	local max_stamina_stacks = staminaAbility:GetLevelSpecialValueFor("stamina_per_interval", 0)

	local cost_per_sec = ability:GetLevelSpecialValueFor("stamina_cost_per_sec", 0)

	if IsValidEntity(caster) then
		local staminaModifier = caster:FindModifierByName("modifier_legion_commander_stamina_bar_datadriven")
		if staminaModifier ~= nil then
			local stackCount = staminaModifier:GetStackCount()
			if stackCount > cost_per_sec then

				local stackCountAfterSpent = stackCount - cost_per_sec
				if stackCountAfterSpent == 0 or stackCountAfterSpent == nil then
					staminaModifier:SetStackCount(1)
					caster:RemoveModifierByName("modifier_lc_d1_white_boots_sprint_effect_datadriven")

				else
					staminaModifier:SetStackCount(stackCountAfterSpent)
					ability:ApplyDataDrivenModifier(caster, caster, "modifier_lc_d1_white_boots_sprint_effect_datadriven", {}) 
				end

			else
				ability:CastAbility()
			end
		else
		end
	else
	end


end










--[[ ============================================================================================================
	Author: Rook
	Date: January 25, 2015
	Called when Power Treads (Strength) is cast.  Swaps the item to Power Treads (Intelligence).
================================================================================================================= ]]
function item_toggle_swap_to_active(keys)
	swap_to_item(keys, "item_lc_d1_white_boots_datadriven")
end


--[[ ============================================================================================================
	Author: Rook
	Date: January 25, 2015
	Called when Power Treads (Agility) is cast.  Swaps the item to Power Treads (Strength).
================================================================================================================= ]]
function item_toggle_swap_to_inactive(keys)
	swap_to_item(keys, "item_lc_d1_white_boots_inactive_datadriven")
end

