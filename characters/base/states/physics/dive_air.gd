class_name DiveAirPhysics
extends AirPhysics


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return false


## runs every frame while active
func _update() -> void:
	## Gravity
	var total_gravity: float = character.get_gravity_sum()
	character.velocity.y += total_gravity
	
	apply_air_drag(total_gravity)
	do_air_movement(character.input["left"][0], character.input["right"][0])
