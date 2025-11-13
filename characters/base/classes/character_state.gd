@abstract
class_name CharacterState
extends Node

## Note that the way physics states relate to action states, is different than you may expect.
## Don't think of it as, say, "You can only be in the Jump action while using Ground physics"
## It's more like, "The Jump action can only start itself while using Ground physics"
## Any action can be paired with any physics. It's better for flexibility, that way.

@export_group("State Info")
@export var priority: int = 0 ## note that states won't override others with the same priority by default
@export var allow_priority_override: bool ## if this is set to true, other states with the same priority can override this one
@export var gravity_factor: float = 1
@export var override_size: bool
@export var custom_size: Vector2

@export_group("Animation Info")
@export var animation: String
@export var sprite_offset: Vector2i
@export_range(-360, 360, 0.1, "radians_as_degrees") var sprite_rot: float
@export_range(-89.9, 89.9, 0.1, "radians_as_degrees") var sprite_skew: float
@export var sprite_scale := Vector2.ONE
@export var animator: Animator
@export var rotator: Rotator

@export_group("Collision")
@export var enable_snap: bool = true ## floor snapping


var character: Character
func _enter_tree() -> void:
	character = get_owner()


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return false


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	return name


## runs every frame while active
func _update() -> void:
	pass


## runs once when this state begins being active
func _on_enter() -> void:
	pass


## runs once when this state stops being active
func _on_exit() -> void:
	pass


## always runs no matter what, before any of the other functions
func _general_update() -> void:
	pass
