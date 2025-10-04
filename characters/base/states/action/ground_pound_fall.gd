class_name GroundPoundFallAction
extends ActionState


@export var fall_power: float


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if character.on_ground:
		return "GroundPoundLandAction"
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	character.velocity.y = fall_power
