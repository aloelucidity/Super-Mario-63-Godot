class_name ColliderBase
extends Node2D


enum CollisionType {Default = 1, Background = 2}
@onready var character: Character = get_owner()

var char_pos: Vector2
var char_vel: Vector2


func _update() -> void:
	pass


func _floor_collision() -> void:
	return


func _wall_collision() -> void:
	return


func _ceiling_collision() -> void:
	return


func hit_test(type: CollisionType, test_pos: Vector2) -> bool:
	var params := PhysicsPointQueryParameters2D.new()
	params.collide_with_areas = true 
	params.position = test_pos
	params.collision_mask = type
	
	var results: Array[Dictionary] = get_world_2d().direct_space_state.intersect_point(params, 1)
	if not results.is_empty():
		return true
	return false
