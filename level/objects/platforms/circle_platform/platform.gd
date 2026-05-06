class_name CirclePlatform
extends MovingPlatform

const BASE_SIZE: int = 16
const PART_SIZE: int = 8
const SIZE_TABLE: Array[int] = [0, 2, 4, 6]

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

enum PlatformSize {Zero = 0, Small = 1, Medium = 2, Large = 3}
var size: PlatformSize
var distance: float
var speed: float

func _enter_tree() -> void:
	var green_platform: GreenPlatformClip = $MovieClip
	green_platform.size = size as GreenPlatformClip.PlatformSize

func _ready() -> void:
	var rect_shape: RectangleShape2D = collision_shape_2d.shape.duplicate()
	rect_shape.size.x = BASE_SIZE + PART_SIZE*SIZE_TABLE[size]
	collision_shape_2d.shape = rect_shape

func _physics_process(_delta: float) -> void:
	position += diff_pos
	angle += speed

	var radians: float = deg_to_rad(angle)
	var new_pos := Vector2(
		-sin(radians),
		cos(radians)
	) * distance

	diff_pos = new_pos - last_pos
	last_pos = new_pos
