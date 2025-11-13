extends Rotator


## returned in degrees
func update_rotation() -> float:
	return MathFuncs.ground_friction(animator.rotation_degrees, 3, 1.3)
