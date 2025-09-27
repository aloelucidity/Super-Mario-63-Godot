class_name CharacterCamera
extends Camera2D


@export var camera_follow: Node2D


var camera_speed: float = 10
var max_camera_speed: float = 1200

var camera_change: Vector2
var camera_velocity: Vector2


func _init(_camera_follow: Node2D) -> void:
	camera_follow = _camera_follow
	global_position = camera_follow.global_position
	process_callback = Camera2D.CAMERA2D_PROCESS_PHYSICS


func _enter_tree() -> void:
	get_viewport().connect("size_changed", window_resized)
	window_resized()


func _physics_process(_delta: float) -> void:
	var center_distance: Vector2 = global_position - camera_follow.global_position
	camera_velocity = (-center_distance + camera_change) / camera_speed
	
	if camera_follow is Character:
		var character: Character = camera_follow
		var grounded: bool = character.on_ground
		if not grounded:
			camera_change.y = (80 - camera_change.y) / 10
		else:
			camera_change.y = (50 - camera_change.y) / 10

	# clamping
	var max_vector := Vector2(max_camera_speed, max_camera_speed)
	camera_velocity = camera_velocity.clamp(-max_vector, max_vector)
	
	position += camera_velocity


# zoom testing
func window_resized() -> void:
	var base_size: float = (
		ProjectSettings.get_setting("display/window/size/viewport_width")
		+ ProjectSettings.get_setting("display/window/size/viewport_height")
	)
	var window: Window = Window.get_focused_window()
	var new_zoom: float = float(window.size.x + window.size.y) / (base_size)
	zoom = Vector2(new_zoom, new_zoom)
	
	#var window: Window = Window.get_focused_window()
	#var new_zoom: float = ((float(window.size.x) / float(window.size.y)) / 2) + 0.5
	#zoom = Vector2(new_zoom, new_zoom)
