class_name CharacterStateOld
extends Node


@onready var character: Character = get_owner()

@export_group("State")
# note that states won't override others with the same priority
@export var priority: int = 0
@export var gravity_factor: float = 1
@export var disable_snap: bool
@export var wide_override: float = -1
@export var tall_override: float = -1

@export_group("Animation")
@export var animation: String = ""
@export var animator: AnimatorBase


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return false


## runs this check every frame while active[br]
## the string returned is the name of the state to change to[br]
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
