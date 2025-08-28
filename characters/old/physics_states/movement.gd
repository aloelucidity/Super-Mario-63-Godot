class_name MovementPhysics
extends CharacterState


## cuz dives are kinda complicated in 63, i made this class
## contain functions for both air and ground movement soo
## child classes can mix and match which ones they want to use :)


@export_group("Ground Movement")
@export var move_speed: float
@export var friction_subtract: float
@export var friction_multiply: float


func do_movement(left: bool, right: bool) -> void:
	var move_dir: int = 0
	if right: move_dir += 1
	if left: move_dir -= 1
	
	if move_dir != 0:
		character.velocity.x += move_speed * move_dir
		if set_facing:
			character.facing_dir = move_dir


func do_friction() -> void:
	character.velocity.x = MathFuncs.ground_friction(character.velocity.x, friction_subtract, friction_multiply)


@export_group("Air Movement")
@export var air_move_speed: float
@export var max_air_move_speed: float
@export var speed_divider: float = 1 # used by some states to slow movement instead of changing move speed vars


func do_air_movement(left: bool, right: bool) -> void:
	if right:
		character.velocity.x -= min((character.velocity.x - air_move_speed) / (max_air_move_speed / 3), 0) / speed_divider
		if set_facing: character.facing_dir = 1
	
	if left:
		character.velocity.x -= max((character.velocity.x + air_move_speed) / (max_air_move_speed / 3), 0) / speed_divider
		if set_facing: character.facing_dir = -1


func apply_air_drag(gravity: float) -> void:
	if character.velocity.y > 0:
		character.velocity.y = MathFuncs.ground_friction(character.velocity.y, gravity / 5, 1.05)
	character.velocity.y = MathFuncs.ground_friction(character.velocity.y, 0, 1.001)
	character.velocity.x = MathFuncs.ground_friction(character.velocity.x, 0, 1.001)


@export_group("Misc")
@export var set_facing: bool = true
@export var rise_speed: float = 0.1 ## you can veryy slightly change the height of ur jump using the up/down keys


func apply_rise() -> void:
	if character.key_pressed("up"):
		character.velocity.y -= rise_speed


func apply_fall() -> void:
	if character.key_pressed("down"):
			character.velocity.y += rise_speed


func _update() -> void:
	apply_fall()
