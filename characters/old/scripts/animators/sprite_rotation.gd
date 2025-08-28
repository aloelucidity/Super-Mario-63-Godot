extends Node


@onready var character: Character = get_owner()
@export var animator: Node2D
@export var collision: CharacterCollision


func _physics_process(_delta: float) -> void:
	if collision.air:
		animator.rotation_degrees = MathFuncs.ground_friction(animator.rotation_degrees, 3, 1.3);
	else:
		var front_point: Vector2 = test_front_point()
		var back_point: Vector2 = test_back_point()
		animator.rotation_degrees = rad_to_deg(atan2(back_point.y - front_point.y, back_point.x - front_point.x))


func test_front_point() -> Vector2:
	var char_pos: Vector2 = character.global_position
	var sprite_rot: float = animator.rotation_degrees
	
	var distance: float = 5
	var front_point := Vector2(
		char_pos.x - (cos(deg_to_rad(sprite_rot)) * distance),
		char_pos.y - (sin(deg_to_rad(sprite_rot)) * distance) + 15)
	var hit_platform: bool = false
	for i in range(9):
		if not hit_platform and i <= 8:
			front_point.y -= 5
		
		# this was misspelled in the original code but its probs better to fix it :)
		var count: int = 0
		# add the other checks after too ,,, sigh
		while not collision.hit_test(collision.platforms, front_point) and collision.hit_test(collision.platforms, front_point + Vector2(0, 7)):
			front_point.y += 1
			hit_platform = true
			count += 1
			if count > 50:
				break
		
		count = 0
		while collision.hit_test(collision.platforms, front_point):
			front_point.y -= 1
			hit_platform = true
			count += 1
			if count > 50:
				break
		
		if hit_platform:
			break
		
		if i >= 8:
			front_point = Vector2(
				char_pos.x - (cos(deg_to_rad(sprite_rot)) * distance),
				char_pos.y - (sin(deg_to_rad(sprite_rot)) * distance))
	
	return front_point


func test_back_point() -> Vector2:
	var char_pos: Vector2 = character.global_position
	var sprite_rot: float = animator.rotation_degrees
	
	var distance: float = 5
	var back_point := Vector2(
		char_pos.x + (cos(deg_to_rad(sprite_rot)) * distance),
		char_pos.y - (sin(deg_to_rad(sprite_rot)) * distance) + 15)
	var hit_platform: bool = false
	for i in range(9):
		if not hit_platform and i <= 8:
			back_point.y -= 5
		
		# this was misspelled in the original code but its probs better to fix it :)
		var count: int = 0
		# add the other checks after too ,,, sigh
		while not collision.hit_test(collision.platforms, back_point) and collision.hit_test(collision.platforms, back_point + Vector2(0, 7)):
			back_point.y += 1
			hit_platform = true
			count += 1
			if count > 50:
				break
		
		count = 0
		while collision.hit_test(collision.platforms, back_point):
			back_point.y -= 1
			hit_platform = true
			count += 1
			if count > 50:
				break
		
		if hit_platform:
			break
		
		if i >= 8:
			back_point = Vector2(
				char_pos.x + (cos(deg_to_rad(sprite_rot)) * distance),
				char_pos.y - (sin(deg_to_rad(sprite_rot)) * distance))
	
	return back_point
