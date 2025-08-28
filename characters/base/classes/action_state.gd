@abstract
class_name ActionState
extends CharacterState

var parent_physics: PhysicsState
func _enter_tree() -> void:
	super()
	parent_physics = get_parent()
