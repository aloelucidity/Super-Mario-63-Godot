extends Rotator


# a misspelling turned this from a global variable
# into a local one. recreating because it affects the feel
var count: int = 0


## returned in degrees
func update_rotation() -> float:
	count = 0
	var front_point: Vector2 = test_front_point()
	var back_point: Vector2 = test_back_point()
	var calculated_rotation: float = rad_to_deg(atan2(back_point.y - front_point.y, back_point.x - front_point.x))
	
	# hate that the visual rotation has to mix with game logic like this
	var speedslide: float = sin(deg_to_rad(calculated_rotation))
	speedslide = max(speedslide, -1)
	speedslide = min(speedslide, 1)
	character.velocity.x += speedslide
	
	return calculated_rotation * -character.facing_dir * 0.9


func test_front_point() -> Vector2:
	var char_pos: Vector2 = character.global_position
	var char_rot: float = animator.rotation_degrees
	
	var distance: float = 5
	var front_point := Vector2(
		char_pos.x - (cos(deg_to_rad(char_rot)) * distance),
		char_pos.y - (sin(deg_to_rad(char_rot)) * distance))
	
	while not collider.hit_test(collider.CollisionType.Default, front_point) and collider.hit_test(collider.CollisionType.Default, front_point + Vector2(0, 25)):
		front_point.y += 0.5
		count += 1
		if count > 50:
			break
	
	while collider.hit_test(collider.CollisionType.Default, front_point):
		front_point.y -= 0.5
		count += 1
		if count > 50:
			break
	
	return front_point


func test_back_point() -> Vector2:
	var char_pos: Vector2 = character.global_position
	var char_rot: float = animator.rotation_degrees
	
	var distance: float = 5
	var back_point := Vector2(
		char_pos.x + (cos(deg_to_rad(char_rot)) * distance),
		char_pos.y - (sin(deg_to_rad(char_rot)) * distance))
	
	# add the other checks after too ,,, sigh
	while not collider.hit_test(collider.CollisionType.Default, back_point) and collider.hit_test(collider.CollisionType.Default, back_point + Vector2(0, 25)):
		back_point.y += 0.5
		count += 1
		if count > 50:
			break
	
	while collider.hit_test(collider.CollisionType.Default, back_point):
		back_point.y -= 0.5
		count += 1
		if count > 50:
			break
	
	return back_point
