extends GameplayObject

const BASE_ID: int = 30
const BASE_SIZE: int = 16
const PART_SIZE: int = 16
const SIZE_TABLE: Array[int] = [0, 1, 2, 3, 9]

@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D

enum PlatformSize {Zero = 0, Small = 1, Medium = 2, Large = 3, Giant = 4}
var size: PlatformSize

func _enter_tree() -> void:
	size = (object_data.legacy_id - BASE_ID) as PlatformSize
	var cloud_platform: CloudPlatformClip = $MovieClip
	cloud_platform.size = size as CloudPlatformClip.PlatformSize

func _ready() -> void:
	var rect_shape: RectangleShape2D = collision_shape_2d.shape.duplicate()
	rect_shape.size.x = BASE_SIZE + PART_SIZE*SIZE_TABLE[size]
	collision_shape_2d.shape = rect_shape
