extends RolloutPhysics


@export var bonk_velocity: Vector2
var debounce: int = 0


## runs once when this state begins being active
func _on_enter() -> void:
	character.on_ground = false
	character.velocity = bonk_velocity * Vector2(-character.facing_dir, 1)
	debounce = 1


## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	if debounce > 0:
		return name
	return super()


## runs every frame while active
func _update() -> void:
	debounce -= 1
	super()
