class_name GroundPhysics
extends MovementPhysics


@export var air_name: String
@export var do_ground_rotation: bool


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return character.on_ground


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if not character.on_ground:
		return air_name
	return name


## runs every frame while active
func _update() -> void:
	character.velocity.y = min(0, character.velocity.y)
	
	do_friction()
	do_movement(character.input["left"][0], character.input["right"][0])
	
	## run base function
	super()
