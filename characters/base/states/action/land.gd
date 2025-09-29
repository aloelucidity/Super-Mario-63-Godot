class_name LandAction
extends ActionState


@export var fall_damage_action: FallDamageAction
@export var land_physics: PhysicsState

## need to compare what the character's velocity was before
## they touched the ground and it was set to 0
var last_velocity: Vector2
var land_time: int
var stop_counter: int
var stop_target: int
var should_land: bool


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return should_land


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if stop_counter > stop_target or not character.on_ground:
		return ""
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	character.set_state("physics", land_physics)
	stop_counter = 0
	stop_target = land_time


## runs once when this state stops being active
func _on_exit() -> void:
	stop_counter = 0


## runs every frame while active
func _update() -> void:
	stop_counter += 1


## always runs no matter what, before any of the other functions
func _general_update() -> void:
	should_land = false
	if character.on_ground:
		if last_velocity.y < 16:
			## bitshift right by 3 is the same as dividing by 8
			land_time = round(fall_damage_action.fall_count >> 3) - 2  
			if character.input["up"][0]:
				land_time -= 3
				if (character.input["right"][0] or character.input["left"][0]) and land_time >= 1:
					land_time -= 2
					land_time = max(land_time, 1)
			
			land_time -= min(abs(last_velocity.x / 1.5), 3)
			
			if last_velocity.y > 3 and land_time > 0:
				land_time = max(land_time, 1)
				land_time = min(land_time, 3)
				should_land = true
			
			if last_velocity.y > 3 and land_time < 1 and not should_land and character.input["up"][0]:
				land_time = 1
				should_land = true
		
		## consider moving this to fall damage action somehow because this
		## kind of coupling probably isnt really good to keep  
		fall_damage_action.fall_count = 0
	last_velocity = character.velocity
