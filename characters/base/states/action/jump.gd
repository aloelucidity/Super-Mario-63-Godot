class_name JumpAction
extends ActionState


@export var jump_speeds: Array[float]
@export var triple_jump_threshold: float
@export var triple_jump_action: ActionState
@export var max_jumps: int

var jump_sequence: int
var reset_frames: int
var pressed_buffer: int


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return character.input["up"][0] and pressed_buffer > 0 and character.velocity.y >= -3


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
	
	## triple jump
	if jump_sequence >= max_jumps - 1 and abs(character.velocity.x) > triple_jump_threshold:
		character.set_state("action", triple_jump_action)
		reset_frames = 0
		jump_sequence = -1
	## single and double jump
	elif jump_sequence < jump_speeds.size():
		character.velocity.y = min(-jump_speeds[jump_sequence], character.velocity.y)
	
	if jump_sequence >= max_jumps:
		jump_sequence = 0
		reset_frames = 0
	else:
		reset_frames = 9
	jump_sequence += 1


func _general_update() -> void:
	var up_just_pressed: bool = character.input["up"][1]
	if up_just_pressed:
		pressed_buffer = 7
	else:
		pressed_buffer -= 1
	
	if character.on_ground:
		reset_frames -= 1
		reset_frames = max(reset_frames, 0)
		if reset_frames == 0:
			jump_sequence = 0
