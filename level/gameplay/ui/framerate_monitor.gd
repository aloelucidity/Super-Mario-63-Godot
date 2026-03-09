extends Label


@onready var debug_text: String = text
@export var monitor: Performance.Monitor


func _process(_delta: float) -> void:
	match monitor: 
		Performance.TIME_FPS:
			text = debug_text % str(int(Performance.get_monitor(monitor)))
		Performance.TIME_PHYSICS_PROCESS:
			var calc_time: float = 1.0 / Engine.physics_ticks_per_second
			text = debug_text % str(snappedf(calc_time / Performance.get_monitor(monitor), 0.1)).pad_zeros(1)
			text += "%"
