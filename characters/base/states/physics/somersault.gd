class_name SomersaultPhysics
extends AirPhysics


@export var action_states: Array[ActionState]
@export var air_name: String


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return false


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if not character.action in action_states:
		return air_name
	return super()
