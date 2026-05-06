extends Node2D

@export var color := Color(0.6, 0.6, 0.6)
@export var radius: float = 2.75

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)
