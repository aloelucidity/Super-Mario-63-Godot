class_name TripleJumpAction
extends ActionState


@export var jump_sound: AudioStreamPlayer
@export var somersault_physics: PhysicsState
@export var launch_speed: float
@export var jump_speed: float
@export var flip_frames: int
var stop_timer: int = 0


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if stop_timer <= 0:
		return ""
	if character.physics is GroundPhysics:
		return ""
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	jump_sound.play()
	character.on_ground = false
	character.velocity.x -= (character.velocity.x - (launch_speed * character.facing_dir)) / 5
	character.velocity.y = min(-jump_speed, character.velocity.y)
	character.set_state("physics", somersault_physics)
	stop_timer = flip_frames


## runs every frame while active
func _update() -> void:
	stop_timer -= 1
