-- This function will be called at start of the game, but also whenever a player adjusts the difficulty through a unit interaction.
function spawnInNpcs()

	--[[
	GameRules.totalNpcsAvaibleQuest = SpawnEntityFromTableSynchronous( "quest", { name = "totalNpcsAvaibleQuest", title = "#totalNpcsAvaibleQuest" } )

	GameRules.totalNpcsAvaibleQuest.totalNpcsAlive = 0
	GameRules.totalNpcsAvaibleQuest.totalNpcsSpawned = 0


	GameRules.Quest = SpawnEntityFromTableSynchronous( "quest", {
	        name = "QuestName",
	        title = "#QuestKill"
	    })
	GameRules.subQuest = SpawnEntityFromTableSynchronous( "subquest_base", {
	    show_progress_bar = true,
	    progress_bar_hue_shift = -119
	} )
	GameRules.Quest.UnitsKilled = 0
	GameRules.Quest.KillLimit = 0
	GameRules.Quest:AddSubquest( GameRules.subQuest )

	-- text on the quest timer at start
	GameRules.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, 0 )
	GameRules.Quest:SetTextReplaceValue( QUEST_TEXT_REPLACE_VALUE_TARGET_VALUE, GameRules.Quest.KillLimit )

	-- value on the bar
	GameRules.subQuest:SetTextReplaceValue( SUBQUEST_TEXT_REPLACE_VALUE_CURRENT_VALUE, 0 )
	GameRules.subQuest:SetTextReplaceValue( SUBQUEST_TEXT_REPLACE_VALUE_TARGET_VALUE, GameRules.Quest.KillLimit )
	]]


	if GameRules.DifficultyLevel == nil then
		GameRules.DifficultyLevel = 1
	else
	end

	GameRules.NPCList = {}
	spawn_skeleton_one_one()
	spawn_skeleton_one_two()
	spawn_skeleton_one_three()
	spawn_skeleton_one_four()
	spawn_skeleton_one_five()
	spawn_skeleton_one_six()
	spawn_skeleton_one_seven()
	spawn_skeleton_one_eight()
	spawn_skeleton_one_nine()
	spawn_skeleton_one_ten()


	Timers:CreateTimer(0, function()

		spawn_skeleton_one_one()
		spawn_skeleton_one_two()
		spawn_skeleton_one_three()
		spawn_skeleton_one_four()
		spawn_skeleton_one_five()
		spawn_skeleton_one_six()
		spawn_skeleton_one_seven()
		spawn_skeleton_one_eight()
		spawn_skeleton_one_nine()
		spawn_skeleton_one_ten()

		return 90
	end)

end


function custom_function_on_GLOBAL_VARIABLE_CURRENT_HERO_LEVEL_increase()
	print("custom_function_on_GLOBAL_VARIABLE_CURRENT_HERO_LEVEL_increase() has executed" )
	local npc_to_adjust_global_variable = Entities:FindAllByClassname("npc_dota_creep_neutral")
	custom_function_adjust_npc_stats(npc_to_adjust_global_variable)
end


function custom_function_adjust_npc_stats(npc_to_adjust_global_variable)
	--print(" custom_function_adjust_npc_stats() has executed" )

	local npc_to_adjust = npc_to_adjust_global_variable

	if IsValidEntity(npc_to_adjust) and 
		GLOBAL_VARIABLE_CURRENT_HERO_LEVEL and
		GLOBAL_VARIABLE_ADDITION_DIFFICULTY_HERO_LEVEL and
		GLOBAL_VARIABLE_ADDITIONAL_HEALTH_PER_LEVEL and
		GLOBAL_VARIABLE_BASE_HEALTH and
		GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_MINION and
		GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_STANDARD and
		GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_ELITE and 
		GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_BOSS then

	    for abilitySlot=0,17 do
	        local ability = npc_to_adjust:GetAbilityByIndex(abilitySlot)

	        if ability then
	            ability:SetLevel(1)
	        end
	    end


		--print("custom_function_adjust_npc_stats has ran")

	else
		--print("custom_function_adjust_npc_stats has ran, but some global variables have passed boolean false i.e. nil")
	end
end


function custom_function_modify_health_and_damage(event)
	local caster = event.caster
	local ability = event.ability

	if IsValidEntity(caster) and 
	GLOBAL_VARIABLE_CURRENT_HERO_LEVEL and
	GLOBAL_VARIABLE_ADDITION_DIFFICULTY_HERO_LEVEL and
	GLOBAL_VARIABLE_ADDITIONAL_HEALTH_PER_LEVEL and
	GLOBAL_VARIABLE_BASE_HEALTH and
	GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_MINION and
	GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_STANDARD and
	GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_ELITE and 
	GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_BOSS then

		print("GLOBAL_VARIABLE_CURRENT_HERO_LEVEL: " .. GLOBAL_VARIABLE_CURRENT_HERO_LEVEL)
		print("GLOBAL_VARIABLE_ADDITION_DIFFICULTY_HERO_LEVEL: " .. GLOBAL_VARIABLE_ADDITION_DIFFICULTY_HERO_LEVEL)
		print("GLOBAL_VARIABLE_ADDITIONAL_HEALTH_PER_LEVEL: " .. GLOBAL_VARIABLE_ADDITIONAL_HEALTH_PER_LEVEL)
		print("GLOBAL_VARIABLE_BASE_HEALTH: " .. GLOBAL_VARIABLE_BASE_HEALTH)
		print("GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_MINION: " .. GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_MINION)
		print("GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_STANDARD: " .. GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_STANDARD)
		print("GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_ELITE: " .. GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_ELITE)
		print("GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_BOSS: " .. GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_BOSS)

		local difficulty_scaled_level_combined = GLOBAL_VARIABLE_CURRENT_HERO_LEVEL + GLOBAL_VARIABLE_ADDITION_DIFFICULTY_HERO_LEVEL

		local health_to_be_adjusted = difficulty_scaled_level_combined*GLOBAL_VARIABLE_ADDITIONAL_HEALTH_PER_LEVEL   

		local health_to_be_adjusted_to = GLOBAL_VARIABLE_BASE_HEALTH+health_to_be_adjusted*GLOBAL_VARIABLE_MOB_TYPE_HEALTH_MULTIPLIER_STANDARD
		print("Health to be adjusted to: " .. health_to_be_adjusted_to)

		local caster_max_health = caster:GetMaxHealth()
		local caster_current_health = caster:GetHealth()

		local health_percentage_in_float = caster_current_health/caster_max_health
		--print("health_percentage_in_float: " .. health_percentage_in_float)
		local health_value_adjusted_to_percentage = health_to_be_adjusted_to*health_percentage_in_float

		caster:SetBaseMaxHealth(health_to_be_adjusted_to)
		--caster:SetHealth(health_value_adjusted_to_percentage)


		local caster_base_attack_time = caster:GetBaseAttackTime()
		local current_dps = difficulty_scaled_level_combined*GLOBAL_VARIABLE_CREEP_DPS_PER_LEVEL
		local caster_base_damage_to_set = caster_base_attack_time*current_dps
		caster:SetBaseDamageMax( caster_base_damage_to_set )
		caster:SetBaseDamageMin( caster_base_damage_to_set )

	else
		print("custom_function_modify_health_and_damage has failed")
	end
end


function spawn_skeleton_one_one()
	local spawn_location_ent = Entities:FindByName(nil, "npc_spawn_location_skeleton_one_one")
	local npc_unit_name = "npc_armory_skeleton_one"
	--[[
		global var name = GameRules.NPCList.npc_armory_skeleton_one_one
	]]
	local spawn_location_origin = spawn_location_ent:GetAbsOrigin()

	if IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_one ) then
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_one ) Passed True")
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_one)

	else
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_one ) Passed False")

		GameRules.NPCList.npc_armory_skeleton_one_one = CreateUnitByName(npc_unit_name, spawn_location_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_one)
	end

end

function spawn_skeleton_one_two()
	local spawn_location_ent = Entities:FindByName(nil, "npc_spawn_location_skeleton_one_two")
	local npc_unit_name = "npc_armory_skeleton_one"
	--[[
		global var name = GameRules.NPCList.npc_armory_skeleton_one_two
	]]
	local spawn_location_origin = spawn_location_ent:GetAbsOrigin()

	if IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_two ) then
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_two ) Passed True")
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_two)

	else
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_two ) Passed False")

		GameRules.NPCList.npc_armory_skeleton_one_two = CreateUnitByName(npc_unit_name, spawn_location_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_two)
	end

end

function spawn_skeleton_one_three()
	local spawn_location_ent = Entities:FindByName(nil, "npc_spawn_location_skeleton_one_three")
	local npc_unit_name = "npc_armory_skeleton_one"
	--[[
		global var name = GameRules.NPCList.npc_armory_skeleton_one_three
	]]
	local spawn_location_origin = spawn_location_ent:GetAbsOrigin()

	if IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_three ) then
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_three ) Passed True")
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_three)

	else
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_three ) Passed False")

		GameRules.NPCList.npc_armory_skeleton_one_three = CreateUnitByName(npc_unit_name, spawn_location_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_three)
	end

end

function spawn_skeleton_one_four()
	local spawn_location_ent = Entities:FindByName(nil, "npc_spawn_location_skeleton_one_four")
	local npc_unit_name = "npc_armory_skeleton_one"
	--[[
		global var name = GameRules.NPCList.npc_armory_skeleton_one_four
	]]
	local spawn_location_origin = spawn_location_ent:GetAbsOrigin()

	if IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_four ) then
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_four ) Passed True")
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_four)

	else
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_four ) Passed False")

		GameRules.NPCList.npc_armory_skeleton_one_four = CreateUnitByName(npc_unit_name, spawn_location_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_four)
	end

end

function spawn_skeleton_one_five()
	local spawn_location_ent = Entities:FindByName(nil, "npc_spawn_location_skeleton_one_five")
	local npc_unit_name = "npc_armory_skeleton_one"
	--[[
		global var name = GameRules.NPCList.npc_armory_skeleton_one_five
	]]
	local spawn_location_origin = spawn_location_ent:GetAbsOrigin()

	if IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_five ) then
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_five ) Passed True")
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_five)

	else
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_five ) Passed False")

		GameRules.NPCList.npc_armory_skeleton_one_five = CreateUnitByName(npc_unit_name, spawn_location_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_five)
	end

end

function spawn_skeleton_one_six()
	local spawn_location_ent = Entities:FindByName(nil, "npc_spawn_location_skeleton_one_six")
	local npc_unit_name = "npc_armory_skeleton_one"
	--[[
		global var name = GameRules.NPCList.npc_armory_skeleton_one_six
	]]
	local spawn_location_origin = spawn_location_ent:GetAbsOrigin()

	if IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_six ) then
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_six ) Passed True")
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_six)

	else
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_six ) Passed False")

		GameRules.NPCList.npc_armory_skeleton_one_six = CreateUnitByName(npc_unit_name, spawn_location_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_six)
	end

end

function spawn_skeleton_one_seven()
	local spawn_location_ent = Entities:FindByName(nil, "npc_spawn_location_skeleton_one_seven")
	local npc_unit_name = "npc_armory_skeleton_one"
	--[[
		global var name = GameRules.NPCList.npc_armory_skeleton_one_seven
	]]
	local spawn_location_origin = spawn_location_ent:GetAbsOrigin()

	if IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_seven ) then
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_seven ) Passed True")
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_seven)

	else
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_seven ) Passed False")

		GameRules.NPCList.npc_armory_skeleton_one_seven = CreateUnitByName(npc_unit_name, spawn_location_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_seven)
	end

end

function spawn_skeleton_one_eight()
	local spawn_location_ent = Entities:FindByName(nil, "npc_spawn_location_skeleton_one_eight")
	local npc_unit_name = "npc_armory_skeleton_one"
	--[[
		global var name = GameRules.NPCList.npc_armory_skeleton_one_eight
	]]
	local spawn_location_origin = spawn_location_ent:GetAbsOrigin()

	if IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_eight ) then
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_eight ) Passed True")
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_eight)

	else
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_eight ) Passed False")

		GameRules.NPCList.npc_armory_skeleton_one_eight = CreateUnitByName(npc_unit_name, spawn_location_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_eight)
	end

end

function spawn_skeleton_one_nine()
	local spawn_location_ent = Entities:FindByName(nil, "npc_spawn_location_skeleton_one_nine")
	local npc_unit_name = "npc_armory_skeleton_one"
	--[[
		global var name = GameRules.NPCList.npc_armory_skeleton_one_nine
	]]
	local spawn_location_origin = spawn_location_ent:GetAbsOrigin()

	if IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_nine ) then
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_nine ) Passed True")
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_nine)

	else
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_nine ) Passed False")

		GameRules.NPCList.npc_armory_skeleton_one_nine = CreateUnitByName(npc_unit_name, spawn_location_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_nine)
	end

end

function spawn_skeleton_one_ten()
	local spawn_location_ent = Entities:FindByName(nil, "npc_spawn_location_skeleton_one_ten")
	local npc_unit_name = "npc_armory_skeleton_one"
	--[[
		global var name = GameRules.NPCList.npc_armory_skeleton_one_ten
	]]
	local spawn_location_origin = spawn_location_ent:GetAbsOrigin()

	if IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_ten ) then
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_ten ) Passed True")
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_ten)

	else
		print("IsValidEntity( GameRules.NPCList.npc_armory_skeleton_one_ten ) Passed False")

		GameRules.NPCList.npc_armory_skeleton_one_ten = CreateUnitByName(npc_unit_name, spawn_location_origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
		custom_function_adjust_npc_stats(GameRules.NPCList.npc_armory_skeleton_one_ten)
	end

end

