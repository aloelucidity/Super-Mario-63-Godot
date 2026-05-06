class_name GreenPlatform
extends Node2D

const BASE_SIZE: int = 16
const PART_SIZE: int = 8
const SIZE_TABLE: Array[int] = [2, 4, 6]

@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D

enum PlatformSize {Small, Medium, Large}
var size: PlatformSize

func _init(_size: PlatformSize) -> void:
	size = _size
	
	nine_patch_rect.size.x = BASE_SIZE + PART_SIZE*SIZE_TABLE[size]
	nine_patch_rect.position.x = -nine_patch_rect.size.x/2
	
	var rect_shape: RectangleShape2D = collision_shape_2d.shape.duplicate()
	rect_shape.size.x = nine_patch_rect.size.x
	collision_shape_2d.shape = rect_shape
