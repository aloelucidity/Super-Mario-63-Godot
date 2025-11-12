class_name RolloutPhysics
extends AirPhysics


@export var action_states: Array[CharacterState]
@export var air_name: String


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if not action_states.is_empty() and not character.action in action_states:
		return air_name
	return super()


## runs every frame while active
func _update() -> void:
	## Gravity
	var total_gravity: float = character.get_gravity_sum()
	character.velocity.y += total_gravity
	
	apply_air_drag(total_gravity)
