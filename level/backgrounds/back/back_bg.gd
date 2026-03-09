extends MovieClip


func _ready() -> void:
	get_viewport().connect("size_changed", window_resized)
	window_resized()


func window_resized() -> void:
	var base_size := Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height")
	)
	
	var screen_size: Vector2i = DisplayServer.window_get_size(0)
	var target_scale: float = screen_size.x / base_size.x
	
	if base_size.x * target_scale < screen_size.x or base_size.y * target_scale < screen_size.y:
		target_scale = screen_size.y / base_size.y  
	
	scale = Vector2(target_scale, target_scale)
	position = Vector2.ZERO
