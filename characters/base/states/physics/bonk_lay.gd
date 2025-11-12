class_name BonkLayPhysics
extends MovementPhysics


@export var stun_time: int
var stun_frames: int


## runs once when this state begins being active
func _on_enter() -> void:
	character.velocity = Vector2.ZERO
	stun_frames = stun_time
	super()


## runs every frame while active
func _update() -> void:
	stun_frames -= 1
	super()
