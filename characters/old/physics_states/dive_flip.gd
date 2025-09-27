extends AirPhysicsOld


@export var action_states: Array[CharacterState]
@export var air_name: String


func _transition_check() -> String:
	if not character.action in action_states:
		return air_name
	return super()


func _update() -> void:
	## Gravity
	var total_gravity: float = character.get_gravity_sum()
	character.velocity.y += total_gravity
	
	apply_air_drag(total_gravity)
