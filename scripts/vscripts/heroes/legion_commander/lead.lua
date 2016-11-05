--[[Author: Pizzalol
	Date: 21.09.2015.
	Prepares all the required information for movement]]
function leadInit( keys )
	local caster = keys.caster
	local ability = keys.ability

	local distance = ability:GetLevelSpecialValueFor("lead_distance", (ability:GetLevel() - 1) )

	local caster_location = caster:GetAbsOrigin()
	local fv = caster:GetForwardVector()
	local origin = caster:GetAbsOrigin()


	
	local target_point = origin + fv * distance






	-- Distance calculations
	local speed = ability:GetLevelSpecialValueFor("charge_speed", (ability:GetLevel() - 1))
	local distance = (target_point - caster_location):Length2D()
	local direction = (target_point - caster_location):Normalized()
	local duration = distance/speed

	-- Saving the data in the ability
	ability.time_walk_distance = distance
	ability.time_walk_speed = speed * 1/30 -- 1/30 is how often the motion controller ticks
	ability.time_walk_direction = direction
	ability.time_walk_traveled_distance = 0

	-- Apply the slow aura and invlunerability modifier to the caster
	--ability:ApplyDataDrivenModifier(caster, caster, caster_aura, {duration = duration})
end

--[[Author: Pizzalol
	Date: 21.09.2015.
	Moves the target until it has traveled the distance to the chosen point]]
function leadMotion( keys )
	local caster = keys.target
	local ability = keys.ability

	-- Move the caster while the distance traveled is less than the original distance upon cast
	if ability.time_walk_traveled_distance < ability.time_walk_distance then
		caster:SetAbsOrigin(caster:GetAbsOrigin() + ability.time_walk_direction * ability.time_walk_speed)
		ability.time_walk_traveled_distance = ability.time_walk_traveled_distance + ability.time_walk_speed
	else
		-- Remove the motion controller once the distance has been traveled
		caster:InterruptMotionControllers(false)
	end
end