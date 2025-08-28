class_name JumpAction
extends CharacterState


@export var jump_counter: CharacterCounter
@export var jump_speed: float
@export var sequence_index: int


func _startup_check() -> bool:
	if jump_counter.jump_sequence != sequence_index: 
		return false
	var up: bool = character.key_pressed("up")
	return up and jump_counter.pressed_buffer > 0 and character.velocity.y >= -3


func _transition_check() -> String:
	if character.velocity.y > 2 or character.physics is GroundPhysics:
		return ""
	return name


func _on_enter() -> void:
	jump_counter.count_jump(sequence_index)
	character.velocity.y = min(-jump_speed, character.velocity.y)
