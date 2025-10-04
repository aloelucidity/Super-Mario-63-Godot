class_name GroundPoundLandAction
extends ActionState


@export var speed_multiplier: float
@export var land_duration: int
var land_timer: int


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if land_timer <= 0:
		return ""
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	land_timer = land_duration


## runs every frame while active
func _update() -> void:
	character.velocity.x *= speed_multiplier
	land_timer -= 1
