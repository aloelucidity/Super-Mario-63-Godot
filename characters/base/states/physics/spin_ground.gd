class_name SpinGroundPhysics
extends AirPhysics


@export var spin_action: SpinAction
@export var air_name: String
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
	if not character.on_ground:
		return air_name
	return name


## runs every frame while active
func _update() -> void:
	character.velocity.y = min(0, character.velocity.y)
	
	do_friction()
	do_movement(character.input["left"][0], character.input["right"][0])
	
	do_air_movement(character.input["left"][0], character.input["right"][0])
	
