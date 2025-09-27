class_name DiveGroundPhysics
extends GroundPhysics


## runs every frame while active
func _update() -> void:
	character.velocity.y = min(0, character.velocity.y)
	
	do_friction()
	do_air_movement(character.input["left"][0], character.input["right"][0])
	
	## dont wanna run the base function so do this instead
	apply_fall()
