class_name SpinAction
extends ActionState


@export var target_air: PhysicsState
@export var target_ground: PhysicsState


## used for animation speed in the original, but also used
## for calculations; so it needs to be put in the state script
var spin_speed: float
## used for left-right spin input
var left_right_counter: int
var last_input_dir: int
var reset_timer: int


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	if character.input["spin"][0] or left_right_counter >= 4:
		spin_speed = 15
		return character.velocity.y > -3
	return false


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	reset_input_vars()
	if character.on_ground:
		character.set_state("physics", target_ground)
	else:
		character.velocity.y *= 0.5
		character.velocity.y -= 5
		character.set_state("physics", target_air)


## runs every frame while active
func _update() -> void:
	if left_right_counter >= 3:
		spin_speed *= 0.8
		spin_speed += 15
		reset_input_vars()
	
	if spin_speed > 7:
		spin_speed = MathFuncs.ground_friction(spin_speed, 0.5, 1.1)
	else:
		spin_speed = MathFuncs.ground_friction(spin_speed, 0.1, 1.03)
	spin_speed = max(spin_speed, 1)


## always runs no matter what, before any of the other functions
func _general_update() -> void:
	reset_timer -= 1
	if reset_timer <= 0:
		reset_input_vars()
	
	# casting bool to int turns true to 1 and false to 0 :)
	var direction: int = 0
	direction -= int(character.input["left"][0])
	direction += int(character.input["right"][0])
	if direction != 0:
		if last_input_dir != direction:
			
			if left_right_counter <= 0 or reset_timer > 0:
				left_right_counter += 1
				# honestly,, i have no clue why these two
				# are different >w<;;
				reset_timer = (
					15 - (left_right_counter * 3) if direction == 1 
					else 11 - (left_right_counter)
				)
		
		last_input_dir = direction


func reset_input_vars() -> void:
	left_right_counter = 0
	last_input_dir = 0
	reset_timer = 0
