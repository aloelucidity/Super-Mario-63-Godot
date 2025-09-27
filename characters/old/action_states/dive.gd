extends CharacterState


@export var jump_counter: CharacterCounter
@export var dive_air_physics: DiveAirPhysicsOld
@export var dive_speed: float


func _startup_check() -> bool:
	var down: bool = character.key_pressed("down")
	return down


func _on_enter() -> void:
	character.velocity.x -= (character.velocity.x - (dive_speed * character.facing_dir)) / 5
	character.velocity.y += 3
	character.set_state("physics", dive_air_physics)
	jump_counter.reset_jumps()
	animation = "Dive"
