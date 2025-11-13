class_name SpinAnimator
extends Animator


const MAX_FRAME: int = 41
@onready var character: Character = get_owner()
@export var spin_action: SpinAction


func _update() -> void:
	movie_clip.frame += min(round(max(spin_action.spin_speed, 5)), 10)
	
	if spin_action.spin_speed <= 10:
		movie_clip.frame += 40
	
	while movie_clip.frame >= MAX_FRAME:
		movie_clip.frame -= 40
