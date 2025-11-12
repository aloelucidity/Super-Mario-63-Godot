class_name PausePhysics
extends PhysicsState

@export var action_states: Array[ActionState]
@export var target_physics_name: String


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if not action_states.is_empty() and not character.action in action_states:
		return target_physics_name
	return super()
