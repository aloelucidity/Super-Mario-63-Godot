extends Camera2D

@export var speed: int = 2


func _physics_process(_delta: float) -> void:
	var move: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += move * speed
