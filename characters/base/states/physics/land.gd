class_name LandPhysics
extends MovementPhysics


## this state just stumps me. what was this even trying to achieve?


@export var action_states: Array[ActionState]
@export var target_physics_name: String


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if not character.action in action_states:
		return target_physics_name
	return super()


## runs every frame while active
func _update() -> void:
	character.velocity.y = min(0, character.velocity.y)
	
	do_friction()
	
	## dont wanna run the base function so do this instead
	apply_fall()
