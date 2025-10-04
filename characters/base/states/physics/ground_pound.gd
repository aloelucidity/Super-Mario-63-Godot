class_name GroundPoundPhysics
extends MovementPhysics

@export var action_states: Array[ActionState]
@export var target_physics_name: String


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if not character.action in action_states:
		return target_physics_name
	return super()


## runs every frame while active
func _update() -> void:
	var gravity: float = character.get_gravity_sum()
	character.velocity.y += gravity / 2
	if character.velocity.y < 3:
		character.velocity.y += gravity / 2
		
	character.velocity.x *= 0.95
	do_air_movement(character.input["left"][0], character.input["right"][0])
