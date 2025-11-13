class_name SpinAirPhysics
extends AirPhysics


@export var spin_action: SpinAction
@export var exit_name: String
@export var exit_threshold: float


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return false


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if not character.input["spin"][0] and spin_action.spin_speed <= exit_threshold:
		character.set_state("action", null)
		return exit_name
	if character.on_ground:
		return ground_name
	return name


## runs every frame while active
func _update() -> void:
	## Gravity
	var total_gravity: float = character.get_gravity_sum()
	character.velocity.y += total_gravity
	apply_air_drag(total_gravity)
	
	var spin_speed: float = spin_action.spin_speed
	if character.input["down"][0]:
		spin_action.spin_speed = max(10, spin_speed + 1)
		# 63 sure did love its weird math equations
		character.velocity.y += sqrt((spin_speed + 1) / 50) / 5;
	else:
		if spin_speed > 7:
			character.velocity.y = MathFuncs.ground_friction(character.velocity.y, 0.3, 1.05)
		else:
			character.velocity.y = MathFuncs.ground_friction(character.velocity.y, 0.1, 1.03)
		character.velocity.y -= sqrt((spin_speed + 1) / 30) / 3
	
	do_air_movement(character.input["left"][0], character.input["right"][0])
