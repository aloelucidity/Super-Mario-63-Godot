extends CharacterState


func _startup_check() -> bool:
	var opposite_dir: bool = false
	if character.key_pressed("left") and character.facing_dir == 1: 
		opposite_dir = true
	elif character.key_pressed("right") and character.facing_dir == -1: 
		opposite_dir = true
	
	return character.key_pressed("up") and abs(character.velocity.x) < 5 and opposite_dir


func _transition_check() -> String:
	if stop_timer <= 0:
		return ""
	if character.physics is GroundPhysics and character.velocity.y > -3:
		return ""
	return name


@export var flip_physics: AirPhysics
@export var flip_speed: float
@export var jump_speed: float
@export var flip_frames: int
@export var dive_lock_frames: int
var stop_timer: int = 0
var priority_timer: int = 0


func _on_enter() -> void:
	character.velocity.x *= 0.75
	character.velocity.x -= (character.velocity.x + (flip_speed * character.facing_dir)) / 5
	character.velocity.y = min(-jump_speed, character.velocity.y)
	character.set_state("physics", flip_physics)
	stop_timer = flip_frames
	priority_timer = dive_lock_frames
	priority = 2


func _on_exit() -> void:
	priority = 2


func _update() -> void:
	stop_timer -= 1
	priority_timer -= 1
	if priority_timer <= 0:
		priority = 0
