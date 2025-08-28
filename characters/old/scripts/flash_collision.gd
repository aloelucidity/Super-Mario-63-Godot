## maybe split this into a base class to facilitate alt collision systems laters ?
class_name CharacterCollision
extends Node


@onready var character: Character = get_parent()

@export var wide: float # distance from center
@export var tall: float # height from bottom
@export var bounce: float # ricochet off walls

@export var platforms: Polygon2D # normal terrain
@export var back_platforms: Polygon2D # one ways
@export var invis_ground: Polygon2D # vanish grates

## various flags set based on results from the last collision test
var water: bool # if water was being touched
var air: bool # if character wasn't touching the ground

## other flags that may need to be moved
var lock_on: bool = true # ground snapping, presumably for slopes
var land_time: float
var fall_count: float
var hurt_fall_count: float
var y_scale: float = 100 # shouldnt be visual, used for squishing


func update() -> void:
	var char_pos: Vector2 = character.global_position
	var char_vel: Vector2 = character.velocity
	
	var up: bool = character.key_pressed("up")
	var left: bool = character.key_pressed("left")
	var right: bool = character.key_pressed("right")
	
	if char_vel.y > -3:
		lock_on = true
	else:
		lock_on = false
	
	var repeats: int = get_repeat_amount(char_vel)
	var i: int = 1
	while i <= repeats:
		## WATER COLLISION GOES HERE
		water = false
		
		## GROUND DETECTION
		if (
			hit_test(platforms, char_pos) and (
				invis_check(char_pos) or 
				hit_test(back_platforms, char_pos)
			)
		):
			air = false
			if char_vel.y < 16:
				land_time = round(fall_count / 8) - 2
				
				if up:
					land_time -= 3
					if (right or left) and land_time >= 1:
						land_time -= 2
						land_time = max(land_time, 1)
					
					land_time -= min(abs(char_vel.x / 1.5), 3)
					
					if char_vel.y > 3 and land_time > 0 and not character.attack:
						land_time = max(land_time, 1)
						land_time = min(land_time, 3)
						character.attack = true
						character.attack_frame = "land"
			
			fall_count = 0
			hurt_fall_count -= 1
			hurt_fall_count = max(hurt_fall_count, 0)
			#fall_squish()
			char_vel.y = min(0, char_vel.y)
		else:
			air = true
		
		## GROUND RESOLUTION
		while (
			(
				hit_test(platforms, char_pos - Vector2(0, 3)) 
				and not is_squished()
				and invis_check(char_pos - Vector2(0, 3))
			)
			or (hit_test(back_platforms, char_pos - Vector2(0, 3)) and char_vel.y >= -3)
		):
			char_pos.y -= 1
			if not is_diving():
				char_vel.x *= 0.98
			else:
				char_vel.x *= 0.997
			#fall_squish()
			
			char_vel.y = min(0, char_vel.y)
		
		## GROUND STICKING (slopes?)
		if water: lock_on = false
		if lock_on:
			while (
				hit_test(platforms, char_pos + Vector2(0, 5)) and 
				not hit_test(platforms, char_pos - Vector2(0, 1)) and 
				invis_check(char_pos + Vector2(0, 5))
			):
				char_pos.y += 1
				if not is_diving():
					char_vel.x *= 0.98
				else:
					char_vel.x *= 0.998
				air = false
				#character.frame = 2
			
			while (
				hit_test(back_platforms, char_pos + Vector2(0, 5)) and
				not hit_test(back_platforms, char_pos - Vector2(0, 1)) and
				char_vel.y >= -3
			):
				char_pos.y += 1
				if not is_diving():
					char_vel.x *= 0.98
				else:
					char_vel.x *= 0.998
				air = false
				#character.frame = 2
		
		## WALL DETECTION AND RESOLUTION
		var half_height: float = char_pos.y - (tall * y_scale / 200)
		var char_right: Vector2 = Vector2(char_pos.x + wide - 1, half_height)
		var char_left: Vector2 = Vector2(char_pos.x - wide + 1, half_height)
		if not is_squished():
			while hit_test(platforms, char_right) and invis_check(char_right):
				char_right.x -= 1
				char_pos.x -= 1
			
			while hit_test(platforms, char_left) and invis_check(char_left):
				char_left.x += 1
				char_pos.x += 1
		
		## WALL BONKING
		char_right = Vector2(char_pos.x + wide, half_height)
		char_left = Vector2(char_pos.x - wide, half_height)
		if hit_test(platforms, char_right) and invis_check(char_right):
			if can_bonk():
				#hit_wall()
				pass
			else:
				if right:
					char_vel.x = min(char_vel.x, -char_vel.x * bounce)
					char_vel.x = MathFuncs.ground_friction(char_vel.x, 3, 1)
				else:
					char_vel.x = min(char_vel.x - 1, -char_vel.x * bounce)
		
		if hit_test(platforms, char_left) and invis_check(char_left):
			if can_bonk():
				#hit_wall()
				pass
			else:
				if left:
					char_vel.x = min(char_vel.x, -char_vel.x * bounce)
					char_vel.x = MathFuncs.ground_friction(char_vel.x, 3, 1)
				else:
					char_vel.x = max(char_vel.x + 1, -char_vel.x * bounce)
		
		## CEILING DETECTION AND RESOLUTION
		var head_height: float = char_pos.y - tall + 1
		if hit_test(platforms, Vector2(char_pos.x, head_height)) and invis_check(Vector2(char_pos.x, head_height - 2)):
			#fall_squish()
			char_vel.y = max(char_vel.y, -3)
		
		if not character.squish or char_vel.y < -1:
			var scaled_head_height: float = char_pos.y - (tall * y_scale / 100)
			head_height = char_pos.y - tall
			while hit_test(platforms, Vector2(char_pos.x, scaled_head_height)) and invis_check(Vector2(char_pos.x, head_height)):
				scaled_head_height += 1
				head_height += 1
				char_pos.y += 1
		
		char_pos.x += char_vel.x / repeats
		char_pos.y += char_vel.y / repeats
		i += 1
	
	character.global_position = char_pos
	character.velocity = char_vel


func get_repeat_amount(velocity: Vector2) -> int:
	var repeats: int = ceil(
		(abs(velocity.x) + abs(velocity.x)) 
		/ 5)
	repeats = min(repeats, 50)
	repeats = max(repeats, 1)
	return repeats


func is_squished() -> bool:
	return character.squish and (y_scale < 70 or (character.attack and character.attack_frame == "Squish"))


func is_diving() -> bool:
	return character.physics is DiveAirPhysics or character.physics is DiveGroundPhysics


func can_bonk() -> bool:
	return false


func invis_check(pos: Vector2) -> bool:
	return not hit_test(invis_ground, pos) or not character.invisible


func hit_test(target: Polygon2D, pos: Vector2) -> bool:
	if not is_instance_valid(target):
		return false
	return Geometry2D.is_point_in_polygon(pos - target.global_position, target.polygon)
