extends Camera2D


@export var camera_follow: Node


var camera_speed: float = 10
var max_camera_speed: float = 1200

var camera_change: Vector2
var camera_velocity: Vector2


func _physics_process(_delta: float) -> void:
	var center_distance: Vector2 = global_position - camera_follow.global_position
	camera_velocity = (-center_distance + camera_change) / camera_speed
	
	# very hacky but i wanna test this hehe
	var grounded: bool = not camera_follow.get_node("Collision").air
	if not grounded:
		camera_change.y = (80 - camera_change.y) / 10
	else:
		camera_change.y = (50 - camera_change.y) / 10

	# clamping
	var max_vector := Vector2(max_camera_speed, max_camera_speed)
	camera_velocity = camera_velocity.clamp(-max_vector, max_vector)
	
	position += camera_velocity
	
	# hacky
	var base_size: float = 900 + 600
	var window: Window = Window.get_focused_window()
	var new_zoom: float = float(window.size.x + window.size.y) / (900+600)
	zoom = Vector2(new_zoom * 2, new_zoom * 2)


func window_resized() -> void:
	pass
