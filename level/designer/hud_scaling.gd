extends MarginContainer


func _ready() -> void:
	get_viewport().connect("size_changed", window_resized)
	window_resized()


func window_resized() -> void:
	var base_scale: float = (
		ProjectSettings.get_setting("display/window/size/viewport_width")
		+ ProjectSettings.get_setting("display/window/size/viewport_height")
	)
	
	var screen_size: Vector2i = DisplayServer.window_get_size(0)
	var screen_scale: float = screen_size.x + screen_size.y
	var gui_scale: float = screen_scale / base_scale
	scale = Vector2(gui_scale, gui_scale)
	
	var window: Window = Window.get_focused_window()
	size = Vector2(window.size) / scale
	position = Vector2.ZERO
