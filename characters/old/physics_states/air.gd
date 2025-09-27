class_name AirPhysicsOld
extends MovementPhysicsOld


@export var collision: CharacterCollision
@export var ground_name: String
@export var do_air_animation: bool


func _transition_check() -> String:
	if not collision.air:
		return ground_name
	return name


func _update() -> void:
	## Gravity
	var total_gravity: float = character.get_gravity_sum()
	character.velocity.y += total_gravity
	
	apply_air_drag(total_gravity)
	do_air_movement(character.key_pressed("left"), character.key_pressed("right"))
	apply_rise()
	
	## run base function
	super()
	
	## animations time!!!
	if do_air_animation:
		animation = "Air 1" if character.velocity.y > 2 else "Air 2"
