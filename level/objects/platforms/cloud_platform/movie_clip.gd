class_name CloudPlatformClip
extends MovieClip

const BASE_SIZE: int = 16
const PART_SIZE: int = 16
const SIZE_TABLE: Array[int] = [0, 1, 2, 3, 9]

@onready var nine_patch_rect: NinePatchRect = $NinePatchRect

enum PlatformSize {Zero = 0, Small = 1, Medium = 2, Large = 3}
var size: PlatformSize

func _ready() -> void:
	var rect_size_x: float = BASE_SIZE + PART_SIZE*SIZE_TABLE[size]
	nine_patch_rect.set_deferred("size", Vector2(rect_size_x, nine_patch_rect.size.y))
	nine_patch_rect.position.x = -rect_size_x/2
