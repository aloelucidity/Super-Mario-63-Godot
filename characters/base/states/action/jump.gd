class_name JumpAction
extends ActionState


@export var jump_speeds: Array[float]
@export var jump_sounds: Array[AudioStreamPlayer]
@export var triple_jump_threshold: float
@export var triple_jump_action: ActionState
@export var air_physics: PhysicsState
@export var max_jumps: int
@export var check_grounded: bool

var jump_sequence: int
var reset_frames: int
var pressed_buffer: int
var snap_buffer: int


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	var ground_check: bool = not check_grounded or character.on_ground
	return character.input["jump"][0] and pressed_buffer > 0 and character.velocity.y >= -3 and ground_check


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if character.velocity.y > 2 or character.physics is GroundPhysics:
		return ""
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	character.on_ground = false
	enable_snap = false
	snap_buffer = 1
	
	## triple jump
	if jump_sequence >= max_jumps - 1 and abs(character.velocity.x) > triple_jump_threshold:
		character.set_state("action", triple_jump_action)
		reset_frames = 0
	## single and double jump
	elif jump_sequence < max_jumps - 1:
		character.set_state("physics", air_physics)
		character.velocity.y = min(-jump_speeds[jump_sequence], character.velocity.y)
		jump_sounds[jump_sequence].play()
	
	jump_sequence += 1
	reset_frames = 9
	if jump_sequence >= max_jumps:
		jump_sequence = 0
		reset_frames = 0


## runs every frame while active
func _update() -> void:
	## the original code disables ground snapping only on the frame that the jump key is pressed
	if snap_buffer > 0:
		snap_buffer -= 1
	else:
		enable_snap = true


## always runs no matter what, before any of the other functions
func _general_update() -> void:
	var jump_just_pressed: bool = character.input["jump"][1]
	if jump_just_pressed:
		pressed_buffer = 7
	else:
		pressed_buffer -= 1
	
	if character.on_ground:
		reset_frames -= 1
		reset_frames = max(reset_frames, 0)
		if reset_frames == 0:
			jump_sequence = 0
