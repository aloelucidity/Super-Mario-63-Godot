class_name RoomEdge
extends Resource


enum EdgeDir {Up, Down, Left, Right}
enum EdgeType {Block, Warp, Kill, Pass}

@export var point_1: Vector2i
@export var point_2: Vector2i
@export var edge_dir: EdgeDir
@export var edge_type: EdgeType
@export var target_room: String

func _init(_point_1: Vector2i, _point_2: Vector2i, _edge_dir: EdgeDir, _edge_type: EdgeType) -> void:
	point_1 = _point_1
	point_2 = _point_2
	edge_dir = _edge_dir
	edge_type = _edge_type
