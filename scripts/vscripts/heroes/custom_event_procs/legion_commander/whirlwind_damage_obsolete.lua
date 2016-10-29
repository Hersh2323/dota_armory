function legion_commander_whirldwind_damage_event( event )
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





		--local duration = ability:GetLevelSpecialValueFor( "vision_duration", ( ability:GetLevel() - 1 ) )



		local caster_base_damage_min = caster:GetBaseDamageMin() 																--print("[caster_base_damage_min] " .. caster_base_damage_min)
		local caster_base_damage_max = caster:GetBaseDamageMax()																--print("[caster_base_damage_max] " .. caster_base_damage_max)
		local caster_base_damage_combined_possibly_float = caster_base_damage_min + caster_base_damage_max						--print("[caster_base_damage_combined_possibly_float] " .. caster_base_damage_combined_possibly_float)
		local caster_base_damage_combined_possibly_float_average = caster_base_damage_combined_possibly_float/2					--print("[caster_base_damage_combined_possibly_float_average] " .. caster_base_damage_combined_possibly_float_average)		
		local caster_base_damage_combined_average_int = math.ceil(caster_base_damage_combined_possibly_float_average) 			--print("[caster_base_damage_combined_average_int] " .. caster_base_damage_combined_average_int)
		local caster_base_damage = caster_base_damage_combined_average_int 														--print("[caster_base_damage] " .. caster_base_damage)

		local abilitySourceForCrit = caster:FindAbilityByName("legion_commander_potion_pb")
		local base_crit_chance = abilitySourceForCrit:GetLevelSpecialValueFor("crit_chance", 0)

		local critical_strike_bonus_modifier = caster:FindModifierByName("modifier_crit_bonus_stack_datadriven")

		if critical_strike_bonus_modifier then 
			local critical_strike_bonus_modifier_stack_value_int = critical_strike_bonus_modifier:GetModifierStackCount(critical_strike_bonus_modifier, caster)
			local base_crit_chance = base_crit_chance + critical_strike_bonus_modifier_stack_value_int
		else
		end

		--print("debug crit chance: " .. base_crit_chance)
		local crit_chance = base_crit_chance

		local crit_damage = abilitySourceForCrit:GetLevelSpecialValueFor("crit_damage", 0)

		local weapon_damage = ability:GetLevelSpecialValueFor( "whirlwind_weapon_damage", ( ability:GetLevel() - 1 ) )

		local damageNonCritical = caster_base_damage*weapon_damage 
		local damageCritical = damageNonCritical*crit_damage

		local crit_roll = RandomFloat(1, 100) -- print("[crit_roll] " .. crit_roll)
		if crit_roll <= crit_chance then

			-- critical
			local damageTable = {
				victim = target,
				attacker = caster,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				damage = damageCritical
			}
			 
			ApplyDamage(damageTable)

			local damageToPrint = math.floor( damageCritical )
			if damageToPrint > 0 then		
				PopupNumbers(target, "crit", Vector(255, 0, 0), 2.0, damageToPrint, nil, POPUP_SYMBOL_POST_LIGHTNING)
			else
			end

			print("[EVENT][DAMAGE EVENT] [" .. casterHeroName .. "]" .. "[PID: " .. playerID .. " ] Damage event via " .. abilityName .. " to target:[ " .. targetHeroName .. " ][ " .. targetplayerID .." ] [DAMAGE CRIT:][ " .. damageCritical .. " ]" )
			------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			-- hook in here for whirlwind criticals
			--------------------------------------------------------------------------------------------------------------------------------------------------------------------


			--------------------------------------------------------------------------------------------------------------------------------------------------------------------
		else
			-- non crit
			local damageTable = {
				victim = target,
				attacker = caster,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage = damageNonCritical
			}
			 
			ApplyDamage(damageTable)

			print("[EVENT][DAMAGE EVENT] [" .. casterHeroName .. "]" .. "[PID: " .. playerID .. " ] Damage event via " .. abilityName .. " to target:[ " .. targetHeroName .. " ][ " .. targetplayerID .." ] [DAMAGE:][ " .. damageNonCritical .. " ]")
			------------------------------------------------------------------------------------------------------------------------------------------------------------------
			-- hook in here for whirlwind non criticals
			------------------------------------------------------------------------------------------------------------------------------------------------------------------
		


			--------------------------------------------------------------------------------------------------------------------------------------------------------------------
		end










	else
	end
end

















