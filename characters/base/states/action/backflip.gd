class_name BackflipAction
extends ActionState


@export var backflip_physics: SomersaultPhysics
@export var backflip_speed: Vector2
@export var backflip_frames: int
@export var priority_frames: int
var backflip_timer: int
var priority_timer: int


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	var opposite_dir: bool = false
	if character.input["left"][0] and character.facing_dir > 0: 
		opposite_dir = true
	elif character.input["right"][0] and character.facing_dir < 0: 
		opposite_dir = true
	
	return character.input["jump"][0] and abs(character.velocity.x) < 5 and opposite_dir


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if backflip_timer <= 0:
		return ""
	if character.on_ground and character.velocity.y > -3:
		return ""
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	character.velocity.x *= 0.75
	character.velocity.x -= (character.velocity.x + (backflip_speed.x * character.facing_dir)) / 5
	character.velocity.y = min(backflip_speed.y, character.velocity.y)
	character.set_state("physics", backflip_physics)
	backflip_timer = backflip_frames
	priority_timer = priority_frames
	allow_priority_override = false


## runs every frame while active
func _update() -> void:
	backflip_timer -= 1
	priority_timer -= 1
	if priority_timer <= 0:
		allow_priority_override = true
