class_name GetupAction
extends ActionState


@export var bonk_lay_physics: BonkLayPhysics
@export var ground_physics: PhysicsState
@export var getup_duration: int
var getup_timer: int



## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return bonk_lay_physics.stun_frames <= 0 and (
		character.input["up"][0] or 
		character.input["down"][0] or 
		character.input["left"][0] or 
		character.input["right"][0] or
		character.input["use_fludd"][0]
	)
	

## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if getup_timer <= 0:
		character.set_state("physics", ground_physics)
		return ""
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	getup_timer = getup_duration


## runs every frame while active
func _update() -> void:
	getup_timer -= 1
