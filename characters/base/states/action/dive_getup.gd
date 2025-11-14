class_name DiveGetupAction
extends ActionState


@export var ground_physics: GroundPhysics
@export var getup_frames: int
var getup_timer: int


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	if abs(character.animator.rotation_degrees) <= 15:
		if character.input["up"][0] and character.on_ground and abs(character.velocity.x) < 3:
			return true
		if not character.input["down"][0] and character.on_ground and abs(character.velocity.x) < 1:
			return true
	return false


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
	getup_timer = getup_frames


## runs every frame while active
func _update() -> void:
	getup_timer -= 1
