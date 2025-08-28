extends JumpAction


@export var collision: CharacterCollision
@export var frontflip_physics: AirPhysics
@export var flip_frames: int
var stop_timer: int = 0


func _startup_check() -> bool:
	return super() and abs(character.velocity.x) > 3


func _transition_check() -> String:
	if stop_timer <= 0:
		return ""
	if character.physics is GroundPhysics and character.velocity.y > -3:
		return ""
	return name


func _on_enter() -> void:
	super()
	character.velocity.x -= (character.velocity.x - (15 * character.facing_dir)) / 5
	character.set_state("physics", frontflip_physics)
	stop_timer = flip_frames


func _update() -> void:
	stop_timer -= 1
