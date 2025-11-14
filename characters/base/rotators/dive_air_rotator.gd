extends Rotator


var rot_speed: float
var target_rot: float


## returned in degrees
func update_rotation() -> float:
	# convoluted but doing it this way does make them slightly different,
	# as it was in the original
	var calculated_rot: float = rad_to_deg(atan2(character.velocity.y, character.velocity.x * character.facing_dir))
	calculated_rot += 10 * character.facing_dir
	calculated_rot *= character.facing_dir
	
	if calculated_rot > 0:
		if calculated_rot < -90:
			target_rot -= 360
		rot_speed = (calculated_rot - target_rot) / 10
	else:
		if calculated_rot > 90:
			target_rot += 360
		rot_speed = (calculated_rot - target_rot) / 10
	
	if (target_rot > 520):
		target_rot -= 360
	
	if (target_rot < -520):
		target_rot += 360
	
	rot_speed = MathFuncs.ground_friction(rot_speed, 0.1, 1.15)
	rot_speed = min(rot_speed, 15)
	rot_speed = max(rot_speed, -15)
	
	target_rot += rot_speed
	return target_rot
