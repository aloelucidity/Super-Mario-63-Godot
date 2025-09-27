class_name AirPhysics
extends MovementPhysics


@export var ground_name: String
@export var do_air_animation: bool


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return not character.on_ground


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if character.on_ground:
		return ground_name
	return name


## runs every frame while active
func _update() -> void:
	## Gravity
	var total_gravity: float = character.get_gravity_sum()
	character.velocity.y += total_gravity
	
	apply_air_drag(total_gravity)
	do_air_movement(character.input["left"][0], character.input["right"][0])
	apply_rise()
	
	## run base function
	super()
	
	## animations time!!!
	if do_air_animation:
		animation = "fall" if character.velocity.y > 2 else "jump"
