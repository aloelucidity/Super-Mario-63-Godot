class_name RunPhysics
extends GroundPhysics


@export var ground_name: String
@export var coyote_frames: int
var start_direction: int
var coyote_timer: int


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return false


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if not character.on_ground and (coyote_timer <= 0 or is_instance_valid(character.action)):
		return air_name
	var move_dir: int = 0
	if character.input["left"][0]: move_dir -= 1
	if character.input["right"][0]: move_dir += 1
	if move_dir != start_direction:
		return ground_name
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	coyote_timer = coyote_frames


## runs every frame while active
func _update() -> void:
	if not character.on_ground:
		var total_gravity: float = character.get_gravity_sum()
		character.velocity.y += total_gravity
		coyote_timer -= 1
	
	do_friction()
	do_movement(character.input["left"][0], character.input["right"][0])
	apply_fall()
