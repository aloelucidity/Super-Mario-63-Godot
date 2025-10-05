class_name RunAnimator
extends Animator


const MAX_FRAME: int = 79 # 1 lower cuz of zero indexing
@onready var character: Character = get_owner()
var air_count: float = 1


func _update() -> void:
	movie_clip.speed_scale = 0
	
	if character.on_ground:
		movie_clip.frame += int( (character.velocity.x * 0.7) - 1.5)
		air_count = 1
	else:
		movie_clip.frame += int( (character.velocity.x / air_count) - 1.5)
		air_count += 0.2
	
	if movie_clip.frame >= MAX_FRAME:
		movie_clip.frame = 0
	if movie_clip.frame < 0:
		movie_clip.frame = MAX_FRAME
