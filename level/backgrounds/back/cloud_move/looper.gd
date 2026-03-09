extends Node2D


func _physics_process(_delta: float) -> void:
	position.x -= 1
	if position.x <= -450:
		position.x += 450
		reset_physics_interpolation()
