extends CharacterState


func _startup_check() -> bool:
	return character.key_pressed("up") and abs(character.velocity.x) > 3


func _transition_check() -> String:
	if stop_timer <= 0:
		return ""
	if character.physics is GroundPhysicsOld and character.velocity.y > -3:
		return ""
	return name


@export var flip_physics: AirPhysicsOld
@export var flip_speed: float
@export var jump_speed: float
@export var flip_frames: int
var stop_timer: int = 0


func _on_enter() -> void:
	character.velocity.x -= (character.velocity.x - (flip_speed * character.facing_dir)) / 5
	character.velocity.y = min(-jump_speed / 1.5, character.velocity.y)
	character.set_state("physics", flip_physics)
	stop_timer = flip_frames


func _update() -> void:
	stop_timer -= 1
