class_name GroundPhysicsOld
extends MovementPhysicsOld


@export var collision: CharacterCollision
@export var air_name: String
@export var do_ground_rotation: bool


func _transition_check() -> String:
	if collision.air:
		return air_name
	return name


func _update() -> void:
	character.velocity.y = min(0, character.velocity.y)
	
	do_friction()
	do_movement(character.key_pressed("left"), character.key_pressed("right"))
	
	## run base function
	super()
