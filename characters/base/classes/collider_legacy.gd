class_name ColliderLegacy
extends ColliderBase


var floor_snap: bool = false


func _update() -> void:
	char_pos = character.global_position
	char_vel = character.velocity
	
	floor_snap = false
	if char_vel.y > -3:
		var physics_snap: bool = true
		var action_snap: bool = true
		if is_instance_valid(character.physics):
			physics_snap = character.physics.enable_snap
		if is_instance_valid(character.action):
			action_snap = character.action.enable_snap
		floor_snap = physics_snap and action_snap

	character.wall_dir = 0
	character.wall_vel = Vector2.ZERO

	var repeats: int = get_repeat_amount(char_vel)
	var i: int = 1
	while i <= repeats:
		_floor_collision()
		_wall_collision()
		_ceiling_collision()
		
		char_pos.x += char_vel.x / repeats
		char_pos.y += char_vel.y / repeats
		i += 1
	
	character.global_position = char_pos
	character.velocity = char_vel


func _floor_collision() -> void:
	## GROUND DETECTION
	if hit_test(CollisionType.Default, char_pos) or hit_test(CollisionType.Background, char_pos):
		character.on_ground = true
		character.land_vel = char_vel
		char_vel.y = min(0, char_vel.y)
	else:
		character.on_ground = false
	
	## GROUND RESOLUTION
	while (
		(hit_test(CollisionType.Default, char_pos - Vector2(0, 3)) and not is_squished())
		or (hit_test(CollisionType.Background, char_pos - Vector2(0, 3)) and char_vel.y >= -3)
	):
		char_pos.y -= 1
		char_vel.y = min(0, char_vel.y)
		if is_instance_valid(character.physics):
			char_vel.x *= character.physics.ground_resolve_mult 
	
	## GROUND STICKING (slopes?)
	if floor_snap:
		while (
			( # regular ground...
				hit_test(CollisionType.Default, char_pos + Vector2(0, 5)) and
				not hit_test(CollisionType.Default, char_pos - Vector2(0, 1))
			)
			or ( # and then one ways :)
				hit_test(CollisionType.Background, char_pos + Vector2(0, 5)) and
				not hit_test(CollisionType.Background, char_pos - Vector2(0, 1)) and
				char_vel.y >= -3
			)
		):
			char_pos.y += 1
			if is_instance_valid(character.physics):
				## ok the original value for diving is ever so slightly different
				## in this part but i cant be bothered to go that far sorry
				char_vel.x *= character.physics.ground_resolve_mult
			# in the original this just sets the animation, but i think its cleaner
			# to do it this way here
			character.on_ground = true


func _wall_collision() -> void:
	## WALL DETECTION AND RESOLUTION
	var half_height: float = char_pos.y - float(character.size.y)/2
	var check_right: Vector2 = Vector2(char_pos.x + character.size.x - 1, half_height)
	var check_left: Vector2 = Vector2(char_pos.x - character.size.x + 1, half_height)
	
	#if not is_squished():
	while hit_test(CollisionType.Default, check_right):
		check_right.x -= 1
		char_pos.x -= 1
	
	while hit_test(CollisionType.Default, check_left):
		check_left.x += 1
		char_pos.x += 1
	
	## WALL BONKING
	check_right = Vector2(char_pos.x + character.size.x, half_height)
	check_left = Vector2(char_pos.x - character.size.x, half_height)
	
	if hit_test(CollisionType.Default, check_right):
		character.wall_dir = 1
		if abs(char_vel.x) > abs(character.wall_vel.x):
			character.wall_vel = char_vel
		if character.input["right"][0]:
			char_vel.x = min(char_vel.x, -char_vel.x * character.bounce)
			char_vel.x = MathFuncs.ground_friction(char_vel.x, 3, 1)
		else:
			char_vel.x = min(char_vel.x - 1, -char_vel.x * character.bounce)
	
	if hit_test(CollisionType.Default, check_left):
		character.wall_dir = -1
		if abs(char_vel.x) > abs(character.wall_vel.x):
			character.wall_vel = char_vel
		if character.input["left"][0]:
			char_vel.x = min(char_vel.x, -char_vel.x * character.bounce)
			char_vel.x = MathFuncs.ground_friction(char_vel.x, 3, 1)
		else:
			char_vel.x = max(char_vel.x + 1, -char_vel.x * character.bounce)


func _ceiling_collision() -> void:
	## CEILING DETECTION AND RESOLUTION
	var head_height: float = char_pos.y - character.size.y + 1
	if hit_test(CollisionType.Default, Vector2(char_pos.x, head_height)):
		#fall_squish()
		char_vel.y = max(char_vel.y, -3)
	
	if true:# not character.squish or char_vel.y < -1:
		## supposed to take squish into account but ill do that Later (tm)
		var scaled_head_height: float = char_pos.y - character.size.y
		head_height = char_pos.y - character.size.y
		while hit_test(CollisionType.Default, Vector2(char_pos.x, scaled_head_height)):
			scaled_head_height += 1
			head_height += 1
			char_pos.y += 1


func is_squished() -> bool:
	return false


func get_repeat_amount(velocity: Vector2) -> int:
	var repeats: int = ceil(
		(abs(velocity.x) + abs(velocity.x)) 
		/ 5)
	repeats = min(repeats, 50)
	repeats = max(repeats, 1)
	return repeats
