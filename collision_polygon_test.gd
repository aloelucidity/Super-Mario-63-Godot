extends CollisionPolygon2D


@export var copy_node: Polygon2D


func _ready() -> void:
	polygon = copy_node.polygon
