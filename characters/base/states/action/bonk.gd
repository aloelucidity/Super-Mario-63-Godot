class_name BonkAction
extends ActionState


@export var bonk_physics: PhysicsState
@export var bonk_threshold: float


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return abs(character.wall_vel.x) > bonk_threshold and character.wall_dir != 0


## runs once when this state begins being active
func _on_enter() -> void:
	character.facing_dir = sign(character.wall_vel.x)
	character.velocity = Vector2.ZERO
	character.set_state("physics", bonk_physics)
