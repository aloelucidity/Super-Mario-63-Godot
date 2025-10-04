class_name GroundPoundStartAction
extends ActionState


@export var start_physics: PhysicsState
@export var start_duration: int
var start_timer: int


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return character.input["ground_pound"][0]


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if start_timer <= 0:
		return "GroundPoundFallAction"
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	character.set_state("physics", start_physics)
	character.velocity = Vector2.ZERO
	start_timer = start_duration


## runs every frame while active
func _update() -> void:
	start_timer -= 1
