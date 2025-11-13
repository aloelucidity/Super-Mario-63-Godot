class_name BonkAction
extends ActionState


@export var bonk_physics: PhysicsState
@export var bonk_move_physics: PhysicsState
@export var bonk_sound: AudioStreamPlayer

@export var bonk_threshold: float
@export var pause_frames: int
var pause_timer: int


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return abs(character.wall_vel.x) > bonk_threshold and character.wall_dir != 0


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if pause_timer <= 0:
		character.set_state("physics", bonk_move_physics)
		return ""
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	character.facing_dir = sign(character.wall_vel.x)
	character.velocity = Vector2.ZERO
	character.set_state("physics", bonk_physics)
	pause_timer = pause_frames
	bonk_sound.play()


## runs every frame while active
func _update() -> void:
	pause_timer -= 1
