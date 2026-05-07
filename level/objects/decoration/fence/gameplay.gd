extends GameplayObject

const BASE_ID: int = 144
const BASE_SIZE: int = 4
const PART_SIZE: int = 10
const SIZE_TABLE: Array[int] = [3, 10]

@onready var sprite: NinePatchRect = $Sprite

var size: int

func _ready() -> void:
	size = (object_data.legacy_id - BASE_ID)
	sprite.size.x = BASE_SIZE + SIZE_TABLE[size]*PART_SIZE
	sprite.position.x = -sprite.size.x/2
