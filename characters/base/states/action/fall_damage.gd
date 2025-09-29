class_name FallDamageAction
extends ActionState


var fall_count: int
var hurt_fall_count: int
var fall_threshold: bool


## always runs no matter what, before any of the other functions
func _general_update() -> void:
	if character.physics == parent_physics:
		var fall_speed_check: float = MathFuncs.ground_friction(character.velocity.y, character.get_gravity_sum() / 5, 1.05)
		if character.velocity.y > 0:
			if character.velocity.y > 7:
				fall_count += 1
				if fall_speed_check >= 15 and character.velocity.y > 15 and not fall_threshold:
					hurt_fall_count += 1
					hurt_fall_count = min(hurt_fall_count, 7)
					if hurt_fall_count >= 5:
						fall_threshold = true
			else:
				## bitshifting right by 1 is the same as dividing by 2
				fall_count = round(fall_count >> 1)
		else:
			fall_count = 0;
			hurt_fall_count -= 1;
			hurt_fall_count = max(hurt_fall_count, 0);
	else:
		#fall_count = 0;
		hurt_fall_count -= 1;
		hurt_fall_count = max(hurt_fall_count, 0);
