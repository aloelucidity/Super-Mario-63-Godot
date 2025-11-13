class_name DiveAction
extends ActionState


@export var dive_air_physics: DiveAirPhysics
@export var dive_speed: float
@export var dive_sound: AudioStreamPlayer


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return character.input["dive"][0]


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	return ""


## runs once when this state begins being active
func _on_enter() -> void:
	character.velocity.x -= (character.velocity.x - (dive_speed * character.facing_dir)) / 5
	character.velocity.y += 3
	character.set_state("physics", dive_air_physics)
	dive_sound.play()
