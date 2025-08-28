class_name MathFuncs


## Common formula used for calculating various physics values in SM63[br]
## Name is misleading; this is used in many different places
static func ground_friction(value: float, subtract: float, divide: float) -> float:
	# subtracting, so if it was 0 originally it would then become -1
	var value_sign: int = sign(value - 0.0001)
	
	value = abs(value)
	value -= subtract
	
	value = max(0, value)
	
	value /= divide
	value *= value_sign
	return value


static func frame_to_seconds(frame: int) -> float:
	var fps: int = ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
	return float(frame) / fps


static func seconds_to_frame(time: float) -> int:
	var fps: int = ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
	return floori(time * fps)
