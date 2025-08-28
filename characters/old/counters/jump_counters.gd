extends CharacterCounter


@onready var character: Character = get_owner()
@export var collision: CharacterCollision

var pressed_buffer: int
var last_up: bool

@export var max_jumps: int
var jump_sequence: int
var reset_frames: int


func _update() -> void:
	var up: bool = character.key_pressed("up")
	if up and not last_up:
		pressed_buffer = 7
	else:
		pressed_buffer -= 1
	last_up = up
	
	if not collision.air:
		reset_frames -= 1
		reset_frames = max(reset_frames, 0)
		if reset_frames == 0:
			jump_sequence = 0


func count_jump(sequence_index: int) -> void:
	jump_sequence = sequence_index + 1
	if jump_sequence >= max_jumps:
		reset_jumps()
	else:
		reset_frames = 9


func reset_jumps() -> void:
	jump_sequence = 0
	reset_frames = 0
