function custom_base_damage_calculation( event, ability, caster, base_damage_min, base_damage_max ) -- returns weapon damage value in integer
	local ability = ability
	local caster = caster

	local caster_base_damage_min = base_damage_min
	local caster_base_damage_max = base_damage_max


	if ability and IsValidEntity(caster) and base_damage_max and base_damage_min then

		local caster_base_damage_combined_possibly_float = caster_base_damage_min + caster_base_damage_max						print("[caster_base_damage_combined_possibly_float] " .. caster_base_damage_combined_possibly_float)
		local caster_base_damage_combined_possibly_float_average = caster_base_damage_combined_possibly_float/2					print("[caster_base_damage_combined_possibly_float_average] " .. caster_base_damage_combined_possibly_float_average)		
		local caster_base_damage_combined_average_int = math.ceil(caster_base_damage_combined_possibly_float_average) 			print("[caster_base_damage_combined_average_int] " .. caster_base_damage_combined_average_int)
		local caster_base_damage_caluclated = caster_base_damage_combined_average_int 											print("[caster_base_damage_caluclated] " .. caster_base_damage_caluclated)


		--print(caster_base_damage_caluclated)
		return caster_base_damage_caluclated
	else
		print("ERROR: custom_base_damage_calculation function broke")
	end

end






function damage_output_post_critical_strike_roll(event, ability, caster, target, base_crit_chance, crit_damage, weapon_damage, damage_type, caster_base_damage_caluclated)

	local critical_strike_bonus_modifier = caster:FindModifierByName("modifier_crit_bonus_stack_datadriven")

	local crit_chance = base_crit_chance
	local critical_strike_bonus_modifier_stack_value_int = 0

	if critical_strike_bonus_modifier then 
		local critical_strike_bonus_modifier_stack_value_int = caster:GetModifierStackCount("critical_strike_bonus_modifier", caster)
		local crit_chance = base_crit_chance + critical_strike_bonus_modifier_stack_value_int
	else
		print("Attempted to determine bonus critical strike chance modifier, but none was found")
	end

	local crit_chance_for_roll = crit_chance
	local abilityName = ability:GetAbilityName()

	print("-------------- [ ABILITY CRIT CHANCE ROLL ] -------------- Ability: " .. abilityName)
	print("-------------- [ CASTER BASE CRIT CHANCE ] -------------- Base Crit Chance: " .. base_crit_chance)
	print("-------------- [ CASTER BONUS CRIT CHANCE ] -------------- Bonus Crit Chance: " .. critical_strike_bonus_modifier_stack_value_int)
	print("-------------- [ COMBINED CRIT CHANCE ] -------------- Combined Crit Chance:" .. crit_chance)

	local caster_base_damage_caluclated = caster_base_damage_caluclated
	local damage_type = damage_type
	local damageNonCritical = caster_base_damage_caluclated*weapon_damage 
	local damageCritical = damageNonCritical*crit_damage

	local crit_roll = RandomFloat(1, 100) -- print("[crit_roll] " .. crit_roll)
	print("-------------- [ ABILITY CRIT ROLL ] -------------- " .. crit_roll)


	if crit_roll <= crit_chance then

		-- critical
		local damageTable = {
			victim = target,
			attacker = caster,
			damage_type = damage_type,
			damage = damageCritical
		}
		 
		ApplyDamage(damageTable)

		local damageToPrint = math.floor( damageCritical )
		if damageToPrint > 0 then		
			PopupNumbers(target, "crit", Vector(255, 0, 0), 2.0, damageToPrint, nil, POPUP_SYMBOL_POST_LIGHTNING)
		else
		end

		-------------------------------------------------------------------------------------------------------------------------------------------------------------------
		-- hook in here for criticals
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	else
		-- non crit
		local damageTable = {
			victim = target,
			attacker = caster,
			damage_type = damage_type,
			damage = damageNonCritical
		}
		 
		ApplyDamage(damageTable)

		------------------------------------------------------------------------------------------------------------------------------------------------------------------
		-- hook in here for non criticals
		------------------------------------------------------------------------------------------------------------------------------------------------------------------

		--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	end

end











function ability_whirlwind_damage(event)
	local ability = event.ability
	local caster = event.caster
	local target = event.target

	local base_damage_min = caster:GetBaseDamageMin() 																
	local base_damage_max = caster:GetBaseDamageMax()	

	local caster_base_damage_caluclated = custom_base_damage_calculation(event, ability, caster, base_damage_min, base_damage_max ) -- returns weapon damage value in integer




	if caster:GetUnitName() == "npc_dota_hero_legion_commander" and IsValidEntity(caster) then

		local abilitySourceForCrit = caster:FindAbilityByName("legion_commander_potion_pb")
		local base_crit_chance = abilitySourceForCrit:GetLevelSpecialValueFor("crit_chance", 0)
		local crit_damage = abilitySourceForCrit:GetLevelSpecialValueFor("crit_damage", 0)
		local weapon_damage = ability:GetLevelSpecialValueFor( "ability_weapon_damage", ( ability:GetLevel() - 1 ) ) / 100

		local damage_type = ability:GetAbilityDamageType()

		damage_output_post_critical_strike_roll(event, ability, caster, target, base_crit_chance, crit_damage, weapon_damage, damage_type, caster_base_damage_caluclated)

	else
	end





	
	--local damage_to_deal_after_critical_strike_roll_and_calculation = 
	
	--print("This is printing from intial called function: custom_damage_test " .. caster_base_damage_caluclated)
end





function ability_strike_damage(event)
	local ability = event.ability
	local caster = event.caster
	local target = caster:GetAttackTarget()

	local base_damage_min = caster:GetBaseDamageMin() 																
	local base_damage_max = caster:GetBaseDamageMax()	

	local caster_base_damage_caluclated = custom_base_damage_calculation(event, ability, caster, base_damage_min, base_damage_max ) -- returns weapon damage value in integer




	if caster:GetUnitName() == "npc_dota_hero_legion_commander" and IsValidEntity(caster) then

		local abilitySourceForCrit = caster:FindAbilityByName("legion_commander_potion_pb")
		local base_crit_chance = abilitySourceForCrit:GetLevelSpecialValueFor("crit_chance", 0)
		local crit_damage = abilitySourceForCrit:GetLevelSpecialValueFor("crit_damage", 0)
		local weapon_damage = ability:GetLevelSpecialValueFor( "ability_weapon_damage", ( ability:GetLevel() - 1 ) ) / 100

		local damage_type = ability:GetAbilityDamageType()

		if target and IsValidEntity(target) and target:IsAlive() then

			local target_hull = target:GetHullRadius()
			local caster_hull = caster:GetHullRadius()
			local caster_attack_range = caster:GetAttackRange()
			local melee_cast_range = target_hull + caster_hull + caster_attack_range

			local casterPos = caster:GetAbsOrigin()
			local targetPos = target:GetAbsOrigin()

			local difference = targetPos - casterPos
			print( difference:Length2D() )



			local mana_cost = ability:GetLevelSpecialValueFor("mana_cost", 0)
			local caster_current_mana = caster:GetMana()


			if mana_cost > caster_current_mana then
				
			end

			if difference:Length2D() < melee_cast_range+1 and mana_cost <= caster_current_mana then

				caster:SpendMana(mana_cost, ability)

				damage_output_post_critical_strike_roll(event, ability, caster, target, base_crit_chance, crit_damage, weapon_damage, damage_type, caster_base_damage_caluclated)

				EmitSoundOnLocationWithCaster(casterPos, "Hero_LegionCommander.Courage", caster)

    			StartAnimation(caster, {duration=0.4, activity=ACT_DOTA_ATTACK, rate=2.0})

    			ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_base_attack_explosion_flash_b.vpcf", PATTACH_ABSORIGIN, caster)

				local cooldown = ability:GetLevelSpecialValueFor("ability_cooldown", 0)

				ability:StartCooldown(cooldown)


			end
		else

		end

		if ability:GetToggleState() == true then
			ability:ToggleAbility()
		end

	else
	end





	
	--local damage_to_deal_after_critical_strike_roll_and_calculation = 
	
	--print("This is printing from intial called function: custom_damage_test " .. caster_base_damage_caluclated)
end






