extends MovieClip


@onready var bg_parent: Node2D = $BGParent
@onready var bg_right: Node2D = $BGParent/BGRight
@export var move_scale := Vector2.ONE
@export var y_offset: float
var camera: CharacterCamera


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


func _process(_delta: float) -> void:
	bg_parent.position = -camera.get_screen_center_position() * move_scale
	bg_parent.position.y += y_offset
	if bg_parent.position.x < -bg_right.position.x or bg_parent.position.x > 0:
		bg_parent.position.x = wrapf(bg_parent.position.x, -bg_right.position.x, 0)
