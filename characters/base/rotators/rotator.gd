class_name Rotator
extends Node2D


@onready var character: Character = get_owner()
@onready var animator: CharacterAnimator = %Animator
@onready var collider: ColliderBase = %Collider


func on_enter() -> void:
	pass


## returned in degrees
func update_rotation() -> float:
	return animator.rotation_degrees
