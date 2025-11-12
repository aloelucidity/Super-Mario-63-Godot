class_name BonkLayPhysics
extends MovementPhysics


## runs once when this state begins being active
func _on_enter() -> void:
	character.velocity = Vector2.ZERO
	super()
