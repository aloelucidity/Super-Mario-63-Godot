extends AirPhysics


@export var action_states: Array[CharacterState]
@export var air_name: String


func _transition_check() -> String:
	if not character.action in action_states:
		return air_name
	return super()
