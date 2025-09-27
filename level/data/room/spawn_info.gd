class_name CharacterSpawnInfo
extends SerializedResource

var spawn_pos: Vector2
var spawn_velocity: Vector2
var spawn_dir: int = 1


func _init(_spawn_pos := Vector2.ZERO, _spawn_velocity := Vector2.ZERO, _spawn_dir: int = 1) -> void:
	spawn_pos = _spawn_pos
	spawn_velocity = _spawn_velocity
	spawn_dir = _spawn_dir
