class_name RunWindupAction
extends ActionState


@export var run_physics: RunPhysics
@export var windup_physics: PhysicsState
@export var spin_action: SpinAction
@export var input_grace_frames: int
@export var windup_duration: int

var windup_timer: int
var run_direction: int
var reset_timer: int


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	if is_instance_valid(spin_action) and spin_action.left_right_counter > 1: 
		return false
	
	var left: bool = character.input["left"][0]
	var right: bool = character.input["right"][0]
	
	if run_direction == 0:
		if right:
			reset_timer = input_grace_frames
			run_direction = 1
			
		if left:
			reset_timer = input_grace_frames
			run_direction = -1
	
	else:
		var inputting_run: bool = (run_direction < 0 and left) or (run_direction > 0 and right)
		
		if not inputting_run:
			run_direction *= 2
		
		if inputting_run and abs(run_direction) > 1:
			return true
	
	return false


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if windup_timer <= 0:
		return ""
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	run_physics.start_direction = sign(run_direction)
	
	reset_timer = 0
	run_direction = 0
	windup_timer = windup_duration
	character.set_state("physics", windup_physics)


## runs every frame while active
func _update() -> void:
	windup_timer -= 1


## always runs no matter what, before any of the other functions
func _general_update() -> void:
	reset_timer -= 1
	if reset_timer <= 0:
		reset_timer = 0
		run_direction = 0
