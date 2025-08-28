class_name DiveGroundPhysics
extends GroundPhysics


func _update() -> void:
	character.velocity.y = min(0, character.velocity.y)
	
	do_friction()
	do_air_movement(character.key_pressed("left"), character.key_pressed("right"))
	
	## dont wanna run the base function so do this instead
	apply_fall()
