class_name RolloutAction
extends ActionState


@export var rollout_physics: RolloutPhysics
@export var dive_sound: AudioStreamPlayer

@export var rollout_speed: Vector2
@export var rollout_frames: int
var rollout_timer: int


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return character.input["jump"][0] and abs(character.velocity.x) > 3


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if rollout_timer <= 0:
		return ""
	if character.on_ground and character.velocity.y > -3:
		return ""
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	character.velocity.x -= (character.velocity.x - (rollout_speed.x * character.facing_dir)) / 5
	character.velocity.y = min(rollout_speed.y, character.velocity.y)
	character.set_state("physics", rollout_physics)
	dive_sound.play()
	rollout_timer = rollout_frames


## runs every frame while active
func _update() -> void:
	rollout_timer -= 1
