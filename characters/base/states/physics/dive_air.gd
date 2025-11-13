class_name DiveAirPhysics
extends AirPhysics


## runs this check every frame while inactive and 
## in the character's current pool of states
func _startup_check() -> bool:
	return false
