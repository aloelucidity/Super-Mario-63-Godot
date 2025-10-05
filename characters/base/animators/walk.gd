class_name WalkAnimator
extends Animator


const MAX_FRAME: int = 79 # 1 lower cuz of zero indexing
@onready var character: Character = get_owner()


func _update() -> void:
	movie_clip.speed_scale = 0
	movie_clip.frame += int(character.velocity.x)
	
	if movie_clip.frame >= MAX_FRAME:
		movie_clip.frame = 0
	if movie_clip.frame < 0:
		movie_clip.frame = MAX_FRAME
